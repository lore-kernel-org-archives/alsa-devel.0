From: "Ronny V. Vindenes" <s864@ii.uib.no>
Subject: Re: Stack usage
Date: Tue, 22 Mar 2005 12:38:17 +0100
Message-ID: <1111491497.4063.1.camel@localhost.localdomain>
References: <1111462442.3058.4.camel@mindpipe>
	 <s5hsm2o2d54.wl@alsa2.suse.de>  <s5hpsxr3opz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hpsxr3opz.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

tir, 22,.03.2005 kl. 12.27 +0100, skrev Takashi Iwai:
> At Tue, 22 Mar 2005 11:22:47 +0100,
> I wrote:
> > 
> > > It looks like snd_emu10k1_add_controls is not too hard to fix, but maybe
> > > I am missing something.
> > 
> > It'd be easy - just use kmalloc() for the temporary
> > emu10k1_fx8010_control_gpr_t instance.
> 
> The below is a quick fix for emu10k1 part.  Could you give a try?
> 
> 
> Takashi
> Index: alsa-kernel/pci/emu10k1/emufx.c
> ===================================================================
> RCS file: /home/iwai/cvs/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
> retrieving revision 1.67
> diff -u -r1.67 emufx.c
> --- alsa-kernel/pci/emu10k1/emufx.c	21 Mar 2005 19:43:42 -0000	1.67
> +++ alsa-kernel/pci/emu10k1/emufx.c	22 Mar 2005 11:25:46 -0000
> @@ -634,7 +634,8 @@
>  	snd_ctl_elem_id_t __user *_id;
>  	snd_ctl_elem_id_t id;
>  	emu10k1_fx8010_control_gpr_t __user *_gctl;
> -	emu10k1_fx8010_control_gpr_t gctl;
> +	emu10k1_fx8010_control_gpr_t *gctl;
> +	int err;
>  	
>  	for (i = 0, _id = icode->gpr_del_controls;
>  	     i < icode->gpr_del_control_count; i++, _id++) {
> @@ -643,28 +644,41 @@
>  		if (snd_emu10k1_look_for_ctl(emu, &id) == NULL)
>  			return -ENOENT;
>  	}
> +	gctl = kmalloc(sizeof(*gctl), GFP_KERNEL);
> +	if (! gctl)
> +		return -ENOMEM;
> +	err = 0;
>  	for (i = 0, _gctl = icode->gpr_add_controls;
>  	     i < icode->gpr_add_control_count; i++, _gctl++) {
> -		if (copy_from_user(&gctl, _gctl, sizeof(gctl)))
> -			return -EFAULT;
> -		if (snd_emu10k1_look_for_ctl(emu, &gctl.id))
> +		if (copy_from_user(gctl, _gctl, sizeof(*gctl))) {
> +			err = -EFAULT;
> +			goto __error;
> +		}
> +		if (snd_emu10k1_look_for_ctl(emu, &gctl->id))
>  			continue;
>  		down_read(&emu->card->controls_rwsem);
> -		if (snd_ctl_find_id(emu->card, &gctl.id) != NULL) {
> +		if (snd_ctl_find_id(emu->card, &gctl->id) != NULL) {
>  			up_read(&emu->card->controls_rwsem);
> -			return -EEXIST;
> +			err = -EEXIST;
> +			goto __error;
>  		}
>  		up_read(&emu->card->controls_rwsem);
> -		if (gctl.id.iface != SNDRV_CTL_ELEM_IFACE_MIXER &&
> -		    gctl.id.iface != SNDRV_CTL_ELEM_IFACE_PCM)
> -			return -EINVAL;
> +		if (gctl->id.iface != SNDRV_CTL_ELEM_IFACE_MIXER &&
> +		    gctl->id.iface != SNDRV_CTL_ELEM_IFACE_PCM) {
> +			err = -EINVAL;
> +			goto __error;
> +		}
>  	}
>  	for (i = 0, _gctl = icode->gpr_list_controls;
>  	     i < icode->gpr_list_control_count; i++, _gctl++) {
>  	     	/* FIXME: we need to check the WRITE access */
> -		if (copy_from_user(&gctl, _gctl, sizeof(gctl)))
> -			return -EFAULT;
> +		if (copy_from_user(gctl, _gctl, sizeof(*gctl))) {
> +			err = -EFAULT;
> +			goto __error;
> +		}
>  	}
> + __error:
> +	kfree(gctl);
>  	return 0;

This should be return err; right?

-- 
Ronny V. Vindenes <s864@ii.uib.no>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
