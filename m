From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rl6231: add 19.2M to 4.096M pll preset
	table
Date: Tue, 15 Nov 2016 15:25:50 +0800
Message-ID: <1479194750-25638-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 85148266718
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 08:26:10 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add a pll mapping table for 19.2M in and 4.096M out.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rl6231.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 1dc68ab..7b447d0 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -102,6 +102,7 @@ struct pll_calc_map {
 };
 
 static const struct pll_calc_map pll_preset_table[] = {
+	{19200000,  4096000,  23, 14, 1, false},
 	{19200000,  24576000,  3, 30, 3, false},
 };
 
-- 
1.8.1.1.439.g50a6b54
