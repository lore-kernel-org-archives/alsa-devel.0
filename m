Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C974C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:42:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43C664E9D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43C664E9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5663016C2;
	Tue,  9 Feb 2021 00:41:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5663016C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827768;
	bh=zDspIRWwagioIMw3O+Yom+0WEbFlNqy4Z9lBuIzPOrw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S7P7mt6fdI6SJ/sQrm8dunDV08T2m0mcalihU1cClWy3NOKtf7AkO0n1ooJoLmCFB
	 SXBev44FZOqU2oXFGkqQb9dnNZ7V3qCJVNs9RqRoch/F0sgrCLzeWcHYHhEqJzfB2/
	 KZcNr7G1mHE6uXQZqq54J174XZrL6ECGApIeXOH4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11DAEF8026C;
	Tue,  9 Feb 2021 00:41:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABE61F80264; Tue,  9 Feb 2021 00:41:06 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C714F80114
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:40:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C714F80114
IronPort-SDR: Yj/CRHj8mZLNtGT0twq7nQH697QG70rGQltczEaLL7l3BDAxm2lpjILwYH3aE+q/r9iPPrnufU
 +H4INgKrQK6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="243297916"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="243297916"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:40:56 -0800
IronPort-SDR: i+2BEftvCgK3CUPaIY1/ph3JDUXlOEeqo3RoMJivfp9EIDEc8z87PA45whygV51ASTfH73UbJh
 TWNvS1vb1v7Q==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="487640920"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:40:53 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 2/2] ASoC: Intel: boards: max98373: get dapm from cpu_dai
Date: Mon,  8 Feb 2021 17:40:43 -0600
Message-Id: <20210208234043.59750-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208234043.59750-1-pierre-louis.bossart@linux.intel.com>
References: <20210208234043.59750-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

There is a prefix on max98373 codec, and the prefix will be added to
the pin name However, there is no prefix on the "Right Spk" and "Left
Spk" widgets.

To avoid getting a redundant prefix, we should get dapm from cpu_dai
component.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_maxim_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_maxim_common.c b/sound/soc/intel/boards/sof_maxim_common.c
index c2a9757181fe..437d20562753 100644
--- a/sound/soc/intel/boards/sof_maxim_common.c
+++ b/sound/soc/intel/boards/sof_maxim_common.c
@@ -63,6 +63,7 @@ int max98373_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai;
 	int j;
 	int ret = 0;
 
@@ -70,10 +71,10 @@ int max98373_trigger(struct snd_pcm_substream *substream, int cmd)
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 		return 0;
 
+	cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	for_each_rtd_codec_dais(rtd, j, codec_dai) {
-		struct snd_soc_component *component = codec_dai->component;
 		struct snd_soc_dapm_context *dapm =
-				snd_soc_component_get_dapm(component);
+				snd_soc_component_get_dapm(cpu_dai->component);
 		char pin_name[MAX_98373_PIN_NAME];
 
 		snprintf(pin_name, ARRAY_SIZE(pin_name), "%s Spk",
-- 
2.25.1

