From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs4341: Add driver for CS4341
 CODEC
Date: Wed, 21 Sep 2016 02:38:49 +0000
Message-ID: <6d495e97-4677-4f1b-9a19-b3c92e4ca606@EX4.ad.cirrus.com>
References: <1473352169-23954-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 53DA6261A5E
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 04:38:53 +0200 (CEST)
In-Reply-To: <1473352169-23954-1-git-send-email-shc_work@mail.ru>
Content-Language: en-US
Content-ID: <C1A8BC6A0F6DB5429EEDCC2AC79A0294@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 9/8/16, 11:29 AM, "Alexander Shiyan" <shc_work@mail.ru> wrote:

>diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>index 1cd6ab3..9853e79 100644
>--- a/sound/soc/codecs/Kconfig
>+++ b/sound/soc/codecs/Kconfig
>@@ -458,6 +458,13 @@ config SND_SOC_CS42XX8_I2C
> 	select SND_SOC_CS42XX8
> 	select REGMAP_I2C
> 
>+config SND_SOC_CS4341
>+	tristate "Cirrus Logic CS4341 CODEC"
>+	depends on SPI_MASTER
>+	select REGMAP_SPI
>+	help
>+	  Enable support for Cirrus Logic (Crystal) CS4341 CODEC.
>+
This devices primary interface is I2C.  That should be added as well since
i2c is read/write and spi is write only.

> # Cirrus Logic CS4349 HiFi DAC
> config SND_SOC_CS4349
> 	tristate "Cirrus Logic CS4349 CODEC"

>
>+#define CS4341_REG_MODE1	0x00
>+#define CS4341_REG_MODE2	0x01
>+#define CS4341_REG_MIX		0x02
>+#define CS4341_REG_VOLA		0x03
>+#define CS4341_REG_VOLB		0x04
>+
>+#define CS4341_MODE2_DIF	(7 << 4)
>+#define CS4341_MODE2_DIF_I2S_24	(0 << 4)
>+#define CS4341_MODE2_DIF_I2S_16	(1 << 4)
>+#define CS4341_MODE2_DIF_LJ_24	(2 << 4)
>+#define CS4341_MODE2_DIF_RJ_24	(3 << 4)
>+#define CS4341_MODE2_DIF_RJ_16	(5 << 4)
>+
>+#define CS4341_VOLX_MUTE	(1 << 7)

It would be a good idea to clean up the indentation here.


>+	switch (cs4341->fmt) {
>+	case SND_SOC_DAIFMT_I2S:
>+		snd_soc_update_bits(codec, CS4341_REG_MODE2, CS4341_MODE2_DIF,
>+				    bits24 ? CS4341_MODE2_DIF_I2S_24 :
>+				    CS4341_MODE2_DIF_I2S_16);
>+		break;
>+	case SND_SOC_DAIFMT_LEFT_J:
>+		snd_soc_update_bits(codec, CS4341_REG_MODE2, CS4341_MODE2_DIF,
>+				    CS4341_MODE2_DIF_LJ_24);
>+		break;
>+	case SND_SOC_DAIFMT_RIGHT_J:
>+		snd_soc_update_bits(codec, CS4341_REG_MODE2, CS4341_MODE2_DIF,
>+				    bits24 ? CS4341_MODE2_DIF_RJ_24 :
>+				    CS4341_MODE2_DIF_RJ_16);
>+		break;
>+	default:
>+		dev_err(codec->dev, "Unsupported DAI format\n");
>+		return -EINVAL;
>+	}

Can we use regmap_update_bits where we can?
>+
>+	return 0;
>+}
>+
>+static int cs4341_digital_mute(struct snd_soc_dai *dai, int mute)
>+{
>+	struct snd_soc_codec *codec = dai->codec;
>+	int ret;
>+
>+	ret = snd_soc_update_bits(codec, CS4341_REG_VOLA, CS4341_VOLX_MUTE,
>+				  mute ? CS4341_VOLX_MUTE : 0);
>+	if (ret < 0)
>+		return ret;
>+
>+	return snd_soc_update_bits(codec, CS4341_REG_VOLB, CS4341_VOLX_MUTE,
>+				   mute ? CS4341_VOLX_MUTE : 0);
regmap_update_bits

>+}
>+
>
>
>
