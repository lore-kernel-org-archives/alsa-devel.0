From: woodrow.shen@canonical.com
Subject: [PATCH v2] ALSA: hda - Fix the headset mic that will
	not work on Dell desktop machine
Date: Fri, 24 Jul 2015 18:22:48 +0800
Message-ID: <1437733368-6690-1-git-send-email-woodrow.shen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E8E64260588
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 12:22:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When the headset was plugged in the Dell desktop, the mic of headset can't be detected and workable.
According to the alsa-info, we found the differece between alsa and init_pin_configs
on the machine, so we need to add the pin configs to make headset work.

Codec: Realtek ALC3234
Vendor Id: 0x10ec0255
Subsystem Id: 0x102806bb

BugLink: https://bugs.launchpad.net/bugs/1477900
Signed-off-by: Woodrow Shen <woodrow.shen@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 742fc62..d94c0e3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5473,6 +5473,28 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1e, 0x411111f0},
 		{0x21, 0x0221103f}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x40000000},
+		{0x14, 0x90170150},
+		{0x17, 0x411111f0},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x02011020},
+		{0x1d, 0x4054c029},
+		{0x1e, 0x411111f0},
+		{0x21, 0x0221105f}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x40000000},
+		{0x14, 0x90170110},
+		{0x17, 0x411111f0},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x01014020},
+		{0x1d, 0x4054c029},
+		{0x1e, 0x411111f0},
+		{0x21, 0x0221101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60160},
 		{0x14, 0x90170120},
 		{0x17, 0x90170140},
-- 
2.1.4
