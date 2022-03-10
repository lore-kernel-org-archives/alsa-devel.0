Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56A8C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 07:02:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16C721716;
	Mon, 14 Mar 2022 08:01:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16C721716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647241320;
	bh=wBT1fyXqyc2nKO7FLXBo5NMt47Y7zbil6MH8lVVYpjk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i+QbJr4UY/m6ZW4ZaB/dJS5HDdFuKb5KoargdLwL5UdTYtZWCcskboRe36WD6+zyP
	 i14Sb5MZZMpJoD730aLbC7ircPiMI18trqKy0ch/GEfZwxEyfNXTXJ7VZH5MgVPPCf
	 +hh2Jp+8Zi/Q7dKGXXK0hTmhf7eDIHfGjcTD9Dd4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CFF4F8052D;
	Mon, 14 Mar 2022 07:58:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2999F800D2; Thu, 10 Mar 2022 14:03:20 +0100 (CET)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 193E0F800D2
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 14:03:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 193E0F800D2
X-QQ-mid: bizesmtp78t1646917384tdsqalkf
Received: from localhost.localdomain ( [113.57.152.160])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 10 Mar 2022 21:03:03 +0800 (CST)
X-QQ-SSF: 01400000002000B0C000B00A0000000
X-QQ-FEAT: hAQ2xUxVESwZEQadtxikZbscZLrGOFgmNn+CeTtX4AR5qtfkmOVoFOHtsHJad
 G3G4uvIAGBdITa72ZM2D/poSJOHwAy34zaXbnYquS5owIxyXuhOkenVy/NNKnVOQY9LEHdr
 A47rhkY13bprr5ZopJn/Qs0h/sW6tGH8FhY6jYIRavc+YVEWqCn3M23PDLTqE6YoI4HlR6D
 p3XoavG5oiFwI6BMHp0fcG9T2kEXatWgBOrisD/1sfUz5NSO2tU6561qBlixpsY087HuOEI
 q/uLWO1zBM0js8+I2mDODwA9C+H6Z6VRoxwRRoYjGF68Yq14+lMOJG+LbQIJPTA8Xa204AG
 sxaWAL0
X-QQ-GoodBg: 2
From: huangwenhui <huangwenhuia@uniontech.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ALSA: hda/realtek - Fix headset mic problem for a HP machine
 with alc671
Date: Thu, 10 Mar 2022 21:03:01 +0800
Message-Id: <20220310130301.22827-1-huangwenhuia@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Mon, 14 Mar 2022 07:58:50 +0100
Cc: alsa-devel@alsa-project.org, kailang@realtek.com,
 tanureal@opensource.cirrus.com, jeremy.szu@canonical.com,
 linux-kernel@vger.kernel.org, wse@tuxedocomputers.com,
 huangwenhui <huangwenhuia@uniontech.com>, hui.wang@canonical.com,
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

On a HP 288 Pro G8, the front Mic could not be detected.

Signed-off-by: huangwenhui <huangwenhuia@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3a42457984e9..bcd56cdc07af 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10519,6 +10519,37 @@ static void alc671_fixup_hp_headset_mic2(struct hda_codec *codec,
 	}
 }
 
+static void alc671_fixup_hp288_headset_mic2(struct hda_codec *codec,
+					     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x19, 0x02a11040 }, /* use as headset mic, with its own jack detect */
+		{ 0x1b, 0x0181304f },
+		{ }
+	};
+
+	if (!hp_pin)
+		hp_pin = 0x21;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->gen.mixer_nid = 0;
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		alc_write_coef_idx(codec, 0x19, 0xa054);
+		msleep(80);
+		snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		msleep(100);
+		break;
+	}
+}
+
 static void alc897_hp_automute_hook(struct hda_codec *codec,
 					 struct hda_jack_callback *jack)
 {
@@ -10615,6 +10646,7 @@ enum {
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS,
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET,
 	ALC671_FIXUP_HP_HEADSET_MIC2,
+	ALC671_FIXUP_HP288_HEADSET_MIC2,
 	ALC662_FIXUP_ACER_X2660G_HEADSET_MODE,
 	ALC662_FIXUP_ACER_NITRO_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_NO_HEADSET_MIC,
@@ -10986,6 +11018,10 @@ static const struct hda_fixup alc662_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc671_fixup_hp_headset_mic2,
 	},
+	[ALC671_FIXUP_HP288_HEADSET_MIC2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc671_fixup_hp288_headset_mic2,
+	},
 	[ALC662_FIXUP_ACER_X2660G_HEADSET_MODE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -11067,6 +11103,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x069f, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP288_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_ASUS_Nx50),
 	SND_PCI_QUIRK(0x1043, 0x129d, "Asus N750", ALC662_FIXUP_ASUS_Nx50),
-- 
2.20.1



