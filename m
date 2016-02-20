From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: add wrdma register definitions"
	to the asoc tree
Date: Sun, 21 Feb 2016 02:14:36 +0900
Message-ID: <E1aXB76-0008Fz-EJ@finisterre>
References: <1454347766-10918-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 271C3264F19
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:14:43 +0100 (CET)
In-Reply-To: <1454347766-10918-1-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: add wrdma register definitions

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 71aaa600787faffd72a9b674c9e5c9ded7cd9a82 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 11 Feb 2016 12:18:14 +0000
Subject: [PATCH] ASoC: qcom: add wrdma register definitions

This patch adds wrdma registers into the lpaif-reg.h.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-lpaif-reg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
index 6599794..760d219 100644
--- a/sound/soc/qcom/lpass-lpaif-reg.h
+++ b/sound/soc/qcom/lpass-lpaif-reg.h
@@ -145,4 +145,15 @@
 #define LPAIF_RDMACTL_ENABLE_OFF	(0 << LPAIF_RDMACTL_ENABLE_SHIFT)
 #define LPAIF_RDMACTL_ENABLE_ON		(1 << LPAIF_RDMACTL_ENABLE_SHIFT)
 
+#define LPAIF_WRDMA_REG_ADDR(v, addr, chan) \
+	(v->wrdma_reg_base + (addr) + \
+	 v->wrdma_reg_stride * (chan - v->wrdma_channel_start))
+
+#define LPAIF_WRDMACTL_REG(v, chan)	LPAIF_WRDMA_REG_ADDR(v, 0x00, (chan))
+#define LPAIF_WRDMABASE_REG(v, chan)	LPAIF_WRDMA_REG_ADDR(v, 0x04, (chan))
+#define	LPAIF_WRDMABUFF_REG(v, chan)	LPAIF_WRDMA_REG_ADDR(v, 0x08, (chan))
+#define LPAIF_WRDMACURR_REG(v, chan)	LPAIF_WRDMA_REG_ADDR(v, 0x0C, (chan))
+#define	LPAIF_WRDMAPER_REG(v, chan)	LPAIF_WRDMA_REG_ADDR(v, 0x10, (chan))
+#define	LPAIF_WRDMAPERCNT_REG(v, chan)	LPAIF_WRDMA_REG_ADDR(v, 0x14, (chan))
+
 #endif /* __LPASS_LPAIF_REG_H__ */
-- 
2.7.0
