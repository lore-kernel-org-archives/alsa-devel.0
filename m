From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel][PATCH 3.0]ASoC: ad193x: add
 spi_hw_read, fix sysclk and register definition
Date: Thu, 11 Aug 2011 04:52:18 -0400
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
References: <CAHG8p1B2HB61yooEsPwzw+4E60ffM2NUsb98yCsanfPnWD9vgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <CAHG8p1B2HB61yooEsPwzw+4E60ffM2NUsb98yCsanfPnWD9vgA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
>[mailto:uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org] On
>Behalf Of Scott Jiang
>Sent: Thursday, August 11, 2011 4:27 PM
>To: Greg Kroah-Hartman
>Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org;
>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>Subject: [uclinux-dist-devel] [alsa-devel][PATCH 3.0]ASoC:
>ad193x: add spi_hw_read, fix sysclk and register definition
>
>asoc cache layer can't support this kind of spi registers, so
>bypass cache and read regiters directly
>

This patch is against stable kernel 3.0 only, the ASOC framework in kernel 3.1 and later are different.

Sonic

>Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> sound/soc/blackfin/bf5xx-ad193x.c |    2 +-
> sound/soc/codecs/ad193x.c         |    8 ++++++--
> sound/soc/codecs/ad193x.h         |    5 +++--
> sound/soc/soc-cache.c             |   23 +++++++++++++++++++++++
> 4 files changed, 33 insertions(+), 5 deletions(-)
>
>diff --git a/sound/soc/blackfin/bf5xx-ad193x.c
>b/sound/soc/blackfin/bf5xx-ad193x.c
>index d40cf68..417200b 100644
>--- a/sound/soc/blackfin/bf5xx-ad193x.c
>+++ b/sound/soc/blackfin/bf5xx-ad193x.c
>@@ -56,7 +56,7 @@ static int bf5xx_ad193x_hw_params(struct
>snd_pcm_substream *substream,
>
>       switch (params_rate(params)) {
>       case 48000:
>-              clk = 12288000;
>+              clk = 24576000;
>               break;
>       }
>
>diff --git a/sound/soc/codecs/ad193x.c
>b/sound/soc/codecs/ad193x.c index 2374ca5..1447cc8 100644
>--- a/sound/soc/codecs/ad193x.c
>+++ b/sound/soc/codecs/ad193x.c
>@@ -307,7 +307,8 @@ static int ad193x_hw_params(struct
>snd_pcm_substream *substream,
>       snd_soc_write(codec, AD193X_PLL_CLK_CTRL0, reg);
>
>       reg = snd_soc_read(codec, AD193X_DAC_CTRL2);
>-      reg = (reg & (~AD193X_DAC_WORD_LEN_MASK)) | word_len;
>+      reg = (reg & (~AD193X_DAC_WORD_LEN_MASK))
>+              | (word_len << AD193X_DAC_WORD_LEN_SHFT);
>       snd_soc_write(codec, AD193X_DAC_CTRL2, reg);
>
>       reg = snd_soc_read(codec, AD193X_ADC_CTRL1); @@ -361,7
>+362,10 @@ static int ad193x_probe(struct snd_soc_codec *codec)
>               dev_err(codec->dev, "failed to set cache I/O:
>%d\n", ret);
>               return ret;
>       }
>-
>+#if defined(CONFIG_SPI_MASTER)
>+      /* asoc cache layer can't support this kind of spi
>registers now */
>+      codec->cache_bypass = 1;
>+#endif
>       /* default setting for ad193x */
>
>       /* unmute dac channels */
>diff --git a/sound/soc/codecs/ad193x.h
>b/sound/soc/codecs/ad193x.h index 9747b54..cccc2e8 100644
>--- a/sound/soc/codecs/ad193x.h
>+++ b/sound/soc/codecs/ad193x.h
>@@ -34,7 +34,8 @@
> #define AD193X_DAC_LEFT_HIGH    (1 << 3)
> #define AD193X_DAC_BCLK_INV     (1 << 7)
> #define AD193X_DAC_CTRL2        0x804
>-#define AD193X_DAC_WORD_LEN_MASK      0xC
>+#define AD193X_DAC_WORD_LEN_SHFT        3
>+#define AD193X_DAC_WORD_LEN_MASK        0x18
> #define AD193X_DAC_MASTER_MUTE  1
> #define AD193X_DAC_CHNL_MUTE    0x805
> #define AD193X_DACL1_MUTE       0
>@@ -63,7 +64,7 @@
> #define AD193X_ADC_CTRL1        0x80f
> #define AD193X_ADC_SERFMT_MASK                0x60
> #define AD193X_ADC_SERFMT_STEREO      (0 << 5)
>-#define AD193X_ADC_SERFMT_TDM         (1 << 2)
>+#define AD193X_ADC_SERFMT_TDM         (1 << 5)
> #define AD193X_ADC_SERFMT_AUX         (2 << 5)
> #define AD193X_ADC_WORD_LEN_MASK      0x3
> #define AD193X_ADC_CTRL2        0x810
>diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
>index 039b953..d9e9682 100644
>--- a/sound/soc/soc-cache.c
>+++ b/sound/soc/soc-cache.c
>@@ -233,6 +233,25 @@ static unsigned int
>snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,  #define
>snd_soc_16_8_read_i2c NULL  #endif
>
>+#if defined(CONFIG_SPI_MASTER)
>+static unsigned int snd_soc_16_8_read_spi(struct snd_soc_codec *codec,
>+                                        unsigned int r)
>+{
>+      struct spi_device *spi = codec->control_data;
>+
>+      const u16 reg = cpu_to_be16(r | 0x100);
>+      u8 data;
>+      int ret;
>+
>+      ret = spi_write_then_read(spi, &reg, 2, &data, 1);
>+      if (ret < 0)
>+              return 0;
>+      return data;
>+}
>+#else
>+#define snd_soc_16_8_read_spi NULL
>+#endif
>+
> static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
>                                     unsigned int reg)
> {
>@@ -337,6 +356,7 @@ static struct {
>       int (*write)(struct snd_soc_codec *codec, unsigned int,
>unsigned int);
>       unsigned int (*read)(struct snd_soc_codec *, unsigned int);
>       unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
>+      unsigned int (*spi_read)(struct snd_soc_codec *, unsigned int);
> } io_types[] = {
>       {
>               .addr_bits = 4, .data_bits = 12,
>@@ -360,6 +380,7 @@ static struct {
>               .addr_bits = 16, .data_bits = 8,
>               .write = snd_soc_16_8_write, .read = snd_soc_16_8_read,
>               .i2c_read = snd_soc_16_8_read_i2c,
>+              .spi_read = snd_soc_16_8_read_spi,
>       },
>       {
>               .addr_bits = 16, .data_bits = 16,
>@@ -425,6 +446,8 @@ int snd_soc_codec_set_cache_io(struct
>snd_soc_codec *codec,  #ifdef CONFIG_SPI_MASTER
>               codec->hw_write = do_spi_write;
> #endif
>+              if (io_types[i].spi_read)
>+                      codec->hw_read = io_types[i].spi_read;
>
>               codec->control_data = container_of(codec->dev,
>                                                  struct spi_device,
>--
>1.7.0.4
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
>
