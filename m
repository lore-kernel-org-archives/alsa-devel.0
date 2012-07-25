From: Paul Freeman <alsa-dev@lists-in.noc4.net>
Subject: Re: VIA VT2021 Support
Date: Wed, 25 Jul 2012 11:57:12 +0100
Message-ID: <f608ff05e8f13c045bcec908f7067e53@noc4.net>
References: <fdaab1c5aa7d31421f010c8b895af801@noc4.net>
 <s5hzk6pqgg6.wl%tiwai@suse.de>
Reply-To: alsa-dev@lists-in.noc4.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta2.mx.noc4.net (mta2.mx.noc4.net [176.67.161.177])
 by alsa0.perex.cz (Postfix) with ESMTP id DC310265300
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 12:56:05 +0200 (CEST)
Received: from unknown (HELO www.noc4.net) (176.67.161.175)
 by mta2.mx.noc4.net with SMTP for <alsa-devel@alsa-project.org>;
 25 Jul 2012 10:56:06 -0000
In-Reply-To: <s5hzk6pqgg6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Alsa Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> seems the list's SPAM filter thought the message including full
>> alsa-info.sh output was to large.. so resorting so pastebin
>> http://pastebin.com/7iSFm3mp
>
> Thanks.  Actually VT2021 is identical with VT2020 from the spec POV,
> so it should be fully supported.
>
> The lack of the headphone output is because of the wrong power state
> handling.  The patch below should fix the issue.  Give it a try.
>
> If it still doesn't and the node 0x0b shows the power state D3, it
> means that the jack detection doesn't work properly on your machine.

this patch works perfectly, great :)

> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
> index 9064556..80d90cb 100644
> --- a/sound/pci/hda/patch_via.c
> +++ b/sound/pci/hda/patch_via.c
> @@ -3226,7 +3226,7 @@ static void
> set_widgets_power_state_vt1718S(struct hda_codec *codec)
>  {
>  	struct via_spec *spec = codec->spec;
>  	int imux_is_smixer;
> -	unsigned int parm;
> +	unsigned int parm, parm2;
>  	/* MUX6 (1eh) = stereo mixer */
>  	imux_is_smixer =
>  	snd_hda_codec_read(codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) 
> == 5;
> @@ -3249,7 +3249,7 @@ static void
> set_widgets_power_state_vt1718S(struct hda_codec *codec)
>  	parm = AC_PWRST_D3;
>  	set_pin_power_state(codec, 0x27, &parm);
>  	update_power_state(codec, 0x1a, parm);
> -	update_power_state(codec, 0xb, parm);
> +	parm2 = parm; /* for pin 0x0b */
>
>  	/* PW2 (26h), AOW2 (ah) */
>  	parm = AC_PWRST_D3;
> @@ -3264,6 +3264,9 @@ static void
> set_widgets_power_state_vt1718S(struct hda_codec *codec)
>  	if (!spec->hp_independent_mode) /* check for redirected HP */
>  		set_pin_power_state(codec, 0x28, &parm);
>  	update_power_state(codec, 0x8, parm);
> +	if (!spec->hp_independent_mode && parm2 != AC_PWRST_D3)
> +		parm = parm2;
> +	update_power_state(codec, 0xb, parm);
>  	/* MW9 (21h), Mw2 (1ah), AOW0 (8h) */
>  	update_power_state(codec, 0x21, imux_is_smixer ? AC_PWRST_D0 : 
> parm);
