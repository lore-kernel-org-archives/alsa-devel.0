From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: add mic related i2s control
	register defines" to the asoc tree
Date: Sun, 21 Feb 2016 02:14:44 +0900
Message-ID: <E1aXB7E-0008GW-57@finisterre>
References: <1455099566-710-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FCD5265011
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:15:00 +0100 (CET)
In-Reply-To: <1455099566-710-1-git-send-email-srinivas.kandagatla@linaro.org>
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

   ASoC: qcom: add mic related i2s control register defines

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

>From 39ad0ecd1e26a4138bf299b98265fceab60553a6 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 11 Feb 2016 12:18:06 +0000
Subject: [PATCH] ASoC: qcom: add mic related i2s control register defines

This patch adds mic related bitmasks and offsets in the i2c control
register.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-lpaif-reg.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
index 95e22f1..6599794 100644
--- a/sound/soc/qcom/lpass-lpaif-reg.h
+++ b/sound/soc/qcom/lpass-lpaif-reg.h
@@ -47,6 +47,28 @@
 #define LPAIF_I2SCTL_SPKMONO_STEREO	(0 << LPAIF_I2SCTL_SPKMONO_SHIFT)
 #define LPAIF_I2SCTL_SPKMONO_MONO	(1 << LPAIF_I2SCTL_SPKMONO_SHIFT)
 
+#define LPAIF_I2SCTL_MICEN_MASK		GENMASK(8, 8)
+#define LPAIF_I2SCTL_MICEN_SHIFT	8
+#define LPAIF_I2SCTL_MICEN_DISABLE	(0 << LPAIF_I2SCTL_MICEN_SHIFT)
+#define LPAIF_I2SCTL_MICEN_ENABLE	(1 << LPAIF_I2SCTL_MICEN_SHIFT)
+
+#define LPAIF_I2SCTL_MICMODE_MASK	GENMASK(7, 4)
+#define LPAIF_I2SCTL_MICMODE_SHIFT	4
+#define LPAIF_I2SCTL_MICMODE_NONE	(0 << LPAIF_I2SCTL_MICMODE_SHIFT)
+#define LPAIF_I2SCTL_MICMODE_SD0	(1 << LPAIF_I2SCTL_MICMODE_SHIFT)
+#define LPAIF_I2SCTL_MICMODE_SD1	(2 << LPAIF_I2SCTL_MICMODE_SHIFT)
+#define LPAIF_I2SCTL_MICMODE_SD2	(3 << LPAIF_I2SCTL_MICMODE_SHIFT)
+#define LPAIF_I2SCTL_MICMODE_SD3	(4 << LPAIF_I2SCTL_MICMODE_SHIFT)
+#define LPAIF_I2SCTL_MICMODE_QUAD01	(5 << LPAIF_I2SCTL_MICMODE_SHIFT)
+#define LPAIF_I2SCTL_MICMODE_QUAD23	(6 << LPAIF_I2SCTL_MICMODE_SHIFT)
+#define LPAIF_I2SCTL_MICMODE_6CH	(7 << LPAIF_I2SCTL_MICMODE_SHIFT)
+#define LPAIF_I2SCTL_MICMODE_8CH	(8 << LPAIF_I2SCTL_MICMODE_SHIFT)
+
+#define LPAIF_I2SCTL_MIMONO_MASK	GENMASK(3, 3)
+#define LPAIF_I2SCTL_MICMONO_SHIFT	3
+#define LPAIF_I2SCTL_MICMONO_STEREO	(0 << LPAIF_I2SCTL_MICMONO_SHIFT)
+#define LPAIF_I2SCTL_MICMONO_MONO	(1 << LPAIF_I2SCTL_MICMONO_SHIFT)
+
 #define LPAIF_I2SCTL_WSSRC_MASK		0x0004
 #define LPAIF_I2SCTL_WSSRC_SHIFT	2
 #define LPAIF_I2SCTL_WSSRC_INTERNAL	(0 << LPAIF_I2SCTL_WSSRC_SHIFT)
-- 
2.7.0
