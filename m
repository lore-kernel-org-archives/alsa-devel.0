From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v3 3/6] ASoC: fsl_ssi: Save a dev reference for
	dev_err() purpose.
Date: Mon, 18 Jan 2016 16:26:08 +0100
Message-ID: <1453130771-24419-4-git-send-email-arnaud.mouiche@invoxia.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 9175D260534
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 16:26:45 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id n5so69395065wmn.0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 07:26:45 -0800 (PST)
In-Reply-To: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Caleb Crome <caleb@crome.org>
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

Most of functions only receive the ssi_private reference and don't have
a knowledge of 'dev' pointer, even for debug purpose.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index dbd5f10..13613fd 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -275,6 +275,7 @@ struct fsl_ssi_private {
 	struct fsl_ssi_dbg dbg_stats;
 
 	const struct fsl_ssi_soc_data *soc;
+	struct device *dev;
 };
 
 /*
@@ -1412,6 +1413,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi_private->soc = of_id->data;
+	ssi_private->dev = &pdev->dev;
 
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (sprop) {
-- 
1.9.1
