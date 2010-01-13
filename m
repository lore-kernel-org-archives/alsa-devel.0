From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Replace comma with semicolon in
	probe function
Date: Wed, 13 Jan 2010 12:37:49 +0200
Message-ID: <1263379069-24326-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id DF0AD103804
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 11:37:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The codec structure initialization statements should be
separated by semicolons.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 2a27f7b..74f0d65 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2192,7 +2192,7 @@ static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 	codec->write = twl4030_write;
 	codec->set_bias_level = twl4030_set_bias_level;
 	codec->dai = twl4030_dai;
-	codec->num_dai = ARRAY_SIZE(twl4030_dai),
+	codec->num_dai = ARRAY_SIZE(twl4030_dai);
 	codec->reg_cache_size = sizeof(twl4030_reg);
 	codec->reg_cache = kmemdup(twl4030_reg, sizeof(twl4030_reg),
 					GFP_KERNEL);
-- 
1.6.6
