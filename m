From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 099/102] ASoC: wm8974: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:45 +0100
Message-ID: <1392724308-13375-19-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B76E265770
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:52 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

... for improving readability and maintainability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8974.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 6e16c4306461..cc30ec5b844d 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -63,23 +63,23 @@ static const char *wm8974_eq5[] = {"5.3kHz", "6.9kHz", "9kHz", "11.7kHz" };
 static const char *wm8974_alc[] = {"ALC", "Limiter" };
 
 static const struct soc_enum wm8974_enum[] = {
-	SOC_ENUM_SINGLE(WM8974_COMP, 1, 4, wm8974_companding), /* adc */
-	SOC_ENUM_SINGLE(WM8974_COMP, 3, 4, wm8974_companding), /* dac */
-	SOC_ENUM_SINGLE(WM8974_DAC,  4, 4, wm8974_deemp),
-	SOC_ENUM_SINGLE(WM8974_EQ1,  8, 2, wm8974_eqmode),
-
-	SOC_ENUM_SINGLE(WM8974_EQ1,  5, 4, wm8974_eq1),
-	SOC_ENUM_SINGLE(WM8974_EQ2,  8, 2, wm8974_bw),
-	SOC_ENUM_SINGLE(WM8974_EQ2,  5, 4, wm8974_eq2),
-	SOC_ENUM_SINGLE(WM8974_EQ3,  8, 2, wm8974_bw),
-
-	SOC_ENUM_SINGLE(WM8974_EQ3,  5, 4, wm8974_eq3),
-	SOC_ENUM_SINGLE(WM8974_EQ4,  8, 2, wm8974_bw),
-	SOC_ENUM_SINGLE(WM8974_EQ4,  5, 4, wm8974_eq4),
-	SOC_ENUM_SINGLE(WM8974_EQ5,  8, 2, wm8974_bw),
-
-	SOC_ENUM_SINGLE(WM8974_EQ5,  5, 4, wm8974_eq5),
-	SOC_ENUM_SINGLE(WM8974_ALC3,  8, 2, wm8974_alc),
+	SOC_ENUM_SINGLE_CONST(WM8974_COMP, 1, wm8974_companding), /* adc */
+	SOC_ENUM_SINGLE_CONST(WM8974_COMP, 3, wm8974_companding), /* dac */
+	SOC_ENUM_SINGLE_CONST(WM8974_DAC,  4, wm8974_deemp),
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ1,  8, wm8974_eqmode),
+
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ1,  5, wm8974_eq1),
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ2,  8, wm8974_bw),
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ2,  5, wm8974_eq2),
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ3,  8, wm8974_bw),
+
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ3,  5, wm8974_eq3),
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ4,  8, wm8974_bw),
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ4,  5, wm8974_eq4),
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ5,  8, wm8974_bw),
+
+	SOC_ENUM_SINGLE_CONST(WM8974_EQ5,  5, wm8974_eq5),
+	SOC_ENUM_SINGLE_CONST(WM8974_ALC3, 8, wm8974_alc),
 };
 
 static const char *wm8974_auxmode_text[] = { "Buffer", "Mixer" };
-- 
1.8.5.2
