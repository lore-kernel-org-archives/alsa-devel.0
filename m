From: Adam Gray <adam@randalflagg.net>
Subject: Re: ALSA on Alienware M17x
Date: Wed, 2 Sep 2009 11:25:06 +0930
Message-ID: <200909021125.06089.adam@randalflagg.net>
References: <200908281621.20263.adam@randalflagg.net>
	<200909020155.18079.adam@randalflagg.net>
	<s5h8wgy9rzr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from randalflagg.net (randalflagg.net [150.101.102.206])
	by alsa0.perex.cz (Postfix) with ESMTP id A445F24410
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 03:55:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by randalflagg.net (Postfix) with SMTP id E2E9E236097
	for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2009 11:25:06 +0930 (CST)
In-Reply-To: <s5h8wgy9rzr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2 Sep 2009 08:45:20 am Takashi Iwai wrote:
> At Wed, 2 Sep 2009 01:55:18 +0930,
> 
> Adam Gray wrote:
> > On Wed, 2 Sep 2009 01:52:15 am Takashi Iwai wrote:
> > > At Wed, 2 Sep 2009 01:37:26 +0930,
> > >
> > > Adam Gray wrote:
> > > > On Wed, 2 Sep 2009 01:15:03 am Takashi Iwai wrote:
> > > > > At Wed, 2 Sep 2009 01:07:22 +0930,
> > > > >
> > > > > Adam Gray wrote:
> > > > > > On Wed, 2 Sep 2009 01:04:11 am Takashi Iwai wrote:
> > > > > > > At Wed, 2 Sep 2009 00:55:02 +0930,
> > > > > > >
> > > > > > > Adam Gray wrote:
> > > > > > > > On Wed, 2 Sep 2009 12:51:21 am Takashi Iwai wrote:
> > > > > > > > > At Wed, 2 Sep 2009 00:40:13 +0930,
> > > > > > > > >
> > > > > > > > > Adam Gray wrote:
> > > > > > > > > > Sorry. Forgot to attach it the first time.
> > > > > > > > > > With model=dell-m6 I only get sound out of the first
> > > > > > > > > > headphone jack and the line-out jack.
> > > > > > > > >
> > > > > > > > > Which I/Os does your machine have?
> > > > > > > > > According to alsa-info.sh output, BIOS gives three HP
> > > > > > > > > jacks, one mic jack, one built-in speaker, one built-in
> > > > > > > > > mic, and one SPDIF out jack.
> > > > > > > > >
> > > > > > > > > I guess the problem is due to three HPs.  The driver hasn't
> > > > > > > > > been tested with three HP jacks, only with two HPs.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > thanks,
> > > > > > > > >
> > > > > > > > > Takashi
> > > > > > > >
> > > > > > > > It has two headphone jacks, one line-out jack and one
> > > > > > > > microphone jack, the front speakers and a microphone used
> > > > > > > > with the webcam (I believe).
> > > > > > >
> > > > > > > OK.  Try to unmute and adjust "Surround" volume.
> > > > > > >
> > > > > > >
> > > > > > > Takashi
> > > > > >
> > > > > > Unmuted surround and volume is up full. Nothing from the
> > > > > > headphones. I also unmuted the PC beep and turned it up (just to
> > > > > > check) and still nothing.
> > > > >
> > > > > Well, which headphone?  The driver tries to mute others when a HP
> > > > > is plugged.  You need to figure out which I/O corresponds to which
> > > > > pin. You can try hda-verb to issue the pin detection verb.  For
> > > > > example, to check the pin 0x0a, run like:
> > > > >
> > > > > 	# hda-verb /dev/snd/hwC0D0 0x0a GET_PIN_SENSE 0
> > > > >
> > > > > If the jack corresponding to this pin is plugged, the bit 31 should
> > > > > be 1.  BIOS shows that pins 0x0a, 0x0b, 0x0d are for HP and
> > > > > line-outs. Figure out which are which.
> > > > >
> > > > > Also, you can try to toggle power bits of IDT codec, e.g.
> > > > > 	# hda-verb /dev/snd/hwC0D0 0x01 0x7ec 0x00
> > > > > to power up all analog pins.
> > > > >
> > > > >
> > > > > Takashi
> > > >
> > > > 0x0a = HP1
> > > > 0x0b = HP2
> > > > 0x0d = line-out
> > > >
> > > > After running "hda-verb /dev/snd/hwC0D0 0x01 0x7ec 0x00" and plugging
> > > > in headphones there's a short burst of sound from them before they
> > > > cut out.
> > >
> > > Issue the power bits verb after plugging the headphone.
> > >
> > >
> > > Takashi
> >
> > Done. For both headphone jacks with no luck :(
> >
> > Unfortunately I have to get to bed now. 2am and work tomorrow. Thanks for
> > your help thus far.
> 
> Could you try the patch below together with the latest alsa-driver
> snapshot?  The URL is below:
>    
>  ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-sn
> apshot.tar.gz Apply it on alsa-driver/alsa-kernel directory with patch -p2
>  option.
> 
> After rebuilding the driver, load the module without model option.
> 
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/patch_sigmatel.c
>  b/sound/pci/hda/patch_sigmatel.c index 83a338b..e31e53d 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -83,6 +83,7 @@ enum {
>  	STAC_DELL_M6_DMIC,
>  	STAC_DELL_M6_BOTH,
>  	STAC_DELL_EQ,
> +	STAC_ALIENWARE_M17X,
>  	STAC_92HD73XX_MODELS
>  };
> 
> @@ -1513,12 +1514,20 @@ static unsigned int dell_m6_pin_configs[13] = {
>  	0x4f0000f0,
>  };
> 
> +static unsigned int alienware_m17x_pin_configs[13] = {
> +	0x0321101f, 0x0321101f, 0x03a11020, 0x03014020,
> +	0x90170110, 0x4f0000f0, 0x4f0000f0, 0x4f0000f0,
> +	0x4f0000f0, 0x90a60160, 0x4f0000f0, 0x4f0000f0,
> +	0x904601b0,
> +};
> +
>  static unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] = {
>  	[STAC_92HD73XX_REF]	= ref92hd73xx_pin_configs,
>  	[STAC_DELL_M6_AMIC]	= dell_m6_pin_configs,
>  	[STAC_DELL_M6_DMIC]	= dell_m6_pin_configs,
>  	[STAC_DELL_M6_BOTH]	= dell_m6_pin_configs,
>  	[STAC_DELL_EQ]	= dell_m6_pin_configs,
> +	[STAC_ALIENWARE_M17X]	= alienware_m17x_pin_configs,
>  };
> 
>  static const char *stac92hd73xx_models[STAC_92HD73XX_MODELS] = {
> @@ -1530,6 +1539,7 @@ static const char
>  *stac92hd73xx_models[STAC_92HD73XX_MODELS] = { [STAC_DELL_M6_DMIC] =
>  "dell-m6-dmic",
>  	[STAC_DELL_M6_BOTH] = "dell-m6",
>  	[STAC_DELL_EQ] = "dell-eq",
> +	[STAC_ALIENWARE_M17X] = "alienware",
>  };
> 
>  static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
> @@ -1567,6 +1577,12 @@ static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] =
>  { {} /* terminator */
>  };
> 
> +static struct snd_pci_quirk stac92hd73xx_codec_id_cfg_tbl[] = {
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02a1,
> +		      "Alienware M17x", STAC_ALIENWARE_M17X),
> +	{} /* terminator */
> +};
> +
>  static unsigned int ref92hd83xxx_pin_configs[10] = {
>  	0x02214030, 0x02211010, 0x02a19020, 0x02170130,
>  	0x01014050, 0x01819040, 0x01014020, 0x90a3014e,
> @@ -4909,6 +4925,12 @@ static int patch_stac92hd73xx(struct hda_codec
>  *codec) STAC_92HD73XX_MODELS,
>  							stac92hd73xx_models,
>  							stac92hd73xx_cfg_tbl);
> +	/* check codec subsystem id if not found */
> +	if (spec->board_config < 0)
> +		spec->board_config =
> +			snd_hda_check_board_codec_sid_config(codec,
> +				STAC_92HD73XX_MODELS, stac92hd73xx_models,
> +				stac92hd73xx_codec_id_cfg_tbl);
>  again:
>  	if (spec->board_config < 0)
>  		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
> @@ -4983,6 +5005,11 @@ again:
>  			break;
>  		}
>  		break;
> +	case STAC_ALIENWARE_M17X:
> +		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
> +		spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
> +		spec->eapd_switch = 0;
> +		break;
>  	default:
>  		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
>  		spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);


Brilliant! Speakers and both headphone jacks and the line-out jack now work.

Thank you very much for that. I owe you a beer :)

Regards,
Adam Gray
