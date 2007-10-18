From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: hda-intel: no soundcard with current linus' git
	tree
Date: Thu, 18 Oct 2007 17:24:46 +0200
Message-ID: <200710181724.47256.maximlevitsky@gmail.com>
References: <471538C2.80806@m3y3r.de>
	<200710181621.59795.maximlevitsky@gmail.com>
	<s5h4pgo1qjh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 472B7247BF
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 17:25:19 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so149012rvb
	for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2007 08:25:18 -0700 (PDT)
In-Reply-To: <s5h4pgo1qjh.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Meyer <thomas@m3y3r.de>
List-Id: alsa-devel@alsa-project.org

On Thursday 18 October 2007 15:49:22 Takashi Iwai wrote:
> At Thu, 18 Oct 2007 16:21:59 +0200,
> Maxim Levitsky wrote:
> > 
> > On Thursday 18 October 2007 07:57:27 Takashi Iwai wrote:
> > > At Thu, 18 Oct 2007 03:53:08 +0200,
> > > Maxim Levitsky wrote:
> > > > 
> > > > From 0824b077b75c19253b45c5a455775c331acd54ee Mon Sep 17 00:00:00 2001
> > > > From: Maxim Levitsky <maximlevitsky@gmail.com>
> > > > Date: Thu, 18 Oct 2007 03:35:37 +0200
> > > > Subject: [PATCH] [HDA] [STAC] Since there is now a master volume control,
> > > > don't call the headphone output "Master", it isn't strictly correct anyway
> > > 
> > > I thought stac925x has no volume knob, so "Master" should be still
> > > applied for this codec?
> > 
> > Yes, you are right, but stac925x has only one DAC, and thus if it is
> > connected to any line-out, it will be 
> > 'Front', but if it is connected to 'headphones' only, then why not
> > to call it 'Headphone' 
> 
> The point is that apps usually require a "Master" volume.  If it's the
> single volume control, it's better to call it master for convenience.
And most STACs didn't have one till I added this volumeknob...


> 
> 
> > STAC  9200 has no volumeknob too, but it is handled seperartly
> 
> Yes, 9200 doesn't call stac92xx_auto_create_hp_ctls(), so it's not
> affected.
> 
> > STAC  9202 and 9250 has no volumeknob too, but as I said they have
> > just one DAC again 
> 
> Both are handled as patch_stac925x.  That's what I meant.  With your
> patch, there will be no master any more.
> 
> So, how about the patch below?
> 
> 
> Takashi
> 
> diff -r fb9512ce24e0 pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c	Thu Oct 18 10:48:43 2007 +0200
> +++ b/pci/hda/patch_sigmatel.c	Thu Oct 18 16:36:35 2007 +0200
> @@ -111,6 +111,7 @@ struct sigmatel_spec {
>  	unsigned int alt_switch: 1;
>  	unsigned int hp_detect: 1;
>  	unsigned int gpio_mute: 1;
> +	unsigned int no_vol_knob :1;
>  
>  	unsigned int gpio_mask, gpio_data;
>  
> @@ -1930,7 +1931,8 @@ static int stac92xx_auto_create_hp_ctls(
>  	}
>  	if (spec->multiout.hp_nid) {
>  		const char *pfx;
> -		if (old_num_dacs == spec->multiout.num_dacs)
> +		if (old_num_dacs == spec->multiout.num_dacs &&
> +		    spec->no_vol_knob)
>  			pfx = "Master";
>  		else
>  			pfx = "Headphone";
> @@ -2487,6 +2489,7 @@ static int patch_stac9200(struct hda_cod
>  	codec->spec = spec;
>  	spec->num_pins = ARRAY_SIZE(stac9200_pin_nids);
>  	spec->pin_nids = stac9200_pin_nids;
> +	spec->no_vol_knob = 1;
>  	spec->board_config = snd_hda_check_board_config(codec, STAC_9200_MODELS,
>  							stac9200_models,
>  							stac9200_cfg_tbl);
> @@ -2541,6 +2544,7 @@ static int patch_stac925x(struct hda_cod
>  	codec->spec = spec;
>  	spec->num_pins = ARRAY_SIZE(stac925x_pin_nids);
>  	spec->pin_nids = stac925x_pin_nids;
> +	spec->no_vol_knob = 1;
>  	spec->board_config = snd_hda_check_board_config(codec, STAC_925x_MODELS,
>  							stac925x_models,


Perfect.
This will ensure the same behavior, as was without the volumeknob.

Best regards,
	Maxim Levitsky	
