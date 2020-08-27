Return-Path: <SRS0=PqWm=CF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65515C433E6
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 23:06:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC6E20872
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xgms53Hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC6E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 674A7181B;
	Fri, 28 Aug 2020 01:05:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 674A7181B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598569608;
	bh=ifTFFpdbpLBHRbw+/paNoMjQGPyTSnOU4tKlsb0+sY0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xgms53Hirtfs2RtIWf63IjvrE+mA8GTrkHm6rEiy7S8eedPWVMsyPGmAkiW22+PIS
	 9abKgbSK+pmRkSK0pad6RQmBTwe9+OveoWkrWAYKthZo7/TaPwZfVM0OiDGE3JczFV
	 wFwbD5PNrO6OtyeKMXZ9QcGz+dGXd0QWf5v84F3U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE5D9F80085;
	Fri, 28 Aug 2020 01:05:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE696F8016F; Fri, 28 Aug 2020 01:05:54 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 248F9F80085
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 01:05:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 248F9F80085
IronPort-SDR: pNFB9NYkuHZ/BDgY3mz6jckzaFAHHWGMiSERVT6aClamwgnaU3JY2+GfKtGjG3Gk1bhby2vDvO
 tOAMpKIcgkVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="157604465"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="157604465"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 16:05:43 -0700
IronPort-SDR: fHIxMqKa1dwKd0C42NvpzBF20uA1s6/qOTdOu4aWbjQ7J4S2H50I2hXHBATyY6FIO+BZLlcZad
 HyL8VVf3B8VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="323781920"
Received: from joycetoh-desk.sc.intel.com ([172.25.206.187])
 by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2020 16:05:43 -0700
From: Harsha Priya <harshapriya.n@intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH v2] ALSA: HDA: Early Forbid of runtime PM
Date: Thu, 27 Aug 2020 16:05:36 -0700
Message-Id: <1598569536-9450-1-git-send-email-harshapriya.n@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Harsha Priya <harshapriya.n@intel.com>,
 Emmanuel Jillela <emmanuel.jillela@intel.com>
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

For certain codecs (like Realtek), pm_runtime_forbid() is invoked 
in the probe function after build_controls(). In a stress test, 
its observed occasionally that runtime PM calls are invoked 
before controls are built. This causes the codec to be
runtime suspended before probe completes. Because of this, not all
controls are enumerated correctly, and audio does not work until
system is rebooted.

This issue being common across all codecs, pm_runtime_forbid() is 
called when the codec object is created to fix this issue. 
A codec enables or disables runtime pm in its own probe function.

Multiple stress tests of 2000+ cycles has been done to test the fix.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Emmanuel Jillela <emmanuel.jillela@intel.com>
Reviewed-by: Kailang Yang <kailang@realtek.com>
---
 sound/pci/hda/hda_codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e96a87f1b611..a356c21edb90 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1000,6 +1000,9 @@ int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
 	if (err < 0)
 		goto error;
 
+	/* PM runtime needs to be enabled later after binding codec */
+	pm_runtime_forbid(&codec->core.dev);
+
 	return 0;
 
  error:
-- 
2.17.1

