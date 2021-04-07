Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BAEC433B4
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 09:58:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B056613A0
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 09:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B056613A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 086FA15F2;
	Wed,  7 Apr 2021 11:57:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 086FA15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617789522;
	bh=Glux1ALxNKD5HzhHYc0vThpV9gWhZoVS+Fvk0k3ZW0g=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S5nTWyfqNHKmOUyoMWqnaiNTDYQo43HqP2XI2/miBYUcNnGLfyb+85lV924cn06AW
	 wCq/Fzd5iQt1HLtgz50tXzwiT2RTCe10BrQrluaAxuON90FSvIHmBwMXp0hUOw+Ome
	 4RjkKNWfbl9Hy/tNKbV5kA30WOJfRXxGPW23dTjQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99EE0F80168;
	Wed,  7 Apr 2021 11:57:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDA30F8016A; Wed,  7 Apr 2021 11:57:49 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFC6EF800BD
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 11:57:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFC6EF800BD
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 70354B066
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 09:57:34 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/realtek: Fix speaker amp setup on Acer Aspire E1
Date: Wed,  7 Apr 2021 11:57:30 +0200
Message-Id: <20210407095730.12560-1-tiwai@suse.de>
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

We've got a report about Acer Aspire E1 (PCI SSID 1025:0840) that
loses the speaker output after resume.  With the comparison of COEF
dumps, it was identified that the COEF 0x0d bits 0x6000 corresponds to
the speaker amp.

This patch adds the specific quirk for the device to restore the COEF
bits at the codec (re-)initialization.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1183869
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 58946d069ee5..a7544b77d3f7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3927,6 +3927,15 @@ static void alc271_fixup_dmic(struct hda_codec *codec,
 		snd_hda_sequence_write(codec, verbs);
 }
 
+/* Fix the speaker amp after resume, etc */
+static void alc269vb_fixup_aspire_e1_coef(struct hda_codec *codec,
+					  const struct hda_fixup *fix,
+					  int action)
+{
+	if (action == HDA_FIXUP_ACT_INIT)
+		alc_update_coef_idx(codec, 0x0d, 0x6000, 0x6000);
+}
+
 static void alc269_fixup_pcm_44k(struct hda_codec *codec,
 				 const struct hda_fixup *fix, int action)
 {
@@ -6301,6 +6310,7 @@ enum {
 	ALC283_FIXUP_HEADSET_MIC,
 	ALC255_FIXUP_MIC_MUTE_LED,
 	ALC282_FIXUP_ASPIRE_V5_PINS,
+	ALC269VB_FIXUP_ASPIRE_E1_COEF,
 	ALC280_FIXUP_HP_GPIO4,
 	ALC286_FIXUP_HP_GPIO_LED,
 	ALC280_FIXUP_HP_GPIO2_MIC_HOTKEY,
@@ -6979,6 +6989,10 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ },
 		},
 	},
+	[ALC269VB_FIXUP_ASPIRE_E1_COEF] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269vb_fixup_aspire_e1_coef,
+	},
 	[ALC280_FIXUP_HP_GPIO4] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc280_fixup_hp_gpio4,
@@ -7901,6 +7915,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0762, "Acer Aspire E1-472", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
+	SND_PCI_QUIRK(0x1025, 0x0840, "Acer Aspire E1", ALC269VB_FIXUP_ASPIRE_E1_COEF),
 	SND_PCI_QUIRK(0x1025, 0x101c, "Acer Veriton N2510G", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1065, "Acer Aspire C20-820", ALC269VC_FIXUP_ACER_HEADSET_MIC),
@@ -8395,6 +8410,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC283_FIXUP_HEADSET_MIC, .name = "alc283-headset"},
 	{.id = ALC255_FIXUP_MIC_MUTE_LED, .name = "alc255-dell-mute"},
 	{.id = ALC282_FIXUP_ASPIRE_V5_PINS, .name = "aspire-v5"},
+	{.id = ALC269VB_FIXUP_ASPIRE_E1_COEF, .name = "aspire-e1-coef"},
 	{.id = ALC280_FIXUP_HP_GPIO4, .name = "hp-gpio4"},
 	{.id = ALC286_FIXUP_HP_GPIO_LED, .name = "hp-gpio-led"},
 	{.id = ALC280_FIXUP_HP_GPIO2_MIC_HOTKEY, .name = "hp-gpio2-hotkey"},
-- 
2.26.2

