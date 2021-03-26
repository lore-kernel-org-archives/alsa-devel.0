Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AC3C433C1
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 16:57:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710F661A27
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 16:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710F661A27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72716167C;
	Fri, 26 Mar 2021 17:57:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72716167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616777871;
	bh=TdjcmSO0DZPvQWlF64CbUa+11zapuNWx86yaoFMV9LM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uxEitakT2nU3EQbkY+5Pm2yX2WhLNJN1OhTnAy91SKSH0jht2UVWA7AoQ+jb5SSc+
	 C6tmnJyUwl6Phmw+NYoWo6tZn3+Xj/uGctv317Lhdqq2K0eeIxJpFtsGBvLrQMKzU4
	 hwo/m5O3pulmdXjIHaSSqtBi8SlTfOKYCX4cVnxU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0208AF801EB;
	Fri, 26 Mar 2021 17:56:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9038F8016B; Fri, 26 Mar 2021 17:56:08 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1822BF80104
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 17:56:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1822BF80104
IronPort-SDR: i3Jc+ArjUnRgUGl333umsMD+j40qY9yaC78NJO7shQEE3eaaFA0zjGZJhn1uM78+OflJTz06bb
 zapcZmcuA6rQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="255177088"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="255177088"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 09:55:57 -0700
IronPort-SDR: lw8RazV76WRkY9loFXhtuqd4QChRhrIvulXVW7N8RsLxSEukvLwkuimRgvDzAZE0ugSFEera4j
 rDpuc2sPn/Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="409978164"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2021 09:55:55 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 2/3] ASoC: SOF: Intel: HDA: add hw params callback for SSP DAIs
Date: Fri, 26 Mar 2021 18:51:49 +0200
Message-Id: <20210326165150.255533-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326165150.255533-1-kai.vehmanen@linux.intel.com>
References: <20210326165150.255533-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
 Jaska Uimonen <jaska.uimonen@linux.intel.com>
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

From: Jaska Uimonen <jaska.uimonen@linux.intel.com>

Currently SSP DAIs don't have hw params callback function as there
wasn't anything to setup after initial topology loading. After enabling
multiple DAI configs the current config can be sent in the callback.

This patch changes the way SSP config ipc is sent to the dsp. Before it
was only sent once in topology loading, but now it will be additionally
sent always when stream is opened. Mechanism is similar as with HDA
DAIs.

Signed-off-by: Jaska Uimonen <jaska.uimonen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index c6cb8c212eca..8d7bab433fb3 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -414,6 +414,44 @@ static struct snd_soc_cdai_ops sof_probe_compr_ops = {
 #endif
 #endif
 
+static int ssp_dai_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, SOF_AUDIO_PCM_DRV_NAME);
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	struct sof_ipc_dai_config *config;
+	struct snd_sof_dai *sof_dai;
+	struct sof_ipc_reply reply;
+	int ret;
+
+	list_for_each_entry(sof_dai, &sdev->dai_list, list) {
+		if (!sof_dai->cpu_dai_name || !sof_dai->dai_config)
+			continue;
+
+		if (!strcmp(dai->name, sof_dai->cpu_dai_name) &&
+		    substream->stream == sof_dai->comp_dai.direction) {
+			config = &sof_dai->dai_config[sof_dai->current_config];
+
+			/* send IPC */
+			ret = sof_ipc_tx_message(sdev->ipc, config->hdr.cmd, config,
+						 config->hdr.size, &reply, sizeof(reply));
+
+			if (ret < 0)
+				dev_err(sdev->dev, "error: failed to set DAI config for %s\n",
+					sof_dai->name);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops ssp_dai_ops = {
+	.hw_params = ssp_dai_hw_params,
+};
+
 /*
  * common dai driver for skl+ platforms.
  * some products who use this DAI array only physically have a subset of
@@ -422,6 +460,7 @@ static struct snd_soc_cdai_ops sof_probe_compr_ops = {
 struct snd_soc_dai_driver skl_dai[] = {
 {
 	.name = "SSP0 Pin",
+	.ops = &ssp_dai_ops,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 8,
@@ -433,6 +472,7 @@ struct snd_soc_dai_driver skl_dai[] = {
 },
 {
 	.name = "SSP1 Pin",
+	.ops = &ssp_dai_ops,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 8,
@@ -444,6 +484,7 @@ struct snd_soc_dai_driver skl_dai[] = {
 },
 {
 	.name = "SSP2 Pin",
+	.ops = &ssp_dai_ops,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 8,
@@ -455,6 +496,7 @@ struct snd_soc_dai_driver skl_dai[] = {
 },
 {
 	.name = "SSP3 Pin",
+	.ops = &ssp_dai_ops,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 8,
@@ -466,6 +508,7 @@ struct snd_soc_dai_driver skl_dai[] = {
 },
 {
 	.name = "SSP4 Pin",
+	.ops = &ssp_dai_ops,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 8,
@@ -477,6 +520,7 @@ struct snd_soc_dai_driver skl_dai[] = {
 },
 {
 	.name = "SSP5 Pin",
+	.ops = &ssp_dai_ops,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 8,
-- 
2.31.0

