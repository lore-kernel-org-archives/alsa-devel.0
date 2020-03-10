Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D14DC3F2D0
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:45:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DFA21D7E
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i7MR9t8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DFA21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C9211669;
	Tue, 10 Mar 2020 18:44:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C9211669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583862341;
	bh=xhMsy34wqbHOJguxIGIMCjKjBYezDuH2glEvSHrFCtQ=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=i7MR9t8GySYbigNldxmj1Zk67tMKI5S85oMaHvJvl7yt27r5sjgy+Ly547qAL7oLi
	 PJVMu2USGD+eLJ0gyZaEjxdoSb+goWfAjMfXCXZAiNSjFrfCgt9B0gfkGy1U3kwJjr
	 PUnj9zmTsvkKZCmUOWPqEdoWuOEBZ0tdr+JcoW1s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B532EF8020C;
	Tue, 10 Mar 2020 18:44:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DE2FF80217; Tue, 10 Mar 2020 18:44:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 65EBBF80123
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 18:44:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65EBBF80123
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EA1F1FB;
 Tue, 10 Mar 2020 10:44:43 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4384A3F67D;
 Tue, 10 Mar 2020 10:44:43 -0700 (PDT)
Date: Tue, 10 Mar 2020 17:44:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Applied "ASoC: Intel: Skylake: Await purge request ack on CNL" to the
 asoc tree
In-Reply-To: <20200305145314.32579-8-cezary.rojewski@intel.com>
Message-Id: <applied-20200305145314.32579-8-cezary.rojewski@intel.com>
X-Patchwork-Hint: ignore
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, vkoul@kernel.org,
 Mark Brown <broonie@kernel.org>
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

The patch

   ASoC: Intel: Skylake: Await purge request ack on CNL

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 7693cadac86548b30389a6e11d78c38db654f393 Mon Sep 17 00:00:00 2001
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Thu, 5 Mar 2020 15:53:14 +0100
Subject: [PATCH] ASoC: Intel: Skylake: Await purge request ack on CNL

Each purge request is sent by driver after master core is powered up and
unresetted but before it is unstalled. On unstall, ROM begins processing
the request and initializing environment for FW load. Host should await
ROM's ack before moving forward. Without doing so, ROM init poll may
start too early and false timeouts can occur.

Fixes: cb6a55284629 ("ASoC: Intel: cnl: Add sst library functions for cnl platform")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-8-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c     |  1 -
 sound/soc/intel/skylake/cnl-sst.c     | 20 ++++++++++++++++++--
 sound/soc/intel/skylake/skl-sst-dsp.h |  1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index cdafade8abd6..38b9d7494083 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -17,7 +17,6 @@
 #include "skl.h"
 
 #define BXT_BASEFW_TIMEOUT	3000
-#define BXT_INIT_TIMEOUT	300
 #define BXT_ROM_INIT_TIMEOUT	70
 #define BXT_IPC_PURGE_FW	0x01004000
 
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 060e47ae3391..c6abcd5aa67b 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -57,18 +57,34 @@ static int cnl_prepare_fw(struct sst_dsp *ctx, const void *fwdata, u32 fwsize)
 	ctx->dsp_ops.stream_tag = stream_tag;
 	memcpy(ctx->dmab.area, fwdata, fwsize);
 
+	ret = skl_dsp_core_power_up(ctx, SKL_DSP_CORE0_MASK);
+	if (ret < 0) {
+		dev_err(ctx->dev, "dsp core0 power up failed\n");
+		ret = -EIO;
+		goto base_fw_load_failed;
+	}
+
 	/* purge FW request */
 	sst_dsp_shim_write(ctx, CNL_ADSP_REG_HIPCIDR,
 			   CNL_ADSP_REG_HIPCIDR_BUSY | (CNL_IPC_PURGE |
 			   ((stream_tag - 1) << CNL_ROM_CTRL_DMA_ID)));
 
-	ret = cnl_dsp_enable_core(ctx, SKL_DSP_CORE0_MASK);
+	ret = skl_dsp_start_core(ctx, SKL_DSP_CORE0_MASK);
 	if (ret < 0) {
-		dev_err(ctx->dev, "dsp boot core failed ret: %d\n", ret);
+		dev_err(ctx->dev, "Start dsp core failed ret: %d\n", ret);
 		ret = -EIO;
 		goto base_fw_load_failed;
 	}
 
+	ret = sst_dsp_register_poll(ctx, CNL_ADSP_REG_HIPCIDA,
+				    CNL_ADSP_REG_HIPCIDA_DONE,
+				    CNL_ADSP_REG_HIPCIDA_DONE,
+				    BXT_INIT_TIMEOUT, "HIPCIDA Done");
+	if (ret < 0) {
+		dev_err(ctx->dev, "timeout for purge request: %d\n", ret);
+		goto base_fw_load_failed;
+	}
+
 	/* enable interrupt */
 	cnl_ipc_int_enable(ctx);
 	cnl_ipc_op_int_enable(ctx);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 067d1ea11cde..1df9ef422f61 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -68,6 +68,7 @@ struct skl_dev;
 #define SKL_FW_INIT			0x1
 #define SKL_FW_RFW_START		0xf
 #define BXT_FW_ROM_INIT_RETRY		3
+#define BXT_INIT_TIMEOUT		300
 
 #define SKL_ADSPIC_IPC			1
 #define SKL_ADSPIS_IPC			1
-- 
2.20.1

