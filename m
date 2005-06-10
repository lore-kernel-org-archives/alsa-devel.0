From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Fri, 10 Jun 2005 15:35:41 +0800
Message-ID: <42A942CD.7030900@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de>	<42A6B51F.20405@netvigator.com> <s5h8y1lkv1c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8y1lkv1c.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Do the au88x0 driver need to free those kcontrols for EQ peak and 
10-bands EQ gain kcontrol  ?

Any method to detect memory leak ? ( THere are other kcontrol such as 
HRTF,ITD,ILD,...)


/* ALSA driver entry points. Init and exit. */
static int vortex_eq_init(vortex_t * vortex)
{
	snd_kcontrol_t *kcontrol;
	int err, i;

	vortex_Eqlzr_init(vortex);

	if ((kcontrol =
	     snd_ctl_new1(&vortex_eqtoggle_kcontrol, vortex)) == NULL)
		return -ENOMEM;
	kcontrol->private_value = 0;
	if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
		return err;

	/* EQ gain controls */
	for (i = 0; i < 10; i++) {
		if ((kcontrol =
		     snd_ctl_new1(&vortex_eq_kcontrol, vortex)) == NULL)
			return -ENOMEM;
		strcpy(kcontrol->id.name, EqBandLabels[i]);
		kcontrol->private_value = i;
		if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
			return err;
		//vortex->eqctrl[i] = kcontrol;
	}
	/* EQ band levels */
	if ((kcontrol = snd_ctl_new1(&vortex_levels_kcontrol, vortex)) == NULL)
		return -ENOMEM;
	if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
		return err;

	return 0;
}

static int vortex_eq_free(vortex_t * vortex)
{
	/*
	   //FIXME: segfault because vortex->eqctrl[i] == 4
	   int i;
	   for (i=0; i<10; i++) {
	   if (vortex->eqctrl[i])
	   snd_ctl_remove(vortex->card, vortex->eqctrl[i]);
	   }
	 */
	vortex_Eqlzr_shutdown(vortex);
	return 0;
}


Takashi Iwai wrote:
> At Wed, 08 Jun 2005 17:06:39 +0800,
> Raymond wrote:
> 
>>au8830 can be loaded after I change "unsigned long __iomem *mmio" to
>>"void __iomem *mmio" on my 32 bits machine.
>>
>>How can I obtain the disassembly of snd-au8830.o to prove that it run 
>>faster than before ( without bitshift ) ?
> 
> 
> Faster?  Not measurable at all :)
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
