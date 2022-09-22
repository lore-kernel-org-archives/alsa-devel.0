Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39917C6FA82
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Sep 2022 10:05:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE43182B;
	Thu, 22 Sep 2022 12:04:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE43182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663841104;
	bh=moircuo2tF+ktIg96N5s2b9R60Z+DX5x4nxS7DD+zrM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ah5HrXHIzwVd0GbbX8zlGrYIuEsiEQ1THRnrfLKUaWOPFeKn+Q4YvTTzHprJJLVpU
	 cPSpgzBC08J2Vj/e9H1o/PqgTz3hbhCaPM5DfXY+JoYJwiWJmB4s5lpZ5nVzRXSFeK
	 YpOCLDMeHUY9d8UMloPyBOEsOYQBrMXBw+LXgbUE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BC4DF804AA;
	Thu, 22 Sep 2022 12:03:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC055F80539; Thu, 22 Sep 2022 12:03:28 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3243BF804AA
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2022 12:03:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3243BF804AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="M964CLpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663841003; x=1695377003;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=moircuo2tF+ktIg96N5s2b9R60Z+DX5x4nxS7DD+zrM=;
 b=M964CLpFg+FouiX0GArV1SlOkq3SfFQwA3+f56OL24maAEvZeKrCFFVB
 Ev4QXAgSATNmDG8Cj72H4AqN3BA+vweThOKXaqereO2pxWBVtOS9DtB5+
 Usl3rYBhuawdrIVaNgkNLqzEodmyGPjHWVRNnJ+Z5SL/OwQ8WFgd1iWZd
 EUPm+N1VhsIT9le09mhxEU/JdPhbuTLTR4LuWXaTC4jS6XMWdi1zhI7qp
 47s/YPHbyMfaqNBFZZed0i6b8DPMAH2lQqmpKosi09GTY1wMwMY4ytSPJ
 SQt4Q+SLX55kdt7Rd78EtAT+ymVkPokX7LMtjEULsZfxWKl8Wck4hTJZi w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300241301"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; d="scan'208";a="300241301"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2022 03:03:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; d="scan'208";a="622036230"
Received: from icostanz-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.home)
 ([10.251.210.149])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2022 03:03:19 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: SOF: pci-tgl: add missing PCI IDs for RPL
Date: Thu, 22 Sep 2022 12:02:54 +0200
Message-Id: <20220922100254.27159-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922100254.27159-1-pierre-louis.bossart@linux.intel.com>
References: <20220922100254.27159-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Add IDs for RPL-M and RPL-PX

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/pci-tgl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/intel/pci-tgl.c b/sound/soc/sof/intel/pci-tgl.c
index 1e0f7f0734e75..f9cbf3ad85b32 100644
--- a/sound/soc/sof/intel/pci-tgl.c
+++ b/sound/soc/sof/intel/pci-tgl.c
@@ -262,6 +262,10 @@ static const struct pci_device_id sof_pci_ids[] = {
 		.driver_data = (unsigned long)&adl_desc},
 	{ PCI_DEVICE(0x8086, 0x51cd), /* ADL-P */
 		.driver_data = (unsigned long)&adl_desc},
+	{ PCI_DEVICE(0x8086, 0x51ce), /* RPL-M */
+		.driver_data = (unsigned long)&rpl_desc},
+	{ PCI_DEVICE(0x8086, 0x51cf), /* RPL-PX */
+		.driver_data = (unsigned long)&rpl_desc},
 	{ PCI_DEVICE(0x8086, 0x54c8), /* ADL-N */
 		.driver_data = (unsigned long)&adl_desc},
 	{ 0, }
-- 
2.34.1

