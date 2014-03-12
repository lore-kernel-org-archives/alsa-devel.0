From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320aic23: Remove spurious bits
	per word setting
Date: Wed, 12 Mar 2014 21:30:30 +0400
Message-ID: <CAMo8BfLxDUC=wFKdcp2X0X2Fu6XdjyL30mF7Not2uMxddaOEqA@mail.gmail.com>
References: <1394631195-10480-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f46.google.com (mail-oa0-f46.google.com
 [209.85.219.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 257DA264F4B
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 18:30:32 +0100 (CET)
Received: by mail-oa0-f46.google.com with SMTP id i7so10548199oag.33
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 10:30:30 -0700 (PDT)
In-Reply-To: <1394631195-10480-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 12, 2014 at 5:33 PM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> regmap should handle any byte ordering issues required, it is looking for
> a byte stream from the bus, so don't set 16 bits per word. This is likely
> to have tested out OK due to use of an unmerged SPI controller driver.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/codecs/tlv320aic23-spi.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Max Filippov <jcmvbkbc@gmail.com>

> diff --git a/sound/soc/codecs/tlv320aic23-spi.c b/sound/soc/codecs/tlv320aic23-spi.c
> index 585aea436c6a..3b387e41d75d 100644
> --- a/sound/soc/codecs/tlv320aic23-spi.c
> +++ b/sound/soc/codecs/tlv320aic23-spi.c
> @@ -25,7 +25,6 @@ static int aic23_spi_probe(struct spi_device *spi)
>
>         dev_dbg(&spi->dev, "probing tlv320aic23 spi device\n");
>
> -       spi->bits_per_word = 16;
>         spi->mode = SPI_MODE_0;
>         ret = spi_setup(spi);
>         if (ret < 0)
> --
> 1.9.0
>

-- 
Thanks.
-- Max
