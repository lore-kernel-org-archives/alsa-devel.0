Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5804EC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 17:01:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D131960FBF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 17:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D131960FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11C0E16DB;
	Mon, 25 Oct 2021 19:00:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11C0E16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635181299;
	bh=hmxSbDvM4ZcRl+Fcq6W66HT1l11XXxkQzDz0t4FTSg0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eXPih4Tziv9eWRKDzlvVLKUoA6BD4KlEVaYpEZAo0cmFC8FIdsknfqiw6r0mGcBr2
	 bFon9nhN3rIZPhQj1ZfC3HpsRTicvznWrM3d3pncl6VBwnRCenBx9s9K0bMg2B1Lzy
	 wFKTmSXlUNSux03QVlTwsAO6vAyxVckwu8YLCcXk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 989D9F804E2;
	Mon, 25 Oct 2021 19:00:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0196FF804E2; Mon, 25 Oct 2021 18:59:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45B54F8025A
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 18:59:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45B54F8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YJXeIOTX"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60BE560E97;
 Mon, 25 Oct 2021 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635181191;
 bh=hmxSbDvM4ZcRl+Fcq6W66HT1l11XXxkQzDz0t4FTSg0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YJXeIOTXtPPwMyjnEUzFcmRAfZEv8k7J4SRiq2jK11GC4R5P4JOrQRLD0z7Ai5sdD
 jLNagpW5ddBEzu5J3WS2I/xJ5z5SIkJNttTvVy8IZfUTaMX2zI9TZN/27zMV+3Y/Tw
 Exrayqzx8hclzm5we8WF8ZSC/NdmjWDz8TsrsAWlGvZCkmjTqQX7XJ3421SAWxEbYV
 cr8DViF8FdtlwfObMTCwk0+6e5cG8vKl0GuukLqYO6sIP3clQ+Uj/YDW+dQxCu0Yya
 5FFm/Zfq2gPFLzEKZ4XXGRI2n3Gb3DafDsDhpyRo7is7xTHB3e74PJfdEanBnzx/Kn
 63bqPFEKz2GGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 05/18] ALSA: hda/realtek: Fixes HP Spectre x360
 15-eb1xxx speakers
Date: Mon, 25 Oct 2021 12:59:18 -0400
Message-Id: <20211025165939.1393655-5-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025165939.1393655-1-sashal@kernel.org>
References: <20211025165939.1393655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, chris.chiu@canonical.com,
 alsa-devel@alsa-project.org, kailang@realtek.com,
 Davide Baldo <davide@baldo.me>, jeremy.szu@canonical.com,
 Takashi Iwai <tiwai@suse.de>, eliadevito@gmail.com, tiwai@suse.com,
 wse@tuxedocomputers.com, hui.wang@canonical.com, pshou@realtek.com,
 sami@loone.fi, cam@neo-zeon.de
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

From: Davide Baldo <davide@baldo.me>

[ Upstream commit d94befbb5ae379f6dfd4fa6d460eacc09fa7b9c3 ]

In laptop 'HP Spectre x360 Convertible 15-eb1xxx/8811' both front and
rear speakers are silent, this patch fixes that by overriding the pin
layout and by initializing the amplifier which needs a GPIO pin to be
set to 1 then 0, similar to the existing HP Spectre x360 14 model.

In order to have volume control, both front and rear speakers were
forced to use the DAC1.

This patch also correctly map the mute LED but since there is no
microphone on/off switch exposed by the alsa subsystem it never turns
on by itself.

There are still known audio issues in this laptop: headset microphone
doesn't work, the button to mute/unmute microphone is not yet mapped,
the LED of the mute/unmute speakers doesn't seems to be exposed via
GPIO and never turns on.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213953
Signed-off-by: Davide Baldo <davide@baldo.me>
Link: https://lore.kernel.org/r/20211015072121.5287-1-davide@baldo.me
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8e6ff50f0f94..a628b2c050bd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6418,6 +6418,44 @@ static void alc_fixup_no_int_mic(struct hda_codec *codec,
 	}
 }
 
+/* GPIO1 = amplifier on/off
+ * GPIO3 = mic mute LED
+ */
+static void alc285_fixup_hp_spectre_x360_eb1(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	static const hda_nid_t conn[] = { 0x02 };
+
+	struct alc_spec *spec = codec->spec;
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x14, 0x90170110 },  /* front/high speakers */
+		{ 0x17, 0x90170130 },  /* back/bass speakers */
+		{ }
+	};
+
+	//enable micmute led
+	alc_fixup_hp_gpio_led(codec, action, 0x00, 0x04);
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->micmute_led_polarity = 1;
+		/* needed for amp of back speakers */
+		spec->gpio_mask |= 0x01;
+		spec->gpio_dir |= 0x01;
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		/* share DAC to have unified volume control */
+		snd_hda_override_conn_list(codec, 0x14, ARRAY_SIZE(conn), conn);
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
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
@@ -6570,6 +6608,7 @@ enum {
 	ALC269_FIXUP_HP_DOCK_GPIO_MIC1_LED,
 	ALC280_FIXUP_HP_9480M,
 	ALC245_FIXUP_HP_X360_AMP,
+	ALC285_FIXUP_HP_SPECTRE_X360_EB1,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13,
@@ -8263,6 +8302,10 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -8597,6 +8640,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
@@ -9018,6 +9063,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC245_FIXUP_HP_X360_AMP, .name = "alc245-hp-x360-amp"},
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
+	{.id = ALC285_FIXUP_HP_SPECTRE_X360_EB1, .name = "alc285-hp-spectre-x360-eb1"},
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
-- 
2.33.0

