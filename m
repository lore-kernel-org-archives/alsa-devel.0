Return-Path: <SRS0=iGAb=EV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D50C2D0E4
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 15:40:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28355223C7
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 15:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sZie3dGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28355223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9707C17A4;
	Sun, 15 Nov 2020 16:39:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9707C17A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605454811;
	bh=qXsDJgH3sCeVvAexXKcSrFo8RcG7kKDmK+Fd2Xgt+f0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sZie3dGUFgEiFrFNnFf+uZk6A3OOYsciDCKoTN5fimNWH+mQppt0Y2YINEDYqTsuv
	 RIplkiPRpFDV+cC3Yuyz48Gke7X06whlqIJOlNUbwv6gF0VDuqlTNcpT6ZnbXZOX01
	 3siNOHqREueOjwHRBbBuqgYztFND5Y2RQSCw38nA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DC5CF801ED;
	Sun, 15 Nov 2020 16:39:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68940F801F5; Sun, 15 Nov 2020 16:39:19 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CC3BF8010A
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2020 16:39:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CC3BF8010A
Received: from 61-220-137-34.hinet-ip.hinet.net ([61.220.137.34]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1keK7B-0007bG-AP; Sun, 15 Nov 2020 15:38:54 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: usb-audio: Use ALC1220-VB-DT mapping for ASUS ROG Strix
 TRX40 mobo
Date: Sun, 15 Nov 2020 23:38:42 +0800
Message-Id: <20201115153843.1109200-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Andrew Oakley <andrew@adoakley.name>, open list <linux-kernel@vger.kernel.org>,
 Chris Boyle <chris@boyle.name>, Chris Wulff <crwulff@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexander Tsoy <alexander@tsoy.me>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

ASUS ROG Strix also uses ALC1220-VB-DT, so adjust the mapping and add
profile name to let userspace pick correct UCM profile.

BugLink: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1031
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/card.c       | 4 ++++
 sound/usb/mixer_maps.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index fa764b61fe9c..4457214a3ae6 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -379,6 +379,10 @@ static const struct usb_audio_device_name usb_audio_names[] = {
 
 	DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"),
 
+	/* ASUS ROG Strix */
+	PROFILE_NAME(0x0b05, 0x1917,
+		     "Realtek", "ALC1220-VB-DT", "Realtek-ALC1220-VB-Desktop"),
+
 	/* Dell WD15 Dock */
 	PROFILE_NAME(0x0bda, 0x4014, "Dell", "WD15 Dock", "Dell-WD15-Dock"),
 	/* Dell WD19 Dock */
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index c369c81e74c4..a7212f16660e 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -561,7 +561,8 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 	},
 	{	/* ASUS ROG Strix */
 		.id = USB_ID(0x0b05, 0x1917),
-		.map = asus_rog_map,
+		.map = trx40_mobo_map,
+		.connector_map = trx40_mobo_connector_map,
 	},
 	{	/* MSI TRX40 Creator */
 		.id = USB_ID(0x0db0, 0x0d64),
-- 
2.28.0

