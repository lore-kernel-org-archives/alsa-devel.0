Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A447C433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:48:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECAF61157
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECAF61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9EE91779;
	Wed,  5 May 2021 18:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9EE91779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620233320;
	bh=iT2avPf8ykFFu7OyRxk2NFxtbxSQnL/F9tfX2rBQK6I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AR5tvNVZUmEmDjBLvCq9zpZ7ouQKbX8enYeK+G18fselrqMCZ/vUrPLVzBGWlNgvQ
	 3hWjjX3I9fCNrRSUZKqMPrv5A8ndsnMArZnEBWVSgBb5u5Su1eP4c8AyZ2pajIrjva
	 mEdXJ+gmIv/iC97/H2QVPG4FhiA76AucJBr/cYys=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10272F805C2;
	Wed,  5 May 2021 18:37:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E2DCF8059F; Wed,  5 May 2021 18:37:36 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61D33F805A9
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:37:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61D33F805A9
IronPort-SDR: GlJv4PUfwx32iQ3ym9FeE33qKpROsSJjkNJTLHQouNd0t5F50gUCiJMFIQqsq2nYWrllwYQVua
 p5YUO94hJqxA==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="196219171"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="196219171"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 09:37:20 -0700
IronPort-SDR: SDsVG/b8fWQfCYWoNUn0LDMOP6CaFbu0N0BnYXQNK8Njmap9etR9v8YWo05dp276FOCyWKy/Hz
 OKl2tObqqBPw==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="458800020"
Received: from rtsagpan-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.51.38])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 09:37:19 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/13] ASoC: Intel: sof_sdw: add mutual exclusion between PCH
 DMIC and RT715
Date: Wed,  5 May 2021 11:36:56 -0500
Message-Id: <20210505163705.305616-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505163705.305616-1-pierre-louis.bossart@linux.intel.com>
References: <20210505163705.305616-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

When external RT714/715 devices are used for capture, we don't want
the PCH DMICs to be used.

Any information provided by the SOF platform driver or DMI quirks will
be overridden.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/boards/sof_sdw.c        | 19 +++++++++++++++++--
 sound/soc/intel/boards/sof_sdw_common.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index ecd3f90f4bbe..85a2797c2550 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -353,6 +353,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.part_id = 0x714,
 		.version_id = 3,
 		.direction = {false, true},
+		.ignore_pch_dmic = true,
 		.dai_name = "rt715-aif2",
 		.init = sof_sdw_rt715_sdca_init,
 	},
@@ -360,6 +361,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.part_id = 0x715,
 		.version_id = 3,
 		.direction = {false, true},
+		.ignore_pch_dmic = true,
 		.dai_name = "rt715-aif2",
 		.init = sof_sdw_rt715_sdca_init,
 	},
@@ -367,6 +369,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.part_id = 0x714,
 		.version_id = 2,
 		.direction = {false, true},
+		.ignore_pch_dmic = true,
 		.dai_name = "rt715-aif2",
 		.init = sof_sdw_rt715_init,
 	},
@@ -374,6 +377,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.part_id = 0x715,
 		.version_id = 2,
 		.direction = {false, true},
+		.ignore_pch_dmic = true,
 		.dai_name = "rt715-aif2",
 		.init = sof_sdw_rt715_init,
 	},
@@ -729,7 +733,8 @@ static int create_sdw_dailink(struct device *dev, int *be_index,
 			      int *cpu_id, bool *group_generated,
 			      struct snd_soc_codec_conf *codec_conf,
 			      int codec_count,
-			      int *codec_conf_index)
+			      int *codec_conf_index,
+			      bool *ignore_pch_dmic)
 {
 	const struct snd_soc_acpi_link_adr *link_next;
 	struct snd_soc_dai_link_component *codecs;
@@ -782,6 +787,9 @@ static int create_sdw_dailink(struct device *dev, int *be_index,
 	if (codec_index < 0)
 		return codec_index;
 
+	if (codec_info_list[codec_index].ignore_pch_dmic)
+		*ignore_pch_dmic = true;
+
 	cpu_dai_index = *cpu_id;
 	for_each_pcm_streams(stream) {
 		char *name, *cpu_name;
@@ -913,6 +921,7 @@ static int sof_card_dai_links_create(struct device *dev,
 	const struct snd_soc_acpi_link_adr *adr_link;
 	struct snd_soc_dai_link_component *cpus;
 	struct snd_soc_codec_conf *codec_conf;
+	bool ignore_pch_dmic = false;
 	int codec_conf_count;
 	int codec_conf_index = 0;
 	bool group_generated[SDW_MAX_GROUPS];
@@ -1019,7 +1028,8 @@ static int sof_card_dai_links_create(struct device *dev,
 					 sdw_cpu_dai_num, cpus, adr_link,
 					 &cpu_id, group_generated,
 					 codec_conf, codec_conf_count,
-					 &codec_conf_index);
+					 &codec_conf_index,
+					 &ignore_pch_dmic);
 		if (ret < 0) {
 			dev_err(dev, "failed to create dai link %d", be_id);
 			return -ENOMEM;
@@ -1087,6 +1097,10 @@ static int sof_card_dai_links_create(struct device *dev,
 DMIC:
 	/* dmic */
 	if (dmic_num > 0) {
+		if (ignore_pch_dmic) {
+			dev_warn(dev, "Ignoring PCH DMIC\n");
+			goto HDMI;
+		}
 		cpus[cpu_id].dai_name = "DMIC01 Pin";
 		init_dai_link(dev, links + link_id, be_id, "dmic01",
 			      0, 1, // DMIC only supports capture
@@ -1105,6 +1119,7 @@ static int sof_card_dai_links_create(struct device *dev,
 		INC_ID(be_id, cpu_id, link_id);
 	}
 
+HDMI:
 	/* HDMI */
 	if (hdmi_num > 0) {
 		idisp_components = devm_kcalloc(dev, hdmi_num,
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index f3cb6796363e..ea60e8ed215c 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -56,6 +56,7 @@ struct sof_sdw_codec_info {
 	int amp_num;
 	const u8 acpi_id[ACPI_ID_LEN];
 	const bool direction[2]; // playback & capture support
+	const bool ignore_pch_dmic;
 	const char *dai_name;
 	const struct snd_soc_ops *ops;
 
-- 
2.25.1

