Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A86FF885A
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A77B60230;
	Mon,  4 May 2026 13:35:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A77B60230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894563;
	bh=KLAE9TNE144Sb/Cs6vbeBafr9AhKhTTBb1J8rd3ZS+M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jHkFJjWJb1CVMDFXkRnc0weugY+G5Gfm+ji0LFEFxcLBgEBIS9LlT6nlhjVY5aULD
	 rN4Wpmrv759y1qhmxnt2K0UnHnfmNAiROj0KncDQGqvuZzbPZAavxbhKglxmY1iRP6
	 9zKNTnTsxKihh4yjZxfrKn65+wKRjKgJoG1DKv6s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC144F805F6; Mon,  4 May 2026 13:35:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F18B1F8064F;
	Mon,  4 May 2026 13:35:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B284F8026D; Sun,  3 May 2026 23:15:37 +0200 (CEST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 959A6F80071
	for <alsa-devel@alsa-project.org>; Sun,  3 May 2026 23:15:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 959A6F80071
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IUmG+wcs
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so519889266b.1
        for <alsa-devel@alsa-project.org>;
 Sun, 03 May 2026 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777842934; x=1778447734;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9i530jahp7PV00PkPdM/PFCWBZvZf7nDUZmBqax44Y=;
        b=IUmG+wcsJDWm3eHuZLYRGwjKPuJxhOluqL2ZKMIxmy91LRMpEoHKjBM9eQoK9h0PsB
         uiN388xkVnkIcIf1ilkBuc3lRB6lESMZaZbvwZnZSdfUGBoy1MtEO84Bow8uWKayFcqz
         sWiJWfAi/TPj+rR2OxRFwVoGfvhMzPiSOIG6rAMJvY96KZySfK5TV70NKauI5AslcuKO
         hzajSxiLUanc0MqP1z7iT7YfyNqLZ9ln+WyQDmPt4t9vIswbup7s8eT0fdFKReeoH0Jg
         yOOVmwK0idn2mEoEOVaSavvF0FRfWgkjXwNf7ko7mgIfXRO3ymUPbEkF85lP20bdbGNm
         uYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777842934; x=1778447734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9i530jahp7PV00PkPdM/PFCWBZvZf7nDUZmBqax44Y=;
        b=efABT7BjADG+WGBSous0u2KBhjaaUjNp4MZOp0tuTaQ5FRhBSfaI2X3WUHTU4Gubj3
         gDx8nxWFN2QOQAodSzi0XXzuAuBODbLY7uFtusztqf+yIUZFrxMpwH7iJznaigq7RiMd
         0zkBd6djL1sI255OeyXVxZCBTjGxagf4ffU1cNO5lkc0IPm/ENGDjhqZx1mKT0PM2Fsh
         nF59waa3L2/DMkrEs3x6jVynbBIHlg77a6F37LRGXHAK8kR3dZk4l1rtAHmA7npSE0IH
         BMe5C/CoAfE5o07w605E355v7S87UB9pMnsz2Z+N5KJ7qpZThcMYg7zRqjLU9Hbul21z
         XjPg==
X-Gm-Message-State: AOJu0YxeQjP2kPlf0NLpt6uwUO3o+WwGnhFaUhjtQVCcJCzvw6hkjnFC
	O4QGYVOym1lNjdK5oM1ZmdRIF3ntjHrNsJEWSQG7Qj36X7TyCFD1jwVz
X-Gm-Gg: AeBDievMBJ96DRSRPlFro61AIQEBcC6UpZ/Ft/r/wgx7sL5a8/iQOkwKvgg2dZFxNNT
	Fvy/NMWBSl/KIOPVK1V69CxXXpcsHLgAntYCfniNkR+W4iXV3XJJjv64gTy9wJ7HhDsnOWtxjS5
	yz19xqhk3pPBE2PFgBnFvVhBo+NqR5uBY9iwPhsT1ojjktkzEczqmgcpt4bFF9JMFtB6DHRQzGk
	FuHJt6fNUWZBNgAFDfCiB0OBry+SxH1JEF8lZqzdpS9Sa6yql1k+imaHymh3/5C/B0OLAlhnvhW
	0YrCUxbWFW1LqTm3J6eMpvEg4rE2XPUoX/9s7OZDRKftqg1oT1M3a7aEHWmBwoTsfPnDkp6tt7o
	vWNQXy5iG4yFRKiimE0mORF0XwUIeBCjNh2/i++nsSJ3uTz55Os/oU0kPxtX5EEXzVEa2mv1Lu2
	bhiutEVyG0JpJwl5Kl2St6w4jdlzrGE6bTgtwtZcpX0iS7pEb9ke5tsdBq9h9S03CsaiGzn7AJI
	Xede7Gk6VWazlWiIC+cVd+uuXuZRATfYowzhaYuiGM=
X-Received: by 2002:a17:907:d02:b0:b9d:c374:6e33 with SMTP id
 a640c23a62f3a-bbffaf3d8e5mr368360766b.26.1777842933836;
        Sun, 03 May 2026 14:15:33 -0700 (PDT)
Received: from Mac.localdomain (c25189.upc-c.chello.nl. [212.187.25.189])
        by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67b86e97f4bsm2803539a12.13.2026.05.03.14.15.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 03 May 2026 14:15:32 -0700 (PDT)
From: Anton Swart <anton.swart.jhb@gmail.com>
To: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Anton Swart <anton.swart.jhb@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Add quirk flags for AlphaTheta EUPHONIA
Date: Sun,  3 May 2026 23:15:17 +0200
Message-ID: <20260503211517.14332-1-anton.swart.jhb@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: anton.swart.jhb@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: C45R3F6NWXXHB44VWGBNBC2QU6KSQULX
X-Message-ID-Hash: C45R3F6NWXXHB44VWGBNBC2QU6KSQULX
X-Mailman-Approved-At: Mon, 04 May 2026 11:34:59 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C45R3F6NWXXHB44VWGBNBC2QU6KSQULX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The AlphaTheta EUPHONIA (VID 0x2b73, PID 0x0047) is a USB Audio
Class 2 DJ mixer that requires implicit feedback for full-duplex
operation. The capture endpoint (0x83 IN, interface 2) acts as the
implicit feedback source for the playback endpoint (0x03 OUT,
interface 1), and the device firmware does not send isochronous
data on the capture endpoint unless the host is simultaneously
sending data on the playback endpoint, i.e. playback must be
started first.

Without QUIRK_FLAG_PLAYBACK_FIRST the kernel waits for capture URBs
before submitting playback URBs, creating a deadlock: the device
waits for playback data and the host waits for capture data.
Without QUIRK_FLAG_GENERIC_IMPLICIT_FB the kernel does not detect
the implicit feedback relationship between the two interfaces.

The same flag combination is already used for the Behringer UMC202HD,
UMC204HD and UMC404HD (0x1397:0x0507/0x0508/0x0509), which exhibit
the identical implicit-feedback topology.

Tested on Raspberry Pi 5 with kernel 6.12.75; continuous full-duplex
streaming at 96 kHz / 24-bit, zero XRUNs.

Signed-off-by: Anton Swart <anton.swart.jhb@gmail.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index f77ff05..b17bdae 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2460,6 +2460,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x2b73, 0x0047, /* AlphaTheta EUPHONIA */
+		   QUIRK_FLAG_PLAYBACK_FIRST | QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2d95, 0x8011, /* VIVO USB-C HEADSET */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
-- 
2.50.1 (Apple Git-155)

