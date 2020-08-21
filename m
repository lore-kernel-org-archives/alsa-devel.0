Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E6C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:04:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAE22072D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ANCFgzBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAE22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D082A1687;
	Fri, 21 Aug 2020 22:03:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D082A1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598040238;
	bh=jl04W2FFEsPOnSU41LCUNzuFcqWoiWo3uQWs4j4jFqA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ANCFgzBsHDNY2M5rMBtIhCtPB7PnW2/hcjK7EKkRQIzYWziR0WVng8CKmKAIv0fxx
	 8udZZHFUFh/wO0dGDORWiWiImzHsp3kmaXNeLWihmHDvq5vEKbxRf4k5Gxoud12SV1
	 kA8TRyLqj7Ih4IMk9CsAnNvHBzSoqGfdMhfdCMn8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DF3DF80334;
	Fri, 21 Aug 2020 21:56:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6BD2F802E9; Fri, 21 Aug 2020 21:56:40 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41EDAF802A9
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 21:56:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41EDAF802A9
IronPort-SDR: 6l233SA9xeup3Anz717kZA0m4eqExQRpbhFIW/0vV5rfupK0L3H3fTWJa8XGGRE+Q7igCtnbSj
 WjPQYpJTNgBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="217158557"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; d="scan'208";a="217158557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 12:56:20 -0700
IronPort-SDR: XMEyhJlIA9tMknhu2WP028WPyFGy0p6FpE4zC+zDSwL6ZOJ8ztMRXrSFmnP5+3Zg/rfbyMhGjm
 EKm39ZnofuXg==
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; d="scan'208";a="279002414"
Received: from pahnn-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.254.176.176])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 12:56:19 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/14] ASoC: Intel: sof_sdw: check SoundWire version when
 matching codec
Date: Fri, 21 Aug 2020 14:55:55 -0500
Message-Id: <20200821195603.215535-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821195603.215535-1-pierre-louis.bossart@linux.intel.com>
References: <20200821195603.215535-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vinod.koul@intel.com, broonie@kernel.org,
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

Some codecs with the same part id but different SoundWire versions
have different configurations. So we have to separate them in
codec_info_list[].

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c        | 35 ++++++++++++++-----------
 sound/soc/intel/boards/sof_sdw_common.h |  1 +
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 100c0a83a6ad..dca981f7c7d3 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -253,18 +253,25 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 	},
 };
 
-static inline int find_codec_info_part(unsigned int part_id)
+static inline int find_codec_info_part(u64 adr)
 {
+	unsigned int part_id, sdw_version;
 	int i;
 
+	part_id = SDW_PART_ID(adr);
+	sdw_version = SDW_VERSION(adr);
 	for (i = 0; i < ARRAY_SIZE(codec_info_list); i++)
-		if (part_id == codec_info_list[i].id)
-			break;
+		/*
+		 * A codec info is for all sdw version with the part id if
+		 * version_id is not specified in the codec info.
+		 */
+		if (part_id == codec_info_list[i].id &&
+		    (!codec_info_list[i].version_id ||
+		     sdw_version == codec_info_list[i].version_id))
+			return i;
 
-	if (i == ARRAY_SIZE(codec_info_list))
-		return -EINVAL;
+	return -EINVAL;
 
-	return i;
 }
 
 static inline int find_codec_info_acpi(const u8 *acpi_id)
@@ -310,13 +317,12 @@ static int get_sdw_dailink_info(const struct snd_soc_acpi_link_adr *links,
 
 	for (link = links; link->num_adr; link++) {
 		const struct snd_soc_acpi_endpoint *endpoint;
-		int part_id, codec_index;
+		int codec_index;
 		int stream;
 		u64 adr;
 
 		adr = link->adr_d->adr;
-		part_id = SDW_PART_ID(adr);
-		codec_index = find_codec_info_part(part_id);
+		codec_index = find_codec_info_part(adr);
 		if (codec_index < 0)
 			return codec_index;
 
@@ -444,7 +450,7 @@ static int create_codec_dai_name(struct device *dev,
 		if (!codec[comp_index].name)
 			return -ENOMEM;
 
-		codec_index = find_codec_info_part(part_id);
+		codec_index = find_codec_info_part(adr);
 		if (codec_index < 0)
 			return codec_index;
 
@@ -468,11 +474,9 @@ static int set_codec_init_func(const struct snd_soc_acpi_link_adr *link,
 		 * same group.
 		 */
 		for (i = 0; i < link->num_adr; i++) {
-			unsigned int part_id;
 			int codec_index;
 
-			part_id = SDW_PART_ID(link->adr_d[i].adr);
-			codec_index = find_codec_info_part(part_id);
+			codec_index = find_codec_info_part(link->adr_d[i].adr);
 
 			if (codec_index < 0)
 				return codec_index;
@@ -576,7 +580,7 @@ static int create_sdw_dailink(struct device *dev, int *be_index,
 	struct snd_soc_dai_link_component *codecs;
 	int cpu_dai_id[SDW_MAX_CPU_DAIS];
 	int cpu_dai_num, cpu_dai_index;
-	unsigned int part_id, group_id;
+	unsigned int group_id;
 	int codec_idx = 0;
 	int i = 0, j = 0;
 	int codec_index;
@@ -618,8 +622,7 @@ static int create_sdw_dailink(struct device *dev, int *be_index,
 	}
 
 	/* find codec info to create BE DAI */
-	part_id = SDW_PART_ID(link->adr_d[0].adr);
-	codec_index = find_codec_info_part(part_id);
+	codec_index = find_codec_info_part(link->adr_d[0].adr);
 	if (codec_index < 0)
 		return codec_index;
 
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 76d6c0c3839d..cb1320348d0b 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -52,6 +52,7 @@ enum {
 
 struct sof_sdw_codec_info {
 	const int id;
+	const int version_id;
 	int amp_num;
 	const u8 acpi_id[ACPI_ID_LEN];
 	const bool direction[2]; // playback & capture support
-- 
2.25.1

