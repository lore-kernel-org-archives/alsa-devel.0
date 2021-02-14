Return-Path: <SRS0=fPON=HQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249D8C433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Feb 2021 15:44:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E4E64DBA
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Feb 2021 15:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E4E64DBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71DBF1684;
	Sun, 14 Feb 2021 16:43:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71DBF1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613317436;
	bh=Tu9hlC9nOu0ArVkncjnFJlOzIU5bqPIfa7sFUTGYr3k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g25NjjHDW+6e74f+2JTfW/n0RAKRYUuV+IWdjaHvXAvmPf6OqZso3hF2a2Eg1m/cL
	 7PCPsB4tnIXuqqRNDycetyWblZjQt9ugAd4gN3YRREEnYRXmCkREsuKZderaJ/scbd
	 V2ABxUrqzN5tw346oCKZEZJszEwito76L3TNDhgA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9FD0F80127;
	Sun, 14 Feb 2021 16:43:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49316F80155; Sun, 14 Feb 2021 16:43:04 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 574F8F800C1
 for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2021 16:42:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 574F8F800C1
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2C2C9AB98;
 Sun, 14 Feb 2021 15:42:55 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Add implicit fb quirk for BOSS GP-10
Date: Sun, 14 Feb 2021 16:42:51 +0100
Message-Id: <20210214154251.10750-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Keith Milner <kamilner@superlative.org>
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

BOSS GP-10 with 0582:0185 requires the similar quirk to make the
implicit feedback working like other BOSS devices.

Reported-by: Keith Milner <kamilner@superlative.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/implicit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 521cc846d9d9..bba54430e6d0 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -73,6 +73,7 @@ static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 	/* No quirk for playback but with capture quirk (see below) */
 	IMPLICIT_FB_SKIP_DEV(0x0582, 0x0130),	/* BOSS BR-80 */
 	IMPLICIT_FB_SKIP_DEV(0x0582, 0x0171),   /* BOSS RC-505 */
+	IMPLICIT_FB_SKIP_DEV(0x0582, 0x0185),	/* BOSS GP-10 */
 	IMPLICIT_FB_SKIP_DEV(0x0582, 0x0189),	/* BOSS GT-100v2 */
 	IMPLICIT_FB_SKIP_DEV(0x0582, 0x01d6),	/* BOSS GT-1 */
 	IMPLICIT_FB_SKIP_DEV(0x0582, 0x01d8),	/* BOSS Katana */
@@ -86,6 +87,7 @@ static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 static const struct snd_usb_implicit_fb_match capture_implicit_fb_quirks[] = {
 	IMPLICIT_FB_FIXED_DEV(0x0582, 0x0130, 0x0d, 0x01), /* BOSS BR-80 */
 	IMPLICIT_FB_FIXED_DEV(0x0582, 0x0171, 0x0d, 0x01), /* BOSS RC-505 */
+	IMPLICIT_FB_FIXED_DEV(0x0582, 0x0185, 0x0d, 0x01), /* BOSS GP-10 */
 	IMPLICIT_FB_FIXED_DEV(0x0582, 0x0189, 0x0d, 0x01), /* BOSS GT-100v2 */
 	IMPLICIT_FB_FIXED_DEV(0x0582, 0x01d6, 0x0d, 0x01), /* BOSS GT-1 */
 	IMPLICIT_FB_FIXED_DEV(0x0582, 0x01d8, 0x0d, 0x01), /* BOSS Katana */
-- 
2.26.2

