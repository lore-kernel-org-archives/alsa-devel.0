From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 03/11] wss_lib: rename cs4321_foo to wss_foo
Date: Tue, 05 Aug 2008 05:41:01 +0200
Message-ID: <4897CBCD.4080909@keyaccess.nl>
References: <20080731210341.969b54be.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D7ED24524
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 05:41:05 +0200 (CEST)
In-Reply-To: <20080731210341.969b54be.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 31-07-08 21:03, Krzysztof Helt wrote:

Takashi, you already applied these but is it possible to still get my 
Acked-by (or Reviewed-by, whatever you want) on them? When a problem is 
bisected to one of these, people tend to put the people in the patch 
tags in CC and I looked at them and would like to be informed of any 
trouble. I tested most users by now, and we'll get the azt2320 fixed 
before this hits the streets but I still like to be in the loop on any 
traffic concerning them.

Acked-by: Rene Herman <rene.herman@gmail.com>

(or Reviewed-by, Tested-by, ...)

Below comments not important:

> @@ -679,23 +679,25 @@ static int __devinit snd_opl3sa2_probe(s

[ ... ]

> -	chip->cs4231 = cs4231;
> -	if ((err = snd_cs4231_pcm(cs4231, 0, NULL)) < 0)
> +	chip->wss = wss;
> +	err = snd_wss_pcm(wss, 0, NULL);
> +	if (err < 0)
>  		return err;
> -	if ((err = snd_cs4231_mixer(cs4231)) < 0)
> +	err = snd_wss_mixer(wss);
> +	if (err < 0)
>  		return err;
>  	if ((err = snd_opl3sa2_mixer(chip)) < 0)
>  		return err;

<mumble>

> -	if ((err = snd_cs4231_timer(cs4231, 0, NULL)) < 0)
> +	err = snd_wss_timer(wss, 0, NULL);
> +	if (err < 0)
>  		return err;

[ ... ]

> +static void snd_wss_debug(struct snd_wss *chip)

> +	printk(KERN_DEBUG
> +		"  0x00: left input      = 0x%02x  "
> +		"  0x10: alt 1 (CFIG 2)  = 0x%02x\n",
> +					snd_wss_in(chip, 0x00),
> +					snd_wss_in(chip, 0x10));
> +	printk(KERN_DEBUG
> +		"  0x01: right input     = 0x%02x  "
> +		"  0x11: alt 2 (CFIG 3)  = 0x%02x\n",
> +					snd_wss_in(chip, 0x01),
> +					snd_wss_in(chip, 0x11));

I'll admit that's actually half-way passable...

> @@ -553,79 +628,88 @@ static void snd_wss_playback_format(s

[ ... ]

>  	if (full_calib) {
> -		snd_cs4231_mce_up(chip);
> +		snd_wss_mce_up(chip);
>  		spin_lock_irqsave(&chip->reg_lock, flags);
> -		if (chip->hardware != CS4231_HW_INTERWAVE && !chip->single_dma) {
> -			snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
> -					(chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE) ?
> -					(pdfr & 0xf0) | (chip->image[CS4231_REC_FORMAT] & 0x0f) :
> -				        pdfr);
> +		if (chip->hardware != WSS_HW_INTERWAVE && !chip->single_dma) {
> +			if (chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE)
> +				pdfr = (pdfr & 0xf0) |
> +				       (chip->image[CS4231_REC_FORMAT] & 0x0f);
>  		} else {
> -			snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
> +			chip->image[CS4231_PLAYBK_FORMAT] = pdfr;
>  		}
> +		snd_wss_out(chip, CS4231_PLAYBK_FORMAT, pdfr);
>  		spin_unlock_irqrestore(&chip->reg_lock, flags);

Much beter.

> +static void snd_wss_capture_format(struct snd_wss *chip,

[ ... ]

> -			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] | 0x20);
> -			snd_cs4231_out(chip, CS4231_REC_FORMAT, chip->image[CS4231_REC_FORMAT] = cdfr);
> -			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] &= ~0x20);
> +			snd_wss_out(chip, CS4231_ALT_FEATURE_1,
> +				chip->image[CS4231_ALT_FEATURE_1] | 0x20);
> +			snd_wss_out(chip, CS4231_REC_FORMAT,
> +				chip->image[CS4231_REC_FORMAT] = cdfr);

Not much better...

> +			snd_wss_out(chip, CS4231_ALT_FEATURE_1,
> +				chip->image[CS4231_ALT_FEATURE_1] &= ~0x20);

Same level of betterness.

Rene.
