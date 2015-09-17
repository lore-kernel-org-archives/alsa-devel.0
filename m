From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: change PTR_ERR argument" to the
	asoc tree
Date: Thu, 17 Sep 2015 18:36:44 +0100
Message-ID: <E1Zcd6y-0006Ku-1a@finisterre>
References: <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C6B0B261B19
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 19:36:52 +0200 (CEST)
In-Reply-To: <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: change PTR_ERR argument

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

>From 8985729578cb42f9e781a8e38e5b6b1ee90c1018 Mon Sep 17 00:00:00 2001
From: Julia Lawall <julia.lawall@lip6.fr>
Date: Thu, 17 Sep 2015 10:47:33 +0200
Subject: [PATCH] ASoC: qcom: change PTR_ERR argument

Apply PTR_ERR to the value that was recently assigned.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,y;
@@

if (IS_ERR(x) || ...) {
  ... when any
      when != IS_ERR(...)
(
   PTR_ERR(x)
|
*  PTR_ERR(y)
)
  ... when any
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 97bc202..e5101e0 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -438,7 +438,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
 			dev_err(&pdev->dev,
 				"%s() error getting mi2s-bit-clk: %ld\n",
-				__func__, PTR_ERR(drvdata->mi2s_bit_clk[i]));
+				__func__,
+				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
 			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
 		}
 	}
-- 
2.5.0
