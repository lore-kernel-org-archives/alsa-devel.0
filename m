Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3078CC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:41:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2953A20856
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Rn8MWc+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2953A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC6F81669;
	Mon, 11 Nov 2019 11:40:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC6F81669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573468874;
	bh=KIIqb2KJ62GnziLbvkYLwx3WolQ5T5uaz6TXDjtBL3A=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rn8MWc+b8uPKw5MSq0RRu1+ww2K6Gp9BqvXpzGmVeMw6S3P73rezN6mrHNCeDyg62
	 0ZxtzNDqDPej1IznrtpHRZcBONt71i71HMMfu2CHUlUgRyxTPmbnRffPlmzgW86vjo
	 5U+aLM+cFIWW8qcqJNe8wbhr7Uf4SK6Na6kSKRAg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54452F8015C;
	Mon, 11 Nov 2019 11:40:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3DC9F804FF; Mon, 11 Nov 2019 04:06:46 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62C4BF8015C
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 04:06:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62C4BF8015C
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Nov 2019 19:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; d="scan'208";a="213680586"
Received: from cooperch-ml.itwn.intel.com ([10.5.253.163])
 by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2019 19:06:38 -0800
From: "Chiou, Cooper" <cooper.chiou@intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 11 Nov 2019 11:06:58 +0800
Message-Id: <20191111030658.3244-1-cooper.chiou@intel.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 11 Nov 2019 11:40:23 +0100
Cc: "Chiou, Cooper" <cooper.chiou@intel.com>, Chiou@alsa-project.org
Subject: [alsa-devel] [PATCH] ALSA: hda: Add Cometlake-S PCI ID
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add HD Audio Device PCI ID for the Intel Cometlake-S platform

Signed-off-by: Chiou, Cooper <cooper.chiou@intel.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cf53fbd872ee..c52419376c74 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2396,6 +2396,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* CometLake-H */
 	{ PCI_DEVICE(0x8086, 0x06C8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* CometLake-S */
+	{ PCI_DEVICE(0x8086, 0xa3f0),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Icelake */
 	{ PCI_DEVICE(0x8086, 0x34c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
