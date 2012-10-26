From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: arizona: Define standard hookup for
	ADSP2
Date: Fri, 26 Oct 2012 19:36:33 +0100
Message-ID: <1351276594-30453-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1351276594-30453-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE979265B77
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 20:36:37 +0200 (CEST)
In-Reply-To: <1351276594-30453-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Many Arizona class devices contain ADSP2 cores with a standard method for
hooking them into the audio map. Define standard helpers for this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.h |   47 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 36ec649..5a09127 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -17,6 +17,8 @@
 
 #include <sound/soc.h>
 
+#include "wm_adsp.h"
+
 #define ARIZONA_CLK_SYSCLK         1
 #define ARIZONA_CLK_ASYNCCLK       2
 #define ARIZONA_CLK_OPCLK          3
@@ -46,15 +48,18 @@
 #define ARIZONA_MIXER_VOL_SHIFT                 1
 #define ARIZONA_MIXER_VOL_WIDTH                 7
 
-#define ARIZONA_MAX_DAI 3
+#define ARIZONA_MAX_DAI  4
+#define ARIZONA_MAX_ADSP 4
 
 struct arizona;
+struct wm_adsp;
 
 struct arizona_dai_priv {
 	int clk;
 };
 
 struct arizona_priv {
+	struct wm_adsp adsp[ARIZONA_MAX_ADSP];
 	struct arizona *arizona;
 	int sysclk;
 	int asyncclk;
@@ -99,6 +104,20 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	static ARIZONA_MUX_CTL_DECL(name##_in3); \
 	static ARIZONA_MUX_CTL_DECL(name##_in4)
 
+#define ARIZONA_DSP_AUX_ENUMS(name, base_reg) \
+	static ARIZONA_MUX_ENUM_DECL(name##_aux1_enum, base_reg);	\
+	static ARIZONA_MUX_ENUM_DECL(name##_aux2_enum, base_reg + 8);	\
+	static ARIZONA_MUX_ENUM_DECL(name##_aux3_enum, base_reg + 16);	\
+	static ARIZONA_MUX_ENUM_DECL(name##_aux4_enum, base_reg + 24);	\
+	static ARIZONA_MUX_ENUM_DECL(name##_aux5_enum, base_reg + 32);	\
+	static ARIZONA_MUX_ENUM_DECL(name##_aux6_enum, base_reg + 40);	\
+	static ARIZONA_MUX_CTL_DECL(name##_aux1); \
+	static ARIZONA_MUX_CTL_DECL(name##_aux2); \
+	static ARIZONA_MUX_CTL_DECL(name##_aux3); \
+	static ARIZONA_MUX_CTL_DECL(name##_aux4); \
+	static ARIZONA_MUX_CTL_DECL(name##_aux5); \
+	static ARIZONA_MUX_CTL_DECL(name##_aux6)
+
 #define ARIZONA_MUX(name, ctrl) \
 	SND_SOC_DAPM_VALUE_MUX(name, SND_SOC_NOPM, 0, 0, ctrl)
 
@@ -109,6 +128,16 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	ARIZONA_MUX(name_str " Input 4", &name##_in4_mux), \
 	SND_SOC_DAPM_MIXER(name_str " Mixer", SND_SOC_NOPM, 0, 0, NULL, 0)
 
+#define ARIZONA_DSP_WIDGETS(name, name_str) \
+	ARIZONA_MIXER_WIDGETS(name##L, name_str "L"), \
+	ARIZONA_MIXER_WIDGETS(name##R, name_str "R"), \
+	ARIZONA_MUX(name_str " Aux 1", &name##_aux1_mux), \
+	ARIZONA_MUX(name_str " Aux 2", &name##_aux2_mux), \
+	ARIZONA_MUX(name_str " Aux 3", &name##_aux3_mux), \
+	ARIZONA_MUX(name_str " Aux 4", &name##_aux4_mux), \
+	ARIZONA_MUX(name_str " Aux 5", &name##_aux5_mux), \
+	ARIZONA_MUX(name_str " Aux 6", &name##_aux6_mux)
+
 #define ARIZONA_MIXER_ROUTES(widget, name) \
 	{ widget, NULL, name " Mixer" },         \
 	{ name " Mixer", NULL, name " Input 1" }, \
@@ -120,6 +149,22 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	ARIZONA_MIXER_INPUT_ROUTES(name " Input 3"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Input 4")
 
+#define ARIZONA_DSP_ROUTES(name) \
+	{ name, NULL, name " Aux 1" }, \
+	{ name, NULL, name " Aux 2" }, \
+	{ name, NULL, name " Aux 3" }, \
+	{ name, NULL, name " Aux 4" }, \
+	{ name, NULL, name " Aux 5" }, \
+	{ name, NULL, name " Aux 6" }, \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 1"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 2"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 3"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 4"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 5"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 6"), \
+	ARIZONA_MIXER_ROUTES(name, name "L"), \
+	ARIZONA_MIXER_ROUTES(name, name "R")
+
 extern const struct soc_enum arizona_lhpf1_mode;
 extern const struct soc_enum arizona_lhpf2_mode;
 extern const struct soc_enum arizona_lhpf3_mode;
-- 
1.7.10.4
