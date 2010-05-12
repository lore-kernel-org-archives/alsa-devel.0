From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: Re: HP dv series mute LED problems?
Date: Wed, 12 May 2010 11:33:06 +0530
Message-ID: <201005121133.06375.kunal.gangakhedkar@gmail.com>
References: <201005120025.07730.kunal.gangakhedkar@gmail.com>
	<s5hljbqp4q9.wl%tiwai@suse.de> <s5hfx1yp3x2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3164110386E
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 08:03:17 +0200 (CEST)
Received: by pxi13 with SMTP id 13so2499598pxi.38
	for <alsa-devel@alsa-project.org>; Tue, 11 May 2010 23:03:16 -0700 (PDT)
In-Reply-To: <s5hfx1yp3x2.wl%tiwai@suse.de>
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
Cc: thoralf.freitag@cactus-online.de, ALSA Devel List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 12 May 2010 2:11:13 am Takashi Iwai wrote:
> At Tue, 11 May 2010 22:23:42 +0200,
> I wrote:
> > 
> > At Wed, 12 May 2010 00:25:07 +0530,
> > Kunal Gangakhedkar wrote:
> > > 
> > > Hi Takashi,
> > > 
> > > The commit 26ebe0a28986f4845b2c5bea43ac5cc0b9f27f0a seems to undo the mute LED
> > > gpio fixes - at least on my dv6 series laptop.
> > > 
> > > Maybe, we need to come up with a better solution to accommodate the problem 
> > > reported in this thread:
> > > http://mailman.alsa-project.org/pipermail/alsa-devel/2010-May/027352.html
> > > I believe, that's the reason for the commit, right?
> > 
> > Yes.  And as I checked the previous code, actually dv4 took GPIO 0.
> > That's why I added it there back.
> > 
> > But, hmm, then it's really depending on the dv model number.
> > Which PCI / codec SSID does your device have?
> 
> As a compromise, how about the additional patch below?
> 
>

Yes, this patch fixes the problems on my dv6 machine and 
looks reasonable to me.

However, we need confirmation from Thoralf - whether it works for him too.
I don't know if STAC_HP_DV4 can be reused for dv7 series machines - since I
don't have access to verify it.

Tested-by: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com> (for dv6-1110ax)
Acked-by: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
> index eb4ea3d..a0e06d8 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -104,6 +104,7 @@ enum {
>  	STAC_DELL_M4_2,
>  	STAC_DELL_M4_3,
>  	STAC_HP_M4,
> +	STAC_HP_DV4,
>  	STAC_HP_DV5,
>  	STAC_HP_HDX,
>  	STAC_HP_DV4_1222NR,
> @@ -1691,6 +1692,7 @@ static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
>  	[STAC_DELL_M4_2]	= dell_m4_2_pin_configs,
>  	[STAC_DELL_M4_3]	= dell_m4_3_pin_configs,
>  	[STAC_HP_M4]		= NULL,
> +	[STAC_HP_DV4]		= NULL,
>  	[STAC_HP_DV5]		= NULL,
>  	[STAC_HP_HDX]           = NULL,
>  	[STAC_HP_DV4_1222NR]	= NULL,
> @@ -1703,6 +1705,7 @@ static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
>  	[STAC_DELL_M4_2] = "dell-m4-2",
>  	[STAC_DELL_M4_3] = "dell-m4-3",
>  	[STAC_HP_M4] = "hp-m4",
> +	[STAC_HP_DV4] = "hp-dv4",
>  	[STAC_HP_DV5] = "hp-dv5",
>  	[STAC_HP_HDX] = "hp-hdx",
>  	[STAC_HP_DV4_1222NR] = "hp-dv4-1222nr",
> @@ -1721,7 +1724,7 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
>  	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x3080,
>  		      "HP", STAC_HP_DV5),
>  	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x30f0,
> -		      "HP dv4-7", STAC_HP_DV5),
> +		      "HP dv4-7", STAC_HP_DV4),
>  	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x3600,
>  		      "HP dv4-7", STAC_HP_DV5),
>  	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3610,
> @@ -5678,6 +5681,9 @@ again:
>  		spec->num_smuxes = 1;
>  		spec->num_dmuxes = 1;
>  		/* fallthrough */
> +	case STAC_HP_DV4:
> +		spec->gpio_led = 0x01;
> +		/* fallthrough */
>  	case STAC_HP_DV5:
>  		snd_hda_codec_set_pincfg(codec, 0x0d, 0x90170010);
>  		stac92xx_auto_set_pinctl(codec, 0x0d, AC_PINCTL_OUT_EN);
> @@ -5686,7 +5692,6 @@ again:
>  		 * detection.
>  		 */
>  		spec->hp_detect = 1;
> -		spec->gpio_led = 0x01;
>  		break;
>  	case STAC_HP_HDX:
>  		spec->num_dmics = 1;
> @@ -5749,7 +5754,8 @@ again:
>  	}
>  
>  	/* enable bass on HP dv7 */
> -	if (spec->board_config == STAC_HP_DV5) {
> +	if (spec->board_config == STAC_HP_DV4 ||
> +	    spec->board_config == STAC_HP_DV5) {
>  		unsigned int cap;
>  		cap = snd_hda_param_read(codec, 0x1, AC_PAR_GPIO_CAP);
>  		cap &= AC_GPIO_IO_COUNT;
> 
