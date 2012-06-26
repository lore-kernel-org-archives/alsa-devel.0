From: =?UTF-8?B?UHJjaGFsIEppxZnDrQ==?= <jiri.prchal@aksignal.cz>
Subject: [PATCH] ASoC: tlv320aic3x: add input clock selection
Date: Tue, 26 Jun 2012 12:21:28 +0200
Message-ID: <4FE98D28.8050908@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C3CA245F7
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 12:21:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vbarinov@embeddedalley.com, mr.swami.reddy@ti.com, peter.ujfalusi@ti.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, sudhakar.raj@ti.com, nsekhar@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

This patch adds input selection of main codec clock - from what pin.
Tested with TLV320AIC3106 on BCLK and MCLK.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>

--- /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.c.orig
+++ /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.c
@@ -972,6 +972,10 @@
  	struct snd_soc_codec *codec = codec_dai->codec;
  	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);

+	/* set clock on MCLK or GPIO2 or BCLK */
+	snd_soc_update_bits(codec, AIC3X_CLKGEN_CTRL_REG, PLLCLK_IN_MASK, clk_id);
+	snd_soc_update_bits(codec, AIC3X_CLKGEN_CTRL_REG, CLKDIV_IN_MASK, clk_id);
+
  	aic3x->sysclk = freq;
  	return 0;
  }

--- /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.h.orig
+++ /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.h
@@ -178,6 +178,13 @@
  #define PLL_CLKIN_SHIFT		4
  #define MCLK_SOURCE		0x0
  #define PLL_CLKDIV_SHIFT	0
+#define PLLCLK_IN_MASK		0x30
+#define CLKDIV_IN_MASK		0xc0
+/* clock in source */
+#define CLKIN_MCLK		0
+#define CLKIN_GPIO2		1
+#define CLKIN_BCLK		2
+

  /* Software reset register bits */
  #define SOFT_RESET		0x80
