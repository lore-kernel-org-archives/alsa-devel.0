Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D800CC4708E
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Dec 2022 13:35:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3342818FB;
	Wed,  7 Dec 2022 14:34:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3342818FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670420149;
	bh=WkQOwn8nAbwlCz0oBgQguM/x7qYAFXc4DCdej09mQCw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mr8JYLjPPNHcc9SY9J46sMCQEINShkre3vXNkFJwxy4fvtzB2YliVrSqUjUd4EdI5
	 MH743N4kKxHH9/lVuoXom48iOJlAlNptW4pOOGtHOgLfwAHJLdBb//kfmg4lNlGdi+
	 Xg2Fm5fzO32Z5OWnxo61L0zaB4Ft2zIlwk6JW9lo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB5AFF800EE;
	Wed,  7 Dec 2022 14:34:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F265BF802BE; Wed,  7 Dec 2022 14:34:56 +0100 (CET)
Received: from mail.edward-p.xyz (mail.edward-p.xyz [103.150.8.150])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E72BF800EE
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2022 14:34:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E72BF800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=edward-p.xyz header.i=@edward-p.xyz
 header.b="Z18MGrQQ"
DKIM-Signature: a=rsa-sha256; bh=6jsHNyzS4Eh+VmABET0Qlk1NGmAhNmu3M916IuPxh1I=; 
 c=relaxed/relaxed; d=edward-p.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@edward-p.xyz; s=default; t=1670420054; v=1; x=1670852054;
 b=Z18MGrQQd2OrZuAR4SP11U5vVwOURqrKa9kQbWwthiGuk1dNmmPt/NGVWLagdoLTtDq9IcHC
 wqCqW9uoUhUf6UKNtYyxkAGIUxMTAjw6LmT6bKJiRUG3ymHWzhDG7Ux48YJvXKwYJwffsinYJxU
 8fOCpWluawwBrk1K4GTYB+aeyI/EbgFCeM3m1v+MisJAIzGvrmCjQVjif2+HDbPJZCQOGNCH7Kz
 LZw3+N1vBx+D6i6PE9qfyvEFbOc/8mF6OT0h6FebwJn9I6jriNFlsv7r5hVHLGZb7id/rx7nAIb
 RItYiy/EmLN/BEZst6A7QYZ09EuiYIf98d9v2qVsopbgw==
Received: by mail.edward-p.xyz (envelope-sender <edward@edward-p.xyz>) with
 ESMTPS id a8bf764e; Wed, 07 Dec 2022 21:34:14 +0800
From: Edward Pacman <edward@edward-p.xyz>
To: tiwai@suse.de
Subject: [PATCH v1] ALSA: hda/realtek: Add quirk for Lenovo TianYi510Pro-14IOB
Date: Wed,  7 Dec 2022 21:32:18 +0800
Message-Id: <20221207133218.18989-1-edward@edward-p.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <87edtb8ksb.wl-tiwai@suse.de>
References: <87edtb8ksb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kailang@realtek.com,
 tanureal@opensource.cirrus.com, tangmeng@uniontech.com, p.jungkamp@gmx.net,
 tiwai@suse.com, tcrawford@system76.com, edward@edward-p.xyz,
 linux-kernel@vger.kernel.org, sbinding@opensource.cirrus.com,
 kai.heng.feng@canonical.com
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

Lenovo TianYi510Pro-14IOB (17aa:3742)
require quirk for enabling headset-mic

Signed-off-by: Edward Pacman <edward@edward-p.xyz>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216756
---
 sound/pci/hda/patch_realtek.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e5c036385666..a2e1bdc06468 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10960,6 +10960,17 @@ static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
 	}
 }
 
+static void alc897_fixup_lenovo_headset_mode(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+		spec->gen.hp_automute_hook = alc897_hp_automute_hook;
+	}
+}
+
 static const struct coef_fw alc668_coefs[] = {
 	WRITE_COEF(0x01, 0xbebe), WRITE_COEF(0x02, 0xaaaa), WRITE_COEF(0x03,    0x0),
 	WRITE_COEF(0x04, 0x0180), WRITE_COEF(0x06,    0x0), WRITE_COEF(0x07, 0x0f80),
@@ -11043,6 +11054,8 @@ enum {
 	ALC897_FIXUP_LENOVO_HEADSET_MIC,
 	ALC897_FIXUP_HEADSET_MIC_PIN,
 	ALC897_FIXUP_HP_HSMIC_VERB,
+	ALC897_FIXUP_LENOVO_HEADSET_MODE,
+	ALC897_FIXUP_HEADSET_MIC_PIN2,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -11469,6 +11482,19 @@ static const struct hda_fixup alc662_fixups[] = {
 			{ }
 		},
 	},
+	[ALC897_FIXUP_LENOVO_HEADSET_MODE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc897_fixup_lenovo_headset_mode,
+	},
+	[ALC897_FIXUP_HEADSET_MIC_PIN2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x01a11140 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC897_FIXUP_LENOVO_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -11521,6 +11547,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x1849, 0x5892, "ASRock B150M", ALC892_FIXUP_ASROCK_MOBO),
-- 
2.38.1

