From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] ASoC: Manage mode and rate bits correctly for
	CS4271 CODEC.
Date: Sat, 05 Mar 2011 03:55:12 +0300
Message-ID: <1299286512.27359.101.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward8.mail.yandex.net (forward8.mail.yandex.net
	[77.88.61.38]) by alsa0.perex.cz (Postfix) with ESMTP id 3E7382438A
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 01:55:15 +0100 (CET)
Received: from smtp7.mail.yandex.net (smtp7.mail.yandex.net [77.88.61.55])
	by forward8.mail.yandex.net (Yandex) with ESMTP id 8889AF60CAC
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 03:55:14 +0300 (MSK)
Received: from [192.168.1.202] (ppp91-77-173-192.pppoe.mtu-net.ru
	[91.77.173.192])
	by smtp7.mail.yandex.net (Yandex) with ESMTPA id 4539A48C8054
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 03:55:14 +0300 (MSK)
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

From: Alexander Sverdlin <subaparts@yandex.ru>

Manage mode and rate bits correctly, according to datasheet in CS4271 CODEC.
This is done to make capture work properly.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/codecs/cs4271.c |   83 ++++++++++++++++++++++++++++----------------
 1 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index e5cc4da..c71ad08 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -168,27 +168,6 @@ struct cs4271_private {
 	int				gpio_disable;
 };
 
-struct cs4271_clk_cfg {
-	unsigned int	ratio;		/* MCLK / sample rate */
-	u8		speed_mode;	/* codec speed mode: 1x, 2x, 4x */
-	u8		mclk_master;	/* ratio bit mask for Master mode */
-	u8		mclk_slave;	/* ratio bit mask for Slave mode */
-};
-
-static struct cs4271_clk_cfg cs4271_clk_tab[] = {
-	{64,   CS4271_MODE1_MODE_4X, CS4271_MODE1_DIV_1,  CS4271_MODE1_DIV_1},
-	{96,   CS4271_MODE1_MODE_4X, CS4271_MODE1_DIV_15, CS4271_MODE1_DIV_1},
-	{128,  CS4271_MODE1_MODE_2X, CS4271_MODE1_DIV_1,  CS4271_MODE1_DIV_1},
-	{192,  CS4271_MODE1_MODE_2X, CS4271_MODE1_DIV_15, CS4271_MODE1_DIV_1},
-	{256,  CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_1,  CS4271_MODE1_DIV_1},
-	{384,  CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_15, CS4271_MODE1_DIV_1},
-	{512,  CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_2,  CS4271_MODE1_DIV_1},
-	{768,  CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_3,  CS4271_MODE1_DIV_3},
-	{1024, CS4271_MODE1_MODE_1X, CS4271_MODE1_DIV_3,  CS4271_MODE1_DIV_3}
-};
-
-#define CS4171_NR_RATIOS ARRAY_SIZE(cs4271_clk_tab)
-
 /*
  * @freq is the desired MCLK rate
  * MCLK rate should (c) be the sample rate, multiplied by one of the
@@ -297,6 +276,45 @@ static int cs4271_put_deemph(struct snd_kcontrol *kcontrol,
 	return cs4271_set_deemph(codec);
 }
 
+struct cs4271_clk_cfg {
+	bool		master;		/* codec mode */
+	u8		speed_mode;	/* codec speed mode: 1x, 2x, 4x */
+	unsigned short	ratio;		/* MCLK / sample rate */
+	u8		ratio_mask;	/* ratio bit mask for Master mode */
+};
+
+static struct cs4271_clk_cfg cs4271_clk_tab[] = {
+	{1, CS4271_MODE1_MODE_1X, 256,  CS4271_MODE1_DIV_1},
+	{1, CS4271_MODE1_MODE_1X, 384,  CS4271_MODE1_DIV_15},
+	{1, CS4271_MODE1_MODE_1X, 512,  CS4271_MODE1_DIV_2},
+	{1, CS4271_MODE1_MODE_1X, 768,  CS4271_MODE1_DIV_3},
+	{1, CS4271_MODE1_MODE_2X, 128,  CS4271_MODE1_DIV_1},
+	{1, CS4271_MODE1_MODE_2X, 192,  CS4271_MODE1_DIV_15},
+	{1, CS4271_MODE1_MODE_2X, 256,  CS4271_MODE1_DIV_2},
+	{1, CS4271_MODE1_MODE_2X, 384,  CS4271_MODE1_DIV_3},
+	{1, CS4271_MODE1_MODE_4X, 64,   CS4271_MODE1_DIV_1},
+	{1, CS4271_MODE1_MODE_4X, 96,   CS4271_MODE1_DIV_15},
+	{1, CS4271_MODE1_MODE_4X, 128,  CS4271_MODE1_DIV_2},
+	{1, CS4271_MODE1_MODE_4X, 192,  CS4271_MODE1_DIV_3},
+	{0, CS4271_MODE1_MODE_1X, 256,  CS4271_MODE1_DIV_1},
+	{0, CS4271_MODE1_MODE_1X, 384,  CS4271_MODE1_DIV_1},
+	{0, CS4271_MODE1_MODE_1X, 512,  CS4271_MODE1_DIV_1},
+	{0, CS4271_MODE1_MODE_1X, 768,  CS4271_MODE1_DIV_2},
+	{0, CS4271_MODE1_MODE_1X, 1024, CS4271_MODE1_DIV_2},
+	{0, CS4271_MODE1_MODE_2X, 128,  CS4271_MODE1_DIV_1},
+	{0, CS4271_MODE1_MODE_2X, 192,  CS4271_MODE1_DIV_1},
+	{0, CS4271_MODE1_MODE_2X, 256,  CS4271_MODE1_DIV_1},
+	{0, CS4271_MODE1_MODE_2X, 384,  CS4271_MODE1_DIV_2},
+	{0, CS4271_MODE1_MODE_2X, 512,  CS4271_MODE1_DIV_2},
+	{0, CS4271_MODE1_MODE_4X, 64,   CS4271_MODE1_DIV_1},
+	{0, CS4271_MODE1_MODE_4X, 96,   CS4271_MODE1_DIV_1},
+	{0, CS4271_MODE1_MODE_4X, 128,  CS4271_MODE1_DIV_1},
+	{0, CS4271_MODE1_MODE_4X, 192,  CS4271_MODE1_DIV_2},
+	{0, CS4271_MODE1_MODE_4X, 256,  CS4271_MODE1_DIV_2},
+};
+
+#define CS4171_NR_RATIOS ARRAY_SIZE(cs4271_clk_tab)
+
 static int cs4271_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
@@ -308,23 +326,28 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 	unsigned int ratio, val;
 
 	cs4271->rate = params_rate(params);
+
+	/* Configure DAC */
+	if (cs4271->rate < 50000)
+		val = CS4271_MODE1_MODE_1X;
+	else if (cs4271->rate < 100000)
+		val = CS4271_MODE1_MODE_2X;
+	else
+		val = CS4271_MODE1_MODE_4X;
+
 	ratio = cs4271->mclk / cs4271->rate;
 	for (i = 0; i < CS4171_NR_RATIOS; i++)
-		if (cs4271_clk_tab[i].ratio == ratio)
+		if ((cs4271_clk_tab[i].master == cs4271->master) &&
+		    (cs4271_clk_tab[i].speed_mode == val) &&
+		    (cs4271_clk_tab[i].ratio == ratio))
 			break;
 
-	if ((i == CS4171_NR_RATIOS) || ((ratio == 1024) && cs4271->master)) {
+	if (i == CS4171_NR_RATIOS) {
 		dev_err(codec->dev, "Invalid sample rate\n");
 		return -EINVAL;
 	}
 
-	/* Configure DAC */
-	val = cs4271_clk_tab[i].speed_mode;
-
-	if (cs4271->master)
-		val |= cs4271_clk_tab[i].mclk_master;
-	else
-		val |= cs4271_clk_tab[i].mclk_slave;
+	val |= cs4271_clk_tab[i].ratio_mask;
 
 	ret = snd_soc_update_bits(codec, CS4271_MODE1,
 		CS4271_MODE1_MODE_MASK | CS4271_MODE1_DIV_MASK, val);
