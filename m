Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE05FCA6002
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:02:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B38216025B;
	Wed,  7 Oct 2026 09:01:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B38216025B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791356528;
	bh=yDdqInFk3YpdDUiRGSXuiC/zzCHwu67hYsiL6JTzZlI=;
	h=Subject:Cc:From:To:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZJxl89QMXFLE/Vg6NdPFdSKqqA7vlk4l/XfMBVPXRM74Ed+cq8D861rGQGi1nffk4
	 GqxtX6w/VwePHpEDjbfUDWlAQXjpXBkXIGafZLPlDzUtIN5bSPvgVPcS5+aA2N6fRm
	 ZcydyM7HXLjnMbEdLiGKR7aMsJA8OM7nPsPEUM4Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6295F80BF3; Wed,  7 Oct 2026 08:59:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A803FF80C08;
	Wed,  7 Oct 2026 08:59:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53DB9F80588; Mon,  5 Oct 2026 14:35:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=131.246.120.220
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791203734;
	b=lWa1o9bnC0nePqGbNQIRKbDtHrinGffqCJEOC4VQLBeiazy1zXLzqzzqjyLPpSrp2avR
	 M17DmRgplne4WFw/QaTY51ruydyXppFO2A3PCGzjq4XwZn1UssHuPyXlTvz6d6BqTM3rC
	 RczZnb9KRQ1rDEYaaCeawNpuxzva5rksfwtXN5tH1JoYdHFiKxW1iD97ES9m3nH5SyhIV
	 5F+I6wvbixXPiEUZu36l5DLL1694kySRd5hWtkvjWXytAUx+wDZ5+SgdeD4ZL9qUhnxVT
	 vvfHRJBlwnbfvB5GZh6dOsxL9a40GYmJgQyLtP9vqCysrDezD4H1ISnXn9irGzb938w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791203734;
	h=Subject:MIME-Version:From:To:Date:Message-ID:DKIM-Signature;
	bh=yDdqInFk3YpdDUiRGSXuiC/zzCHwu67hYsiL6JTzZlI=;
	b=orwnAHBFSHfgB+8e5oD/t2crxX3tCBQ4jDi0rEJJuzcXv0md7vk114O00ybylxe0uoWK
	 vv9Z3uQeeexLubxaLlU/Ojv6jZTKUL0mD4Hatl1tX+Amd/bCYagj90Zk3/ap3UQsXeL1v
	 JQWo6+8wnKPBG9ll8tyUe1BUXlqCNQGXRjX8lKSP5i/D0V6kNMZGbCUpEVRdxWN0gomda
	 dceSuYg0UCi9XU1F1L247zB8714OWBbOMHc5p2JH8xPGPXVTL7PL/q4nOsbdzl68Z+qbh
	 ioFN0tbWU1UgaF2T+LmjIChAq2iU7EjkZmL7RCVyRUNYq7qbdgpADdjLzfz5QiTqptA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=rptu.de header.i=@rptu.de header.a=rsa-sha256
 header.s=rptu2026 header.b=HMkk8ytz;
	arc=none smtp.remote-ip=131.246.120.220
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 453CAF8007E
	for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2026 14:35:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 453CAF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=rptu.de header.i=@rptu.de header.a=rsa-sha256
 header.s=rptu2026 header.b=HMkk8ytz
Received: from uni-kl.de (mail.uni-kl.de [131.246.120.212])
	by mailgw1.uni-kl.de (8.18.1/8.18.1/Debian-6) with ESMTPS id 695CZPFW1272843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 5 Oct 2026 14:35:25 +0200
Received: from [2003:f6:2713:f52:6111:977:9049:d446] (account
 fyw21nur@rptu.de)
  by rptu.de (CommuniGate Pro XIMSS 6.3.11)
  with HTTPU id 325891654; Mon, 05 Oct 2026 14:35:25 +0200
X-Mailer: Samoware HTML5 6.3.6509139
Subject: [PATCH] ALSA: hda/realtek: Add quirk for LG gram 16 (16Z90SP)
MIME-Version: 1.0
Cc: tiwai@suse.de, stable@vger.kernel.org
From: "Prateek Yadav" <fyw21nur@rptu.de>
To: alsa-devel@alsa-project.org
Date: Mon, 05 Oct 2026 14:35:25 +0200
Message-ID: <ximss-325891667@mail1.uni-kl.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=rptu.de;
 h=subject:mime-version:cc:from:to:date:message-id:content-type:content-transfer-encoding;
 s=rptu2026; bh=yDdqInFk3YpdDUiRGSXuiC/zzCHwu67hYsiL6JTzZlI=;
 b=HMkk8ytzlzH/3i9a46OPWDcjCpHbFFXV0GCrddbdDFOteY1TPNbb3RLsf2fTDRT++U2z3NyWhMUYFh6AdZZXEsCppM9cAxZzMOYDylHy3UrjPyevj+ej2t5682Iuw/sA0UCZpISUnlRBqKmjIvReVUSfP8m9/Qd/VcgKu2gxKhQh+5kbRY/RQEa/qE+Gqs2f169OdH4Uf/aUxoXsg+XP19qGSZ943L9/CHx3LvjO8RrcPdf3KfwKkI3zNMHehK/EwzL0h56k/FMN4bVEjMViticfHiiW0OLiAWqCfHOb6ZHDMEb7UTDHNTtxXtcRVfRqTEYTb6SDg8FB1UXvSo4xSg==
X-MailFrom: fyw21nur@rptu.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4MWH7XYG5JUDTKVZLLGZNZB36KCL3IBS
X-Message-ID-Hash: 4MWH7XYG5JUDTKVZLLGZNZB36KCL3IBS
X-Mailman-Approved-At: Wed, 07 Oct 2026 06:58:31 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4MWH7XYG5JUDTKVZLLGZNZB36KCL3IBS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The LG gram 16 (16Z90SP, SSID 1854:053b) drives its internal speakers
through Samsung-style smart amplifiers on an ALC298. Nothing
initialises them, so the internal speakers are silent after a cold
boot, while headphones, HDMI and the microphones work. A warm reboot
masks the problem, as the amps stay initialised.

Evidence (kernel 7.2.5-3-omarchy, sof-firmware 2025.12.2-1,
PipeWire 1.6.8):
- aplay -D plughw:0,0 completes with exit 0 but no audible output.
- During playback the codec shows Node 0x03 Converter stream=1,
   Amp-Out vals [0x69 0x69] unmuted, and Pin 0x17 OUT with EAPD on —
   the digital path is correct, the amps simply never start.
- Headphone Jack reports off, Speaker Phantom Jack reports on.
- Running the known 4-amp hda-verb init sequence
   (amps 0x38/0x39/0x3C/0x3D, cf. joshuagrisham/galaxy-book2-pro-linux
   necessary-verbs.sh) restores speaker output immediately.
- Machine dual-boots Windows, which explains cold-boot-only silence.

This mirrors the 16Z90TR (1854:0554) case fixed with
ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS, and the 16" 16Z90R-A (1854:0489)
which uses the 4-amp variant. I verified the 4-amp init works on this
machine; please adjust to _2_AMPS if COEF 0x22 indicates two amps.

  sound/hda/codecs/realtek/alc269.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c 
b/sound/hda/codecs/realtek/alc269.c
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8114,6 +8114,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
      SND_PCI_QUIRK(0x1854, 0x0489, "LG gram 16 (16Z90R-A)", 
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
      SND_PCI_QUIRK(0x1854, 0x048a, "LG gram 17 (17ZD90R)", 
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
      SND_PCI_QUIRK(0x1854, 0x0490, "LG Gram Style 14 (14Z90RS)", 
ALC298_FIXUP_LG_GRAM_STYLE_14),
+    SND_PCI_QUIRK(0x1854, 0x053b, "LG gram 16 (16Z90SP)", 
ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
      SND_PCI_QUIRK(0x1854, 0x0554, "LG gram 16 (16Z90TR)", 
ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),

Hardware: LG 16Z90SP-A.AD7BG, Intel Meteor Lake-P HD Audio [8086:7e28],
Realtek ALC298 [10ec:0298] rev 0x100103, SSID 1854:053b.
ALSA info: 
https://alsa-project.org/db/?f=7e8c49270f1b902ebb9fa76a4695f8301db040cf


Signed-off-by: Prateek prateek.yadav@edu.rptu.de
