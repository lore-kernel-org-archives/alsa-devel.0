From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: avoid using divisible by 3 for DMIC clk
Date: Tue, 10 Nov 2015 14:40:55 +0800
Message-ID: <1447137655-31293-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1636B2606AB
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 07:41:20 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Few codecs will meet no DMIC clock output issue when select a divided
number which is divisible by 3. To prevent this issue, the patch ignore
the numbers when calculating the DMIC clock divider.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rl6231.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index aca479f..18b4292 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -80,6 +80,8 @@ int rl6231_calc_dmic_clk(int rate)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(div); i++) {
+		if ((div[i] % 3) == 0)
+			continue;
 		/* find divider that gives DMIC frequency below 3MHz */
 		if (3000000 * div[i] >= rate)
 			return i;
-- 
1.8.1.1.439.g50a6b54
