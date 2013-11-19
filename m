From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Add post SYSCLK register patch
	for rev D chip
Date: Tue, 19 Nov 2013 10:51:29 +0000
Message-ID: <1384858289-25396-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D2CC2610C7
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 11:52:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Certain registers require patching after the SYSCLK has been brought up
add support for this into the CODEC driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index f2d1094..c3c7396 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -37,6 +37,47 @@ struct wm5110_priv {
 	struct arizona_fll fll[2];
 };
 
+static const struct reg_default wm5110_sysclk_revd_patch[] = {
+	{ 0x3093, 0x1001 },
+	{ 0x30E3, 0x1301 },
+	{ 0x3133, 0x1201 },
+	{ 0x3183, 0x1501 },
+	{ 0x31D3, 0x1401 },
+};
+
+static int wm5110_sysclk_ev(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	struct regmap *regmap = codec->control_data;
+	const struct reg_default *patch = NULL;
+	int i, patch_size;
+
+	switch (arizona->rev) {
+	case 3:
+		patch = wm5110_sysclk_revd_patch;
+		patch_size = ARRAY_SIZE(wm5110_sysclk_revd_patch);
+		break;
+	default:
+		return 0;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (patch)
+			for (i = 0; i < patch_size; i++)
+				regmap_write(regmap, patch[i].reg,
+					     patch[i].def);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
@@ -400,7 +441,7 @@ static const struct snd_kcontrol_new wm5110_aec_loopback_mux =
 
 static const struct snd_soc_dapm_widget wm5110_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
-		    0, NULL, 0),
+		    0, wm5110_sysclk_ev, SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_SUPPLY("ASYNCCLK", ARIZONA_ASYNC_CLOCK_1,
 		    ARIZONA_ASYNC_CLK_ENA_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("OPCLK", ARIZONA_OUTPUT_SYSTEM_CLOCK,
-- 
1.7.2.5
