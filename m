Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9E2C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 16:36:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A4A6168B;
	Thu, 21 Apr 2022 18:35:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A4A6168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650558970;
	bh=ZORpNS0w/y5IYoLKx4aBrIVAWfB5EAJlbjC5Lfs6TNs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AJjlJhvo1XpXd+SLBB2igzbCi8VqOp9c3h8s3XO60wf+df7dSgCmM7F92fhezvieh
	 iMpXxDBHtPL+S+H53Z+oiNgmvZSYg7bhxN4fcerrTGGPFEA8hdqz+OqtYK2oiqoy19
	 wvTABxuwIXzSsFy4hbk1bB/O0p8xXj4/q41c1OBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1475F80506;
	Thu, 21 Apr 2022 18:34:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEE41F804FE; Thu, 21 Apr 2022 18:34:26 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC1A1F804DA
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 18:34:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC1A1F804DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Cj68gFkd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650558863; x=1682094863;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZORpNS0w/y5IYoLKx4aBrIVAWfB5EAJlbjC5Lfs6TNs=;
 b=Cj68gFkda6xjJHGKvKoPKfQ/Uv5j3CbjgkOvb3qs9RY30Sm2DtjMn3QK
 Sx1KcM1PRlGeIxf2lF193h1ptMgLm5TFf8A/Ccl6fLAnQD+Pme5i0sxld
 pXBIC8kc1II9xip5DA8Bf5ek89FayOmCyZkanmh7a8cx3nb0H3I3mNHq2
 t+0D8YF3kh/6ZFP4lvWA3eKFhgwEHDqrDnSPz22mtua4CzbFqOIhU91X0
 RSvRkuNkQP2/cICrukPYoP/CS9msaLIpRPn8ZZsZ2SYBx8JnNdfELwnx1
 vabGOQqQa4+42wM5tYU/ix7AQmYW+Xep1cyvMorrit3hURDHgZPG68oTr w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246310273"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="246310273"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 09:34:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="614980755"
Received: from qingsu-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.148.250])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 09:34:10 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/4] ASoC: SOF: Intel: pci-tgl: add ADL-PS support
Date: Thu, 21 Apr 2022 11:33:57 -0500
Message-Id: <20220421163358.319489-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421163358.319489-1-pierre-louis.bossart@linux.intel.com>
References: <20220421163358.319489-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Muralidhar Reddy <muralidhar.reddy@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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

From: Muralidhar Reddy <muralidhar.reddy@intel.com>

Add PCI DID for Intel Alder Lake PS.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Muralidhar Reddy <muralidhar.reddy@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/pci-tgl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/intel/pci-tgl.c b/sound/soc/sof/intel/pci-tgl.c
index 478f9d051c4c5..f6a76dcf28fd6 100644
--- a/sound/soc/sof/intel/pci-tgl.c
+++ b/sound/soc/sof/intel/pci-tgl.c
@@ -176,6 +176,8 @@ static const struct pci_device_id sof_pci_ids[] = {
 		.driver_data = (unsigned long)&adl_desc},
 	{ PCI_DEVICE(0x8086, 0x51cd), /* ADL-P */
 		.driver_data = (unsigned long)&adl_desc},
+	{ PCI_DEVICE(0x8086, 0x51c9), /* ADL-PS */
+		.driver_data = (unsigned long)&adl_desc},
 	{ PCI_DEVICE(0x8086, 0x51cc), /* ADL-M */
 		.driver_data = (unsigned long)&adl_desc},
 	{ PCI_DEVICE(0x8086, 0x54c8), /* ADL-N */
-- 
2.30.2

