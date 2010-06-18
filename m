From: Junhwa Rhee <junhwa.rhee@gmail.com>
Subject: Re: Contents of Alsa-devel digest...
Date: Fri, 18 Jun 2010 13:59:35 +0900
Message-ID: <DF76546F-1098-4684-9BF5-35CF4BA28DCE@gmail.com>
References: <mailman.8202.1276828700.2074.alsa-devel@alsa-project.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D2CF810380E
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 06:59:45 +0200 (CEST)
Received: by iwn8 with SMTP id 8so725625iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2010 21:59:43 -0700 (PDT)
In-Reply-To: <mailman.8202.1276828700.2074.alsa-devel@alsa-project.org>
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
List-Id: alsa-devel@alsa-project.org


On Jun 18, 2010, at 11:38 AM, alsa-devel-request@alsa-project.org wrote:

> Send Alsa-devel mailing list submissions to
> 	alsa-devel@alsa-project.org
> 
> To subscribe or unsubscribe via the World Wide Web, visit
> 	http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> or, via email, send a message with subject or body 'help' to
> 	alsa-devel-request@alsa-project.org
> 
> You can reach the person managing the list at
> 	alsa-devel-owner@alsa-project.org
> 
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Alsa-devel digest..."
> 
> 
> Today's Topics:
> 
>   1. Re: [PATCH 2/5] ALSA: usb-audio: unify UAC macros and	struct
>      names (Daniel Mack)
>   2. Re: Timing Info (Clemens Ladisch)
>   3. Re: [PATCH] ASoC: pandora: fix CLKX polarity (Mark Brown)
>   4. [PATCH] ALSA: hda - add ideapad model for Conexant	5051 codec
>      (Herton Ronaldo Krzesinski)
>   5. Re: [PATCH] ALSA: hda - add ideapad model for Conexant	5051
>      codec (Takashi Iwai)
>   6. Re: snd_mixer_selem_get_playback_volume return value	outside
>      allowed range (Raymond Yau)
>   7. Re: [PATCH] eukrea-tlv320: add support for our i.MX25	board
>      (Mark Brown)
>   8. SOC_DOUBLE_R_SX_TLV (was Update on TLV320AIC3204 Driver)
>      (Stuart Longland)
> 
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Thu, 17 Jun 2010 17:26:26 +0200
> From: Daniel Mack <daniel@caiaq.de>
> Subject: Re: [alsa-devel] [PATCH 2/5] ALSA: usb-audio: unify UAC
> 	macros and	struct names
> To: Alex Lee <alexlee188@gmail.com>
> Cc: Takashi Iwai <tiwai@suse.de>,	"alsa-devel@alsa-project.org"
> 	<alsa-devel@alsa-project.org>,	"clemens@ladisch.de"
> 	<clemens@ladisch.de>
> Message-ID: <20100617152626.GL17833@buzzloop.caiaq.de>
> Content-Type: text/plain; charset=us-ascii
> 
> (hint, hint: don't top-post :))
> 
> On Thu, Jun 17, 2010 at 08:21:22AM -0700, Alex Lee wrote:
>> It will not help existing codes, I agree.  But it may make writing new UAC2
>> specific code easier?
> 
> Not as long as most of the code stays hybrid for both versions. If there
> were versions of these enum values for both UAC1 and UAC2, you would
> need to choose one of them in the parser codes. Which one you go for
> doesn't actually make any difference as they're both the same, but the
> code would read as if it was specific to any version.
> 
> I'd say this would add more to the confusion, and not ease any.
> 
> 
> Daniel
> 
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Thu, 17 Jun 2010 17:36:59 +0200
> From: Clemens Ladisch <clemens@ladisch.de>
> Subject: Re: [alsa-devel] Timing Info
> To: Paul Dugas <paul@dugasenterprises.com>
> Cc: alsa-devel@alsa-project.org
> Message-ID: <4C1A411B.2060301@ladisch.de>
> Content-Type: text/plain; charset=us-ascii
> 
> Paul Dugas wrote:
>> On Sun, Jun 13, 2010 at 10:10 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>>> Set SND_PCM_TSTAMP_ENABLE to generate a timestamp whenever the hardware
>>> position is updated.  Call snd_pcm_status to read the position and the
>>> corresponding timestamp.
>> 
>> I've re-read this a number of times and have been fiddling with code
>> that dumps the status at various points but I'm still not grasping the
>> concept here.  Can comeone point me to an explanation of the delay,
>> avail, and avail_max values?
> 
> The avail value tells you how many frames are available, i.e., can be
> written, in the output buffer.  The largest value that this had since
> the last snd_pcm_status call is avail_max.
> 
> The delay value is the time that will elapse before the next frame that
> you write into the buffer will actually be output by the hardware.  This
> is not only the time until the hardware reads this frame out of the
> buffer (which could be computed from avail) but also any processing
> after that.
> 
> 
> HTH
> Clemens
> 
> 
> ------------------------------
> 
> Message: 3
> Date: Thu, 17 Jun 2010 16:50:01 +0100
> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Subject: Re: [alsa-devel] [PATCH] ASoC: pandora: fix CLKX polarity
> To: Grazvydas Ignotas <notasas@gmail.com>, alsa-devel@alsa-project.org
> Cc: lrg@slimlogic.co.uk
> Message-ID: <u6g5khs6pbrq63fngu2ncjvv.1276789801383@email.android.com>
> Content-Type: text/plain; charset=utf-8
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Probably best to add a CC to stable too. Sorry about the rubbish formatting, on my phone and it can't do any better.
> 
> Grazvydas Ignotas <notasas@gmail.com> wrote:
> 
>> After mass production started it was found that several boards exhibit
>> noise problems during sound playback. After some investigation it was
>> determined that CLKX polarity is set incorrectly, and even if most boards
>> can tolerate the wrong setting, there are some that don't.
>> 
>> Fix polarity setup in the board file. As the clock settings for input and
>> output now match, merge in and out functions and structures to simplify
>> code.
>> 
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>> sound/soc/omap/omap3pandora.c |   36 ++++++++----------------------------
>> 1 files changed, 8 insertions(+), 28 deletions(-)
>> 
>> diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
>> index 87ce842..9eecac1 100644
>> --- a/sound/soc/omap/omap3pandora.c
>> +++ b/sound/soc/omap/omap3pandora.c
>> @@ -43,12 +43,14 @@
>> 
>> static struct regulator *omap3pandora_dac_reg;
>> 
>> -static int omap3pandora_cmn_hw_params(struct snd_pcm_substream *substream,
>> -	struct snd_pcm_hw_params *params, unsigned int fmt)
>> +static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
>> +	struct snd_pcm_hw_params *params)
>> {
>> 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
>> 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
>> +	int fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>> +		  SND_SOC_DAIFMT_CBS_CFS;
>> 	int ret;
>> 
>> 	/* Set codec DAI configuration */
>> @@ -91,24 +93,6 @@ static int omap3pandora_cmn_hw_params(struct snd_pcm_substream *substream,
>> 	return 0;
>> }
>> 
>> -static int omap3pandora_out_hw_params(struct snd_pcm_substream *substream,
>> -	struct snd_pcm_hw_params *params)
>> -{
>> -	return omap3pandora_cmn_hw_params(substream, params,
>> -					  SND_SOC_DAIFMT_I2S |
>> -					  SND_SOC_DAIFMT_IB_NF |
>> -					  SND_SOC_DAIFMT_CBS_CFS);
>> -}
>> -
>> -static int omap3pandora_in_hw_params(struct snd_pcm_substream *substream,
>> -	struct snd_pcm_hw_params *params)
>> -{
>> -	return omap3pandora_cmn_hw_params(substream, params,
>> -					  SND_SOC_DAIFMT_I2S |
>> -					  SND_SOC_DAIFMT_NB_NF |
>> -					  SND_SOC_DAIFMT_CBS_CFS);
>> -}
>> -
>> static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
>> 	struct snd_kcontrol *k, int event)
>> {
>> @@ -231,12 +215,8 @@ static int omap3pandora_in_init(struct snd_soc_codec *codec)
>> 	return snd_soc_dapm_sync(codec);
>> }
>> 
>> -static struct snd_soc_ops omap3pandora_out_ops = {
>> -	.hw_params = omap3pandora_out_hw_params,
>> -};
>> -
>> -static struct snd_soc_ops omap3pandora_in_ops = {
>> -	.hw_params = omap3pandora_in_hw_params,
>> +static struct snd_soc_ops omap3pandora_ops = {
>> +	.hw_params = omap3pandora_hw_params,
>> };
>> 
>> /* Digital audio interface glue - connects codec <--> CPU */
>> @@ -246,14 +226,14 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
>> 		.stream_name = "HiFi Out",
>> 		.cpu_dai = &omap_mcbsp_dai[0],
>> 		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
>> -		.ops = &omap3pandora_out_ops,
>> +		.ops = &omap3pandora_ops,
>> 		.init = omap3pandora_out_init,
>> 	}, {
>> 		.name = "TWL4030",
>> 		.stream_name = "Line/Mic In",
>> 		.cpu_dai = &omap_mcbsp_dai[1],
>> 		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
>> -		.ops = &omap3pandora_in_ops,
>> +		.ops = &omap3pandora_ops,
>> 		.init = omap3pandora_in_init,
>> 	}
>> };
>> -- 
>> 1.6.3.3
>> 
> 
> ------------------------------
> 
> Message: 4
> Date: Thu, 17 Jun 2010 14:15:06 -0300
> From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> Subject: [alsa-devel] [PATCH] ALSA: hda - add ideapad model for
> 	Conexant	5051 codec
> To: alsa-devel@alsa-project.org
> Cc: Takashi Iwai <tiwai@suse.de>
> Message-ID: <201006171415.07101.herton@mandriva.com.br>
> Content-Type: Text/Plain;  charset="us-ascii"
> 
> Lenovo IdeaPad Y430 has an additional subwoofer connected at pin 0x1b,
> which isn't muted when headphone is plugged in. This adds additional
> support to the extra subwoofer via new ideapad model.
> 
> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> ---
> Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
> sound/pci/hda/patch_conexant.c               |   20 ++++++++++++++++++++
> 2 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt 
> b/Documentation/sound/alsa/HD-Audio-Models.txt
> index 1d38b0d..84e81ad 100644
> --- a/Documentation/sound/alsa/HD-Audio-Models.txt
> +++ b/Documentation/sound/alsa/HD-Audio-Models.txt
> @@ -282,6 +282,7 @@ Conexant 5051
>   hp		HP Spartan laptop
>   hp-dv6736	HP dv6736
>   hp-f700	HP Compaq Presario F700
> +  ideapad	Lenovo IdeaPad laptop
>   lenovo-x200	Lenovo X200 laptop
>   toshiba	Toshiba Satellite M300
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index 2bf2cb5..54f7419 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -1632,6 +1632,11 @@ static void cxt5051_update_speaker(struct hda_codec 
> *codec)
> 	pinctl = (!spec->hp_present && spec->cur_eapd) ? PIN_OUT : 0;
> 	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
> 			    pinctl);
> +	/* on ideapad there is an aditional speaker (subwoofer) to mute */
> +	if (spec->ideapad)
> +		snd_hda_codec_write(codec, 0x1b, 0,
> +				    AC_VERB_SET_PIN_WIDGET_CONTROL,
> +				    pinctl);
> }
> 
> /* turn on/off EAPD (+ mute HP) as a master switch */
> @@ -1888,6 +1893,13 @@ static void cxt5051_init_mic_port(struct hda_codec 
> *codec, hda_nid_t nid,
> #endif
> }
> 
> +static struct hda_verb cxt5051_ideapad_init_verbs[] = {
> +	/* Subwoofer */
> +	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x00},
> +	{ } /* end */
> +};
> +
> /* initialize jack-sensing, too */
> static int cxt5051_init(struct hda_codec *codec)
> {
> @@ -1917,6 +1929,7 @@ enum {
> 	CXT5051_LENOVO_X200,	/* Lenovo X200 laptop, also used for Advanced Mini 
> Dock 250410 */
> 	CXT5051_F700,       /* HP Compaq Presario F700 */
> 	CXT5051_TOSHIBA,	/* Toshiba M300 & co */
> +	CXT5051_IDEAPAD,	/* Lenovo IdeaPad Y430 */
> 	CXT5051_MODELS
> };
> 
> @@ -1927,6 +1940,7 @@ static const char *cxt5051_models[CXT5051_MODELS] = {
> 	[CXT5051_LENOVO_X200]	= "lenovo-x200",
> 	[CXT5051_F700]          = "hp-700",
> 	[CXT5051_TOSHIBA]	= "toshiba",
> +	[CXT5051_IDEAPAD]	= "ideapad",
> };
> 
> static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
> @@ -1938,6 +1952,7 @@ static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
> 		      CXT5051_LAPTOP),
> 	SND_PCI_QUIRK(0x14f1, 0x5051, "HP Spartan 1.1", CXT5051_HP),
> 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo X200", CXT5051_LENOVO_X200),
> +	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo IdeaPad", CXT5051_IDEAPAD),
> 	{}
> };
> 
> @@ -1999,6 +2014,11 @@ static int patch_cxt5051(struct hda_codec *codec)
> 		spec->mixers[0] = cxt5051_toshiba_mixers;
> 		spec->auto_mic = AUTO_MIC_PORTB;
> 		break;
> +	case CXT5051_IDEAPAD:
> +		spec->init_verbs[spec->num_init_verbs++] =
> +			cxt5051_ideapad_init_verbs;
> +		spec->ideapad = 1;
> +		break;
> 	}
> 
> 	return 0;
> -- 
> 1.7.1
> 
> 
> 
> ------------------------------
> 
> Message: 5
> Date: Thu, 17 Jun 2010 20:39:20 +0200
> From: Takashi Iwai <tiwai@suse.de>
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - add ideapad model for
> 	Conexant	5051 codec
> To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> Cc: alsa-devel@alsa-project.org
> Message-ID: <s5hk4pxld0n.wl%tiwai@suse.de>
> Content-Type: text/plain; charset=US-ASCII
> 
> At Thu, 17 Jun 2010 14:15:06 -0300,
> Herton Ronaldo Krzesinski wrote:
>> 
>> Lenovo IdeaPad Y430 has an additional subwoofer connected at pin 0x1b,
>> which isn't muted when headphone is plugged in. This adds additional
>> support to the extra subwoofer via new ideapad model.
>> 
>> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> 
> Thanks, applied now.
> 
> 
> Takashi
> 
>> ---
>> Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
>> sound/pci/hda/patch_conexant.c               |   20 ++++++++++++++++++++
>> 2 files changed, 21 insertions(+), 0 deletions(-)
>> 
>> diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt 
>> b/Documentation/sound/alsa/HD-Audio-Models.txt
>> index 1d38b0d..84e81ad 100644
>> --- a/Documentation/sound/alsa/HD-Audio-Models.txt
>> +++ b/Documentation/sound/alsa/HD-Audio-Models.txt
>> @@ -282,6 +282,7 @@ Conexant 5051
>>   hp		HP Spartan laptop
>>   hp-dv6736	HP dv6736
>>   hp-f700	HP Compaq Presario F700
>> +  ideapad	Lenovo IdeaPad laptop
>>   lenovo-x200	Lenovo X200 laptop
>>   toshiba	Toshiba Satellite M300
>> 
>> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
>> index 2bf2cb5..54f7419 100644
>> --- a/sound/pci/hda/patch_conexant.c
>> +++ b/sound/pci/hda/patch_conexant.c
>> @@ -1632,6 +1632,11 @@ static void cxt5051_update_speaker(struct hda_codec 
>> *codec)
>> 	pinctl = (!spec->hp_present && spec->cur_eapd) ? PIN_OUT : 0;
>> 	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
>> 			    pinctl);
>> +	/* on ideapad there is an aditional speaker (subwoofer) to mute */
>> +	if (spec->ideapad)
>> +		snd_hda_codec_write(codec, 0x1b, 0,
>> +				    AC_VERB_SET_PIN_WIDGET_CONTROL,
>> +				    pinctl);
>> }
>> 
>> /* turn on/off EAPD (+ mute HP) as a master switch */
>> @@ -1888,6 +1893,13 @@ static void cxt5051_init_mic_port(struct hda_codec 
>> *codec, hda_nid_t nid,
>> #endif
>> }
>> 
>> +static struct hda_verb cxt5051_ideapad_init_verbs[] = {
>> +	/* Subwoofer */
>> +	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>> +	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x00},
>> +	{ } /* end */
>> +};
>> +
>> /* initialize jack-sensing, too */
>> static int cxt5051_init(struct hda_codec *codec)
>> {
>> @@ -1917,6 +1929,7 @@ enum {
>> 	CXT5051_LENOVO_X200,	/* Lenovo X200 laptop, also used for Advanced Mini 
>> Dock 250410 */
>> 	CXT5051_F700,       /* HP Compaq Presario F700 */
>> 	CXT5051_TOSHIBA,	/* Toshiba M300 & co */
>> +	CXT5051_IDEAPAD,	/* Lenovo IdeaPad Y430 */
>> 	CXT5051_MODELS
>> };
>> 
>> @@ -1927,6 +1940,7 @@ static const char *cxt5051_models[CXT5051_MODELS] = {
>> 	[CXT5051_LENOVO_X200]	= "lenovo-x200",
>> 	[CXT5051_F700]          = "hp-700",
>> 	[CXT5051_TOSHIBA]	= "toshiba",
>> +	[CXT5051_IDEAPAD]	= "ideapad",
>> };
>> 
>> static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
>> @@ -1938,6 +1952,7 @@ static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
>> 		      CXT5051_LAPTOP),
>> 	SND_PCI_QUIRK(0x14f1, 0x5051, "HP Spartan 1.1", CXT5051_HP),
>> 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo X200", CXT5051_LENOVO_X200),
>> +	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo IdeaPad", CXT5051_IDEAPAD),
>> 	{}
>> };
>> 
>> @@ -1999,6 +2014,11 @@ static int patch_cxt5051(struct hda_codec *codec)
>> 		spec->mixers[0] = cxt5051_toshiba_mixers;
>> 		spec->auto_mic = AUTO_MIC_PORTB;
>> 		break;
>> +	case CXT5051_IDEAPAD:
>> +		spec->init_verbs[spec->num_init_verbs++] =
>> +			cxt5051_ideapad_init_verbs;
>> +		spec->ideapad = 1;
>> +		break;
>> 	}
>> 
>> 	return 0;
>> -- 
>> 1.7.1
>> 
> 
> 
> ------------------------------
> 
> Message: 6
> Date: Fri, 18 Jun 2010 07:39:07 +0800
> From: Raymond Yau <superquad.vortex2@gmail.com>
> Subject: Re: [alsa-devel] snd_mixer_selem_get_playback_volume return
> 	value	outside allowed range
> To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
> Message-ID:
> 	<AANLkTin7y2JzkaCYb4p69uDfWOo4cTa85in0Q3l7RwbD@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
> 
> 2010/6/17 Clemens Ladisch <clemens@ladisch.de>
> 
>> Raymond Yau wrote:
>>> Should snd_mixer_selem_get_playback_volume() perform range check ?
>> 
>> No, it's the responsibility of the control implementation to return
>> valid values (and to check that values that are being set are valid).
>> 
>> 
>> Regards,
>> Clemens
>> 
> 
> If it is the responsibility of the driver/external plugin to keep the value
> inside the allowed range
> 
> your patch actually help those buggy driver/external plugin hide the bug
> only
> 
> 
> ------------------------------
> 
> Message: 7
> Date: Fri, 18 Jun 2010 01:56:37 +0100
> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Subject: Re: [alsa-devel] [PATCH] eukrea-tlv320: add support for our
> 	i.MX25	board
> To: Eric B?nard <eric@eukrea.com>
> Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de,
> 	lrg@slimlogic.co.uk
> Message-ID: <20100618005637.GA3333@opensource.wolfsonmicro.com>
> Content-Type: text/plain; charset=iso-8859-1
> 
> On Thu, Jun 17, 2010 at 03:44:01PM +0200, Eric B?nard wrote:
>> * tdm slot has to be configured to get sound working on i.MX25
>> 
>> Signed-off-by: Eric B?nard <eric@eukrea.com>
> 
> Applied but I had to hand apply the Kconfig update, please check that it
> applied correctly.
> 
> 
> ------------------------------
> 
> Message: 8
> Date: Fri, 18 Jun 2010 12:38:10 +1000
> From: Stuart Longland <redhatter@gentoo.org>
> Subject: [alsa-devel] SOC_DOUBLE_R_SX_TLV (was Update on TLV320AIC3204
> 	Driver)
> To: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,	Eric
> 	B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
> Message-ID: <20100618023810.GS7759@www.longlandclan.yi.org>
> Content-Type: text/plain; charset=us-ascii
> 
> On Tue, Jun 15, 2010 at 03:11:10PM +1000, Stuart Longland wrote:
>> When a read is performed, this structure points to this function as the
>> means for reading the register (defined in sound/soc-core.c):
>> 
>> /**
>> * snd_soc_get_volsw_2r_sx - double with tlv and variable data size
>> *  mixer get callback
>> * @kcontrol: mixer control
>> * @uinfo: control element information
>> *
>> * Returns 0 for success.
>> */
>> int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
>>                        struct snd_ctl_elem_value *ucontrol)
>> {
>>        struct soc_mixer_control *mc =
>>                (struct soc_mixer_control *)kcontrol->private_value;
>>        struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>>        unsigned int mask = (1<<mc->shift)-1;
>>        int min = mc->min;
>>        int val = snd_soc_read(codec, mc->reg) & mask;
>>        int valr = snd_soc_read(codec, mc->rreg) & mask;
>> 
>>        ucontrol->value.integer.value[0] = ((val & 0xff)-min);
>>        ucontrol->value.integer.value[1] = ((valr & 0xff)-min);
>>        return 0;
>> }
>> EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r_sx);
> 
> I've figured it out now... and there'll be a patch to fix it.
> 
> The mute <--> gain interaction was pure coincidence as it turns out.
> There's no interaction between the two, just that when I toggle the
> mute, the gain gets re-read, and hence it *appeared* to interact.
> 
> Notice the value calculated for the channel is:
> 
> 	output = ( regval & 0xff ) - minimum
> 
> In my case, my minimum is -6.  Suppose I set my driver gain to -1dB, in
> hexadecimal, 0x3f.  Since no sign extension is done, (regval & 0xff) =
> 63.  Adding 6 to this (double negation) you get 69... which is greater
> than the maximum gain of 29.  Hence the scale shoots up to maximum.
> 
> The fix, is to change the above so that they mask the result; thus
> wrapping around the zero point like so:
> 
> 	output = ( ( regval & 0xff ) - minimum ) & mask
> 
> This fixes the problem that I observe, and shouldn't break the other
> user of the control.  A patch to fix this issue is coming.
> -- 
> Stuart Longland (aka Redhatter, VK4MSL)      .'''.
> Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
> . . . . . . . . . . . . . . . . . . . . . .   .'.'
> http://dev.gentoo.org/~redhatter             :.'
> 
> I haven't lost my mind...
>  ...it's backed up on a tape somewhere.
> 
> 
> ------------------------------
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
> End of Alsa-devel Digest, Vol 40, Issue 80
> ******************************************
