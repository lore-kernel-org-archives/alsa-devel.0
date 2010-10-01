From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8940: incorrect mask for BCLKDIV
Date: Fri, 1 Oct 2010 19:13:39 +0100
Message-ID: <20101001181338.GA12031@sirena.org.uk>
References: <4CA59A8F.3000800@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ECC4103A14
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 20:13:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CA59A8F.3000800@elproma.com.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 01, 2010 at 10:23:43AM +0200, Grzegorz Daniluk wrote:
> corrected bitmask in BCLKDIV setting (wm8940_set_dai_clkdiv) and
> bias_level in wm8940 register function.

This doesn't correspond to the contents of the patch?

You also need to provide a Signed-off-by for your patches - the meaning
and purpose of this is covered in Documentation/SubmittingPatches.
Please remember to CC maintainers on patches also.

> ----
> diff -urN a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
> --- a/sound/soc/codecs/wm8940.c    2010-04-16 11:10:10.000000000 +0000
> +++ b/sound/soc/codecs/wm8940.c    2010-09-29 14:12:17.263497290 +0000
> @@ -514,7 +514,7 @@
> 
>      if ((Ndiv < 6) || (Ndiv > 12))
>          printk(KERN_WARNING
> -            "WM8940 N value %d outwith recommended range!d\n",
> +            "WM8940 N value %d outwith recommended range!\n",
>              Ndiv);
> 
>      pll_div.n = Ndiv;

This is a typo fix, it's fine but should ideally be submitted as a
separate patch and should at least be noted in the changelog.

> @@ -604,7 +604,7 @@
> 
>      switch (div_id) {
>      case WM8940_BCLKDIV:
> -        reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFFEF3;
> +        reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFFE3;
>          ret = snd_soc_write(codec, WM8940_CLOCK, reg | (div << 2));
>          break;
>      case WM8940_MCLKDIV:

This is the bit from the changelog, this looks like a good fix.

> @@ -800,9 +800,10 @@
> 
>      wm8940_dai.dev = codec->dev;
> 
> -    wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +    wm8940_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
> 
> -    ret = snd_soc_write(codec, WM8940_POWER1, 0x180);
> +    reg = snd_soc_read(codec, WM8940_POWER1);
> +    ret = snd_soc_write(codec, WM8940_POWER1, reg | 0x180);
>      if (ret < 0)
>          return ret;

These are another separate change which wasn't mentioned in the
changelog.  I don't understand the purpose of this change but it doesn't
look like a change I'd expect to see made.
