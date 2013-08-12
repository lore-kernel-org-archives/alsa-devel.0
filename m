From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Add widget<->mux route into mux
	route macro
Date: Mon, 12 Aug 2013 11:33:32 +0100
Message-ID: <1376303612-28203-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65BF72610B5
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 12:42:44 +0200 (CEST)
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

The routes linking the widget and the input mux were being added
manually, rather than by the ARIZONA_MUX_ROUTES macro. This patchs adds
the routes to the macro.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.h |    3 ++-
 sound/soc/codecs/wm5102.c  |   41 ++++++++++++-----------------------------
 sound/soc/codecs/wm5110.c  |    8 ++++----
 3 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index b60b08c..bf67d65 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -150,7 +150,8 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	ARIZONA_MUX(name_str " Aux 5", &name##_aux5_mux), \
 	ARIZONA_MUX(name_str " Aux 6", &name##_aux6_mux)
 
-#define ARIZONA_MUX_ROUTES(name) \
+#define ARIZONA_MUX_ROUTES(widget, name) \
+	{ widget, NULL, name " Input" }, \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Input")
 
 #define ARIZONA_MIXER_ROUTES(widget, name) \
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 282fd23..9e9a0c1 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1499,23 +1499,6 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "IN3L PGA", NULL, "IN3L" },
 	{ "IN3R PGA", NULL, "IN3R" },
 
-	{ "ASRC1L", NULL, "ASRC1L Input" },
-	{ "ASRC1R", NULL, "ASRC1R Input" },
-	{ "ASRC2L", NULL, "ASRC2L Input" },
-	{ "ASRC2R", NULL, "ASRC2R Input" },
-
-	{ "ISRC1DEC1", NULL, "ISRC1DEC1 Input" },
-	{ "ISRC1DEC2", NULL, "ISRC1DEC2 Input" },
-
-	{ "ISRC1INT1", NULL, "ISRC1INT1 Input" },
-	{ "ISRC1INT2", NULL, "ISRC1INT2 Input" },
-
-	{ "ISRC2DEC1", NULL, "ISRC2DEC1 Input" },
-	{ "ISRC2DEC2", NULL, "ISRC2DEC2 Input" },
-
-	{ "ISRC2INT1", NULL, "ISRC2INT1 Input" },
-	{ "ISRC2INT2", NULL, "ISRC2INT2 Input" },
-
 	ARIZONA_MIXER_ROUTES("OUT1L", "HPOUT1L"),
 	ARIZONA_MIXER_ROUTES("OUT1R", "HPOUT1R"),
 	ARIZONA_MIXER_ROUTES("OUT2L", "HPOUT2L"),
@@ -1567,22 +1550,22 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	ARIZONA_MIXER_ROUTES("LHPF3", "LHPF3"),
 	ARIZONA_MIXER_ROUTES("LHPF4", "LHPF4"),
 
-	ARIZONA_MUX_ROUTES("ASRC1L"),
-	ARIZONA_MUX_ROUTES("ASRC1R"),
-	ARIZONA_MUX_ROUTES("ASRC2L"),
-	ARIZONA_MUX_ROUTES("ASRC2R"),
+	ARIZONA_MUX_ROUTES("ASRC1L", "ASRC1L"),
+	ARIZONA_MUX_ROUTES("ASRC1R", "ASRC1R"),
+	ARIZONA_MUX_ROUTES("ASRC2L", "ASRC2L"),
+	ARIZONA_MUX_ROUTES("ASRC2R", "ASRC2R"),
 
-	ARIZONA_MUX_ROUTES("ISRC1INT1"),
-	ARIZONA_MUX_ROUTES("ISRC1INT2"),
+	ARIZONA_MUX_ROUTES("ISRC1INT1", "ISRC1INT1"),
+	ARIZONA_MUX_ROUTES("ISRC1INT2", "ISRC1INT2"),
 
-	ARIZONA_MUX_ROUTES("ISRC1DEC1"),
-	ARIZONA_MUX_ROUTES("ISRC1DEC2"),
+	ARIZONA_MUX_ROUTES("ISRC1DEC1", "ISRC1DEC1"),
+	ARIZONA_MUX_ROUTES("ISRC1DEC2", "ISRC1DEC2"),
 
-	ARIZONA_MUX_ROUTES("ISRC2INT1"),
-	ARIZONA_MUX_ROUTES("ISRC2INT2"),
+	ARIZONA_MUX_ROUTES("ISRC2INT1", "ISRC2INT1"),
+	ARIZONA_MUX_ROUTES("ISRC2INT2", "ISRC2INT2"),
 
-	ARIZONA_MUX_ROUTES("ISRC2DEC1"),
-	ARIZONA_MUX_ROUTES("ISRC2DEC2"),
+	ARIZONA_MUX_ROUTES("ISRC2DEC1", "ISRC2DEC1"),
+	ARIZONA_MUX_ROUTES("ISRC2DEC2", "ISRC2DEC2"),
 
 	ARIZONA_DSP_ROUTES("DSP1"),
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 2e7cb4b..0cfc5e6 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -979,10 +979,10 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	ARIZONA_MIXER_ROUTES("LHPF3", "LHPF3"),
 	ARIZONA_MIXER_ROUTES("LHPF4", "LHPF4"),
 
-	ARIZONA_MUX_ROUTES("ASRC1L"),
-	ARIZONA_MUX_ROUTES("ASRC1R"),
-	ARIZONA_MUX_ROUTES("ASRC2L"),
-	ARIZONA_MUX_ROUTES("ASRC2R"),
+	ARIZONA_MUX_ROUTES("ASRC1L", "ASRC1L"),
+	ARIZONA_MUX_ROUTES("ASRC1R", "ASRC1R"),
+	ARIZONA_MUX_ROUTES("ASRC2L", "ASRC2L"),
+	ARIZONA_MUX_ROUTES("ASRC2R", "ASRC2R"),
 
 	{ "HPOUT1L", NULL, "OUT1L" },
 	{ "HPOUT1R", NULL, "OUT1R" },
-- 
1.7.2.5
