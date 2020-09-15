Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45502C43461
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:40:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510AB206B5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u0FdR7pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510AB206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49E091612;
	Tue, 15 Sep 2020 12:39:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49E091612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600166441;
	bh=NHeDZ3yQ9rxCv6OTKTxGj1UqwKZVjHyGBgpXcvDTZQQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u0FdR7pkIULCRYIuWSRJoz12wb9mBFRWZFbRV+KtQJ+NQcVb92WTR8cJngtgIes8D
	 tkBq0RVFf1cZ2S/9KYuyxCus02L45KPm9hZwOAlct9dVNSGJNKJLkBk/QdGnZt8SKK
	 aVz+DrDj5PkVHSGSVcNs8rj5TRLxsrpEKWh+fVvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3421F800F1;
	Tue, 15 Sep 2020 12:39:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F6F5F80212; Tue, 15 Sep 2020 12:39:49 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE312F800F1
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 12:39:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE312F800F1
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1kI8N0-0002fg-UJ; Tue, 15 Sep 2020 10:39:31 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] Revert "ALSA: usb-audio: Disable Lenovo P620 Rear line-in
 volume control"
Date: Tue, 15 Sep 2020 18:39:23 +0800
Message-Id: <20200915103925.12777-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Andrew Oakley <andrew@adoakley.name>, open list <linux-kernel@vger.kernel.org>,
 Chris Boyle <chris@boyle.name>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>
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

This reverts commit 34dedd2a83b241ba6aeb290260313c65dc58660e.

According to Realtek, volume FU works for line-in.

I can confirm volume control works after device firmware is updated.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/mixer_maps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 5b43e9e40e49..c369c81e74c4 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -371,7 +371,6 @@ static const struct usbmix_name_map asus_rog_map[] = {
 };
 
 static const struct usbmix_name_map lenovo_p620_rear_map[] = {
-	{ 19, NULL, 2 }, /* FU, Volume */
 	{ 19, NULL, 12 }, /* FU, Input Gain Pad */
 	{}
 };
-- 
2.17.1

