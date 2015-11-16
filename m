From: John Lin <john.lin@realtek.com>
Subject: [PATCH] ASoC: rl6231: fix range of DMIC clock
Date: Mon, 16 Nov 2015 14:41:07 +0800
Message-ID: <1447656067-19415-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 05F3F2614C7
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 07:43:15 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, benzh@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The maximum DMIC clock rate is 3.072 MHz for most DMIC. And it will get better
performance in higher clock rate. If we set maximum to 3 MHz in driver, we will
get a clock rate which is not even close to 3 MHz.
For example, if DMIC clock source is 24.576 MHz, the DMIC clock will be about
1.5 MHz in current code. But it will be 3.072 MHz with this patch.

Signed-off-by: John Lin <john.lin@realtek.com>
---
 sound/soc/codecs/rl6231.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 18b4292..1dc68ab 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -82,8 +82,8 @@ int rl6231_calc_dmic_clk(int rate)
 	for (i = 0; i < ARRAY_SIZE(div); i++) {
 		if ((div[i] % 3) == 0)
 			continue;
-		/* find divider that gives DMIC frequency below 3MHz */
-		if (3000000 * div[i] >= rate)
+		/* find divider that gives DMIC frequency below 3.072MHz */
+		if (3072000 * div[i] >= rate)
 			return i;
 	}
 
-- 
1.8.1.1.439.g50a6b54
