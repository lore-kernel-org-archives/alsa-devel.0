From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] ASoC: wcd9335: remove multiple defines.
Date: Thu,  4 Jul 2019 17:54:10 +0100
Message-ID: <20190704165410.7173-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACA40F800E8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 18:54:17 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id n4so7319390wrs.3
 for <alsa-devel@alsa-project.org>; Thu, 04 Jul 2019 09:54:17 -0700 (PDT)
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
Changes since v1:
	rebased on top of kernel/git/broonie/sound.git for-next

 sound/soc/codecs/wcd9335.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 85737fe54474..1bbbe421b999 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -86,11 +86,6 @@
 #define WCD9335_DEC_PWR_LVL_HP 0x04
 #define WCD9335_DEC_PWR_LVL_DF 0x00
 
-#define  TX_HPF_CUT_OFF_FREQ_MASK	0x60
-#define  CF_MIN_3DB_4HZ			0x0
-#define  CF_MIN_3DB_75HZ		0x1
-#define  CF_MIN_3DB_150HZ		0x2
-
 #define WCD9335_SLIM_RX_CH(p) \
 	{.port = p + WCD9335_RX_START, .shift = p,}
 
-- 
2.21.0
