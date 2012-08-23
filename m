From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Update for new WM1811 variants
Date: Thu, 23 Aug 2012 15:57:42 +0100
Message-ID: <1345733862-19092-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6488F265CD7
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 16:57:47 +0200 (CEST)
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

There are some new WM1811 variants distinguished by both revision and
cust_id which need slightly different handling.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 8d5b65a..c7dbbd4 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3823,14 +3823,20 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		wm8994->hubs.no_cache_dac_hp_direct = true;
 		wm8994->fll_byp = true;
 
-		switch (wm8994->revision) {
+		switch (control->cust_id) {
 		case 0:
-		case 1:
 		case 2:
-		case 3:
 			wm8994->hubs.dcs_codes_l = -9;
 			wm8994->hubs.dcs_codes_r = -7;
 			break;
+		case 1:
+		case 3:
+			wm8994->hubs.dcs_codes_l = -8;
+			wm8994->hubs.dcs_codes_r = -7;
+			break;
+		default:
+			break;
+		}
 		default:
 			break;
 		}
@@ -3919,7 +3925,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	switch (control->type) {
 	case WM1811:
-		if (wm8994->revision > 1) {
+		if (control->cust_id > 1 || wm8994->revision > 1) {
 			ret = wm8994_request_irq(wm8994->wm8994,
 						 WM8994_IRQ_GPIO(6),
 						 wm1811_jackdet_irq, "JACKDET",
-- 
1.7.10.4
