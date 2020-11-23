Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4946DC2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:09:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212EC20756
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GPEozcoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212EC20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 855D5171E;
	Mon, 23 Nov 2020 10:09:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 855D5171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606122594;
	bh=79y/nSWMPEKnNr4pLKSEQrH2GYR6ymyiC9cQnhf+rFg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GPEozcoDcPMoDLizCPZe8OrFI2LxzQbkfHP/68uXgPYzBh93nhzebBrYJq9nKezkb
	 smKFlxI0eDBwiU/8jUPxzB9l3jOzUeBF08kdZ1WN6Va3JMg+jatiIGRkAxoIMbFIms
	 nTNJG8o+lXBwcJIonKY9ku3+52rDrsMEOJhVMeFw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 590EFF80616;
	Mon, 23 Nov 2020 09:55:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05961F80568; Mon, 23 Nov 2020 09:54:53 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD12AF804FC
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:54:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD12AF804FC
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0A40CAFE1;
 Mon, 23 Nov 2020 08:53:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 40/41] ALSA: usb-audio: Fix quirks for other BOSS devices
Date: Mon, 23 Nov 2020 09:53:46 +0100
Message-Id: <20201123085347.19667-41-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201123085347.19667-1-tiwai@suse.de>
References: <20201123085347.19667-1-tiwai@suse.de>
Cc: Matwey Kornilov <matwey.kornilov@gmail.com>,
 Dylan Robinson <dylan_robinson@motu.com>,
 Keith Milner <kamilner@superlative.org>
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

A few other BOSS devices (BR-80, GT-100v2, Katana) seem requiring the
same quirk as BOSS GT-001, i.e. no implicit feedback for playback but
tying with capture.  Add and correct the corresponding quirk table
entries for them.

Reported-and-tested-by: Keith Milner <kamilner@superlative.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/implicit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 1d87fcdae95b..1f7fb036c5b6 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -72,10 +72,10 @@ static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 	  .type = IMPLICIT_FB_FIXED,
 	  .ep_num = 0x84, .iface = 0 },		/* MOTU MicroBook II */
 
-	/* No quirk */
-	IMPLICIT_FB_SKIP_DEV(0x0582, 0x01d8),	/* BOSS Katana */
-
 	/* No quirk for playback but with capture quirk (see below) */
+	IMPLICIT_FB_SKIP_DEV(0x0582, 0x0130),	/* BOSS BR-80 */
+	IMPLICIT_FB_SKIP_DEV(0x0582, 0x0189),	/* BOSS GT-100v2 */
+	IMPLICIT_FB_SKIP_DEV(0x0582, 0x01d8),	/* BOSS Katana */
 	IMPLICIT_FB_SKIP_DEV(0x0582, 0x01e5),	/* BOSS GT-001 */
 
 	{} /* terminator */
@@ -83,6 +83,9 @@ static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 
 /* Implicit feedback quirk table for capture: only FIXED type */
 static const struct snd_usb_implicit_fb_match capture_implicit_fb_quirks[] = {
+	IMPLICIT_FB_FIXED_DEV(0x0582, 0x0130, 0x0d, 0x01), /* BOSS BR-80 */
+	IMPLICIT_FB_FIXED_DEV(0x0582, 0x0189, 0x0d, 0x01), /* BOSS GT-100v2 */
+	IMPLICIT_FB_FIXED_DEV(0x0582, 0x01d8, 0x0d, 0x01), /* BOSS Katana */
 	IMPLICIT_FB_FIXED_DEV(0x0582, 0x01e5, 0x0d, 0x01), /* BOSS GT-001 */
 
 	{} /* terminator */
-- 
2.16.4

