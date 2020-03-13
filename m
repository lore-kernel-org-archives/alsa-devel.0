Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB596C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:57:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DFD20724
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dAV9PE4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DFD20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8AF2F1810;
	Fri, 13 Mar 2020 16:56:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8AF2F1810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584115028;
	bh=Mwr5dozpbfthVrHw0goDWngpbxR0cEEQ2JLD3vy+P7U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dAV9PE4MPEIiWaNHZ0vJC7Ydzi6m0vsRZvMENmgSVmcbO+xVQAoIpGi7uxmNN98dj
	 mvNg/BPMtB6dXAoNz+Cb9qB67yaUYV1G6/icnwBOUgnHSPO+qSmtMX9aGw9O8YKS97
	 dJvhsTUcOLOAb2jw7oXlZoK0uhetscm6xqLga6AY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01770F801A3;
	Fri, 13 Mar 2020 16:56:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50B9AF801EB; Fri, 13 Mar 2020 16:56:15 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6808BF80086
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 16:56:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6808BF80086
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 08:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; d="scan'208";a="442462247"
Received: from msbaldwi-mobl.amr.corp.intel.com (HELO
 yzhi-desktop.amr.corp.intel.com) ([10.251.4.79])
 by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 08:56:06 -0700
From: Yong Zhi <yong.zhi@intel.com>
To: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com
Subject: [PATCH] ASoC: max98357a: Add ACPI HID MAX98360A
Date: Fri, 13 Mar 2020 10:55:26 -0500
Message-Id: <1584114926-29287-1-git-send-email-yong.zhi@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com,
 Rajesh.Swaminathan@maximintegrated.com, broonie@kernel.org,
 sathyanarayana.nujella@intel.com, uday.m.bhat@intel.com,
 Yong Zhi <yong.zhi@intel.com>
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

Maxim MAX98360A audio amplifier is functionally identical to MAX98357A,
add ACPI ID "MAX98360A" for driver reuse.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/codecs/max98357a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 74f20114297c..a8bd793a7867 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -133,6 +133,7 @@ MODULE_DEVICE_TABLE(of, max98357a_device_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id max98357a_acpi_match[] = {
 	{ "MX98357A", 0 },
+	{ "MX98360A", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, max98357a_acpi_match);
-- 
2.7.4

