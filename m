From: Jan-Marek Glogowski <glogow@fbihome.de>
Subject: [RfC][PATCH] ALSA: hda/realtek Pin quirk for Fujitsu
	U7[25]7
Date: Fri, 26 Jan 2018 16:12:53 +0100
Message-ID: <dcac37ef-4319-9eb3-4652-17bc6aa8fbc9@fbihome.de>
References: <c6ec1a50-187e-42d8-4137-f162c52e4f79@fbihome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironman.h-da.de (ironman.h-da.de [141.100.10.250])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B91626721A
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 16:12:54 +0100 (CET)
Received: from [172.16.3.194] (unknown [194.113.41.246])
 by mail.fbihome.de (Postfix) with ESMTPSA id 373BF4210D
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 16:12:53 +0100 (CET)
In-Reply-To: <c6ec1a50-187e-42d8-4137-f162c52e4f79@fbihome.de>
Content-Language: en-GB
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

Hi everybody,

I got new HW from our supplier, a Fujitsu U727 and a U757 laptop, which
have a headset jack. Attaching a headset, the microphone doesn't work.
After some reading and trying various tools to understand the problem, I
found hdajacksensetest, which showed a sense change for a seemingly
wrong unconnected pin.
Overriding this pins' config has fixed the headsets microphone, so now I
have the attached kernel patch with a SND_HDA_PIN_QUIRK.

After compiling the patched module (for 4.4), everything works as
expected, but hdajackretask still shows the pin as unconnected, so I'm
wondering,  if I need to do something in addition? Is this normal
behaviour? This is just a port to master, as we (Munich) are on Ubuntu
Trusty with Xenial HWE (4.4 kernel).

Thanks for the review.

Jan-Marek Glogowski

P.S. checkpatch.pl warned about too long lines for the
SND_HDA_PIN_QUIRK. Should I fix that?


>From 69f1c296b22ab6dce93ba50de9cf05e279d52088 Mon Sep 17 00:00:00 2001
From: Jan-Marek Glogowski <glogow@fbihome.de>
Date: Wed, 24 Jan 2018 18:57:38 +0100
Subject: [PATCH] ALSA: hda/realtek Pin quirk for Fujitsu U7[25]7

These laptops have a combined jack to attach headsets, the U727 on
the left, the U757 on the right, but a headsets microphone doesn't
work. Using hdajacksensetest I found that pin 0x19 changed the
present state when plugging the headset, in addition to 0x21, but
didn't have the correct configuration (shown as "Not connected").

So this sets the configuration to the same values as the headphone
pin 0x21 except for the device type microphone, which makes it
work correctly. With the patch the configured pins for U727 are

Pin 0x12 (Internal Mic, Mobile-In): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x19 (Black Mic, Left side): present = No
Pin 0x1d (Internal Aux): present = No
Pin 0x21 (Black Headphone, Left side): present = No

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
---
 sound/pci/hda/patch_realtek.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9aafc6c..52c6beb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5275,6 +5275,8 @@ enum {
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
+	ALC255_FIXUP_FUJITSU_U727_MIC,
+	ALC255_FIXUP_FUJITSU_U757_MIC,
 	ALC255_FIXUP_HEADSET_MODE,
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -5786,6 +5788,20 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC255_FIXUP_FUJITSU_U727_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11020 }, /* detect headset mic, left */
+			{ }
+		},
+	},
+	[ALC255_FIXUP_FUJITSU_U757_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x04a11020 }, /* detect headset mic, right */
+			{ }
+		},
+	},
 	[ALC255_FIXUP_HEADSET_MODE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_mode_alc255,
@@ -6589,6 +6605,18 @@ static const struct snd_hda_pin_quirk
alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell",
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x1b, 0x01011020},
 		{0x21, 0x02211010}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x10cf, "Fujitsu Lifebook U727",
ALC255_FIXUP_FUJITSU_U727_MIC,
+		{0x12, 0xb7a60130},
+		{0x14, 0x90170110},
+		{0x19, 0x411111f0},
+		{0x1d, 0x909701f0},
+		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x10cf, "Fujitsu Livebook U757",
ALC255_FIXUP_FUJITSU_U757_MIC,
+		{0x12, 0xb7a60130},
+		{0x14, 0x90170110},
+		{0x19, 0x411111f0},
+		{0x1d, 0x909701f0},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell",
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60130},
 		{0x14, 0x90170110},
-- 
2.1.4
