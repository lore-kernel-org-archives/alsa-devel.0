Return-Path: <SRS0=YBNN=GF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF39C433DB
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Jan 2021 19:02:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDBF207CD
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Jan 2021 19:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDBF207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=agon.one
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CC0C169E;
	Sat,  2 Jan 2021 20:01:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CC0C169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609614163;
	bh=Ae3KV3ViMF20JX1G4UPzsvJNQwGX77+73j5AJu19Tdg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lmdjsgagkD2qZljvdh0auUlLEspdqQGOSYFxAVofnPbgS8LAnhsVdFUdPb4EyU0hv
	 UqGd2nd3Svls0d314QQ4SYRY5xneNbktCVxrTnv0MM7z2v5Rf3aYMMMs8inGc5RA/W
	 bBoaAAsvKsC0u0IGTLF9W9DkJV1jYFVEzi0Nz7vM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0E00F8020C;
	Sat,  2 Jan 2021 20:01:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BF21F8022B; Sat,  2 Jan 2021 20:01:24 +0100 (CET)
Received: from smtp.agon.one (agon.one
 [IPv6:2a01:238:430d:8700:555:4534:8491:bcc5])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A5E9F80157
 for <alsa-devel@alsa-project.org>; Sat,  2 Jan 2021 20:01:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A5E9F80157
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=agon.one header.i=@agon.one
 header.b="k6W1Y2/D"
From: Timon Reinold <tirei@agon.one>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=agon.one; s=mail;
 t=1609614068; bh=Ae3KV3ViMF20JX1G4UPzsvJNQwGX77+73j5AJu19Tdg=;
 h=From:To:Cc:Subject:Date:From;
 b=k6W1Y2/DHxz7OeKM1SogksFLCzDIf8VLesyh1XEHJXQwkdlgyiFirnGi0XOd+VI0E
 oJfaSWl1X/o9o18U8PE1NM3+E3l3VBfKMgB8dRt9MVnSDPAdQ1ZaATqxvkU9tS1E4H
 62U+q5AbFKuRgjt7YC6ERZ9GSEtcf3lWJHkaDdgM+1ZsczoF3OUoIOEa9hDCxz/QY7
 s3amJFeNzJHJJTcUB4yjKIGb3q/luacTwdJdjClNNocjIPjHQTFebXx1ABY0OsZFKZ
 FBHqrAc35eIULp3hXRCnc/gLm+NS/qUcK9599JjyAFriU/tO4Ple9ccr0vwRCrwufw
 PvtWYWVa22mtQ==
To: tiwai@suse.com,
	perex@perex.cz,
	alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Add quirk for RC-505
Date: Sat,  2 Jan 2021 20:00:39 +0100
Message-Id: <20210102190039.14494-1-tirei@agon.one>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Harry Reinold <harry.reinold@posteo.de>, Timon Reinold <tirei@agon.one>
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

BOSS RC-505 (shown by lsusb as "Roland Corp. RC-505") does require the
same quirk as these other BOSS devices.

Without this quirk it is neither possible to capture audio from nor to
write audio to the RC-505. Both just result in an empty audio
stream. With these changes both capture and playback seem to work
quite fine. MIDI funtionality was not tested.

Tested-by: Harry Reinold <harry.reinold@posteo.de>
Signed-off-by: Timon Reinold <tirei@agon.one>
---

We found the hint to enable the same quirk as reqired by the BOSS
Katana for the RC-505 in this post:
https://old.reddit.com/r/linuxaudio/comments/fom7z4/roland_rc505_usb_audio_interface/frfgrfw/
But none of the code posted there was used (since that predates
implicit.c), so I think that shouldn't create any copyright
problems.

We're currently running the older version of this patch (without
implicit.c) on Linux Mint and it seems quite stable so far. We did
also test this version of the patch and that seems to work fine, too.

Yours sincerely,
Timon Reinold

 sound/usb/implicit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 70b9777b2e63..2d7f747c0237 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -79,6 +79,7 @@ static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 	IMPLICIT_FB_SKIP_DEV(0x0582, 0x01d8),	/* BOSS Katana */
 	IMPLICIT_FB_SKIP_DEV(0x0582, 0x01e5),	/* BOSS GT-001 */
 	IMPLICIT_FB_SKIP_DEV(0x0582, 0x0203),   /* BOSS AD-10 */
+	IMPLICIT_FB_SKIP_DEV(0x0582, 0x0171),   /* BOSS RC-505 */
 
 	{} /* terminator */
 };
@@ -91,6 +92,7 @@ static const struct snd_usb_implicit_fb_match capture_implicit_fb_quirks[] = {
 	IMPLICIT_FB_FIXED_DEV(0x0582, 0x01d8, 0x0d, 0x01), /* BOSS Katana */
 	IMPLICIT_FB_FIXED_DEV(0x0582, 0x01e5, 0x0d, 0x01), /* BOSS GT-001 */
 	IMPLICIT_FB_FIXED_DEV(0x0582, 0x0203, 0x0d, 0x01), /* BOSS AD-10 */
+	IMPLICIT_FB_FIXED_DEV(0x0582, 0x0171, 0x0d, 0x01), /* BOSS RC-505 */
 
 	{} /* terminator */
 };
-- 
2.29.2

