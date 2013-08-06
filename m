From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Correct input OSR bits for wm5110
Date: Tue,  6 Aug 2013 17:03:55 +0100
Message-ID: <1375805035-22463-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B956426087E
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 18:12:39 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The input OSR bits are specified differently for wm5110 than for current
revs of wm5102. This patch corrects support for this on wm5110.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   20 ++++++++++++++++++++
 sound/soc/codecs/arizona.h |    1 +
 sound/soc/codecs/wm5110.c  |   12 ++++--------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 8dc6881..779a0ee 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -553,6 +553,26 @@ const struct soc_enum arizona_ng_hold =
 			4, arizona_ng_hold_text);
 EXPORT_SYMBOL_GPL(arizona_ng_hold);
 
+static const char * const arizona_in_dmic_osr_text[] = {
+	"1.536MHz", "3.072MHz", "6.144MHz",
+};
+
+const struct soc_enum arizona_in_dmic_osr[] = {
+	SOC_ENUM_SINGLE(ARIZONA_IN1L_CONTROL, ARIZONA_IN1_OSR_SHIFT,
+			ARRAY_SIZE(arizona_in_dmic_osr_text),
+			arizona_in_dmic_osr_text),
+	SOC_ENUM_SINGLE(ARIZONA_IN2L_CONTROL, ARIZONA_IN2_OSR_SHIFT,
+			ARRAY_SIZE(arizona_in_dmic_osr_text),
+			arizona_in_dmic_osr_text),
+	SOC_ENUM_SINGLE(ARIZONA_IN3L_CONTROL, ARIZONA_IN3_OSR_SHIFT,
+			ARRAY_SIZE(arizona_in_dmic_osr_text),
+			arizona_in_dmic_osr_text),
+	SOC_ENUM_SINGLE(ARIZONA_IN4L_CONTROL, ARIZONA_IN4_OSR_SHIFT,
+			ARRAY_SIZE(arizona_in_dmic_osr_text),
+			arizona_in_dmic_osr_text),
+};
+EXPORT_SYMBOL_GPL(arizona_in_dmic_osr);
+
 static void arizona_in_set_vu(struct snd_soc_codec *codec, int ena)
 {
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index fe1b794..b6b6d70 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -198,6 +198,7 @@ extern const struct soc_enum arizona_lhpf3_mode;
 extern const struct soc_enum arizona_lhpf4_mode;
 
 extern const struct soc_enum arizona_ng_hold;
+extern const struct soc_enum arizona_in_dmic_osr[];
 
 extern int arizona_in_ev(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index fc41037..77fd531 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -58,14 +58,10 @@ static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 	SOC_SINGLE(name " NG SPKDAT2R Switch", base, 11, 1, 0)
 
 static const struct snd_kcontrol_new wm5110_snd_controls[] = {
-SOC_SINGLE("IN1 High Performance Switch", ARIZONA_IN1L_CONTROL,
-	   ARIZONA_IN1_OSR_SHIFT, 1, 0),
-SOC_SINGLE("IN2 High Performance Switch", ARIZONA_IN2L_CONTROL,
-	   ARIZONA_IN2_OSR_SHIFT, 1, 0),
-SOC_SINGLE("IN3 High Performance Switch", ARIZONA_IN3L_CONTROL,
-	   ARIZONA_IN3_OSR_SHIFT, 1, 0),
-SOC_SINGLE("IN4 High Performance Switch", ARIZONA_IN4L_CONTROL,
-	   ARIZONA_IN4_OSR_SHIFT, 1, 0),
+SOC_ENUM("IN1 OSR", arizona_in_dmic_osr[0]),
+SOC_ENUM("IN2 OSR", arizona_in_dmic_osr[1]),
+SOC_ENUM("IN3 OSR", arizona_in_dmic_osr[2]),
+SOC_ENUM("IN4 OSR", arizona_in_dmic_osr[3]),
 
 SOC_SINGLE_RANGE_TLV("IN1L Volume", ARIZONA_IN1L_CONTROL,
 		     ARIZONA_IN1L_PGA_VOL_SHIFT, 0x40, 0x5f, 0, ana_tlv),
-- 
1.7.2.5
