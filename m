From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/6] ASoC: Fix WM8962 headphone volume update
	for use of advanced caches
Date: Wed,  8 Jun 2011 14:50:50 +0100
Message-ID: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 115AC1038D9
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 15:51:03 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index f90ae42..5e05eed 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1999,12 +1999,12 @@ static int wm8962_put_hp_sw(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	/* If the left PGA is enabled hit that VU bit... */
-	if (reg_cache[WM8962_PWR_MGMT_2] & WM8962_HPOUTL_PGA_ENA)
+	if (snd_soc_read(codec, WM8962_PWR_MGMT_2) & WM8962_HPOUTL_PGA_ENA)
 		return snd_soc_write(codec, WM8962_HPOUTL_VOLUME,
 				     reg_cache[WM8962_HPOUTL_VOLUME]);
 
 	/* ...otherwise the right.  The VU is stereo. */
-	if (reg_cache[WM8962_PWR_MGMT_2] & WM8962_HPOUTR_PGA_ENA)
+	if (snd_soc_read(codec, WM8962_PWR_MGMT_2) & WM8962_HPOUTR_PGA_ENA)
 		return snd_soc_write(codec, WM8962_HPOUTR_VOLUME,
 				     reg_cache[WM8962_HPOUTR_VOLUME]);
 
-- 
1.7.5.3
