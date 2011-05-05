From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/12] ASoC: SSM2602: Cleanup coeff handling
Date: Thu,  5 May 2011 16:59:10 +0200
Message-ID: <1304607560-15083-2-git-send-email-lars@metafoo.de>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id 1D5E91039F5
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:43 +0200 (CEST)
In-Reply-To: <1304607560-15083-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

Drop unused field from the coeff struct, precalculate the srate register at
compile-time and cleanup up the naming.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |   75 ++++++++++++++++++++-----------------------
 1 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 7e21949..d536820 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -167,83 +167,78 @@ static int ssm2602_add_widgets(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct _coeff_div {
+struct ssm2602_coeff {
 	u32 mclk;
 	u32 rate;
-	u16 fs;
-	u8 sr:4;
-	u8 bosr:1;
-	u8 usb:1;
+	u8 srate;
 };
 
-/* codec mclk clock divider coefficients */
-static const struct _coeff_div coeff_div[] = {
+#define SSM2602_COEFF_SRATE(sr, bosr, usb) (((sr) << 2) | ((bosr) << 1) | (usb))
+
+/* codec mclk clock coefficients */
+static const struct ssm2602_coeff ssm2602_coeff_table[] = {
 	/* 48k */
-	{12288000, 48000, 256, 0x0, 0x0, 0x0},
-	{18432000, 48000, 384, 0x0, 0x1, 0x0},
-	{12000000, 48000, 250, 0x0, 0x0, 0x1},
+	{12288000, 48000, SSM2602_COEFF_SRATE(0x0, 0x0, 0x0)},
+	{18432000, 48000, SSM2602_COEFF_SRATE(0x0, 0x1, 0x0)},
+	{12000000, 48000, SSM2602_COEFF_SRATE(0x0, 0x0, 0x1)},
 
 	/* 32k */
-	{12288000, 32000, 384, 0x6, 0x0, 0x0},
-	{18432000, 32000, 576, 0x6, 0x1, 0x0},
-	{12000000, 32000, 375, 0x6, 0x0, 0x1},
+	{12288000, 32000, SSM2602_COEFF_SRATE(0x6, 0x0, 0x0)},
+	{18432000, 32000, SSM2602_COEFF_SRATE(0x6, 0x1, 0x0)},
+	{12000000, 32000, SSM2602_COEFF_SRATE(0x6, 0x0, 0x1)},
 
 	/* 8k */
-	{12288000, 8000, 1536, 0x3, 0x0, 0x0},
-	{18432000, 8000, 2304, 0x3, 0x1, 0x0},
-	{11289600, 8000, 1408, 0xb, 0x0, 0x0},
-	{16934400, 8000, 2112, 0xb, 0x1, 0x0},
-	{12000000, 8000, 1500, 0x3, 0x0, 0x1},
+	{12288000, 8000, SSM2602_COEFF_SRATE(0x3, 0x0, 0x0)},
+	{18432000, 8000, SSM2602_COEFF_SRATE(0x3, 0x1, 0x0)},
+	{11289600, 8000, SSM2602_COEFF_SRATE(0xb, 0x0, 0x0)},
+	{16934400, 8000, SSM2602_COEFF_SRATE(0xb, 0x1, 0x0)},
+	{12000000, 8000, SSM2602_COEFF_SRATE(0x3, 0x0, 0x1)},
 
 	/* 96k */
-	{12288000, 96000, 128, 0x7, 0x0, 0x0},
-	{18432000, 96000, 192, 0x7, 0x1, 0x0},
-	{12000000, 96000, 125, 0x7, 0x0, 0x1},
+	{12288000, 96000, SSM2602_COEFF_SRATE(0x7, 0x0, 0x0)},
+	{18432000, 96000, SSM2602_COEFF_SRATE(0x7, 0x1, 0x0)},
+	{12000000, 96000, SSM2602_COEFF_SRATE(0x7, 0x0, 0x1)},
 
 	/* 44.1k */
-	{11289600, 44100, 256, 0x8, 0x0, 0x0},
-	{16934400, 44100, 384, 0x8, 0x1, 0x0},
-	{12000000, 44100, 272, 0x8, 0x1, 0x1},
+	{11289600, 44100, SSM2602_COEFF_SRATE(0x8, 0x0, 0x0)},
+	{16934400, 44100, SSM2602_COEFF_SRATE(0x8, 0x1, 0x0)},
+	{12000000, 44100, SSM2602_COEFF_SRATE(0x8, 0x1, 0x1)},
 
 	/* 88.2k */
-	{11289600, 88200, 128, 0xf, 0x0, 0x0},
-	{16934400, 88200, 192, 0xf, 0x1, 0x0},
-	{12000000, 88200, 136, 0xf, 0x1, 0x1},
+	{11289600, 88200, SSM2602_COEFF_SRATE(0xf, 0x0, 0x0)},
+	{16934400, 88200, SSM2602_COEFF_SRATE(0xf, 0x1, 0x0)},
+	{12000000, 88200, SSM2602_COEFF_SRATE(0xf, 0x1, 0x1)},
 };
 
-static inline int get_coeff(int mclk, int rate)
+static inline int ssm2602_get_coeff(int mclk, int rate)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(coeff_div); i++) {
-		if (coeff_div[i].rate == rate && coeff_div[i].mclk == mclk)
-			return i;
+	for (i = 0; i < ARRAY_SIZE(ssm2602_coeff_table); i++) {
+		if (ssm2602_coeff_table[i].rate == rate &&
+			ssm2602_coeff_table[i].mclk == mclk)
+			return ssm2602_coeff_table[i].srate;
 	}
-	return i;
+	return -EINVAL;
 }
 
 static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	u16 srate;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, SSM2602_IFACE) & 0xfff3;
-	int i = get_coeff(ssm2602->sysclk, params_rate(params));
+	int srate = ssm2602_get_coeff(ssm2602->sysclk, params_rate(params));
 
 	if (substream == ssm2602->slave_substream) {
 		dev_dbg(codec->dev, "Ignoring hw_params for slave substream\n");
 		return 0;
 	}
 
-	/*no match is found*/
-	if (i == ARRAY_SIZE(coeff_div))
-		return -EINVAL;
-
-	srate = (coeff_div[i].sr << 2) |
-		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
+	if (srate < 0)
+		return srate;
 
 	snd_soc_write(codec, SSM2602_ACTIVE, 0);
 	snd_soc_write(codec, SSM2602_SRATE, srate);
-- 
1.7.2.5
