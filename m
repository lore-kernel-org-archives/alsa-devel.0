Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD20C433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:47:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4A620738
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RlWgCrsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4A620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC61F950;
	Mon,  3 Aug 2020 08:47:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC61F950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596437273;
	bh=/LkMrWqxV0dXhrjoZsNa+AbWkVjPnAs6G9jlJIcqa38=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RlWgCrsIadCt5DE7YwgjnRAWxn9IKhnzMAS0Nn+bC8pA19eK0g8WCZe+Y7ecN2az6
	 qma08RZo6DAZYZTyuRMzdsb7yuxpNZjKgymTkdLg7NCBTNqj9ylAV46E2WG/lu5hTz
	 HMJv8V/uGBNMA/gRTNWfITCz0ucBqQnPHqjvsgLc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66640F801F7;
	Mon,  3 Aug 2020 08:47:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DDB9F801F7; Mon,  3 Aug 2020 08:47:01 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76092F800B7
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 08:46:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76092F800B7
Received: from [114.252.213.24] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1k2UFJ-0002pN-0H; Mon, 03 Aug 2020 06:46:53 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] Revert "ALSA: hda: call runtime_allow() for all hda
 controllers"
Date: Mon,  3 Aug 2020 14:46:38 +0800
Message-Id: <20200803064638.6139-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: stable@vger.kernel.org
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

This reverts commit 9a6418487b56 ("ALSA: hda: call runtime_allow()
for all hda controllers").

The reverted patch already introduced some regressions on some
machines:
 - on gemini-lake machines, the error of "azx_get_response timeout"
   happens in the hda driver.
 - on the machines with alc662 codec, the audio jack detection doesn't
   work anymore.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208511
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/hda_intel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e699873c8293..e34a4d5d047c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2352,7 +2352,6 @@ static int azx_probe_continue(struct azx *chip)
 
 	if (azx_has_pm_runtime(chip)) {
 		pm_runtime_use_autosuspend(&pci->dev);
-		pm_runtime_allow(&pci->dev);
 		pm_runtime_put_autosuspend(&pci->dev);
 	}
 
-- 
2.17.1

