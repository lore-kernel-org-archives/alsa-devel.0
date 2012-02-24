From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/6] ASoC: fsl: correct get_dma_channel
	parameter name
Date: Fri, 24 Feb 2012 22:09:36 +0800
Message-ID: <1330092582-21180-2-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 371ED245E6
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 14:56:19 +0100 (CET)
Received: by dady9 with SMTP id y9so2726533dad.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 05:56:18 -0800 (PST)
In-Reply-To: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The second parameter of function get_dma_channel is actually a property
name rather than a compatible string, so rename it for less confusing.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/mpc8610_hpcd.c |    4 ++--
 sound/soc/fsl/p1022_ds.c     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 0ea4a5a..15e06e9d 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -273,7 +273,7 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 }
 
 static int get_dma_channel(struct device_node *ssi_np,
-			   const char *compatible,
+			   const char *name,
 			   struct snd_soc_dai_link *dai,
 			   unsigned int *dma_channel_id,
 			   unsigned int *dma_id)
@@ -283,7 +283,7 @@ static int get_dma_channel(struct device_node *ssi_np,
 	const u32 *iprop;
 	int ret;
 
-	dma_channel_np = get_node_by_phandle_name(ssi_np, compatible,
+	dma_channel_np = get_node_by_phandle_name(ssi_np, name,
 						  "fsl,ssi-dma-channel");
 	if (!dma_channel_np)
 		return -EINVAL;
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index a5d4e80..d32ec46 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -276,7 +276,7 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 }
 
 static int get_dma_channel(struct device_node *ssi_np,
-			   const char *compatible,
+			   const char *name,
 			   struct snd_soc_dai_link *dai,
 			   unsigned int *dma_channel_id,
 			   unsigned int *dma_id)
@@ -286,7 +286,7 @@ static int get_dma_channel(struct device_node *ssi_np,
 	const u32 *iprop;
 	int ret;
 
-	dma_channel_np = get_node_by_phandle_name(ssi_np, compatible,
+	dma_channel_np = get_node_by_phandle_name(ssi_np, name,
 						  "fsl,ssi-dma-channel");
 	if (!dma_channel_np)
 		return -EINVAL;
-- 
1.7.5.4
