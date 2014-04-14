From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/17] ASoC: wm8988: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:31:07 +0200
Message-ID: <1397503872-20864-13-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 56D8E2656BE
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:31 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

SND_SOC_DAPM_VALUE_MUX and SOC_DAPM_VALUE_ENUM are deprecated and merely an
alias for SND_SOC_DAPM_MUX and SOC_DAPM_ENUM. Replace the deprecated macros so
we can eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8988.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 3a1ae4f5..d3fea46 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -268,7 +268,7 @@ static const struct soc_enum wm8988_lline_enum =
 			      wm8988_line_texts,
 			      wm8988_line_values);
 static const struct snd_kcontrol_new wm8988_left_line_controls =
-	SOC_DAPM_VALUE_ENUM("Route", wm8988_lline_enum);
+	SOC_DAPM_ENUM("Route", wm8988_lline_enum);
 
 static const struct soc_enum wm8988_rline_enum =
 	SOC_VALUE_ENUM_SINGLE(WM8988_ROUTM1, 0, 7,
@@ -276,7 +276,7 @@ static const struct soc_enum wm8988_rline_enum =
 			      wm8988_line_texts,
 			      wm8988_line_values);
 static const struct snd_kcontrol_new wm8988_right_line_controls =
-	SOC_DAPM_VALUE_ENUM("Route", wm8988_lline_enum);
+	SOC_DAPM_ENUM("Route", wm8988_lline_enum);
 
 /* Left Mixer */
 static const struct snd_kcontrol_new wm8988_left_mixer_controls[] = {
@@ -304,7 +304,7 @@ static const struct soc_enum wm8988_lpga_enum =
 			      wm8988_pga_sel,
 			      wm8988_pga_val);
 static const struct snd_kcontrol_new wm8988_left_pga_controls =
-	SOC_DAPM_VALUE_ENUM("Route", wm8988_lpga_enum);
+	SOC_DAPM_ENUM("Route", wm8988_lpga_enum);
 
 /* Right PGA Mux */
 static const struct soc_enum wm8988_rpga_enum =
@@ -313,7 +313,7 @@ static const struct soc_enum wm8988_rpga_enum =
 			      wm8988_pga_sel,
 			      wm8988_pga_val);
 static const struct snd_kcontrol_new wm8988_right_pga_controls =
-	SOC_DAPM_VALUE_ENUM("Route", wm8988_rpga_enum);
+	SOC_DAPM_ENUM("Route", wm8988_rpga_enum);
 
 /* Differential Mux */
 static const char *wm8988_diff_sel[] = {"Line 1", "Line 2"};
-- 
1.8.0
