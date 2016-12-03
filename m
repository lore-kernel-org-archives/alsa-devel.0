From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs35l34: Simplify the logic to set
	CS35L34_MCLK_CTL setting
Date: Sat,  3 Dec 2016 15:10:50 +0800
Message-ID: <20161203071050.17811-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 92B87266621
 for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2016 08:11:11 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id x23so10119095pgx.3
 for <alsa-devel@alsa-project.org>; Fri, 02 Dec 2016 23:11:11 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The logic of "value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_XXXXXX;" is
unnecessary complex. By setting CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_MASK
as the mask for regmap_update_bits() call, what the code does is exactly
the same as setting value = CS35L34_MCLK_RATE_XXXXXX.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l34.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index e0f672a..7c5d151 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -610,15 +610,15 @@ static int cs35l34_dai_set_sysclk(struct snd_soc_dai *dai,
 
 	switch (freq) {
 	case CS35L34_MCLK_5644:
-		value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_5P6448;
+		value = CS35L34_MCLK_RATE_5P6448;
 		cs35l34->mclk_int = freq;
 	break;
 	case CS35L34_MCLK_6:
-		value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_6P0000;
+		value = CS35L34_MCLK_RATE_6P0000;
 		cs35l34->mclk_int = freq;
 	break;
 	case CS35L34_MCLK_6144:
-		value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_6P1440;
+		value = CS35L34_MCLK_RATE_6P1440;
 		cs35l34->mclk_int = freq;
 	break;
 	case CS35L34_MCLK_11289:
-- 
2.9.3
