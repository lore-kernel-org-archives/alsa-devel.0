From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl_asrc: old version asrc only support
	even numbered channels
Date: Fri, 18 Dec 2015 17:29:13 +0800
Message-ID: <beec631c1838b4a0a2a43066e1e308ec1407715b.1450430846.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0101.outbound.protection.outlook.com [207.46.100.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 47D0226559B
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 10:27:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org

The latest asrc's channel bits is 4 bit, the old asrc's channel
bits is 3. For the old version asrc, channel should be a even number.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_asrc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index be78dc9..484e46ca 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -113,7 +113,8 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 	if (index == ASRC_INVALID_PAIR) {
 		dev_err(dev, "all pairs are busy now\n");
 		ret = -EBUSY;
-	} else if (asrc_priv->channel_avail < channels) {
+	} else if (asrc_priv->channel_avail < channels ||
+		  (asrc_priv->channel_bits < 4 && channels % 2 != 0)) {
 		dev_err(dev, "can't afford required channels: %d\n", channels);
 		ret = -EINVAL;
 	} else {
-- 
1.9.1
