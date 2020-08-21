Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9D3C433E4
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:15:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FCC22B43
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XvFXOSkj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv7W/vIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FCC22B43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 900F91684;
	Fri, 21 Aug 2020 18:14:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 900F91684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598026530;
	bh=KXQV7iN6LfRHw4fLqfpnmxvNW34f/PK96F7lMXsjoCQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XvFXOSkjsBY7NP8V/iSjEj31tCXj4qNi0CRfBJnwWO6rpxPjRlce4SJNejwIltJ3N
	 2trARhgS15b9pN5nGzpkKc3CtoN/GugmmPg2Zfr5odksY8JUVLxW36P/5XhgaJhqoo
	 p0AKR6dZqrcIGRCIu2hrcCI7u3SIGLv0HAh09X0g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94353F800D3;
	Fri, 21 Aug 2020 18:14:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F8E4F80260; Fri, 21 Aug 2020 18:14:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6C5FF800D2
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 18:14:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6C5FF800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Hv7W/vIi"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C6B79208DB;
 Fri, 21 Aug 2020 16:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598026468;
 bh=KXQV7iN6LfRHw4fLqfpnmxvNW34f/PK96F7lMXsjoCQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hv7W/vIizXQxpqteMFQwNXpFg8sppcx4MvtwnUQZ1qOGmwkWxt1dOYwlvK/oOVqgl
 ns/8qwGAGlWdXotADZaQ6DWWp6Gao3P4ZMdFxP9D99VPR3XoFJropswSDl+VjgWzU5
 Ei2huTCDiuOiBOAJwppNkWosW2ok3GcX9fkZpjV0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 03/62] ALSA: hda/realtek: Fix pin default on Intel
 NUC 8 Rugged
Date: Fri, 21 Aug 2020 12:13:24 -0400
Message-Id: <20200821161423.347071-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161423.347071-1-sashal@kernel.org>
References: <20200821161423.347071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit e2d2fded6bdf3f7bb40718a208140dba8b4ec574 ]

The jack on Intel NUC 8 Rugged rear panel doesn't work.

The spec [1] states that the jack supports both headphone and
microphone, so override a Pin Complex which has both Amp-In and Amp-Out
to make the jack work.

Node 0x1b fits the requirement, and user confirmed the jack now works
with new pin config.

[1] https://www.intel.com/content/dam/support/us/en/documents/mini-pcs/NUC8CCH_TechProdSpec.pdf
BugLink: https://bugs.launchpad.net/bugs/1875199

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200807080514.15293-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 00d155b98c1d1..049a07447ba1a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6169,6 +6169,7 @@ enum {
 	ALC269_FIXUP_CZC_L101,
 	ALC269_FIXUP_LEMOTE_A1802,
 	ALC269_FIXUP_LEMOTE_A190X,
+	ALC256_FIXUP_INTEL_NUC8_RUGGED,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7490,6 +7491,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		},
 		.chain_id = ALC269_FIXUP_DMIC,
 	},
+	[ALC256_FIXUP_INTEL_NUC8_RUGGED] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7787,6 +7797,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1c06, 0x2013, "Lemote A1802", ALC269_FIXUP_LEMOTE_A1802),
 	SND_PCI_QUIRK(0x1c06, 0x2015, "Lemote A190X", ALC269_FIXUP_LEMOTE_A190X),
+	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
-- 
2.25.1

