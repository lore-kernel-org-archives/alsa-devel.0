From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 095/102] ASoC: wm8750: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:41 +0100
Message-ID: <1392724308-13375-15-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 51EB5265767
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
 sound/soc/codecs/wm8750.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 78616a638a55..c824c43fe7a5 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -114,23 +114,23 @@ static const char *wm8750_mono_mux[] = {"Stereo", "Mono (Left)",
 	"Mono (Right)", "Digital Mono"};
 
 static const struct soc_enum wm8750_enum[] = {
-SOC_ENUM_SINGLE(WM8750_BASS, 7, 2, wm8750_bass),
-SOC_ENUM_SINGLE(WM8750_BASS, 6, 2, wm8750_bass_filter),
-SOC_ENUM_SINGLE(WM8750_TREBLE, 6, 2, wm8750_treble),
-SOC_ENUM_SINGLE(WM8750_3D, 5, 2, wm8750_3d_lc),
-SOC_ENUM_SINGLE(WM8750_3D, 6, 2, wm8750_3d_uc),
-SOC_ENUM_SINGLE(WM8750_3D, 7, 2, wm8750_3d_func),
-SOC_ENUM_SINGLE(WM8750_ALC1, 7, 4, wm8750_alc_func),
-SOC_ENUM_SINGLE(WM8750_NGATE, 1, 2, wm8750_ng_type),
-SOC_ENUM_SINGLE(WM8750_LOUTM1, 0, 5, wm8750_line_mux),
-SOC_ENUM_SINGLE(WM8750_ROUTM1, 0, 5, wm8750_line_mux),
-SOC_ENUM_SINGLE(WM8750_LADCIN, 6, 4, wm8750_pga_sel), /* 10 */
-SOC_ENUM_SINGLE(WM8750_RADCIN, 6, 4, wm8750_pga_sel),
-SOC_ENUM_SINGLE(WM8750_ADCTL2, 7, 4, wm8750_out3),
-SOC_ENUM_SINGLE(WM8750_ADCIN, 8, 2, wm8750_diff_sel),
-SOC_ENUM_SINGLE(WM8750_ADCDAC, 5, 4, wm8750_adcpol),
-SOC_ENUM_SINGLE(WM8750_ADCDAC, 1, 4, wm8750_deemph),
-SOC_ENUM_SINGLE(WM8750_ADCIN, 6, 4, wm8750_mono_mux), /* 16 */
+SOC_ENUM_SINGLE_CONST(WM8750_BASS, 7, wm8750_bass),
+SOC_ENUM_SINGLE_CONST(WM8750_BASS, 6, wm8750_bass_filter),
+SOC_ENUM_SINGLE_CONST(WM8750_TREBLE, 6, wm8750_treble),
+SOC_ENUM_SINGLE_CONST(WM8750_3D, 5, wm8750_3d_lc),
+SOC_ENUM_SINGLE_CONST(WM8750_3D, 6, wm8750_3d_uc),
+SOC_ENUM_SINGLE_CONST(WM8750_3D, 7, wm8750_3d_func),
+SOC_ENUM_SINGLE_CONST(WM8750_ALC1, 7, wm8750_alc_func),
+SOC_ENUM_SINGLE_CONST(WM8750_NGATE, 1, wm8750_ng_type),
+SOC_ENUM_SINGLE_CONST(WM8750_LOUTM1, 0, wm8750_line_mux),
+SOC_ENUM_SINGLE_CONST(WM8750_ROUTM1, 0, wm8750_line_mux),
+SOC_ENUM_SINGLE_CONST(WM8750_LADCIN, 6, wm8750_pga_sel), /* 10 */
+SOC_ENUM_SINGLE_CONST(WM8750_RADCIN, 6, wm8750_pga_sel),
+SOC_ENUM_SINGLE_CONST(WM8750_ADCTL2, 7, wm8750_out3),
+SOC_ENUM_SINGLE_CONST(WM8750_ADCIN, 8, wm8750_diff_sel),
+SOC_ENUM_SINGLE_CONST(WM8750_ADCDAC, 5, wm8750_adcpol),
+SOC_ENUM_SINGLE_CONST(WM8750_ADCDAC, 1, wm8750_deemph),
+SOC_ENUM_SINGLE_CONST(WM8750_ADCIN, 6, wm8750_mono_mux), /* 16 */
 
 };
 
-- 
1.8.5.2
