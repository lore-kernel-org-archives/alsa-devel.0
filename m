From: Andy <hornett83@yahoo.co.uk>
Subject: Re: ALC262 - HDA-Intel
Date: Wed, 25 Jul 2007 18:59:03 +0100 (BST)
Message-ID: <372443.44207.qm@web27212.mail.ukl.yahoo.com>
References: <s5hzm1kv3r7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web27212.mail.ukl.yahoo.com (web27212.mail.ukl.yahoo.com
	[217.146.182.102])
	by alsa0.perex.cz (Postfix) with SMTP id 21A8010386C
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jul 2007 19:59:04 +0200 (CEST)
In-Reply-To: <s5hzm1kv3r7.wl%tiwai@suse.de>
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

Yep, I'm happy to report that does indeed fix it!

Thank-you Takashi! :)

Andy.

--- Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 25 Jul 2007 16:51:25 +0100 (BST),
> Andy wrote:
> > 
> > Hello again Takashi,
> > 
> > I put in some printks, and indeed the function
> does
> > run and it correctly detects that there are no
> > headphones present, but the speakers are not
> unmuted.
> > 
> > (the 'mute' variable both times is reported as
> being
> > 0x80 after it is set with snd_hda_codec_amp_read)
> 
> Ah, it means that this intiailization gets called
> before restoring the
> mixer elements.  Since sony model doesn't have the
> mixer element for
> the NID 0x14 that is linked with 0x15, 0x14 isn't
> restored properly in
> the end.
> 
> How about the patch below?  It's a bit too ad hoc,
> but better than
> buggy.
> 
> 
> Takashi
> 
> diff -r 43059389c583 pci/hda/patch_realtek.c
> --- a/pci/hda/patch_realtek.c	Tue Jul 24 18:04:05
> 2007 +0200
> +++ b/pci/hda/patch_realtek.c	Wed Jul 25 18:35:06
> 2007 +0200
> @@ -7140,9 +7140,28 @@ static struct
> snd_kcontrol_new alc262_HP
>  	{ } /* end */
>  };
>  
> +static int alc262_sony_sw_put(struct snd_kcontrol
> *kcontrol,
> +			      struct snd_ctl_elem_value *ucontrol)
> +{
> +	unsigned long private_save =
> kcontrol->private_value;
> +	int change;
> +	kcontrol->private_value =
> HDA_COMPOSE_AMP_VAL(0x14, 3, 0, HDA_OUTPUT);
> +	change = snd_hda_mixer_amp_switch_put(kcontrol,
> ucontrol);
> +	kcontrol->private_value = private_save;
> +	change |= snd_hda_mixer_amp_switch_put(kcontrol,
> ucontrol);
> +	return change;
> +}
> +
>  static struct snd_kcontrol_new alc262_sony_mixer[]
> = {
>  	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c,
> 0x0, HDA_OUTPUT),
> -	HDA_CODEC_MUTE("Front Playback Switch", 0x15, 0x0,
> HDA_OUTPUT),
> +	{
> +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +		.name = "Front Playback Switch",
> +		.info = snd_hda_mixer_amp_switch_info,
> +		.get = snd_hda_mixer_amp_switch_get,
> +		.put = alc262_sony_sw_put,
> +		.private_value = HDA_COMPOSE_AMP_VAL(0x15, 3, 0,
> HDA_OUTPUT),
> +	},
>  	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0,
> HDA_INPUT),
>  	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0,
> HDA_INPUT),
>  	HDA_CODEC_VOLUME("ATAPI Mic Playback Volume",
> 0x0b, 0x01, HDA_INPUT),
> @@ -7269,20 +7288,17 @@ static struct hda_verb
> alc262_sony_unsol
>  };
>  
>  /* mute/unmute internal speaker according to the hp
> jack and mute state */
> -static void alc262_hippo_automute(struct hda_codec
> *codec, int force)
> +static void alc262_hippo_automute(struct hda_codec
> *codec)
>  {
>  	struct alc_spec *spec = codec->spec;
>  	unsigned int mute;
> -
> -	if (force || !spec->sense_updated) {
> -		unsigned int present;
> -		/* need to execute and sync at first */
> -		snd_hda_codec_read(codec, 0x15, 0,
> AC_VERB_SET_PIN_SENSE, 0);
> -		present = snd_hda_codec_read(codec, 0x15, 0,
> -				    	 AC_VERB_GET_PIN_SENSE, 0);
> -		spec->jack_present = (present & 0x80000000) != 0;
> -		spec->sense_updated = 1;
> -	}
> +	unsigned int present;
> +
> +	/* need to execute and sync at first */
> +	snd_hda_codec_read(codec, 0x15, 0,
> AC_VERB_SET_PIN_SENSE, 0);
> +	present = snd_hda_codec_read(codec, 0x15, 0,
> +				     AC_VERB_GET_PIN_SENSE, 0);
> +	spec->jack_present = (present & 0x80000000) != 0;
>  	if (spec->jack_present) {
>  		/* mute internal speaker */
>  		snd_hda_codec_amp_update(codec, 0x14, 0,
> HDA_OUTPUT, 0,
> @@ -7306,24 +7322,19 @@ static void
> alc262_hippo_unsol_event(str
>  {
>  	if ((res >> 26) != ALC880_HP_EVENT)
>  		return;
> -	alc262_hippo_automute(codec, 1);
> -}
> -
> -static void alc262_hippo1_automute(struct hda_codec
> *codec, int force)
> -{
> -	struct alc_spec *spec = codec->spec;
> +	alc262_hippo_automute(codec);
> +}
> +
> +static void alc262_hippo1_automute(struct hda_codec
> *codec)
> +{
>  	unsigned int mute;
> -
> -	if (force || !spec->sense_updated) {
> -		unsigned int present;
> -		/* need to execute and sync at first */
> -		snd_hda_codec_read(codec, 0x1b, 0,
> AC_VERB_SET_PIN_SENSE, 0);
> -		present = snd_hda_codec_read(codec, 0x1b, 0,
> -				    	 AC_VERB_GET_PIN_SENSE, 0);
> -		spec->jack_present = (present & 0x80000000) != 0;
> -		spec->sense_updated = 1;
> -	}
> -	if (spec->jack_present) {
> +	unsigned int present;
> +
> +	snd_hda_codec_read(codec, 0x1b, 0,
> AC_VERB_SET_PIN_SENSE, 0);
> +	present = snd_hda_codec_read(codec, 0x1b, 0,
> +				     AC_VERB_GET_PIN_SENSE, 0);
> +	present = (present & 0x80000000) != 0;
> +	if (present) {
>  		/* mute internal speaker */
>  		snd_hda_codec_amp_update(codec, 0x14, 0,
> HDA_OUTPUT, 0,
>  					 0x80, 0x80);
> @@ -7346,7 +7357,7 @@ static void
> alc262_hippo1_unsol_event(st
>  {
>  	if ((res >> 26) != ALC880_HP_EVENT)
>  		return;
> -	alc262_hippo1_automute(codec, 1);
> +	alc262_hippo1_automute(codec);
>  }
>  
>  /*
> @@ -7923,6 +7934,7 @@ static struct snd_pci_quirk
> alc262_cfg_t
>  	SND_PCI_QUIRK(0x17ff, 0x058f, "Benq Hippo",
> ALC262_HIPPO_1),
>  	SND_PCI_QUIRK(0x17ff, 0x0560, "Benq ED8",
> ALC262_BENQ_ED8),
>  	SND_PCI_QUIRK(0x17ff, 0x058d, "Benq T31-16",
> ALC262_BENQ_T31),
> +	SND_PCI_QUIRK(0x104d, 0x820f, "Sony ASSAMD",
> ALC262_SONY_ASSAMD),
>  	SND_PCI_QUIRK(0x104d, 0x9015, "Sony 0x9015",
> ALC262_SONY_ASSAMD),
>  	SND_PCI_QUIRK(0x104d, 0x900e, "Sony ASSAMD",
> ALC262_SONY_ASSAMD),
>  	SND_PCI_QUIRK(0x104d, 0x1f00, "Sony ASSAMD",
> ALC262_SONY_ASSAMD),
> @@ -7951,6 +7963,7 @@ static struct
> alc_config_preset alc262_p
>  		.channel_mode = alc262_modes,
>  		.input_mux = &alc262_capture_source,
>  		.unsol_event = alc262_hippo_unsol_event,
> +		.init_hook = alc262_hippo_automute,
>  	},
>  	[ALC262_HIPPO_1] = {
>  		.mixers = { alc262_hippo1_mixer },
> @@ -7963,6 +7976,7 @@ static struct
> alc_config_preset alc262_p
>  		.channel_mode = alc262_modes,
>  		.input_mux = &alc262_capture_source,
>  		.unsol_event = alc262_hippo1_unsol_event,
> +		.init_hook = alc262_hippo1_automute,
>  	},
>  	[ALC262_FUJITSU] = {
>  		.mixers = { alc262_fujitsu_mixer },
> 
=== message truncated ===



      ___________________________________________________________ 
Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for
your free account today http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html 
