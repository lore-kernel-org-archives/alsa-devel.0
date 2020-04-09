Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6978C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:03:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C71320679
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TFNHBVJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C71320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B14BD15F2;
	Thu,  9 Apr 2020 21:02:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B14BD15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586459000;
	bh=Y5aYd5RjZleqamafOhFisZ1S+ZBIxChXDIbEhebj6GI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TFNHBVJCkbXs50DOcrUGp6OLenytcXukXr2qi8Yh6Ng01FVE1Ot3/9zSjsSCbQ4Yp
	 J7+7QgQHJBNVJf7TiSDy/grrjFgLpykYBOsSQVq1Fth0fKtr6spxIZA4Oq/iMxLbAv
	 ru7hTYZs8Y+vrBHjAPwDcNwbLaE2zhUNFXjFci84=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D32DBF802BC;
	Thu,  9 Apr 2020 20:58:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EEBBF80299; Thu,  9 Apr 2020 20:58:47 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F368F80213
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 20:58:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F368F80213
IronPort-SDR: AQ3SisiIycyirY7vPWjRTPNpMhdSrc0jKobANKKPh7lFHGAI60VOXhVP3rf9Gm/VByeR66Csp+
 h4lSIJRoXltA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 11:58:39 -0700
IronPort-SDR: uPCpqh1RDUvxgRjug/44yqUDy6VDcIucWLe+n7rSab9CdzMSGR4WfUyUpdkJuZjXjjRUUZcwz6
 2g06f50ZSxSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="255248838"
Received: from davidadu-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.151.218])
 by orsmga006.jf.intel.com with ESMTP; 09 Apr 2020 11:58:38 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/13] ASoC: intel: sof_sdw: init all aggregated codecs
Date: Thu,  9 Apr 2020 13:58:20 -0500
Message-Id: <20200409185827.16255-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409185827.16255-1-pierre-louis.bossart@linux.intel.com>
References: <20200409185827.16255-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>
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

Init codecs which belong to the same group id on all links.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 41 ++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index a64dc563b47e..6a1b51c0546b 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -411,25 +411,36 @@ static int create_codec_dai_name(struct device *dev,
 
 static int set_codec_init_func(const struct snd_soc_acpi_link_adr *link,
 			       struct snd_soc_dai_link *dai_links,
-			       bool playback)
+			       bool playback, int group_id)
 {
 	int i;
 
-	for (i = 0; i < link->num_adr; i++) {
-		unsigned int part_id;
-		int codec_index;
-
-		part_id = SDW_PART_ID(link->adr_d[i].adr);
-		codec_index = find_codec_info_part(part_id);
+	do {
+		/*
+		 * Initialize the codec. If codec is part of an aggregated
+		 * group (group_id>0), initialize all codecs belonging to
+		 * same group.
+		 */
+		for (i = 0; i < link->num_adr; i++) {
+			unsigned int part_id;
+			int codec_index;
 
-		if (codec_index < 0)
-			return codec_index;
+			part_id = SDW_PART_ID(link->adr_d[i].adr);
+			codec_index = find_codec_info_part(part_id);
 
-		if (codec_info_list[codec_index].init)
-			codec_info_list[codec_index].init(link, dai_links,
-						 &codec_info_list[codec_index],
-						 playback);
-	}
+			if (codec_index < 0)
+				return codec_index;
+			/* The group_id is > 0 iff the codec is aggregated */
+			if (link->adr_d[i].endpoints->group_id != group_id)
+				continue;
+			if (codec_info_list[codec_index].init)
+				codec_info_list[codec_index].init(link,
+						dai_links,
+						&codec_info_list[codec_index],
+						playback);
+		}
+		link++;
+	} while (link->mask && group_id);
 
 	return 0;
 }
@@ -623,7 +634,7 @@ static int create_sdw_dailink(struct device *dev, int *be_index,
 			      NULL, &sdw_ops);
 
 		ret = set_codec_init_func(link, dai_links + (*be_index)++,
-					  playback);
+					  playback, group_id);
 		if (ret < 0) {
 			dev_err(dev, "failed to init codec %d", codec_index);
 			return ret;
-- 
2.20.1

