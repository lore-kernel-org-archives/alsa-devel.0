From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH v2] ASoC: fsl_asrc: old version asrc only
	support even numbered channels
Date: Thu, 24 Dec 2015 13:37:26 +0800
Message-ID: <6344b98f891fff3011257b21e1d8e39d7a123831.1450935357.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0145.outbound.protection.outlook.com [65.55.169.145])
 by alsa0.perex.cz (Postfix) with ESMTP id F2340266578
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 06:34:33 +0100 (CET)
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
v1->v2:
1. add an extra else if for the new condition.

 sound/soc/fsl/fsl_asrc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index be78dc9..16ff156 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -116,6 +116,10 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 	} else if (asrc_priv->channel_avail < channels) {
 		dev_err(dev, "can't afford required channels: %d\n", channels);
 		ret = -EINVAL;
+	} else if (asrc_priv->channel_bits < 4 && channels % 2 != 0) {
+		dev_err(dev, "old version asrc can't support an odd \
+			      channel number\n");
+		ret = -EINVAL;
 	} else {
 		asrc_priv->channel_avail -= channels;
 		asrc_priv->pair[index] = pair;
-- 
1.9.1
