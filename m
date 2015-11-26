From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v2 3/6] ASoC: fsl_ssi: Save a dev reference for
	dev_err() purpose.
Date: Thu, 26 Nov 2015 16:05:38 +0100
Message-ID: <1448550341-11765-4-git-send-email-arnaud.mouiche@invoxia.com>
References: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id CF938261A5E
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 16:06:12 +0100 (CET)
Received: by wmvv187 with SMTP id v187so35376318wmv.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 07:06:12 -0800 (PST)
In-Reply-To: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>, Roberto Fichera <kernel@tekno-soft.it>, Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

Most of functions only receive the ssi_private reference and don't have
a knowledge of 'dev' pointer, even for debug purpose.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b34c09f..243c9af 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -191,6 +191,7 @@ struct fsl_ssi_private {
 	struct fsl_ssi_dbg dbg_stats;
 
 	const struct fsl_ssi_soc_data *soc;
+	struct device *dev;
 };
 
 /*
@@ -1329,6 +1330,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi_private->soc = of_id->data;
+	ssi_private->dev = &pdev->dev;
 
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (sprop) {
-- 
1.9.1
