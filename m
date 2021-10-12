Return-Path: <SRS0=z7f8=PA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C9C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 11:49:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E42560F21
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 11:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E42560F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB68C167D;
	Tue, 12 Oct 2021 13:48:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB68C167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634039342;
	bh=ygw49SCBGkLszc+FJyBSDYk1SGDXLC4GJsO5qWr/Kfo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rBrFwk5nBJD11sfuBxOWSGFkl/8seWNGOHSHBCUOVvlcBe0Q7HBFxka4aSpYpU0Ou
	 6gFqrNrULp+xebkRAC2tg5X7mhqDM01+zXatpqpKxgzkVjDTnr+4ZUQmdJJLczU03O
	 A31sqBbKaFkdHoN2EXgM3YcD2j0g6xTBOheGk7FA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75754F801F7;
	Tue, 12 Oct 2021 13:48:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C335DF80212; Tue, 12 Oct 2021 13:48:10 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AB56F80088
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 13:48:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AB56F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="gY8lUY9u"
Received: from localhost.localdomain (unknown [123.112.69.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C958E40049; 
 Tue, 12 Oct 2021 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634039279;
 bh=2lpVt2XYiPkKaR75Uw0kkw/Xv64RqcoglShtc0fgqYs=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=gY8lUY9uqGBLzXvHIxFi6J88GBgWs1Odma3VBuOTuv6b7qGPBXPnhu/yiKKQqGFeV
 okYhQISjzNzgbcV6lCye7SbZE8lZI/pgdcHlmwa+gcgNToQUM1bx5HVGnFF2tgdGDb
 gg/NjakwtFjOIAZFrE4PTQ7zaKKdVZ02hiodATJCWDncEQ+SDVhuVy2y4u28Tik/ai
 n/ZC38FozqJ2R/B9sBmzgpfgJY2kkRn0ZQxm/Htpp/PNmXXtLtgHs2mUcz1bqD32f0
 bx1kWsjgFOGPq10c/AkHoYLMNPzMO/OX1E8bivn/2JvHehhqKC/eM5YROFbUx++fqk
 KEdo2p77/7z4w==
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix the mic type detection issue for ASUS
 G551JW
Date: Tue, 12 Oct 2021 19:47:48 +0800
Message-Id: <20211012114748.5238-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: msd.mmq@gmail.com
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

We need to define the codec pin 0x1b to be the mic, but somehow
the mic doesn't support hot plugging detection, and Windows also has
this issue, so we set it to phantom headset-mic.

Also the determine_headset_type() often returns the omtp type by a
mistake when we plug a ctia headset, this makes the mic can't record
sound at all. Because most of the headset are ctia type nowadays and
some machines have the fixed ctia type audio jack, it is possible this
machine has the fixed ctia jack too. Here we set this mic jack to
fixed ctia type, this could avoid the mic type detection mistake and
make the ctia headset work stable.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214537
Reported-and-tested-by: msd <msd.mmq@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bca5830ff706..22d27b12c4e7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10197,6 +10197,9 @@ enum {
 	ALC671_FIXUP_HP_HEADSET_MIC2,
 	ALC662_FIXUP_ACER_X2660G_HEADSET_MODE,
 	ALC662_FIXUP_ACER_NITRO_HEADSET_MODE,
+	ALC668_FIXUP_ASUS_NO_HEADSET_MIC,
+	ALC668_FIXUP_HEADSET_MIC,
+	ALC668_FIXUP_MIC_DET_COEF,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -10580,6 +10583,29 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC662_FIXUP_USI_FUNC
 	},
+	[ALC668_FIXUP_ASUS_NO_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x04a1112c },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC668_FIXUP_HEADSET_MIC
+	},
+	[ALC668_FIXUP_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_headset_mic,
+		.chained = true,
+		.chain_id = ALC668_FIXUP_MIC_DET_COEF
+	},
+	[ALC668_FIXUP_MIC_DET_COEF] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x15 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0d60 },
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -10615,6 +10641,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x15a7, "ASUS UX51VZH", ALC662_FIXUP_BASS_16),
 	SND_PCI_QUIRK(0x1043, 0x177d, "ASUS N551", ALC668_FIXUP_ASUS_Nx51),
 	SND_PCI_QUIRK(0x1043, 0x17bd, "ASUS N751", ALC668_FIXUP_ASUS_Nx51),
+	SND_PCI_QUIRK(0x1043, 0x185d, "ASUS G551JW", ALC668_FIXUP_ASUS_NO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1963, "ASUS X71SL", ALC662_FIXUP_ASUS_MODE8),
 	SND_PCI_QUIRK(0x1043, 0x1b73, "ASUS N55SF", ALC662_FIXUP_BASS_16),
 	SND_PCI_QUIRK(0x1043, 0x1bf3, "ASUS N76VZ", ALC662_FIXUP_BASS_MODE4_CHMAP),
-- 
2.25.1

