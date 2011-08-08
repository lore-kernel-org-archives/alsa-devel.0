From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Move WM8962 CLKREG_OVD earlier
Date: Mon,  8 Aug 2011 09:05:37 +0900
Message-ID: <1312761937-1764-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EFFD21037F8
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 02:05:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When the clocking registers are not overriden some of the registers are
not writable.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index a381104..e6d58b5 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2934,10 +2934,6 @@ static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 					    WM8962_BIAS_ENA | 0x180);
 
 			msleep(5);
-
-			snd_soc_update_bits(codec, WM8962_CLOCKING2,
-					    WM8962_CLKREG_OVD,
-					    WM8962_CLKREG_OVD);
 		}
 
 		/* VMID 2*250k */
@@ -3875,6 +3871,10 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	 */
 	snd_soc_update_bits(codec, WM8962_CLOCKING2, WM8962_SYSCLK_ENA, 0);
 
+	/* Ensure we have soft control over all registers */
+	snd_soc_update_bits(codec, WM8962_CLOCKING2,
+			    WM8962_CLKREG_OVD, WM8962_CLKREG_OVD);
+
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 
 	if (pdata) {
-- 
1.7.5.4
