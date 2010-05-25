From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 5/7] ASoC: TWL4030: Helper to check chip
 default registers
Date: Tue, 25 May 2010 12:57:24 +0100
Message-ID: <1274788644.3000.151.camel@odin>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
	<1274787248-18583-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 720B4244B3
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 13:57:29 +0200 (CEST)
Received: by wwb18 with SMTP id 18so793057wwb.38
	for <alsa-devel@alsa-project.org>; Tue, 25 May 2010 04:57:28 -0700 (PDT)
In-Reply-To: <1274787248-18583-6-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-05-25 at 14:34 +0300, Peter Ujfalusi wrote:
> Since the twl4030 codec driver supports different version
> of the PM chip, a helper function can come handy, which
> can check the driver's default versus the chip values.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/twl4030.c |   23 +++++++++++++++++++++++
>  sound/soc/codecs/twl4030.h |    1 +
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 08f24de..4220c8d 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -243,6 +243,25 @@ static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
>  	udelay(10);
>  }
>  
> +static inline void twl4030_check_defaults(struct snd_soc_codec *codec)
> +{
> +	int i, difference = 0;
> +	u8 val;
> +
> +	dev_info(codec->dev, "Checking TWL audio default configuration\n");
> +	for (i = 1; i <= TWL4030_REG_MISC_SET_2; i++) {
> +		twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &val, i);
> +		if (val != twl4030_reg[i]) {
> +			difference++;
> +			dev_info(codec->dev,
> +				 "Reg 0x%02x: chip: 0x%02x driver: 0x%02x\n",
> +				 i, val, twl4030_reg[i]);
> +		}
> +	}
> +	dev_info(codec->dev, "Found %d non maching registers. %s\n",

matching

> +		 difference, difference ? "Not OK" : "OK");
> +}
> +
>  static void twl4030_init_chip(struct platform_device *pdev)
>  {
>  	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> @@ -252,6 +271,10 @@ static void twl4030_init_chip(struct platform_device *pdev)
>  	u8 reg, byte;
>  	int i = 0;
>  
> +	/* Check defaults, if instructed before anythiing else */
> +	if (setup && setup->check_defaults)
> +		twl4030_check_defaults(codec);
> +

Is this purely for information/debug purposes ?

Why do we need to check default vales at init(). Is there another driver
changing the audio codec registers ?

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
