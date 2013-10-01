From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: davinci-mcasp: add support for suspend
	and resume
Date: Tue,  1 Oct 2013 14:50:02 +0200
Message-ID: <1380631802-19498-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A9C1265366
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 14:50:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: marek.belisko@gmail.com, s.neumann@raumfeld.com, nsekhar@ti.com, Daniel Mack <zonque@gmail.com>, broonie@kernel.org, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

When the system returns from suspend, it looses its configuration. Most
of it is restored by running a normal audio stream startup, but the DAI
format is left unset as that's configured on the audio device creation.

Hence, it suffices here to care for the registers which are touched by
davinci_mcasp_set_dai_fmt() and restore them when the system is resumed.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/davinci/davinci-mcasp.c | 39 +++++++++++++++++++++++++++++++++++++++
 sound/soc/davinci/davinci-mcasp.h | 12 ++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 591f853..5023da7 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1272,12 +1272,51 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int davinci_mcasp_suspend(struct device *dev)
+{
+	struct davinci_audio_dev *a = dev_get_drvdata(dev);
+	void __iomem *base = a->base;
+
+	a->context.txfmtctl = mcasp_get_reg(base + DAVINCI_MCASP_TXFMCTL_REG);
+	a->context.rxfmtctl = mcasp_get_reg(base + DAVINCI_MCASP_RXFMCTL_REG);
+	a->context.txfmt = mcasp_get_reg(base + DAVINCI_MCASP_TXFMT_REG);
+	a->context.rxfmt = mcasp_get_reg(base + DAVINCI_MCASP_RXFMT_REG);
+	a->context.aclkxctl = mcasp_get_reg(base + DAVINCI_MCASP_ACLKXCTL_REG);
+	a->context.aclkrctl = mcasp_get_reg(base + DAVINCI_MCASP_ACLKRCTL_REG);
+	a->context.pdir = mcasp_get_reg(base + DAVINCI_MCASP_PDIR_REG);
+
+	return 0;
+}
+
+static int davinci_mcasp_resume(struct device *dev)
+{
+	struct davinci_audio_dev *a = dev_get_drvdata(dev);
+	void __iomem *base = a->base;
+
+	mcasp_set_reg(base + DAVINCI_MCASP_TXFMCTL_REG, a->context.txfmtctl);
+	mcasp_set_reg(base + DAVINCI_MCASP_RXFMCTL_REG, a->context.rxfmtctl);
+	mcasp_set_reg(base + DAVINCI_MCASP_TXFMT_REG, a->context.txfmt);
+	mcasp_set_reg(base + DAVINCI_MCASP_RXFMT_REG, a->context.rxfmt);
+	mcasp_set_reg(base + DAVINCI_MCASP_ACLKXCTL_REG, a->context.aclkxctl);
+	mcasp_set_reg(base + DAVINCI_MCASP_ACLKRCTL_REG, a->context.aclkrctl);
+	mcasp_set_reg(base + DAVINCI_MCASP_PDIR_REG, a->context.pdir);
+
+	return 0;
+}
+#endif
+
+SIMPLE_DEV_PM_OPS(davinci_mcasp_pm_ops,
+		  davinci_mcasp_suspend,
+		  davinci_mcasp_resume);
+
 static struct platform_driver davinci_mcasp_driver = {
 	.probe		= davinci_mcasp_probe,
 	.remove		= davinci_mcasp_remove,
 	.driver		= {
 		.name	= "davinci-mcasp",
 		.owner	= THIS_MODULE,
+		.pm	= &davinci_mcasp_pm_ops,
 		.of_match_table = mcasp_dt_ids,
 	},
 };
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index a9ac0c1..a2e27e1 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -43,6 +43,18 @@ struct davinci_audio_dev {
 	/* McASP FIFO related */
 	u8	txnumevt;
 	u8	rxnumevt;
+
+#ifdef CONFIG_PM_SLEEP
+	struct {
+		u32	txfmtctl;
+		u32	rxfmtctl;
+		u32	txfmt;
+		u32	rxfmt;
+		u32	aclkxctl;
+		u32	aclkrctl;
+		u32	pdir;
+	} context;
+#endif
 };
 
 #endif	/* DAVINCI_MCASP_H */
-- 
1.8.3.1
