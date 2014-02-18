From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 097/102] ASoC: wm8960: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:43 +0100
Message-ID: <1392724308-13375-17-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 53A42265768
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
 sound/soc/codecs/wm8960.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index f156010e52bc..79cf2d6c459e 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -138,12 +138,12 @@ static const char *wm8960_alcfunc[] = {"Off", "Right", "Left", "Stereo"};
 static const char *wm8960_alcmode[] = {"ALC", "Limiter"};
 
 static const struct soc_enum wm8960_enum[] = {
-	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
-	SOC_ENUM_SINGLE(WM8960_DACCTL2, 5, 4, wm8960_polarity),
-	SOC_ENUM_SINGLE(WM8960_3D, 6, 2, wm8960_3d_upper_cutoff),
-	SOC_ENUM_SINGLE(WM8960_3D, 5, 2, wm8960_3d_lower_cutoff),
-	SOC_ENUM_SINGLE(WM8960_ALC1, 7, 4, wm8960_alcfunc),
-	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
+	SOC_ENUM_SINGLE_CONST(WM8960_DACCTL1, 5, wm8960_polarity),
+	SOC_ENUM_SINGLE_CONST(WM8960_DACCTL2, 5, wm8960_polarity),
+	SOC_ENUM_SINGLE_CONST(WM8960_3D, 6, wm8960_3d_upper_cutoff),
+	SOC_ENUM_SINGLE_CONST(WM8960_3D, 5, wm8960_3d_lower_cutoff),
+	SOC_ENUM_SINGLE_CONST(WM8960_ALC1, 7, wm8960_alcfunc),
+	SOC_ENUM_SINGLE_CONST(WM8960_ALC3, 8, wm8960_alcmode),
 };
 
 static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
-- 
1.8.5.2
