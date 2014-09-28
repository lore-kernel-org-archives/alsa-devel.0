From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: core: fix possible ZERO_SIZE_PTR pointer
	dereferencing error.
Date: Sun, 28 Sep 2014 17:29:37 +0800
Message-ID: <1411896577-30965-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0122.outbound.protection.outlook.com [65.55.169.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 91174260567
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 11:30:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Since we cannot make sure the 'params->num_regs' will always be none
zero here, and then if it equals to zero, the kmemdup() will return
ZERO_SIZE_PTR, which equals to ((void *)16).

So this patch fix this with just doing the zero check before calling
kmemdup().

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7b5a7ce..263514a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3051,7 +3051,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 	unsigned int val, mask;
 	void *data;
 
-	if (!component->regmap)
+	if (!component->regmap || !params->num_regs)
 		return -EINVAL;
 
 	len = params->num_regs * component->val_bytes;
-- 
2.1.0.27.g96db324
