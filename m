From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Run the headphone in class G
	mode when sidetone is enabled
Date: Thu,  1 Mar 2012 16:41:36 +0000
Message-ID: <1330620096-1302-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D0BE2436F
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2012 17:41:40 +0100 (CET)
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

Class W mode with sidetone is not fully supported.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e73c857..d5ee3ec 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2242,9 +2242,11 @@ static const struct snd_soc_dapm_route wm8962_intercon[] = {
 
 	{ "STL", "Left", "ADCL" },
 	{ "STL", "Right", "ADCR" },
+	{ "STL", NULL, "Class G" },
 
 	{ "STR", "Left", "ADCL" },
 	{ "STR", "Right", "ADCR" },
+	{ "STR", NULL, "Class G" },
 
 	{ "DACL", NULL, "SYSCLK" },
 	{ "DACL", NULL, "TOCLK" },
-- 
1.7.9.1
