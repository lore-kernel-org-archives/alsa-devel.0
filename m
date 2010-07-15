From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] asoc: multi-component: mpc8610: fix typo in
	mpc8610_hpcd_data
Date: Thu, 15 Jul 2010 16:55:00 -0500
Message-ID: <1279230900-26193-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	by alsa0.perex.cz (Postfix) with ESMTP id D5387103816
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 23:55:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The dma_id[] variable in struct mpc8610_hpcd_data is a zero-length
array, when it should be of length 2.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Liam, please squash this into your repository.

 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 81ab639..8665cc2 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -37,7 +37,7 @@ struct mpc8610_hpcd_data {
 	unsigned int cpu_clk_direction;
 	unsigned int clk_frequency;
 	unsigned int ssi_id;		/* 0 = SSI1, 1 = SSI2, etc */
-	unsigned int dma_id[0];		/* 0 = DMA1, 1 = DMA2, etc */
+	unsigned int dma_id[2];		/* 0 = DMA1, 1 = DMA2, etc */
 	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
 	char dai_name[32];
 };
-- 
1.7.0.1
