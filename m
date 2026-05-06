Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6286BCD37AC
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:42:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E21F3601D5;
	Mon, 11 May 2026 16:42:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E21F3601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510545;
	bh=ZFRFZrVkjqNZBHax1F2/Juf7EuDYvO80Hfsf06etGTU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Ff9KRiA7Ch8l5LA43dvTWu8hA8YFrvm8MuJ0gGtOAYsustF/cN5NVp4eje/ZMU5X8
	 bQOVo8scTTEGsKHduYw+dhgZHjeAdnUptwLwuS5H9aQYJTC/WiTm1sPBaYCar5R8Hl
	 ANBAI8BuPnLuME8V2VvJ8JYB49uEIbcdCn90iPD4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D08E4F805EC; Mon, 11 May 2026 16:41:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EE80F805F3;
	Mon, 11 May 2026 16:41:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3E0CF80217; Wed,  6 May 2026 20:33:28 +0200 (CEST)
Received: from mx.brightberry.eu (mx.brightberry.eu [185.229.55.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E0B3EF8003C
	for <alsa-devel@alsa-project.org>; Wed,  6 May 2026 20:33:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0B3EF8003C
Received: from mx.brightberry.eu (localhost [127.0.0.1])
	by mx.brightberry.eu (Proxmox) with ESMTP id EAC2F26CC;
	Wed, 06 May 2026 20:33:24 +0200 (CEST)
Received: from yoga9-patch-38d5.eml (YST00841.fritz.box [192.168.178.64])
	by mx.brightberry.eu (Proxmox) with ESMTP id CD7DF173;
	Wed, 06 May 2026 20:33:24 +0200 (CEST)
From: =?UTF-8?q?R=C3=A1mon_van_Raaij?= <ramon@vanraaij.eu>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek: Add codec SSID quirk for Lenovo Yoga Pro 9
 16IMH9 (17aa:38d5)
Date: Wed, 06 May 2026 20:31:18 +0200
Message-Id: <20260506183118.patch1-ramon@vanraaij.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: ramon@vanraaij.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: G5HRI55PEIZ3GOG4UWTL565ZY5TME4U5
X-Message-ID-Hash: G5HRI55PEIZ3GOG4UWTL565ZY5TME4U5
X-Mailman-Approved-At: Mon, 11 May 2026 14:41:47 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G5HRI55PEIZ3GOG4UWTL565ZY5TME4U5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some Lenovo Yoga Pro 9 16IMH9 units carry codec SSID 17aa:38d5 instead
of 17aa:38d6, which was added in commit 56722cfbb78d ("ALSA: hda/realtek:
Add codec SSID quirk for Lenovo Yoga Pro 9 16IMH9"). The corresponding
firmware blob TAS2XXX38D5.bin already ships in linux-firmware, and the
hardware is otherwise identical: same PCI subsystem ID 17aa:3811 shared
with the Legion S7 15IMH05, same TI TAS2781 amplifiers behind ACPI HID
TIAS2781, same ALC287_FIXUP_TAS2781_I2C requirement.

Add a second HDA_CODEC_QUIRK entry directly above the existing 17aa:38d6
entry so both variants resolve to the correct fixup. Reported and
verified on hardware by GitHub user 0xEthamin.

Link: https://github.com/ramonvanraaij/yoga9-tas2781-hda/issues/1
Signed-off-by: Rámon van Raaij <ramon@vanraaij.eu>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7608,6 +7608,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	/* Yoga Pro 9 16IMH9 shares PCI SSID 17aa:3811 with Legion S7 15IMH05;
 	 * use codec SSID to distinguish them
 	 */
+	HDA_CODEC_QUIRK(0x17aa, 0x38d5, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
 	HDA_CODEC_QUIRK(0x17aa, 0x38d6, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
--
2.54.0


