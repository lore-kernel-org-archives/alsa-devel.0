Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0BAC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 08:41:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0822A611BD
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 08:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0822A611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=baldo.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F79E16B9;
	Tue, 28 Sep 2021 10:40:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F79E16B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632818470;
	bh=9tis6MQOFRbgB/nS92n2z6w2gu6QaHWy3NEI3OndlKU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Gd1bWZ2LC3BtnSN5dH47BKX3B22oZRTdymHIea2ONcxYPqHprB6E9j5Vf3gP9CHxw
	 /s+hg0vWD6p7gdxTEhyxn9GEhwnWVNc6sMZa5xu9aMNnhXpuaOnqDZulAvIdAYuLkq
	 Otz53uXOFN0pLPJ3yjvLnFLlb30wB+azZp0D7VaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 373F0F804E2;
	Tue, 28 Sep 2021 10:39:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45EF7F80268; Sat, 25 Sep 2021 21:49:18 +0200 (CEST)
Received: from mail.baldo.me (mail.baldo.me [51.15.71.247])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1147F8013D
 for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2021 21:49:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1147F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baldo.me header.i=@baldo.me
 header.b="X2zZE0SC"
Received: from mail.baldo.me (localhost [127.0.0.1])
 by mail.baldo.me (Postfix) with ESMTPS id 7DEB7425C0;
 Sat, 25 Sep 2021 19:49:11 +0000 (UTC)
Received: from mail.baldo.me (localhost [127.0.0.1])
 by mail.baldo.me (Postfix) with ESMTPS id 652EC425D8;
 Sat, 25 Sep 2021 19:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.baldo.me 652EC425D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baldo.me;
 s=BA429582-84BB-11EA-85D5-B6667C1AB266; t=1632599351;
 bh=zDL2/RA2SuZbFjeltpf+skeRppd8krxlhI+77dRTBRY=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=X2zZE0SCHicO9Vl+5WAUDB69IQmSd/8H0BkAByItJKflclCgOOMjRohVcdAxw2zP7
 248KwdAlA6a/RvOsPhtt59eYj6qDBVMV9g3lQKKx+TTGY3q8v4eByUJQLMW2zow6ac
 Nkw+hv0xHEHEqDZTaXb11qieqA+WYvlQhfGVmxTHu8fYeGO4luszpsjEKx7zaO8qSG
 98tko8+Rqo/YHKEQPkrFPSmHRQblGcb4VcI2B9haHDR3LrtqfmSE7IS5OwYCqL/AwN
 5lZgEmCZfJiYwgTopWdKAvIRm8g1vHrwuVfR1CR1jiEZ1IfQo1cD/Yd4cXERBQqw8i
 4cZQKnRo1q44A==
Received: from localhost.localdomain (to-18-83-216.service.infuturo.it
 [151.18.83.216])
 by mail.baldo.me (Postfix) with ESMTPSA id 09985425C0;
 Sat, 25 Sep 2021 19:49:10 +0000 (UTC)
From: Davide Baldo <davide@baldo.me>
To: alsa-devel@alsa-project.org
Subject: [PATCH] Fixes HP Spectre x360 15-eb1xxx speakers
Date: Sat, 25 Sep 2021 21:44:26 +0200
Message-Id: <20210925194425.9028-1-davide@baldo.me>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Sep 2021 10:39:26 +0200
Cc: Davide Baldo <davide@baldo.me>
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


First kernel contribution, I only tested this patch myself on a 5.14.7.
There is probably some way to fix the remaining issues, but I need
some guidance on how I could test the different pinouts since
hdajackretask hangs the audio card and I can't test out combinations.
In the meantime this commit fix the most serius problem: silent
speakers.

In laptop 'HP Spectre x360 Convertible 15-eb1xxx/8811' both front and
rear speakers are silent, this patch fixes that by overriding the pin
layout and by initializing the amplifier which needs a GPIO pin to be
set to 1 then 0, similar to the existing HP Spectre x360 14 model.

This patch also correctly map the mute LED but since there is no
microphone on/off switch exposed by the alsa subsystem it never turns
on by itself.

There are still known audio issues in this laptop: headset microphone
doesn't work, the button to mute/unmute microphone is not yet mapped,
the LED of the mute/unmute speakers doesn't seems to be exposed via
GPIO and never turns on.

Signed-off-by: Davide Baldo <davide@baldo.me>
---
 sound/pci/hda/patch_realtek.c | 41 ++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 70516527ebce..90f845976793 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6414,6 +6414,38 @@ static void alc_fixup_no_int_mic(struct hda_codec *codec,
 	}
 }
 
+/* GPIO1 = amplifier on/off
+ * GPIO3 = mic mute LED
+ */
+static void alc285_fixup_hp_spectre_x360_eb1(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x14, 0x90170110 },  /* front speakers */
+		{ }
+	};
+
+	//enable micmute led
+	alc_fixup_hp_gpio_led(codec, action, 0x00, 0x04);
+	spec->micmute_led_polarity = 1;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		/* needed for amp of back speakers */
+		spec->gpio_mask |= 0x01;
+		spec->gpio_dir |= 0x01;
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		/* need to toggle GPIO to enable the amp of back speakers */
+		alc_update_gpio_data(codec, 0x01, true);
+		msleep(100);
+		alc_update_gpio_data(codec, 0x01, false);
+		break;
+	}
+}
+
 static void alc285_fixup_hp_spectre_x360(struct hda_codec *codec,
 					  const struct hda_fixup *fix, int action)
 {
@@ -6534,6 +6566,7 @@ enum {
 	ALC269_FIXUP_HP_DOCK_GPIO_MIC1_LED,
 	ALC280_FIXUP_HP_9480M,
 	ALC245_FIXUP_HP_X360_AMP,
+	ALC285_FIXUP_HP_SPECTRE_X360_EB1,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13,
@@ -6658,7 +6691,7 @@ enum {
 	ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP,
 	ALC623_FIXUP_LENOVO_THINKSTATION_P340,
 	ALC255_FIXUP_ACER_HEADPHONE_AND_MIC,
-	ALC236_FIXUP_HP_LIMIT_INT_MIC_BOOST,
+	ALC236_FIXUP_HP_LIMIT_INT_MIC_BOOST
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8222,6 +8255,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360,
 	},
+	[ALC285_FIXUP_HP_SPECTRE_X360_EB1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_spectre_x360_eb1
+	},
 	[ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_ideapad_s740_coef,
@@ -8415,6 +8452,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
+	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
@@ -8858,6 +8896,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC245_FIXUP_HP_X360_AMP, .name = "alc245-hp-x360-amp"},
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
+	{.id = ALC285_FIXUP_HP_SPECTRE_X360_EB1, .name = "alc285-hp-spectre-x360-eb1"},
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
-- 
2.32.0

