Return-Path: <SRS0=rARa=DB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE6BC4363D
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:13:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99335238E3
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hAKMKhkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99335238E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2C9A1806;
	Thu, 24 Sep 2020 18:12:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2C9A1806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600964030;
	bh=SH1rdXBligHHMW32C6eJHcRKTxNusL2DiyZJKh90clY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hAKMKhkMVpNu9YPxs8zVrt8ulNF+pwipwppZhAMAtfyvt7iC8gSw+Y92LrPIPLFcd
	 8VPlWiHHIn5wudLehI+tQp59Whi8mSS4zK8WbO+oxwAYQ4s0Wpkrnd3EHDXDJaTfDR
	 Yln8NuJmb6d7j7GiXXeKFd9DHVtG1AGEzzB1uqII=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D4AEF8023E;
	Thu, 24 Sep 2020 18:12:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92500F80256; Thu, 24 Sep 2020 18:12:18 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05CC0F80229
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2020 18:12:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05CC0F80229
IronPort-SDR: ThtrT8AvXsbGEgEPJGbP7knzJjlEk7WQCBfoJx9vnxUhcSOAChZuAuQEb08+gGjx45ExlSuXD3
 jzQhHDWvzMpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="246053519"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="246053519"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 09:12:01 -0700
IronPort-SDR: pJ2XnV5RlvYgaNSHVmG++HhkLXla6vLeMAjC8038Sbq7qO4rE3130RanCFZ9cyFLkgz4In9k+k
 BZWCPsm5Sfyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="383112452"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga001.jf.intel.com with ESMTP; 24 Sep 2020 09:12:00 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH v2] ALSA: hda - remove kerneldoc for internal hdac_i915
 function
Date: Thu, 24 Sep 2020 19:10:27 +0300
Message-Id: <20200924161027.3402260-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com
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

Drop the kerneldoc markup for connectivity_check() as it's an
static helper function. Fixes the following make W=1 warning:

sound/hda/hdac_i915.c:80: warning: Function parameter or member 'i915' not described in 'connectivity_check'
sound/hda/hdac_i915.c:80: warning: Function parameter or member 'hdac' not described in 'connectivity_check'

Fixes: 7b882fe3e3e8 ('ALSA: hda - handle multiple i915 device instances')
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/hda/hdac_i915.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index d236e497435d..5f0a1aa6ad84 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -73,9 +73,7 @@ void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_i915_set_bclk);
 
-/**
- * Returns true if the devices can be connected for audio.
- */
+/* returns true if the devices can be connected for audio */
 static bool connectivity_check(struct pci_dev *i915, struct pci_dev *hdac)
 {
 	struct pci_bus *bus_a = i915->bus, *bus_b = hdac->bus;
-- 
2.27.0

