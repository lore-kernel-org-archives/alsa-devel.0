From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add zenbook-boost model for ASUS
	Zenbook
Date: Thu, 28 Nov 2013 11:52:03 +0100
Message-ID: <1385635923-16136-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 017B52652DA
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 11:52:04 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C191DA7D75
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 11:52:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There's been a complaint about the too soft output on ASUS Zenbook
with ALC269VB in comparison with Windows.  It turned out, however,
that the actual hardware output level is same between Linux and
Windows unless software plugin is used.  Still, it'd be convenient to
give a capability for increasing the output level via Realtek codec's
D-class amp.

As a compromise, here provides a new model option, zenbook-boost, to
enable the COEFs for the output boost amp.  It's not used unless the
option is given explicitly just for safety reason.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=62651
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |  1 +
 sound/pci/hda/patch_realtek.c                | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 85c362d8ea34..6fbd108bcb27 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -32,6 +32,7 @@ ALC269/270/275/276/28x/29x
   lenovo-dock   	Enables docking station I/O for some Lenovos
   dell-headset-multi	Headset jack, which can also be used as mic-in
   dell-headset-dock	Headset jack (without mic-in), and also dock I/O
+  zenbook-boost		Add +6dB amp to output of ASUS Zenbook
 
 ALC66x/67x/892
 ==============
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3a9a1b0c1dbe..284952c37929 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3799,6 +3799,7 @@ enum {
 	ALC269_FIXUP_ACER_AC700,
 	ALC269_FIXUP_LIMIT_INT_MIC_BOOST,
 	ALC269VB_FIXUP_ASUS_ZENBOOK,
+	ALC269VB_FIXUP_ASUS_ZENBOOK_BOOST,
 	ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED,
 	ALC269VB_FIXUP_ORDISSIMO_EVE2,
 	ALC283_FIXUP_CHROME_BOOK,
@@ -4082,6 +4083,17 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269VB_FIXUP_DMIC,
 	},
+	[ALC269VB_FIXUP_ASUS_ZENBOOK_BOOST] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* class-D output boost +6dB */
+			{0x20, AC_VERB_SET_COEF_INDEX, 0x12},
+			{0x20, AC_VERB_SET_PROC_COEF, 0x3000},
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269VB_FIXUP_ASUS_ZENBOOK,
+	},
 	[ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_limit_int_mic_boost,
@@ -4299,6 +4311,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_HP_GPIO_LED, .name = "hp-gpio-led"},
 	{.id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
 	{.id = ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name = "dell-headset-dock"},
+	{.id = ALC269VB_FIXUP_ASUS_ZENBOOK_BOOST, .name = "zenbook-boost"},
 	{}
 };
 
-- 
1.8.4.4
