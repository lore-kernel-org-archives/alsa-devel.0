From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - Make the pin quirk tables use
	the SND_HDA_PIN_QUIRK macro
Date: Tue, 24 Jun 2014 14:46:54 +0200
Message-ID: <1403614014-15417-2-git-send-email-david.henningsson@canonical.com>
References: <1403614014-15417-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 77A9C26530A
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 14:46:50 +0200 (CEST)
In-Reply-To: <1403614014-15417-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, hui.wang@canonical.com, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is cosmetical - it makes the pin quirk table look better.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 510 +++++++++++++++---------------------------
 1 file changed, 183 insertions(+), 327 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c70d43f..60bf5ee 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5076,228 +5076,129 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 };
 
 static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
-	{
-		.codec = 0x10ec0255,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60140},
-			{0x14, 0x90170110},
-			{0x17, 0x40000000},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40700001},
-			{0x1e, 0x411111f0},
-			{0x21, 0x02211020},
-		},
-		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0255,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60160},
-			{0x14, 0x90170120},
-			{0x17, 0x40000000},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40700001},
-			{0x1e, 0x411111f0},
-			{0x21, 0x02211030},
-		},
-		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0255,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60160},
-			{0x14, 0x90170120},
-			{0x17, 0x90170140},
-			{0x18, 0x40000000},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x41163b05},
-			{0x1e, 0x411111f0},
-			{0x21, 0x0321102f},
-		},
-		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0255,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60160},
-			{0x14, 0x90170130},
-			{0x17, 0x40000000},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40700001},
-			{0x1e, 0x411111f0},
-			{0x21, 0x02211040},
-		},
-		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0255,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60160},
-			{0x14, 0x90170140},
-			{0x17, 0x40000000},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40700001},
-			{0x1e, 0x411111f0},
-			{0x21, 0x02211050},
-		},
-		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0255,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60170},
-			{0x14, 0x90170120},
-			{0x17, 0x40000000},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40700001},
-			{0x1e, 0x411111f0},
-			{0x21, 0x02211030},
-		},
-		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0255,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60170},
-			{0x14, 0x90170130},
-			{0x17, 0x40000000},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40700001},
-			{0x1e, 0x411111f0},
-			{0x21, 0x02211040},
-		},
-		.value = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0283,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60130},
-			{0x14, 0x90170110},
-			{0x17, 0x40020008},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40e00001},
-			{0x1e, 0x411111f0},
-			{0x21, 0x0321101f},
-		},
-		.value = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0283,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60160},
-			{0x14, 0x90170120},
-			{0x17, 0x40000000},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40700001},
-			{0x1e, 0x411111f0},
-			{0x21, 0x02211030},
-		},
-		.value = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0292,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60140},
-			{0x13, 0x411111f0},
-			{0x14, 0x90170110},
-			{0x15, 0x0221401f},
-			{0x16, 0x411111f0},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40700001},
-			{0x1e, 0x411111f0},
-		},
-		.value = ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
-	},
-	{
-		.codec = 0x10ec0293,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x40000000},
-			{0x13, 0x90a60140},
-			{0x14, 0x90170110},
-			{0x15, 0x0221401f},
-			{0x16, 0x21014020},
-			{0x18, 0x411111f0},
-			{0x19, 0x21a19030},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40700001},
-			{0x1e, 0x411111f0},
-		},
-		.value = ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
-	},
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60140},
+		{0x14, 0x90170110},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x02211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60160},
+		{0x14, 0x90170120},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x02211030}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60160},
+		{0x14, 0x90170120},
+		{0x17, 0x90170140},
+		{0x18, 0x40000000},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x41163b05},
+		{0x1e, 0x411111f0},
+		{0x21, 0x0321102f}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60160},
+		{0x14, 0x90170130},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x02211040}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60160},
+		{0x14, 0x90170140},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x02211050}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60170},
+		{0x14, 0x90170120},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x02211030}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60170},
+		{0x14, 0x90170130},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x02211040}),
+	SND_HDA_PIN_QUIRK(0x10ec0283, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x17, 0x40020008},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40e00001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x0321101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0283, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60160},
+		{0x14, 0x90170120},
+		{0x17, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0},
+		{0x21, 0x02211030}),
+	SND_HDA_PIN_QUIRK(0x10ec0292, 0x1028, "Dell", ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
+		{0x12, 0x90a60140},
+		{0x13, 0x411111f0},
+		{0x14, 0x90170110},
+		{0x15, 0x0221401f},
+		{0x16, 0x411111f0},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x40000000},
+		{0x13, 0x90a60140},
+		{0x14, 0x90170110},
+		{0x15, 0x0221401f},
+		{0x16, 0x21014020},
+		{0x18, 0x411111f0},
+		{0x19, 0x21a19030},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0}),
 	{}
 };
 
@@ -6153,111 +6054,66 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 };
 
 static const struct snd_hda_pin_quirk alc662_pin_fixup_tbl[] = {
-	{
-		.codec = 0x10ec0668,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x99a30130},
-			{0x14, 0x90170110},
-			{0x15, 0x0321101f},
-			{0x16, 0x03011020},
-			{0x18, 0x40000008},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x41000001},
-			{0x1e, 0x411111f0},
-			{0x1f, 0x411111f0},
-		},
-		.value = ALC668_FIXUP_AUTO_MUTE,
-	},
-	{
-		.codec = 0x10ec0668,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x99a30140},
-			{0x14, 0x90170110},
-			{0x15, 0x0321101f},
-			{0x16, 0x03011020},
-			{0x18, 0x40000008},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x41000001},
-			{0x1e, 0x411111f0},
-			{0x1f, 0x411111f0},
-		},
-		.value = ALC668_FIXUP_AUTO_MUTE,
-	},
-	{
-		.codec = 0x10ec0668,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x99a30150},
-			{0x14, 0x90170110},
-			{0x15, 0x0321101f},
-			{0x16, 0x03011020},
-			{0x18, 0x40000008},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x41000001},
-			{0x1e, 0x411111f0},
-			{0x1f, 0x411111f0},
-		},
-		.value = ALC668_FIXUP_AUTO_MUTE,
-	},
-	{
-		.codec = 0x10ec0668,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x411111f0},
-			{0x14, 0x90170110},
-			{0x15, 0x0321101f},
-			{0x16, 0x03011020},
-			{0x18, 0x40000008},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x41000001},
-			{0x1e, 0x411111f0},
-			{0x1f, 0x411111f0},
-		},
-		.value = ALC668_FIXUP_AUTO_MUTE,
-	},
-	{
-		.codec = 0x10ec0668,
-		.subvendor = 0x1028,
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		.name = "Dell XPS 15",
-#endif
-		.pins = (const struct hda_pintbl[]) {
-			{0x12, 0x90a60130},
-			{0x14, 0x90170110},
-			{0x15, 0x0321101f},
-			{0x16, 0x40000000},
-			{0x18, 0x411111f0},
-			{0x19, 0x411111f0},
-			{0x1a, 0x411111f0},
-			{0x1b, 0x411111f0},
-			{0x1d, 0x40d6832d},
-			{0x1e, 0x411111f0},
-			{0x1f, 0x411111f0},
-		},
-		.value = ALC668_FIXUP_AUTO_MUTE,
-	},
+	SND_HDA_PIN_QUIRK(0x10ec0668, 0x1028, "Dell", ALC668_FIXUP_AUTO_MUTE,
+		{0x12, 0x99a30130},
+		{0x14, 0x90170110},
+		{0x15, 0x0321101f},
+		{0x16, 0x03011020},
+		{0x18, 0x40000008},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x41000001},
+		{0x1e, 0x411111f0},
+		{0x1f, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0668, 0x1028, "Dell", ALC668_FIXUP_AUTO_MUTE,
+		{0x12, 0x99a30140},
+		{0x14, 0x90170110},
+		{0x15, 0x0321101f},
+		{0x16, 0x03011020},
+		{0x18, 0x40000008},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x41000001},
+		{0x1e, 0x411111f0},
+		{0x1f, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0668, 0x1028, "Dell", ALC668_FIXUP_AUTO_MUTE,
+		{0x12, 0x99a30150},
+		{0x14, 0x90170110},
+		{0x15, 0x0321101f},
+		{0x16, 0x03011020},
+		{0x18, 0x40000008},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x41000001},
+		{0x1e, 0x411111f0},
+		{0x1f, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0668, 0x1028, "Dell", ALC668_FIXUP_AUTO_MUTE,
+		{0x12, 0x411111f0},
+		{0x14, 0x90170110},
+		{0x15, 0x0321101f},
+		{0x16, 0x03011020},
+		{0x18, 0x40000008},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x41000001},
+		{0x1e, 0x411111f0},
+		{0x1f, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0668, 0x1028, "Dell XPS 15", ALC668_FIXUP_AUTO_MUTE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x15, 0x0321101f},
+		{0x16, 0x40000000},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40d6832d},
+		{0x1e, 0x411111f0},
+		{0x1f, 0x411111f0}),
 	{}
 };
 
-- 
1.9.1
