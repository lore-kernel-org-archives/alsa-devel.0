Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DE2C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 08:09:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 326981767;
	Thu, 21 Apr 2022 10:08:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 326981767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650528545;
	bh=UhcPkQ2F0+AfVFg9YHqNEPCYB37LdJwX2du13NXYzUo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=essvW+XFbfwVmTBcmw44keD8l1srf/ME268DV3LpDpTwexqhkNvo+FCOyGNaYh56Y
	 GQeVYjUDEQPK8Li2xvlm2ZxMnG9q5yr5g9OyT9KMtaP2mRE0Ij54VNV7d70y2nyS/k
	 C6hnaSYuofUvD5GqQo6e6lmU9qY1R2Hkewuh4fSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D07CF80508;
	Thu, 21 Apr 2022 10:07:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD6EAF804F3; Thu, 21 Apr 2022 10:07:26 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1CA23F8032D
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 10:07:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1CA23F8032D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="nP1CnJfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650528441; x=1682064441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UhcPkQ2F0+AfVFg9YHqNEPCYB37LdJwX2du13NXYzUo=;
 b=nP1CnJfG/hsSKQW/Ti9ModdXkTT6UYCuK8a8JQAbExJVOZ+ZbB6l07fX
 hqVGIRiTJOVysgy4jK3QRtS6m9Ja1uQ01YxC22tmL/uWxo8TELh/xSvv4
 VlJkX0x4l68CQJf+75pN+8K9qkjAnXI3lqeIL0lhWepOwGQjzoTEWukjN
 bfcnrCDWzC1/54BnOl0ai4E3xAMMhNTSMNhkhufRZ3uBsW0ABtKT//whV
 nwWZWCk1IYgRQiDQYB6/+XcQbs2lKVxWptgPC5GcCFOcSRJ8yHgvimNts
 cJcifSfh2k8nSaNT0HVoI/VJcWXmBp3LvUSFqCKUACW8VpKZ+NWyZ9Luq g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324718779"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="324718779"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 01:07:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="577087013"
Received: from dchirca-mobl4.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.215.207])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 01:07:16 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, AjitKumar.Pandey@amd.com,
 daniel.baluta@nxp.com
Subject: [PATCH 2/6] ASoC: SOF: Do not check for the fw_ready callback
Date: Thu, 21 Apr 2022 11:07:31 +0300
Message-Id: <20220421080735.31698-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220421080735.31698-1-peter.ujfalusi@linux.intel.com>
References: <20220421080735.31698-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

The fw_ready is handled internally to ipc3, the callback no longer in
use and it is going to be removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Ajit Pandey <ajitkumar.pandey@amd.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index d981a1c3fb05..5f43adda0b11 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -367,7 +367,7 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
 	if (!sof_ops(sdev) || !sof_ops(sdev)->probe || !sof_ops(sdev)->run ||
 	    !sof_ops(sdev)->block_read || !sof_ops(sdev)->block_write ||
 	    !sof_ops(sdev)->send_msg || !sof_ops(sdev)->load_firmware ||
-	    !sof_ops(sdev)->ipc_msg_data || !sof_ops(sdev)->fw_ready) {
+	    !sof_ops(sdev)->ipc_msg_data) {
 		dev_err(dev, "error: missing mandatory ops\n");
 		return -EINVAL;
 	}
-- 
2.35.3

