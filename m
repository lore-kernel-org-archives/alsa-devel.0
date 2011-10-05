From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: Remove unused function declaration
	in imx-ssi.h
Date: Wed, 05 Oct 2011 14:40:46 +0800
Message-ID: <1317796846.21481.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FB6F1037FC
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 08:40:57 +0200 (CEST)
Received: by ywn1 with SMTP id 1so1484840ywn.38
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 23:40:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

These functions are removed in commit f0fba2ad
"ASoC: multi-component - ASoC Multi-Component Support".
Let's remove the leftover function declaration in header file.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/imx/imx-ssi.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/imx/imx-ssi.h
index 0a84cec..1072dfb 100644
--- a/sound/soc/imx/imx-ssi.h
+++ b/sound/soc/imx/imx-ssi.h
@@ -218,12 +218,6 @@ struct imx_ssi {
 	struct platform_device *soc_platform_pdev_fiq;
 };
 
-struct snd_soc_platform *imx_ssi_fiq_init(struct platform_device *pdev,
-		struct imx_ssi *ssi);
-void imx_ssi_fiq_exit(struct platform_device *pdev, struct imx_ssi *ssi);
-struct snd_soc_platform *imx_ssi_dma_mx2_init(struct platform_device *pdev,
-		struct imx_ssi *ssi);
-
 int snd_imx_pcm_mmap(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 int imx_pcm_new(struct snd_soc_pcm_runtime *rtd);
 void imx_pcm_free(struct snd_pcm *pcm);
-- 
1.7.4.1
