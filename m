From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: wcd9335: remove multiple defines.
Date: Wed,  3 Jul 2019 13:32:57 +0100
Message-ID: <20190703123257.27228-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5D45F800C5
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2019 14:33:00 +0200 (CEST)
Received: by mail-wm1-x343.google.com with SMTP id a15so2020357wmj.5
 for <alsa-devel@alsa-project.org>; Wed, 03 Jul 2019 05:33:00 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Found during review that there are multiple defines of same constants.
This patch removes them!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 6f205638a8b8..da6c50ccecd9 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -87,11 +87,6 @@
 #define WCD9335_DEC_PWR_LVL_HP 0x04
 #define WCD9335_DEC_PWR_LVL_DF 0x00
 
-#define  TX_HPF_CUT_OFF_FREQ_MASK	0x60
-#define  CF_MIN_3DB_4HZ			0x0
-#define  CF_MIN_3DB_75HZ		0x1
-#define  CF_MIN_3DB_150HZ		0x2
-
 #define WCD9335_MBHC_MAX_BUTTONS	(8)
 
 #define WCD9335_SLIM_RX_CH(p) \
-- 
2.21.0
