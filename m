From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rl6231: remove never matched if condition
Date: Thu, 21 Dec 2017 11:21:33 +0800
Message-ID: <1513826493-9866-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 187EF266DD5
 for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2017 04:21:44 +0100 (CET)
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

(in_t < 0) will never be true since in_t is unsigned.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rl6231.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 33690e9..7ef3b54 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -178,8 +178,6 @@ int rl6231_pll_calc(const unsigned int freq_in,
 		for (n_t = 0; n_t <= max_n; n_t++) {
 			in_t = f_in * (n_t + 2);
 			pll_out = f_out * (k_t + 2);
-			if (in_t < 0)
-				continue;
 			if (in_t == pll_out) {
 				bypass = true;
 				n = n_t;
-- 
2.7.4
