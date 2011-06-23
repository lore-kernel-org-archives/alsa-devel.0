From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Thu, 23 Jun 2011 18:40:47 +0200
Message-ID: <4E036C8F.3080709@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org> <s5h39j0zpnc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id A2B8124575
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 18:40:54 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1605749fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 09:40:51 -0700 (PDT)
In-Reply-To: <s5h39j0zpnc.wl%tiwai@suse.de>
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

On 23/06/2011 14:41, Takashi Iwai wrote:
> At Thu, 23 Jun 2011 08:36:55 +0200,
> Julian Sikorski wrote:
>>
>> Hi,
>>
>> I am coming here from pulseaudio-general mailing list [1]. I recently
>> got myself a Clevo P150HM laptop. It has 2.1 speakers, a built-in
>> microphone and the following connectors:
>> - headphone out
>> - microphone in; can be switched to center/lfe out
>> - spdif out; can be switched to rear speaker out
>> - line in; can be switched to side speaker out
>> Alsa does not seem to reflect that the device is capable of 5.1 and 7.1
>> sound, and there are two configs showing up in pavucontrol (analog
>> output and analog headphones) which seem to be the same. I have uploaded
>> the output of alsa-info.sh [2]. Please let me know if more information
>> is needed.
>
> The current parser doesn't allow the multi-io pins when the primary
> output is no line-out.  The patch below should fix (change) the
> behavior.  It'll count HP out, too.
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index fe56b2b..b0cf726 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -18992,6 +18992,7 @@ static int alc662_auto_fill_dac_nids(struct hda_codec *codec,
>   	hda_nid_t dac;
>
>   	spec->multiout.dac_nids = spec->private_dac_nids;
> +	spec->multiout.num_dacs = 0;
>   	for (i = 0; i<  cfg->line_outs; i++) {
>   		dac = alc_auto_look_for_dac(codec, cfg->line_out_pins[i]);
>   		if (!dac)
> @@ -19326,8 +19327,20 @@ static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
>   	unsigned int location, defcfg;
>   	int num_pins;
>
> +	if (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT&&  cfg->hp_outs == 1) {
> +		/* use HP as primary out */
> +		cfg->speaker_outs = cfg->line_outs;
> +		memcpy(cfg->speaker_pins, cfg->line_out_pins,
> +		       sizeof(cfg->speaker_pins));
> +		cfg->line_outs = cfg->hp_outs;
> +		memcpy(cfg->line_out_pins, cfg->hp_pins, sizeof(cfg->hp_pins));
> +		cfg->hp_outs = 0;
> +		memset(cfg->hp_pins, 0, sizeof(cfg->hp_pins));
> +		cfg->line_out_type = AUTO_PIN_HP_OUT;
> +		alc662_auto_fill_dac_nids(codec, cfg);
> +	}
>   	if (cfg->line_outs != 1 ||
> -	    cfg->line_out_type != AUTO_PIN_LINE_OUT)
> +	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
>   		return 0;
>
>   	defcfg = snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0]);
> @@ -19348,6 +19361,8 @@ static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
>   		spec->multi_ios = num_pins;
>   		spec->ext_channel_count = 2;
>   		spec->multiout.num_dacs = num_pins + 1;
> +		/* for avoiding multi HP mixers */
> +		cfg->line_out_type = AUTO_PIN_LINE_OUT;
>   	}
>   	return 0;
>   }
Would you like me to test this patch? If so, what should I apply it to 
and how should I proceed?

Julian
