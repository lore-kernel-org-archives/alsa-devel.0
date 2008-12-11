From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Fix variable name for Blackfin I2S
	DAI
Date: Thu, 11 Dec 2008 16:18:59 +0000
Message-ID: <1229012340-25102-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081211161752.GA25028@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B925A245F3
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 17:19:01 +0100 (CET)
In-Reply-To: <20081211161752.GA25028@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/blackfin/bf5xx-i2s.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index c17b131..d1d95d2 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -315,13 +315,13 @@ EXPORT_SYMBOL_GPL(bf5xx_i2s_dai);
 
 static int __init bfin_i2s_init(void)
 {
-	return snd_soc_register_dai(&bfin_i2s_dai);
+	return snd_soc_register_dai(&bf5xx_i2s_dai);
 }
 module_init(bfin_i2s_init);
 
 static void __exit bfin_i2s_exit(void)
 {
-	snd_soc_unregister_dai(&bfin_i2s_dai);
+	snd_soc_unregister_dai(&bf5xx_i2s_dai);
 }
 module_exit(bfin_i2s_exit);
 
-- 
1.5.6.5
