From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: tlv320aic3x: Connect 'Left Line1R Mux'
	and 'Right Line1L Mux'
Date: Mon, 7 Oct 2013 11:59:19 +0300
Message-ID: <1381136359-26931-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AD9F260895
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 10:59:11 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The two paths were not connected in the DAPM route causing the associated
routes to be non working and the following warnings printed in the logs:
tlv320aic3x-codec 0-001b: ASoC: mux Right Line1L Mux has no paths
tlv320aic3x-codec 0-001b: ASoC: mux Left Line1R Mux has no paths

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 892c108..a160b7d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -678,6 +678,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* Left Input */
 	{"Left Line1L Mux", "single-ended", "LINE1L"},
 	{"Left Line1L Mux", "differential", "LINE1L"},
+	{"Left Line1R Mux", "single-ended", "LINE1R"},
+	{"Left Line1R Mux", "differential", "LINE1R"},
 
 	{"Left Line2L Mux", "single-ended", "LINE2L"},
 	{"Left Line2L Mux", "differential", "LINE2L"},
@@ -694,6 +696,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* Right Input */
 	{"Right Line1R Mux", "single-ended", "LINE1R"},
 	{"Right Line1R Mux", "differential", "LINE1R"},
+	{"Right Line1L Mux", "single-ended", "LINE1L"},
+	{"Right Line1L Mux", "differential", "LINE1L"},
 
 	{"Right Line2R Mux", "single-ended", "LINE2R"},
 	{"Right Line2R Mux", "differential", "LINE2R"},
-- 
1.8.3.2
