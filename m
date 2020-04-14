Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268DCC2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:15:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E5420644
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hhdOB+dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E5420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5F661682;
	Tue, 14 Apr 2020 12:14:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5F661682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586859318;
	bh=d+kRxqRHPuD3myktnDiyUbNm/K6jwFLGJ8vedp3+HDs=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hhdOB+dOY3QrKQVzybjMT0KZe6Gu3g4fAIMgkg2o/uWb176slafavomB6xQWAcb6Q
	 lHAvq15/EWRtGOuhWQ6N+HX/iubZZbDkQ0mC7d6ME3kNqRKe5q4spVRmUr/+ZfqP91
	 z81yTBnJiAivGAKYaq7cE4IzE6Pbu2cg7NPEdetM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A62AF80126;
	Tue, 14 Apr 2020 12:14:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 675BFF8013D; Tue, 14 Apr 2020 12:14:26 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7FAEF800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 12:14:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7FAEF800B9
Received: from [222.130.141.248] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1jOIaD-0000mq-8q; Tue, 14 Apr 2020 10:14:22 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda: enable the runtime_pm for non-vgaswitcheroo hda
 controllers
Date: Tue, 14 Apr 2020 18:14:05 +0800
Message-Id: <20200414101405.6992-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
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

Before the pci_driver->probe() is called, the pci subsystem calls
runtime_forbib() and runtime_get_sync() on this pci dev, so only call
runtime_put_autosuspend() is not enough to enable the runtime_pm on
this device.

For controllers with vgaswitcheroo feature, the pci/quirks.c will call
runtime_allow() for this dev, then the controllers could enter
rt_idle/suspend/resume, but for non-vgaswitcheroo controllers like
Intel hda controllers, the runtime_pm is not enabled even it calls
put_autosuspend(). Need to call runtime_allow() for those controllers
in the hda driver.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 8519051a426e..779705bef88b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2356,6 +2356,8 @@ static int azx_probe_continue(struct azx *chip)
 
 	if (azx_has_pm_runtime(chip)) {
 		pm_runtime_use_autosuspend(&pci->dev);
+		if (!use_vga_switcheroo(chip))
+			pm_runtime_allow(&pci->dev);
 		pm_runtime_put_autosuspend(&pci->dev);
 	}
 
-- 
2.17.1

