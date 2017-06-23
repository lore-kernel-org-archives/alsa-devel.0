From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: enable speaker protection
	features
Date: Fri, 23 Jun 2017 10:24:57 +0800
Message-ID: <1498184697-2156-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 781DC266DB8
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 04:25:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, albertchen@realtek.com, alexlee@realtek.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch is uploaded for enabling the speaker protection features
of the audio codec.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 162044d..9344af2 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -59,10 +59,11 @@ static const struct regmap_range_cfg rt5645_ranges[] = {
 
 static const struct reg_sequence init_list[] = {
 	{RT5645_PR_BASE + 0x3d,	0x3600},
-	{RT5645_PR_BASE + 0x1c,	0xfd20},
+	{RT5645_PR_BASE + 0x1c,	0xfd70},
 	{RT5645_PR_BASE + 0x20,	0x611f},
 	{RT5645_PR_BASE + 0x21,	0x4040},
 	{RT5645_PR_BASE + 0x23,	0x0004},
+	{RT5645_CLSD_OUT_CTRL, 0xa0e8},
 	{RT5645_ASRC_4, 0x0120},
 };
 
@@ -171,7 +172,7 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0x9c, 0x0aea },
 	{ 0x9d, 0x000c },
 	{ 0x9e, 0x0400 },
-	{ 0xa0, 0xa0a8 },
+	{ 0xa0, 0xa0e8 },
 	{ 0xa1, 0x0059 },
 	{ 0xa2, 0x0001 },
 	{ 0xae, 0x6000 },
@@ -328,7 +329,7 @@ static const struct reg_default rt5650_reg[] = {
 	{ 0x9c, 0x0aea },
 	{ 0x9d, 0x000c },
 	{ 0x9e, 0x0400 },
-	{ 0xa0, 0xa0a8 },
+	{ 0xa0, 0xa0e8 },
 	{ 0xa1, 0x0059 },
 	{ 0xa2, 0x0001 },
 	{ 0xae, 0x6000 },
-- 
2.7.4
