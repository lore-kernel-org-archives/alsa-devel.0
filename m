From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/5] sound: soc: fsl: no need to check return
	value of debugfs_create functions
Date: Fri, 14 Jun 2019 11:47:55 +0200
Message-ID: <20190614094756.2965-4-gregkh@linuxfoundation.org>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0F91F80794
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 12:07:25 +0200 (CEST)
In-Reply-To: <20190614094756.2965-1-gregkh@linuxfoundation.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: <alsa-devel@alsa-project.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_ssi.c     |  4 +---
 sound/soc/fsl/fsl_ssi.h     |  8 +++-----
 sound/soc/fsl/fsl_ssi_dbg.c | 18 ++++--------------
 sound/soc/fsl/imx-audmux.c  | 10 ++--------
 4 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 09b2967befd9..fa862af25c1a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1582,9 +1582,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = fsl_ssi_debugfs_create(&ssi->dbg_stats, dev);
-	if (ret)
-		goto error_asoc_register;
+	fsl_ssi_debugfs_create(&ssi->dbg_stats, dev);
 
 	/* Initially configures SSI registers */
 	fsl_ssi_hw_init(ssi);
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 0bdda608d414..db57cad80449 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -270,7 +270,6 @@ struct device;
 
 struct fsl_ssi_dbg {
 	struct dentry *dbg_dir;
-	struct dentry *dbg_stats;
 
 	struct {
 		unsigned int rfrc;
@@ -299,7 +298,7 @@ struct fsl_ssi_dbg {
 
 void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *ssi_dbg, u32 sisr);
 
-int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev);
+void fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev);
 
 void fsl_ssi_debugfs_remove(struct fsl_ssi_dbg *ssi_dbg);
 
@@ -312,10 +311,9 @@ static inline void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *stats, u32 sisr)
 {
 }
 
-static inline int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg,
-					 struct device *dev)
+static inline void fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg,
+					  struct device *dev)
 {
-	return 0;
 }
 
 static inline void fsl_ssi_debugfs_remove(struct fsl_ssi_dbg *ssi_dbg)
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 6f6294149476..2a20ee23dc52 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -126,25 +126,15 @@ static int fsl_ssi_stats_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(fsl_ssi_stats);
 
-int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
+void fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 {
 	ssi_dbg->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
-	if (!ssi_dbg->dbg_dir)
-		return -ENOMEM;
 
-	ssi_dbg->dbg_stats = debugfs_create_file("stats", 0444,
-						 ssi_dbg->dbg_dir, ssi_dbg,
-						 &fsl_ssi_stats_fops);
-	if (!ssi_dbg->dbg_stats) {
-		debugfs_remove(ssi_dbg->dbg_dir);
-		return -ENOMEM;
-	}
-
-	return 0;
+	debugfs_create_file("stats", 0444, ssi_dbg->dbg_dir, ssi_dbg,
+			    &fsl_ssi_stats_fops);
 }
 
 void fsl_ssi_debugfs_remove(struct fsl_ssi_dbg *ssi_dbg)
 {
-	debugfs_remove(ssi_dbg->dbg_stats);
-	debugfs_remove(ssi_dbg->dbg_dir);
+	debugfs_remove_recursive(ssi_dbg->dbg_dir);
 }
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 04e59e66711d..b2351cd33b0f 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -141,17 +141,11 @@ static void audmux_debugfs_init(void)
 	char buf[20];
 
 	audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
-	if (!audmux_debugfs_root) {
-		pr_warning("Failed to create AUDMUX debugfs root\n");
-		return;
-	}
 
 	for (i = 0; i < MX31_AUDMUX_PORT7_SSI_PINS_7 + 1; i++) {
 		snprintf(buf, sizeof(buf), "ssi%lu", i);
-		if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
-					 (void *)i, &audmux_debugfs_fops))
-			pr_warning("Failed to create AUDMUX port %lu debugfs file\n",
-				   i);
+		debugfs_create_file(buf, 0444, audmux_debugfs_root,
+				    (void *)i, &audmux_debugfs_fops);
 	}
 }
 
-- 
2.22.0
