Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17476C433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 14:46:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80A661260
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 14:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80A661260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50D8315F9;
	Wed,  7 Apr 2021 16:46:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50D8315F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617806815;
	bh=bMmEHWDovAsGRWb4Z11bdRf62esoDlNdZcXMgXR+ygw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gmxK3t2v3/dviMoxz2NgkosvZ/7JqktKNPP/i8zF+VyPfzXBZFQiWAZtCLQ+b56yh
	 pyGNKMwV86n79eUAeoxXTGqSjRtLSvsSoe3ZCL5NiKuGBnLnoxedwF4q5YHFOfa5zn
	 P+yGvvDUu1IgJKjklKPoZOFXsdnMp4yvFK6adIpM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB798F80124;
	Wed,  7 Apr 2021 16:46:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 321DFF8016A; Wed,  7 Apr 2021 16:46:03 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71ABAF80124
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 16:45:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71ABAF80124
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C712AB155
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 14:45:50 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Add MIDI quirk for Vox ToneLab EX
Date: Wed,  7 Apr 2021 16:45:49 +0200
Message-Id: <20210407144549.1530-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
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

ToneLab EX guitar pedal device requires the same quirk like ToneLab ST
for supporting the MIDI.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=212593
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 9716a9f7c095..8a8fe2b980a1 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2376,6 +2376,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+{
+	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0204),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "KORG, Inc.",
+		/* .product_name = "ToneLab EX", */
+		.ifnum = 3,
+		.type = QUIRK_MIDI_STANDARD_INTERFACE,
+	}
+},
+
 /* AKAI devices */
 {
 	USB_DEVICE(0x09e8, 0x0062),
-- 
2.26.2

