Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD2C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 20:38:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EE664DDD
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 20:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EE664DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9F141680;
	Thu,  4 Feb 2021 21:37:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9F141680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612471119;
	bh=lHNstz8C1LQoCLvQCBg2qcUfjMNaRZRi95AaX7BKQeA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hn0ZG01nSAhj15dHbRfncP02DM1/jYZxIKlFtWLddmd6l5XIkBJwsp+NqsAxNWyC0
	 S+WUxYz4OUaZm7M9M/aJpOxYUWtydtMnFmr9NTrpqtUumy5UcuF7INPu+o71btwIs2
	 6eA27t+t8quBC7jW3/W6bpdNlIy3S+h/f4IxJNNM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4308EF804DA;
	Thu,  4 Feb 2021 21:34:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CD67F80139; Thu,  4 Feb 2021 21:33:58 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4948AF80139
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 21:33:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4948AF80139
IronPort-SDR: hAiNMab20jnH+fSTn9lZZaegyHeOatUqngYDKarqNAAq/c1WP+Zss1YaoJNs8+lD5cA60FAQOo
 K6tLP51CztnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181472524"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="181472524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 12:33:50 -0800
IronPort-SDR: iNMCUVqBpimLMKNHYxSKx6tl+WW3UvaexWw8d54NzLPPeNkix26PP3f1KjsCh+X+EH38JPaUf4
 6e5IppSNvleQ==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="483700339"
Received: from jdasilva-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.66.22])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 12:33:49 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 09/14] ASoC: Intel: sof_sdw: add trace for dai links
Date: Thu,  4 Feb 2021 14:33:07 -0600
Message-Id: <20210204203312.27112-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204203312.27112-1-pierre-louis.bossart@linux.intel.com>
References: <20210204203312.27112-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org, broonie@kernel.org, Rander Wang <rander.wang@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

We create dai links dynamically, so it is not easy to know what dai
links are created. So adding trace for dai link name and id.

Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 06f07dd45fb4..8adce6417b02 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -476,15 +476,14 @@ static int get_sdw_dailink_info(const struct snd_soc_acpi_link_adr *links,
 	return 0;
 }
 
-static void init_dai_link(struct snd_soc_dai_link *dai_links, int be_id,
-			  char *name, int playback, int capture,
-			  struct snd_soc_dai_link_component *cpus,
-			  int cpus_num,
-			  struct snd_soc_dai_link_component *codecs,
-			  int codecs_num,
+static void init_dai_link(struct device *dev, struct snd_soc_dai_link *dai_links,
+			  int be_id, char *name, int playback, int capture,
+			  struct snd_soc_dai_link_component *cpus, int cpus_num,
+			  struct snd_soc_dai_link_component *codecs, int codecs_num,
 			  int (*init)(struct snd_soc_pcm_runtime *rtd),
 			  const struct snd_soc_ops *ops)
 {
+	dev_dbg(dev, "create dai link %s, id %d\n", name, be_id);
 	dai_links->id = be_id;
 	dai_links->name = name;
 	dai_links->platforms = platform_component;
@@ -822,7 +821,7 @@ static int create_sdw_dailink(struct device *dev, int *be_index,
 
 		playback = (stream == SNDRV_PCM_STREAM_PLAYBACK);
 		capture = (stream == SNDRV_PCM_STREAM_CAPTURE);
-		init_dai_link(dai_links + *be_index, *be_index, name,
+		init_dai_link(dev, dai_links + *be_index, *be_index, name,
 			      playback, capture,
 			      cpus + *cpu_id, cpu_dai_num,
 			      codecs, codec_num,
@@ -1061,7 +1060,7 @@ static int sof_card_dai_links_create(struct device *dev,
 
 		playback = info->direction[SNDRV_PCM_STREAM_PLAYBACK];
 		capture = info->direction[SNDRV_PCM_STREAM_CAPTURE];
-		init_dai_link(links + link_id, be_id, name,
+		init_dai_link(dev, links + link_id, be_id, name,
 			      playback, capture,
 			      cpus + cpu_id, 1,
 			      ssp_components, 1,
@@ -1078,7 +1077,7 @@ static int sof_card_dai_links_create(struct device *dev,
 	/* dmic */
 	if (dmic_num > 0) {
 		cpus[cpu_id].dai_name = "DMIC01 Pin";
-		init_dai_link(links + link_id, be_id, "dmic01",
+		init_dai_link(dev, links + link_id, be_id, "dmic01",
 			      0, 1, // DMIC only supports capture
 			      cpus + cpu_id, 1,
 			      dmic_component, 1,
@@ -1086,7 +1085,7 @@ static int sof_card_dai_links_create(struct device *dev,
 		INC_ID(be_id, cpu_id, link_id);
 
 		cpus[cpu_id].dai_name = "DMIC16k Pin";
-		init_dai_link(links + link_id, be_id, "dmic16k",
+		init_dai_link(dev, links + link_id, be_id, "dmic16k",
 			      0, 1, // DMIC only supports capture
 			      cpus + cpu_id, 1,
 			      dmic_component, 1,
@@ -1129,7 +1128,7 @@ static int sof_card_dai_links_create(struct device *dev,
 			return -ENOMEM;
 
 		cpus[cpu_id].dai_name = cpu_name;
-		init_dai_link(links + link_id, be_id, name,
+		init_dai_link(dev, links + link_id, be_id, name,
 			      1, 0, // HDMI only supports playback
 			      cpus + cpu_id, 1,
 			      idisp_components + i, 1,
-- 
2.25.1

