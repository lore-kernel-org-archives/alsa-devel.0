From: Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] sound: fix typos in code comments
Date: Sat, 18 May 2019 20:10:26 +0800
Message-ID: <20190518121026.19135-1-houweitaoo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org, niklas.cassel@linaro.org, yuehaibing@huawei.com, houweitaoo@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

fix lenght to length

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 sound/soc/qcom/qdsp6/q6asm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 4f85cb19a309..e8141a33a55e 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1194,7 +1194,7 @@ EXPORT_SYMBOL_GPL(q6asm_open_read);
  * q6asm_write_async() - non blocking write
  *
  * @ac: audio client pointer
- * @len: lenght in bytes
+ * @len: length in bytes
  * @msw_ts: timestamp msw
  * @lsw_ts: timestamp lsw
  * @wflags: flags associated with write
-- 
2.18.0
