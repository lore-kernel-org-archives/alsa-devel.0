From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: Alsa 1.0.15rc2 and oops with Dell M1210
Date: Wed, 10 Oct 2007 15:21:20 -0300
Message-ID: <200710101521.21897.herton@mandriva.com.br>
References: <1191056837.4984.12.camel@localhost.localdomain>
	<200710031658.35289.herton@mandriva.com.br>
	<s5hwstwtxwr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id EAF641038C3
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Oct 2007 20:21:31 +0200 (CEST)
In-Reply-To: <s5hwstwtxwr.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, zhejiang <zhe.jiang@intel.com>
List-Id: alsa-devel@alsa-project.org

Em Tuesday 09 October 2007 06:55:32 Takashi Iwai escreveu:
> At Wed, 3 Oct 2007 16:58:35 -0300,
>
> Herton Ronaldo Krzesinski wrote:
> > Em Saturday 29 September 2007 18:53:29 Herton Ronaldo Krzesinski escreveu:
> > > On Saturday 29 September 2007 06:07:17 zhejiang wrote:
> > > > Seems that the spec->input_mux contains no item at all.
> > > > So system maybe crash in the snd_hda_input_mux_info() when try to
> > > > copy the items[].label,which is null pointer.
> > > >
> > > > May you replace the function  stac92xx_mux_enum_info() in
> > > > alsa-driver-1.0.15rc2/alsa-kernel/pci/hda/patch_sigmatel.c ?
> > > >
> > > > static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol,
> > > > struct snd_ctl_elem_info *uinfo)
> > > > {
> > > > 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> > > > 	struct sigmatel_spec *spec = codec->spec;
> > > > 	printk("spec->input_mux->num_items is %d
> > > > \n",spec->input_mux->num_items);
> > > > 	if(!spec->input_mux->num_items)
> > > > 		return 0;
> > > > 	return snd_hda_input_mux_info(spec->input_mux, uinfo);
> > > > }
> > > >
> > > > Does it still crash?
> > > > What's the number of num_items?
> >
> > I received feedback from the reporter:
> > spec->input_mux->num_items is 0
> >
> > Also sound works fine, no more crashes.
>
> OK, then could you check whether the patch below fixes the problem?
> Such a check should be done in the common routine.

Yes, the patch was reported to me as working fine, thanks.

>
>
> Thanks,
>
> Takashi
>
> diff -r a4cf3aa3dc5b pci/hda/hda_codec.c
> --- a/pci/hda/hda_codec.c	Tue Oct 09 10:34:06 2007 +0200
> +++ b/pci/hda/hda_codec.c	Tue Oct 09 11:53:39 2007 +0200
> @@ -2341,6 +2341,8 @@ int snd_hda_input_mux_info(const struct
>  	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
>  	uinfo->count = 1;
>  	uinfo->value.enumerated.items = imux->num_items;
> +	if (!imux->num_items)
> +		return 0;
>  	index = uinfo->value.enumerated.item;
>  	if (index >= imux->num_items)
>  		index = imux->num_items - 1;
> @@ -2356,6 +2358,8 @@ int snd_hda_input_mux_put(struct hda_cod
>  {
>  	unsigned int idx;
>
> +	if (!imux->num_items)
> +		return 0;
>  	idx = ucontrol->value.enumerated.item[0];
>  	if (idx >= imux->num_items)
>  		idx = imux->num_items - 1;

--
[]'s
Herton
