Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29032C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 16:17:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD4561090
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 16:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BD4561090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 287E0181C;
	Fri, 15 Oct 2021 18:16:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 287E0181C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634314638;
	bh=Shte7RfdBCyw1mXEAlH1qYr4A7/b3Uxy7prlaC0uQJo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=miKPNBcKWfSrqVGJqZgEY0ylB8rpxtgt9UQG9h31mS/ufQeyMpbNMZTp+EMwj1X3h
	 Sqzyj80fSGbBhAXut65vSjCwqgSfYo/Z+gbzoL0YrPHXRlvm/DZXKr3Mh8MC5awvWw
	 L4xR6Cq84Ck5bcIX35sRqkAbhcjBjFXR1aOXmiO8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8BCDF80167;
	Fri, 15 Oct 2021 18:15:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF2EFF804E5; Fri, 15 Oct 2021 18:15:50 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F078F80167
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 18:15:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F078F80167
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225404634"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="225404634"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 09:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="564375222"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by FMSMGA003.fm.intel.com with ESMTP; 15 Oct 2021 09:11:12 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/6] ASoC: topology: Add header payload_size verification
Date: Fri, 15 Oct 2021 18:12:53 +0200
Message-Id: <20211015161257.27052-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015161257.27052-1-cezary.rojewski@intel.com>
References: <20211015161257.27052-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.com,
 hdegoede@redhat.com, broonie@kernel.org
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

Add sanity check to make sure the data is read within file boundary.
Helps in situations where file is only partially copied or malformed.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/soc-topology.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 88f849b119da..2484de8fd79a 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2438,6 +2438,7 @@ static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 		_manifest = manifest;
 	} else {
 		abi_match = false;
+
 		ret = manifest_new_ver(tplg, manifest, &_manifest);
 		if (ret < 0)
 			return ret;
@@ -2468,6 +2469,14 @@ static int soc_valid_header(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
+	if (soc_tplg_get_hdr_offset(tplg) + hdr->payload_size >= tplg->fw->size) {
+		dev_err(tplg->dev,
+			"ASoC: invalid header of type %d at offset %ld payload_size %d\n",
+			le32_to_cpu(hdr->type), soc_tplg_get_hdr_offset(tplg),
+			hdr->payload_size);
+		return -EINVAL;
+	}
+
 	/* big endian firmware objects not supported atm */
 	if (le32_to_cpu(hdr->magic) == SOC_TPLG_MAGIC_BIG_ENDIAN) {
 		dev_err(tplg->dev,
-- 
2.25.1

