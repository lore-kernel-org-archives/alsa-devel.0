Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD1EC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 16:00:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C83923434
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 16:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C83923434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62BFE1712;
	Wed, 13 Jan 2021 16:59:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62BFE1712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610553636;
	bh=nwR/+l7tGqLVyQizYtAYiZmWmdXHjr8LDWw1T2uIXB8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Oo1MdpKhmz7aDhLzDkxmXYpH6pTG+MRaYmjFxcpnIJXqfHoWGjg+9048dCF9NO1CI
	 qIS/j91oiVbcMlVk74Ork121snwigUI0M8o6JiYFXOE3s+X3ZOobYj1p5GXdvTS0ey
	 ikyzHEMu8qH5q2SQfj48X/Iqxn8pTvjzKB4Fmzhk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B501DF8016D;
	Wed, 13 Jan 2021 16:59:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A28C3F801ED; Wed, 13 Jan 2021 16:59:43 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E34E9F80113
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 16:59:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E34E9F80113
IronPort-SDR: ggefpbEaywGz4FBpjJVBEACK1L1gHRcErv0wavH6C7cEFBDRZSCNwitfvWSfKrUUQ2nTWfUq/l
 8e0OSpcsIPJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="157404928"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; d="scan'208";a="157404928"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 07:59:34 -0800
IronPort-SDR: HY3vRV8wXKXm6TsvmPiqGxJ8LD8CQ4mZOQCaDSYXsSz1v8D20BOSPN5aNlZH0g9eYNsQnaW7NJ
 87W4wvrGMcOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; d="scan'208";a="381903736"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008.jf.intel.com with ESMTP; 13 Jan 2021 07:59:32 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda: Add AlderLake-P PCI ID and HDMI codec vid
Date: Wed, 13 Jan 2021 17:56:29 +0200
Message-Id: <20210113155629.4097057-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 kai.vehmanen@linux.intel.com,
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

Add HD Audio PCI ID and HDMI codec vendor ID for Intel AlderLake-P.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/pci/hda/hda_intel.c  | 3 +++
 sound/pci/hda/patch_hdmi.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f36ddf1149a6..279739fa3a7d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2507,6 +2507,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* Alderlake-S */
 	{ PCI_DEVICE(0x8086, 0x7ad0),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Alderlake-P */
+	{ PCI_DEVICE(0x8086, 0x51c8),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Elkhart Lake */
 	{ PCI_DEVICE(0x8086, 0x4b55),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 74d246a0dc6d..97adff0cbcab 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4346,6 +4346,7 @@ HDA_CODEC_ENTRY(0x8086280f, "Icelake HDMI",	patch_i915_icl_hdmi),
 HDA_CODEC_ENTRY(0x80862812, "Tigerlake HDMI",	patch_i915_tgl_hdmi),
 HDA_CODEC_ENTRY(0x80862814, "DG1 HDMI",	patch_i915_tgl_hdmi),
 HDA_CODEC_ENTRY(0x80862815, "Alderlake HDMI",	patch_i915_tgl_hdmi),
+HDA_CODEC_ENTRY(0x8086281c, "Alderlake-P HDMI", patch_i915_tgl_hdmi),
 HDA_CODEC_ENTRY(0x80862816, "Rocketlake HDMI",	patch_i915_tgl_hdmi),
 HDA_CODEC_ENTRY(0x8086281a, "Jasperlake HDMI",	patch_i915_icl_hdmi),
 HDA_CODEC_ENTRY(0x8086281b, "Elkhartlake HDMI",	patch_i915_icl_hdmi),
-- 
2.29.2

