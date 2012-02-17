From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: wm8962: Add new SYSCLK ratios for
	new device revisions
Date: Thu, 16 Feb 2012 22:30:06 -0800
Message-ID: <1329460209-30495-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E85CC103A55
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 07:30:47 +0100 (CET)
In-Reply-To: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensourc.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 798ee01..deeaffe 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2445,7 +2445,7 @@ static const int bclk_divs[] = {
 };
 
 static const int sysclk_rates[] = {
-	64, 128, 192, 256, 384, 512, 768, 1024, 1408, 1536,
+	64, 128, 192, 256, 384, 512, 768, 1024, 1408, 1536, 3072, 6144
 };
 
 static void wm8962_configure_bclk(struct snd_soc_codec *codec)
-- 
1.7.9.rc1
