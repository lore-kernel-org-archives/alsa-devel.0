From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove direct register cache accesses
	from WM8962 driver
Date: Fri, 23 Sep 2011 21:36:38 +0100
Message-ID: <1316810199-29396-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7F8C72448D
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 22:36:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Also fix return values for speaker switch updates.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 59b2ad6..c2f68aa 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2141,7 +2141,6 @@ static int wm8962_put_spk_sw(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	u16 *reg_cache = codec->reg_cache;
 	int ret;
 
 	/* Apply the update (if any) */
@@ -2150,16 +2149,19 @@ static int wm8962_put_spk_sw(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	/* If the left PGA is enabled hit that VU bit... */
-	if (reg_cache[WM8962_PWR_MGMT_2] & WM8962_SPKOUTL_PGA_ENA)
-		return snd_soc_write(codec, WM8962_SPKOUTL_VOLUME,
-				     reg_cache[WM8962_SPKOUTL_VOLUME]);
+	ret = snd_soc_read(codec, WM8962_PWR_MGMT_2);
+	if (ret & WM8962_SPKOUTL_PGA_ENA) {
+		snd_soc_write(codec, WM8962_SPKOUTL_VOLUME,
+			      snd_soc_read(codec, WM8962_SPKOUTL_VOLUME));
+		return 1;
+	}
 
 	/* ...otherwise the right.  The VU is stereo. */
-	if (reg_cache[WM8962_PWR_MGMT_2] & WM8962_SPKOUTR_PGA_ENA)
-		return snd_soc_write(codec, WM8962_SPKOUTR_VOLUME,
-				     reg_cache[WM8962_SPKOUTR_VOLUME]);
+	if (ret & WM8962_SPKOUTR_PGA_ENA)
+		snd_soc_write(codec, WM8962_SPKOUTR_VOLUME,
+			      snd_soc_read(codec, WM8962_SPKOUTR_VOLUME));
 
-	return 0;
+	return 1;
 }
 
 static const char *cap_hpf_mode_text[] = {
@@ -2500,7 +2502,6 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	u16 *reg_cache = codec->reg_cache;
 	int reg;
 
 	switch (w->shift) {
@@ -2523,7 +2524,7 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		return snd_soc_write(codec, reg, reg_cache[reg]);
+		return snd_soc_write(codec, reg, snd_soc_read(codec, reg));
 	default:
 		BUG();
 		return -EINVAL;
-- 
1.7.6.3
