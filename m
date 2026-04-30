Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BD1CD342C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:34:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E01BF60212;
	Mon,  4 May 2026 13:33:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E01BF60212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894437;
	bh=cle3FIpVj8rMuxtFGWmJq6+qk/rpfD+/VkzLUIDbXRo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=D9+prnAo5qOlfQAIPc9tky1qZewoERZ9n7+7VhHLcmGxdXKpck0pwKoYjPhaXczXx
	 t9Y6wHYH01gaEi5eX/YUJoDKXHytRjFA/Yb8RD5grERVCLFTi6jlVlvDMey2PU2om3
	 R5tEPs4bcfWmj7hi2Lg5H+P5lan8ZDH3fXoRdIDA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 124D8F8060D; Mon,  4 May 2026 13:33:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DE3BF80619;
	Mon,  4 May 2026 13:33:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C0F1F802BE; Thu, 30 Apr 2026 21:14:18 +0200 (CEST)
Received: from mx.brightberry.eu (mx.brightberry.eu [185.229.55.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A4AA8F8016D
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2026 21:14:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4AA8F8016D
Received: from mx.brightberry.eu (localhost [127.0.0.1])
	by mx.brightberry.eu (Proxmox) with ESMTP id AAD803855;
	Thu, 30 Apr 2026 21:14:15 +0200 (CEST)
Received: from yoga9-patch.eml (YST00841.fritz.box [192.168.178.64])
	by mx.brightberry.eu (Proxmox) with ESMTP id 8CF252ED4;
	Thu, 30 Apr 2026 21:14:15 +0200 (CEST)
From: =?UTF-8?q?R=C3=A1mon_van_Raaij?= <ramon@vanraaij.eu>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek: Add codec SSID quirk for Lenovo Yoga Pro 9
 16IMH9
Date: Thu, 30 Apr 2026 21:12:24 +0200
Message-Id: <20260430191224.patch1-ramon@vanraaij.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: ramon@vanraaij.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 7OQFKNZDP4W74OPCJQRXB6ONTU6FVOLI
X-Message-ID-Hash: 7OQFKNZDP4W74OPCJQRXB6ONTU6FVOLI
X-Mailman-Approved-At: Mon, 04 May 2026 11:33:10 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7OQFKNZDP4W74OPCJQRXB6ONTU6FVOLI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Yoga Pro 9 16IMH9 (codec SSID 17aa:38d6) shares PCI audio device
subsystem ID 17aa:3811 with the Legion S7 15IMH05. The existing
SND_PCI_QUIRK entry for the Legion routes both machines to
ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS, which does not bind the TAS2781
smart amplifiers, resulting in near-silent built-in speakers.

Add an HDA_CODEC_QUIRK entry immediately before the conflicting PCI quirk
that matches the Yoga Pro 9's unique codec SSID and routes it to
ALC287_FIXUP_TAS2781_I2C. Codec quirks are evaluated after PCI quirks and
take precedence, leaving the Legion S7 15IMH05 entry unaffected.

This follows the same pattern used to disambiguate PCI SSID 17aa:3847
(shared between Yoga Pro 7 14IMH9 and Legion 7 16ACHG6), where a
HDA_CODEC_QUIRK for codec SSID 17aa:38cf resolves the conflict.

Signed-off-by: Rámon van Raaij <ramon@vanraaij.eu>
---
 sound/hda/codecs/realtek/alc269.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index ae74e1b69..648051366 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7605,6 +7605,10 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
+	/* Yoga Pro 9 16IMH9 shares PCI SSID 17aa:3811 with Legion S7 15IMH05;
+	 * use codec SSID to distinguish them
+	 */
+	HDA_CODEC_QUIRK(0x17aa, 0x38d6, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
--
2.54.0


