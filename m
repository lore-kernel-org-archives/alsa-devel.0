Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE44BC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:39:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039CF64D9D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039CF64D9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F3FF169D;
	Tue,  9 Feb 2021 00:38:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F3FF169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827542;
	bh=0KKn65JggR9AM9pFBNuvLNqjpD1+v9yhbYRBEq3h4do=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pb9HizGk+YpsIPzg2+ATI31hZf+8ezXnUcyQs+hhWumexHybIv2SF+QTEl+Gde3Xb
	 5cRXMC85kQtzLCkvPlMOZrBa1iUnN5qyeSfvxG/e6ub85CLQxbcMOYBccf+uvza8sM
	 rvZwcBOWTphuTQ4NWUckycEdRLd48ZOPptsXTZ6w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50454F804E2;
	Tue,  9 Feb 2021 00:34:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02C0BF8027C; Tue,  9 Feb 2021 00:34:16 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D3A7F8027B
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:34:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D3A7F8027B
IronPort-SDR: Sa8HgKKSY3Jg2hhx2ApkVSlTfVl0//WIWxHFj80BiCjHd3rYE0+wsLImyg2SBsVqjmIiMYTi7C
 E4ovAtpzpshw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168923512"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="168923512"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:57 -0800
IronPort-SDR: RHNWFdgtL/cN9Dssh3fzAJkDQ8N9Xs9NW9r1eRNlhuypvwzVQkTUgoQHXvReYSLHEMxqFdHexc
 Fc9b9DqnJIng==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="374741354"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:56 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 08/11] ASoC: SOF: Intel: SoundWire: refine ACPI match
Date: Mon,  8 Feb 2021 17:33:33 -0600
Message-Id: <20210208233336.59449-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
References: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

We have existing platforms where the wrong machine is selected. We
need to make sure the number of devices reported on a link matches
what we expect for a link descriptor. This helps avoid using the
TGL-RVP configuration for an HP platform or vice-versa, depending on
the order in which they are inserted in the table.

Co-developed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
---
 sound/soc/sof/intel/hda.c | 59 +++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 57853ef89cd1..2279e30c9245 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1021,32 +1021,63 @@ static bool link_slaves_found(struct snd_sof_dev *sdev,
 	struct sdw_intel_slave_id *ids = sdw->ids;
 	int num_slaves = sdw->num_slaves;
 	unsigned int part_id, link_id, unique_id, mfg_id;
-	int i, j;
+	int i, j, k;
 
 	for (i = 0; i < link->num_adr; i++) {
 		u64 adr = link->adr_d[i].adr;
+		int reported_part_count = 0;
 
 		mfg_id = SDW_MFG_ID(adr);
 		part_id = SDW_PART_ID(adr);
 		link_id = SDW_DISCO_LINK_ID(adr);
+
+		for (j = 0; j < num_slaves; j++) {
+			/* find out how many identical parts were reported on that link */
+			if (ids[j].link_id == link_id &&
+			    ids[j].id.part_id == part_id &&
+			    ids[j].id.mfg_id == mfg_id)
+				reported_part_count++;
+		}
+
 		for (j = 0; j < num_slaves; j++) {
+			int expected_part_count = 0;
+
 			if (ids[j].link_id != link_id ||
 			    ids[j].id.part_id != part_id ||
 			    ids[j].id.mfg_id != mfg_id)
 				continue;
-			/*
-			 * we have to check unique id
-			 * if there is more than one
-			 * Slave on the link
-			 */
-			unique_id = SDW_UNIQUE_ID(adr);
-			if (link->num_adr == 1 ||
-			    ids[j].id.unique_id == SDW_IGNORED_UNIQUE_ID ||
-			    ids[j].id.unique_id == unique_id) {
-				dev_dbg(bus->dev,
-					"found %x at link %d\n",
-					part_id, link_id);
-				break;
+
+			/* find out how many identical parts are expected */
+			for (k = 0; k < link->num_adr; k++) {
+				u64 adr2 = link->adr_d[i].adr;
+				unsigned int part_id2, link_id2, mfg_id2;
+
+				mfg_id2 = SDW_MFG_ID(adr2);
+				part_id2 = SDW_PART_ID(adr2);
+				link_id2 = SDW_DISCO_LINK_ID(adr2);
+
+				if (link_id2 == link_id &&
+				    part_id2 == part_id &&
+				    mfg_id2 == mfg_id)
+					expected_part_count++;
+			}
+
+			if (reported_part_count == expected_part_count) {
+				/*
+				 * we have to check unique id
+				 * if there is more than one
+				 * Slave on the link
+				 */
+				unique_id = SDW_UNIQUE_ID(adr);
+				if (reported_part_count == 1 ||
+				    ids[j].id.unique_id == unique_id) {
+					dev_dbg(bus->dev, "found %x at link %d\n",
+						part_id, link_id);
+					break;
+				}
+			} else {
+				dev_dbg(bus->dev, "part %x reported %d expected %d on link %d, skipping\n",
+					part_id, reported_part_count, expected_part_count, link_id);
 			}
 		}
 		if (j == num_slaves) {
-- 
2.25.1

