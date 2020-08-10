Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17782C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:32:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E8E206E9
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ddezna3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E8E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5FAF15F9;
	Mon, 10 Aug 2020 15:31:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5FAF15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597066347;
	bh=hXDHYACO4grhKhALcKtYFeQ7GUaxjUV7PegPtPEYIf0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ddezna3XiaFABqFJfBBLXk7gy9HaxLdgBrI6VyupyiJdRfRUiLWyhxdsS4AU+NAMB
	 tNO526TkGtv8W7xCKdvonraF4wJ6d80R1l+MaUQGTWN+u3j7BFcWgvnhLrA1Y9IiK5
	 cBZCJbAN/itAdNmY1xU4ML7tz1ox1CbF7qyuYxyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56F5CF800BC;
	Mon, 10 Aug 2020 15:31:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6692EF8022B; Mon, 10 Aug 2020 15:31:34 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05E11F800BC
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 15:31:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05E11F800BC
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1k57tQ-000489-AE; Mon, 10 Aug 2020 13:31:12 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: usb-audio: Disable Lenovo P620 Rear line-in volume
 control
Date: Mon, 10 Aug 2020 21:31:06 +0800
Message-Id: <20200810133108.31580-1-kai.heng.feng@canonical.com>
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

The USB device (0x17aa:0x1046) that support Lenovo P620 rear panel
line-in claim to support volume control, but it doens't seem to have an
AMP, so when line-in volume lowers below 80, nothing gets recorded
anymore.

Disable the volume control to workaround the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/mixer_maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index c369c81e74c4..5b43e9e40e49 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -371,6 +371,7 @@ static const struct usbmix_name_map asus_rog_map[] = {
 };
 
 static const struct usbmix_name_map lenovo_p620_rear_map[] = {
+	{ 19, NULL, 2 }, /* FU, Volume */
 	{ 19, NULL, 12 }, /* FU, Input Gain Pad */
 	{}
 };
-- 
2.17.1

