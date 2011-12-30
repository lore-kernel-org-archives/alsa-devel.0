From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: Fix return value of
	wm8580_set_sysclk()
Date: Fri, 30 Dec 2011 23:36:23 +0800
Message-ID: <1325259383.4755.2.camel@phoenix>
References: <1325259294.4755.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A2259103ACB
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:36:31 +0100 (CET)
Received: by yhjj56 with SMTP id j56so8333170yhj.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 07:36:31 -0800 (PST)
In-Reply-To: <1325259294.4755.1.camel@phoenix>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

We can't just pass back the return value of snd_soc_update_bits() as it
will be 1 if a bit changed rather than zero.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8580.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index b1c8d3d..2112851 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -670,7 +670,7 @@ static int wm8580_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
-	int sel, sel_mask, sel_shift;
+	int ret, sel, sel_mask, sel_shift;
 
 	switch (dai->driver->id) {
 	case WM8580_DAI_PAIFRX:
@@ -711,7 +711,11 @@ static int wm8580_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	/* We really should validate PLL settings but not yet */
 	wm8580->sysclk[dai->driver->id] = freq;
 
-	return snd_soc_update_bits(codec, WM8580_CLKSEL, sel_mask, sel);
+	ret = snd_soc_update_bits(codec, WM8580_CLKSEL, sel_mask, sel);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int wm8580_digital_mute(struct snd_soc_dai *codec_dai, int mute)
-- 
1.7.5.4
