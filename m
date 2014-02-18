From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 098/102] ASoC: wm8971: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:44 +0100
Message-ID: <1392724308-13375-18-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AD30265771
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
 sound/soc/codecs/wm8971.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 67aba78a7ca5..54fda9dc434d 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -113,20 +113,20 @@ static const char *wm8971_adcpol[] = {"Normal", "L Invert", "R Invert",
 	"L + R Invert"};
 
 static const struct soc_enum wm8971_enum[] = {
-	SOC_ENUM_SINGLE(WM8971_BASS, 7, 2, wm8971_bass),	/* 0 */
-	SOC_ENUM_SINGLE(WM8971_BASS, 6, 2, wm8971_bass_filter),
-	SOC_ENUM_SINGLE(WM8971_TREBLE, 6, 2, wm8971_treble),
-	SOC_ENUM_SINGLE(WM8971_ALC1, 7, 4, wm8971_alc_func),
-	SOC_ENUM_SINGLE(WM8971_NGATE, 1, 2, wm8971_ng_type),    /* 4 */
-	SOC_ENUM_SINGLE(WM8971_ADCDAC, 1, 4, wm8971_deemp),
-	SOC_ENUM_SINGLE(WM8971_ADCTL1, 4, 4, wm8971_mono_mux),
-	SOC_ENUM_SINGLE(WM8971_ADCTL1, 1, 2, wm8971_dac_phase),
-	SOC_ENUM_SINGLE(WM8971_LOUTM1, 0, 5, wm8971_lline_mux), /* 8 */
-	SOC_ENUM_SINGLE(WM8971_ROUTM1, 0, 5, wm8971_rline_mux),
-	SOC_ENUM_SINGLE(WM8971_LADCIN, 6, 4, wm8971_lpga_sel),
-	SOC_ENUM_SINGLE(WM8971_RADCIN, 6, 4, wm8971_rpga_sel),
-	SOC_ENUM_SINGLE(WM8971_ADCDAC, 5, 4, wm8971_adcpol),    /* 12 */
-	SOC_ENUM_SINGLE(WM8971_ADCIN, 6, 4, wm8971_mono_mux),
+	SOC_ENUM_SINGLE_CONST(WM8971_BASS, 7, wm8971_bass),	/* 0 */
+	SOC_ENUM_SINGLE_CONST(WM8971_BASS, 6, wm8971_bass_filter),
+	SOC_ENUM_SINGLE_CONST(WM8971_TREBLE, 6, wm8971_treble),
+	SOC_ENUM_SINGLE_CONST(WM8971_ALC1, 7, wm8971_alc_func),
+	SOC_ENUM_SINGLE_CONST(WM8971_NGATE, 1, wm8971_ng_type),    /* 4 */
+	SOC_ENUM_SINGLE_CONST(WM8971_ADCDAC, 1, wm8971_deemp),
+	SOC_ENUM_SINGLE_CONST(WM8971_ADCTL1, 4, wm8971_mono_mux),
+	SOC_ENUM_SINGLE_CONST(WM8971_ADCTL1, 1, wm8971_dac_phase),
+	SOC_ENUM_SINGLE_CONST(WM8971_LOUTM1, 0, wm8971_lline_mux), /* 8 */
+	SOC_ENUM_SINGLE_CONST(WM8971_ROUTM1, 0, wm8971_rline_mux),
+	SOC_ENUM_SINGLE_CONST(WM8971_LADCIN, 6, wm8971_lpga_sel),
+	SOC_ENUM_SINGLE_CONST(WM8971_RADCIN, 6, wm8971_rpga_sel),
+	SOC_ENUM_SINGLE_CONST(WM8971_ADCDAC, 5, wm8971_adcpol),    /* 12 */
+	SOC_ENUM_SINGLE_CONST(WM8971_ADCIN, 6, wm8971_mono_mux),
 };
 
 static const struct snd_kcontrol_new wm8971_snd_controls[] = {
-- 
1.8.5.2
