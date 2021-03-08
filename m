Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E170C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 13:38:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041B7651C2
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 13:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041B7651C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63774825;
	Mon,  8 Mar 2021 14:38:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63774825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615210736;
	bh=s5DA6g0bLoNqIET1adhXU2KVjOceripnJuVCA6Ok7Uo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j6IBX3e/4ZLdR9ZOP2fT575mLBC19IzcDurVaDK3yultOtDDWqprdK3C5gOkb67Vo
	 llun0KbpfVcTQCm0PIYmbyDhK5H9F8mXiNfW+FAdi/e2pMA3ZkhDzY1wixdOwhpKgS
	 X4fXPSqVastBWw4nguEig08Hy5SEzweofOic17d4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3969F800ED;
	Mon,  8 Mar 2021 14:35:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3090BF80482; Mon,  8 Mar 2021 14:35:53 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A0B3F8020D
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 14:35:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A0B3F8020D
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E8C0E20050C;
 Mon,  8 Mar 2021 14:35:39 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1ABAE20050B;
 Mon,  8 Mar 2021 14:35:33 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B6889402B0;
 Mon,  8 Mar 2021 14:35:24 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v4 4/6] ASoC: imx-audio-rpmsg: Add rpmsg_driver for audio
 channel
Date: Mon,  8 Mar 2021 21:22:28 +0800
Message-Id: <1615209750-2357-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This driver is used to accept the message from rpmsg audio
channel, and if this driver is probed, it will help to register
the platform driver, the platform driver will use this
audio channel to send and receive messages to and from Cortex-M
core.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/Kconfig           |   4 +
 sound/soc/fsl/Makefile          |   1 +
 sound/soc/fsl/imx-audio-rpmsg.c | 151 ++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 sound/soc/fsl/imx-audio-rpmsg.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index f833856f6de0..cc81f6b917be 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -126,6 +126,10 @@ config SND_SOC_IMX_PCM_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
+config SND_SOC_IMX_AUDIO_RPMSG
+	tristate
+	depends on RPMSG
+
 config SND_SOC_IMX_AUDMUX
 	tristate "Digital Audio Mux module support"
 	help
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index b63802f345cc..f08f3cd07ff5 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_SND_SOC_IMX_AUDMUX) += snd-soc-imx-audmux.o
 
 obj-$(CONFIG_SND_SOC_IMX_PCM_FIQ) += imx-pcm-fiq.o
 obj-$(CONFIG_SND_SOC_IMX_PCM_DMA) += imx-pcm-dma.o
+obj-$(CONFIG_SND_SOC_IMX_AUDIO_RPMSG) += imx-audio-rpmsg.o
 
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
diff --git a/sound/soc/fsl/imx-audio-rpmsg.c b/sound/soc/fsl/imx-audio-rpmsg.c
new file mode 100644
index 000000000000..145edb1492b4
--- /dev/null
+++ b/sound/soc/fsl/imx-audio-rpmsg.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2017-2020 NXP
+
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+#include "imx-pcm-rpmsg.h"
+
+/*
+ * struct imx_audio_rpmsg: private data
+ *
+ * @rpmsg_pdev: pointer of platform device
+ */
+struct imx_audio_rpmsg {
+	struct platform_device *rpmsg_pdev;
+};
+
+static int imx_audio_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
+			      void *priv, u32 src)
+{
+	struct imx_audio_rpmsg *rpmsg = dev_get_drvdata(&rpdev->dev);
+	struct rpmsg_info *info = platform_get_drvdata(rpmsg->rpmsg_pdev);
+	struct rpmsg_r_msg *r_msg = (struct rpmsg_r_msg *)data;
+	struct rpmsg_msg *msg;
+	unsigned long flags;
+
+	dev_dbg(&rpdev->dev, "get from%d: cmd:%d. %d\n",
+		src, r_msg->header.cmd, r_msg->param.resp);
+
+	switch (r_msg->header.type) {
+	case MSG_TYPE_C:
+		/* TYPE C is notification from M core */
+		switch (r_msg->header.cmd) {
+		case TX_PERIOD_DONE:
+			spin_lock_irqsave(&info->lock[TX], flags);
+			msg = &info->msg[TX_PERIOD_DONE + MSG_TYPE_A_NUM];
+
+			/*
+			 * Low power mode: get the buffer pointer from
+			 * receive msg.
+			 */
+			if (r_msg->header.major == 1 &&
+			    r_msg->header.minor == 2)
+				msg->r_msg.param.buffer_tail =
+						r_msg->param.buffer_tail;
+			else
+				msg->r_msg.param.buffer_tail++;
+
+			msg->r_msg.param.buffer_tail %= info->num_period[TX];
+			spin_unlock_irqrestore(&info->lock[TX], flags);
+			info->callback[TX](info->callback_param[TX]);
+			break;
+		case RX_PERIOD_DONE:
+			spin_lock_irqsave(&info->lock[RX], flags);
+			msg = &info->msg[RX_PERIOD_DONE + MSG_TYPE_A_NUM];
+
+			if (r_msg->header.major == 1 &&
+			    r_msg->header.minor == 2)
+				msg->r_msg.param.buffer_tail =
+						r_msg->param.buffer_tail;
+			else
+				msg->r_msg.param.buffer_tail++;
+
+			msg->r_msg.param.buffer_tail %= info->num_period[1];
+			spin_unlock_irqrestore(&info->lock[RX], flags);
+			info->callback[RX](info->callback_param[RX]);
+			break;
+		default:
+			dev_warn(&rpdev->dev, "unknown msg command\n");
+			break;
+		}
+		break;
+	case MSG_TYPE_B:
+		/* TYPE B is response msg */
+		memcpy(&info->r_msg, r_msg, sizeof(struct rpmsg_r_msg));
+		complete(&info->cmd_complete);
+		break;
+	default:
+		dev_warn(&rpdev->dev, "unknown msg type\n");
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_audio_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct imx_audio_rpmsg *data;
+	int ret = 0;
+
+	dev_info(&rpdev->dev, "new channel: 0x%x -> 0x%x!\n",
+		 rpdev->src, rpdev->dst);
+
+	data = devm_kzalloc(&rpdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	dev_set_drvdata(&rpdev->dev, data);
+
+	/* Register platform driver for rpmsg routine */
+	data->rpmsg_pdev = platform_device_register_data(&rpdev->dev,
+							 IMX_PCM_DRV_NAME,
+							 PLATFORM_DEVID_NONE,
+							 NULL, 0);
+	if (IS_ERR(data->rpmsg_pdev)) {
+		dev_err(&rpdev->dev, "failed to register rpmsg platform.\n");
+		ret = PTR_ERR(data->rpmsg_pdev);
+	}
+
+	return ret;
+}
+
+static void imx_audio_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct imx_audio_rpmsg *data = dev_get_drvdata(&rpdev->dev);
+
+	if (data->rpmsg_pdev)
+		platform_device_unregister(data->rpmsg_pdev);
+
+	dev_info(&rpdev->dev, "audio rpmsg driver is removed\n");
+}
+
+static struct rpmsg_device_id imx_audio_rpmsg_id_table[] = {
+	{ .name	= "rpmsg-audio-channel" },
+	{ },
+};
+
+static struct rpmsg_driver imx_audio_rpmsg_driver = {
+	.drv.name	= "imx_audio_rpmsg",
+	.drv.owner	= THIS_MODULE,
+	.id_table	= imx_audio_rpmsg_id_table,
+	.probe		= imx_audio_rpmsg_probe,
+	.callback	= imx_audio_rpmsg_cb,
+	.remove		= imx_audio_rpmsg_remove,
+};
+
+static int __init imx_audio_rpmsg_init(void)
+{
+	return register_rpmsg_driver(&imx_audio_rpmsg_driver);
+}
+
+static void __exit imx_audio_rpmsg_exit(void)
+{
+	unregister_rpmsg_driver(&imx_audio_rpmsg_driver);
+}
+module_init(imx_audio_rpmsg_init);
+module_exit(imx_audio_rpmsg_exit);
+
+MODULE_DESCRIPTION("Freescale SoC Audio RPMSG interface");
+MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
+MODULE_ALIAS("platform:imx_audio_rpmsg");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

