Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80373C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:37:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79C064E7B
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79C064E7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3AF216B5;
	Tue,  9 Feb 2021 00:36:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3AF216B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827434;
	bh=FiN0XNUHFeKrhSgxX4yB+urpWiz+gRShJ9U6DGnflQQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mtU4/97vUucZDgzQ9paBt3Z9gM1ESDHpvl7z3RrMgGF7rvrFrwN7jhzKUr96sVMiK
	 AUqMZjI1qte4s6Iz4jP9iWXfRtDPfqDIQ1Arf3VJOZ+I3eMYUBA+FJvOl2GZaLB3uH
	 Vkc6zyTgDCvDh7X3ej2dN2gWAjy90UNRuTKllrcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27378F80169;
	Tue,  9 Feb 2021 00:34:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FD8FF8032D; Tue,  9 Feb 2021 00:34:13 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BDB5F80240
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:33:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BDB5F80240
IronPort-SDR: 6ESs5L5gxYgesvETwt6XwbMx7Jo1z+UnjDzsqUWaCSA81TMg7pcotYxiISXJRXU2Sow7qPsauL
 +D3AkVcFU/Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168923506"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="168923506"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:55 -0800
IronPort-SDR: ReyxhAsOnN9js2813/CQdF1Rj6RRpcprxnCre1ITHdGQKOyq2UxDBZanVLw+JiyK2+XmXaikGQ
 XvJpvz3js6Uw==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="374741341"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:54 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 06/11] ASoC: intel: sof_sdw: add trace for dai links
Date: Mon,  8 Feb 2021 17:33:31 -0600
Message-Id: <20210208233336.59449-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
References: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>
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
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
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

