Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED2DC352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E47A2082F
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LlVMftBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E47A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9157416B5;
	Tue, 11 Feb 2020 17:03:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9157416B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581437062;
	bh=X86hjahnsdqxDgef/gBL3O0djTb2X0EIgpbq171KjDQ=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=LlVMftBb9U3WmbPkZU2KQT2IYpAYKR9/usOuYa8d4RZo+MtwB1MteJy98Kr4otYAw
	 dcDl1YL5kUASq2itReCaIUvuDoYmmC/pqaI2BH2jP2YnFqM4tdNPVIcVpODymYo+jw
	 cUxm6L2eTH8FfEVt6CButXgyCgAPjw9RDcWhKlp4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CED88F80376;
	Tue, 11 Feb 2020 16:49:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81853F80368; Tue, 11 Feb 2020 16:49:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 91D20F800E7
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 16:49:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91D20F800E7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 065A731B;
 Tue, 11 Feb 2020 07:49:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F19F3F68E;
 Tue, 11 Feb 2020 07:49:19 -0800 (PST)
Date: Tue, 11 Feb 2020 15:49:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Paul Olaru <paul.olaru@nxp.com>
In-Reply-To: <20200210095817.13226-3-daniel.baluta@oss.nxp.com>
Message-Id: <applied-20200210095817.13226-3-daniel.baluta@oss.nxp.com>
X-Patchwork-Hint: ignore
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Mark Brown <broonie@kernel.org>, linux-imx@nxp.com,
 Daniel Baluta <daniel.baluta@nxp.com>
Subject: [alsa-devel] Applied "ASoC: SOF: imx8: Add ops for i.MX8QM" to the
	asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: SOF: imx8: Add ops for i.MX8QM

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From acfa52027bb64b8f93324da2277ff662c7a95679 Mon Sep 17 00:00:00 2001
From: Paul Olaru <paul.olaru@nxp.com>
Date: Mon, 10 Feb 2020 11:58:15 +0200
Subject: [PATCH] ASoC: SOF: imx8: Add ops for i.MX8QM

i.MX8QM and i.MX8QXP are mostly identical platforms with minor hardware
differences. One of these differences affects the firmware boot process,
requiring the run operation to differ. All other ops are reused.

Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200210095817.13226-3-daniel.baluta@oss.nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/imx/imx8.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index 9ffc2a955e4f..b692752b2178 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -178,6 +178,24 @@ static int imx8x_run(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+static int imx8_run(struct snd_sof_dev *sdev)
+{
+	struct imx8_priv *dsp_priv = (struct imx8_priv *)sdev->private;
+	int ret;
+
+	ret = imx_sc_misc_set_control(dsp_priv->sc_ipc, IMX_SC_R_DSP,
+				      IMX_SC_C_OFS_SEL, 0);
+	if (ret < 0) {
+		dev_err(sdev->dev, "Error system address offset source select\n");
+		return ret;
+	}
+
+	imx_sc_pm_cpu_start(dsp_priv->sc_ipc, IMX_SC_R_DSP, true,
+			    RESET_VECTOR_VADDR);
+
+	return 0;
+}
+
 static int imx8_probe(struct snd_sof_dev *sdev)
 {
 	struct platform_device *pdev =
@@ -360,6 +378,39 @@ static struct snd_soc_dai_driver imx8_dai[] = {
 },
 };
 
+/* i.MX8 ops */
+struct snd_sof_dsp_ops sof_imx8_ops = {
+	/* probe and remove */
+	.probe		= imx8_probe,
+	.remove		= imx8_remove,
+	/* DSP core boot */
+	.run		= imx8_run,
+
+	/* Block IO */
+	.block_read	= sof_block_read,
+	.block_write	= sof_block_write,
+
+	/* ipc */
+	.send_msg	= imx8_send_msg,
+	.fw_ready	= sof_fw_ready,
+	.get_mailbox_offset	= imx8_get_mailbox_offset,
+	.get_window_offset	= imx8_get_window_offset,
+
+	.ipc_msg_data	= imx8_ipc_msg_data,
+	.ipc_pcm_params	= imx8_ipc_pcm_params,
+
+	/* module loading */
+	.load_module	= snd_sof_parse_module_memcpy,
+	.get_bar_index	= imx8_get_bar_index,
+	/* firmware loading */
+	.load_firmware	= snd_sof_load_firmware_memcpy,
+
+	/* DAI drivers */
+	.drv = imx8_dai,
+	.num_drv = 1, /* we have only 1 ESAI interface on i.MX8 */
+};
+EXPORT_SYMBOL(sof_imx8_ops);
+
 /* i.MX8X ops */
 struct snd_sof_dsp_ops sof_imx8x_ops = {
 	/* probe and remove */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
