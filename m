Return-Path: <SRS0=zdUo=3U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD92C2D0DB
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 20:41:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20C121734
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 20:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ar2jZQg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20C121734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CB6F1665;
	Fri, 31 Jan 2020 21:40:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CB6F1665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580503281;
	bh=08wAzbLNH+mIXspUpEOVGSpAA8OglggptRjOTeEKgqE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ar2jZQg6ADibcWEf6s6WjDxBk2dvxWcUXeQDuZmXSuKnNGDNvZJc5tYPuIrK6Brdg
	 2fjeSXf0CcPvCNDIeFcDVcws80AOjodoQlfMUdTQrFB6WCtDPROnUwu2SelgTNz/K0
	 DNcVMXz+sOkfoGPFMA12gy/jp9fUfEZPDfwhJZb0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76860F80218;
	Fri, 31 Jan 2020 21:40:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9DD1F8021E; Fri, 31 Jan 2020 21:40:28 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2654FF80143
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2020 21:40:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2654FF80143
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 12:40:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,387,1574150400"; d="scan'208";a="324887818"
Received: from dukhwank-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.182.128])
 by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2020 12:40:17 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 31 Jan 2020 14:40:03 -0600
Message-Id: <20200131204003.10153-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>
Subject: [alsa-devel] [PATCH] ALSA: hda: Add JasperLake PCI ID and codec vid
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Yong Zhi <yong.zhi@intel.com>

Add HD Audio Device PCI ID and codec vendor_id for the Intel JasperLake
REV2/A0 silicon.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_intel.c  | 2 ++
 sound/pci/hda/patch_hdmi.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b5e8d4301883..92a042e34d3e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2451,6 +2451,8 @@ static const struct pci_device_id azx_ids[] = {
 	/* Jasperlake */
 	{ PCI_DEVICE(0x8086, 0x38c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	{ PCI_DEVICE(0x8086, 0x4dc8),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Tigerlake */
 	{ PCI_DEVICE(0x8086, 0xa0c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 48bddc218829..7c006f9858c0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4256,6 +4256,7 @@ HDA_CODEC_ENTRY(0x8086280c, "Cannonlake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x8086280d, "Geminilake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x8086280f, "Icelake HDMI",	patch_i915_icl_hdmi),
 HDA_CODEC_ENTRY(0x80862812, "Tigerlake HDMI",	patch_i915_tgl_hdmi),
+HDA_CODEC_ENTRY(0x8086281a, "Jasperlake HDMI",	patch_i915_icl_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
