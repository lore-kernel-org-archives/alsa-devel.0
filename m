Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2ABC3F68F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:12:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1A32176D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EDvRW/I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1A32176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 323F8169A;
	Wed, 18 Dec 2019 21:11:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 323F8169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576699962;
	bh=+lIcsNylhlzJk4D4zRwOcB1Ar7SoduCmH8WMeXvgih0=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=EDvRW/I8POqkphxS3+FtfMKdKYaTm2DUWVcQtXAEcrN2jZEAjoyccgSF11dZkn2zC
	 8azsZri962F434wg1pBAMTKvwFMZSrScL9iaSMIxXeECNEJJ6zdcPeIAPU2ja5d7fg
	 r4laG7KHy9orUmvlFrcLa9A1c0R9yLOzDAm7kXH4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EF7BF802E7;
	Wed, 18 Dec 2019 21:05:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5838F802EA; Wed, 18 Dec 2019 21:05:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id CC86BF802DD
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 21:05:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC86BF802DD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 648F711B3;
 Wed, 18 Dec 2019 12:05:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67FF3F67D;
 Wed, 18 Dec 2019 12:05:49 -0800 (PST)
Date: Wed, 18 Dec 2019 20:05:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Guido Roncarolo <guido.roncarolo@nxp.com>
In-Reply-To: <20191218002616.7652-9-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191218002616.7652-9-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: imx: Read SAI parameters and send
	them to DSP" to the asoc tree
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

   ASoC: SOF: imx: Read SAI parameters and send them to DSP

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From d88cbd6feaf4b5de07d91f531112cf57ce821d78 Mon Sep 17 00:00:00 2001
From: Guido Roncarolo <guido.roncarolo@nxp.com>
Date: Tue, 17 Dec 2019 18:26:16 -0600
Subject: [PATCH] ASoC: SOF: imx: Read SAI parameters and send them to DSP

Follow example from Intel SSP.

Signed-off-by: Guido Roncarolo <guido.roncarolo@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191218002616.7652-9-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/pcm.c      |  8 +++++
 sound/soc/sof/topology.c | 69 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 86829e5bd62d..9bb6388742e1 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -693,6 +693,14 @@ static int sof_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 		channels->min = dai->dai_config->esai.tdm_slots;
 		channels->max = dai->dai_config->esai.tdm_slots;
 
+		dev_dbg(component->dev,
+			"channels_min: %d channels_max: %d\n",
+			channels->min, channels->max);
+		break;
+	case SOF_DAI_IMX_SAI:
+		channels->min = dai->dai_config->sai.tdm_slots;
+		channels->max = dai->dai_config->sai.tdm_slots;
+
 		dev_dbg(component->dev,
 			"channels_min: %d channels_max: %d\n",
 			channels->min, channels->max);
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index e06fa7c7e502..9f4f8868b386 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -695,6 +695,13 @@ static const struct sof_topology_token esai_tokens[] = {
 		offsetof(struct sof_ipc_dai_esai_params, mclk_id), 0},
 };
 
+/* SAI */
+static const struct sof_topology_token sai_tokens[] = {
+	{SOF_TKN_IMX_SAI_MCLK_ID,
+		SND_SOC_TPLG_TUPLE_TYPE_SHORT, get_token_u16,
+		offsetof(struct sof_ipc_dai_sai_params, mclk_id), 0},
+};
+
 /*
  * DMIC PDM Tokens
  * SOF_TKN_INTEL_DMIC_PDM_CTRL_ID should be the first token
@@ -2704,8 +2711,66 @@ static int sof_link_sai_load(struct snd_soc_component *scomp, int index,
 			     struct snd_soc_tplg_hw_config *hw_config,
 			     struct sof_ipc_dai_config *config)
 {
-	/*TODO: Add implementation */
-	return 0;
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
+	struct snd_soc_tplg_private *private = &cfg->priv;
+	struct sof_ipc_reply reply;
+	u32 size = sizeof(*config);
+	int ret;
+
+	/* handle master/slave and inverted clocks */
+	sof_dai_set_format(hw_config, config);
+
+	/* init IPC */
+	memset(&config->sai, 0, sizeof(struct sof_ipc_dai_sai_params));
+	config->hdr.size = size;
+
+	ret = sof_parse_tokens(scomp, &config->sai, sai_tokens,
+			       ARRAY_SIZE(sai_tokens), private->array,
+			       le32_to_cpu(private->size));
+	if (ret != 0) {
+		dev_err(scomp->dev, "error: parse sai tokens failed %d\n",
+			le32_to_cpu(private->size));
+		return ret;
+	}
+
+	config->sai.mclk_rate = le32_to_cpu(hw_config->mclk_rate);
+	config->sai.mclk_direction = hw_config->mclk_direction;
+
+	config->sai.tdm_slots = le32_to_cpu(hw_config->tdm_slots);
+	config->sai.tdm_slot_width = le32_to_cpu(hw_config->tdm_slot_width);
+	config->sai.rx_slots = le32_to_cpu(hw_config->rx_slots);
+	config->sai.tx_slots = le32_to_cpu(hw_config->tx_slots);
+
+	dev_info(scomp->dev,
+		 "tplg: config SAI%d fmt 0x%x mclk %d width %d slots %d mclk id %d\n",
+		config->dai_index, config->format,
+		config->sai.mclk_rate, config->sai.tdm_slot_width,
+		config->sai.tdm_slots, config->sai.mclk_id);
+
+	if (config->sai.tdm_slots < 1 || config->sai.tdm_slots > 8) {
+		dev_err(scomp->dev, "error: invalid channel count for SAI%d\n",
+			config->dai_index);
+		return -EINVAL;
+	}
+
+	/* send message to DSP */
+	ret = sof_ipc_tx_message(sdev->ipc,
+				 config->hdr.cmd, config, size, &reply,
+				 sizeof(reply));
+
+	if (ret < 0) {
+		dev_err(scomp->dev, "error: failed to set DAI config for SAI%d\n",
+			config->dai_index);
+		return ret;
+	}
+
+	/* set config for all DAI's with name matching the link name */
+	ret = sof_set_dai_config(sdev, size, link, config);
+	if (ret < 0)
+		dev_err(scomp->dev, "error: failed to save DAI config for SAI%d\n",
+			config->dai_index);
+
+	return ret;
 }
 
 static int sof_link_esai_load(struct snd_soc_component *scomp, int index,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
