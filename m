Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F2C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 06:56:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3165B61ACE
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 06:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3165B61ACE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F23216A2;
	Tue, 16 Nov 2021 07:55:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F23216A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637045773;
	bh=tCeGJXDoLIfzUW+dTWxRm7bTb633D+JCrCTnttge2W4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ss11BggjZL8T4DyQTdl3qJCZ7oQ9PxdTL9aDcAYpESIbBYBvZB2+lhQYxSOpf4f9L
	 KNMy6roZfrWnkncaLg+XHR1yCFpx7zyPlgcPFYi5ZS6rypFFSziu6MYk0pa9lvwCle
	 I8Tltv4KfI/je/QFhp0wS6YUZVVGFOduqK14ZH+k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E204F804ED;
	Tue, 16 Nov 2021 07:54:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09E81F804C3; Tue, 16 Nov 2021 07:54:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AED22F80134
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 07:54:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AED22F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="w16YdsKo"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="U6ucQzFM"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 99373218B5
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 06:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637045658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIpmEvHiYpztzcBhvlpeghd+39AoDpySNLy2JLuPLe4=;
 b=w16YdsKo30UrloStgzM3A1kr7914OzqaKmm50sGQaHW9V97MmYlMHotReaOn71H4qenFMy
 dSeyZ8bx+Od5b2TduRyagXPfiSt/WnE8P6Yrm4T7+1vJp8S6rMSOy2OJ7ZG4pc40TLiNUq
 YlYbdQ9LKBoztyEuVvBzBMwxBfkhWiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637045658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIpmEvHiYpztzcBhvlpeghd+39AoDpySNLy2JLuPLe4=;
 b=U6ucQzFMkiiDq2QuzA7+TYXSCJEXYkE2mg5QNvUaiUTzclfUgIABmxO65RARgOSWM5ka58
 C4ZHP1H8vLug8XBA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 943E3A3B83;
 Tue, 16 Nov 2021 06:54:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ALSA: usb-audio: Fix dB level of Bose Revolve+ SoundLink
Date: Tue, 16 Nov 2021 07:54:15 +0100
Message-Id: <20211116065415.11159-4-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211116065415.11159-1-tiwai@suse.de>
References: <20211116065415.11159-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Bose Revolve+ SoundLink (0a57:40fa) advertises invalid dB level for
the speaker volume.  This patch provides the correction in the mixer
map quirk table entry.

Note that this requires the prerequisite change to add min_mute flag
to the dB map table.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1192375
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_maps.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 9d71c569b148..5d391f62351b 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -337,6 +337,13 @@ static const struct usbmix_name_map bose_companion5_map[] = {
 	{ 0 }	/* terminator */
 };
 
+/* Bose Revolve+ SoundLink, correction of dB maps */
+static const struct usbmix_dB_map bose_soundlink_dB = {-8283, -0, true};
+static const struct usbmix_name_map bose_soundlink_map[] = {
+	{ 2, NULL, .dB = &bose_soundlink_dB },
+	{ 0 }	/* terminator */
+};
+
 /* Sennheiser Communications Headset [PC 8], the dB value is reported as -6 negative maximum  */
 static const struct usbmix_dB_map sennheiser_pc8_dB = {-9500, 0};
 static const struct usbmix_name_map sennheiser_pc8_map[] = {
@@ -522,6 +529,11 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x05a7, 0x1020),
 		.map = bose_companion5_map,
 	},
+	{
+		/* Bose Revolve+ SoundLink */
+		.id = USB_ID(0x05a7, 0x40fa),
+		.map = bose_soundlink_map,
+	},
 	{
 		/* Corsair Virtuoso SE (wired mode) */
 		.id = USB_ID(0x1b1c, 0x0a3d),
-- 
2.26.2

