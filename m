From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6afe: Fix wrong MI2S SD line
	mask" to the asoc tree
Date: Mon,  5 Nov 2018 11:57:13 +0000 (GMT)
Message-ID: <20181105115713.A86111124D98@debutante.sirena.org.uk>
References: <1541073067-29553-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ADBD4267692
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:57:15 +0100 (CET)
In-Reply-To: <1541073067-29553-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, niklas.cassel@linaro.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 112b57fa737445b2361be332ce8cc0fd3e2b994e Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Thu, 1 Nov 2018 17:21:07 +0530
Subject: [PATCH] ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask

SD line mask for MI2S starts from BIT 0 instead of BIT 1.
Fix all bit mask for MI2S SD lines.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 000775b4bba8..829b5e987b2a 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -49,14 +49,14 @@
 #define AFE_PORT_I2S_SD1		0x2
 #define AFE_PORT_I2S_SD2		0x3
 #define AFE_PORT_I2S_SD3		0x4
-#define AFE_PORT_I2S_SD0_MASK		BIT(0x1)
-#define AFE_PORT_I2S_SD1_MASK		BIT(0x2)
-#define AFE_PORT_I2S_SD2_MASK		BIT(0x3)
-#define AFE_PORT_I2S_SD3_MASK		BIT(0x4)
-#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(2, 1)
-#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(4, 3)
-#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(3, 1)
-#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(4, 1)
+#define AFE_PORT_I2S_SD0_MASK		BIT(0x0)
+#define AFE_PORT_I2S_SD1_MASK		BIT(0x1)
+#define AFE_PORT_I2S_SD2_MASK		BIT(0x2)
+#define AFE_PORT_I2S_SD3_MASK		BIT(0x3)
+#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(1, 0)
+#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(3, 2)
+#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(2, 0)
+#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(3, 0)
 #define AFE_PORT_I2S_QUAD01		0x5
 #define AFE_PORT_I2S_QUAD23		0x6
 #define AFE_PORT_I2S_6CHS		0x7
-- 
2.19.0.rc2
