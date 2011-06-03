From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Only update SYSCLK_ENA when pausing
	WM8915 SYSCLK
Date: Fri,  3 Jun 2011 18:47:01 +0100
Message-ID: <1307123223-30847-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307123223-30847-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 86AC724371
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 19:47:06 +0200 (CEST)
In-Reply-To: <1307123223-30847-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8915.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index c61bc32..6324d4e 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -1839,7 +1839,7 @@ static int wm8915_set_sysclk(struct snd_soc_dai *dai,
 		return 0;
 
 	/* Disable SYSCLK while we reconfigure */
-	old = snd_soc_read(codec, WM8915_AIF_CLOCKING_1);
+	old = snd_soc_read(codec, WM8915_AIF_CLOCKING_1) & WM8915_SYSCLK_ENA;
 	snd_soc_update_bits(codec, WM8915_AIF_CLOCKING_1,
 			    WM8915_SYSCLK_ENA, 0);
 
-- 
1.7.5.3
