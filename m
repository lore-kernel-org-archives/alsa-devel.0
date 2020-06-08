Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59224C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE0921532
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GSbp+LJu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8WzBhao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE0921532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 638491679;
	Tue,  9 Jun 2020 01:17:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 638491679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591658284;
	bh=hH8VdHMcoSdW4iq/P16jtsTULNtxfV93v0SaSsDH9LE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GSbp+LJuZPanVIgTxistSxSFMBe1PA1P/OkuNLal+QxC4CqAsSi3zhnM4w96Zw3PL
	 tzDNA1wsKAN8ZkladpZsKA7bI2qpqFpIxXv1fzwsyrL58uxqnDbJonCf/diL/rsDVq
	 MadYWRSoH83+DgroU9/apbbttWdh2gwUs7UivtOo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C70EDF802F7;
	Tue,  9 Jun 2020 01:15:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B769F802F7; Tue,  9 Jun 2020 01:15:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5109F8021E
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 01:14:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5109F8021E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="o8WzBhao"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9D9DD2158C;
 Mon,  8 Jun 2020 23:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658095;
 bh=hH8VdHMcoSdW4iq/P16jtsTULNtxfV93v0SaSsDH9LE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o8WzBhaou6blv1CXvicM13zj0rZNFP/Bzx3t4QqEd2hYri8vjiFzV/4xuggbPv5BC
 Vq9K1jISbAl/GXCL2Ksa4lPW1+YNvffIy/qF7NyYvPAT8kc3IAEoGhJ9O6dTx6kHMg
 z/cgJKole8wizIQVT//g73h6zI9KFphIdrr5/DRA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 137/606] ALSA: hda/realtek: Add quirk for Samsung
 Notebook
Date: Mon,  8 Jun 2020 19:04:22 -0400
Message-Id: <20200608231211.3363633-137-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Mike Pozulp <pozulp.kernel@gmail.com>,
 alsa-devel@alsa-project.org, Sasha Levin <sashal@kernel.org>
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

From: Mike Pozulp <pozulp.kernel@gmail.com>

[ Upstream commit 14425f1f521fdfe274a7bb390637c786432e08b4 ]

Some models of the Samsung Notebook 9 have very quiet and distorted
headphone output. This quirk changes the VREF value of the ALC298
codec NID 0x1a from default HIZ to new 100.

[ adjusted to 5.7-base and rearranged in SSID order -- tiwai ]

Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Link: https://lore.kernel.org/r/20200510032838.1989130-1-pozulp.kernel@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 368ed3678fc2..b377aca71cbf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6095,6 +6095,7 @@ enum {
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
+	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7251,6 +7252,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_mute_led,
 	},
+	[ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc5 },
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7446,6 +7454,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
+	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
-- 
2.25.1

