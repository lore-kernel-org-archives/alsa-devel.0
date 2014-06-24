Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 272012652C1
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 14:10:42 +0200 (CEST)
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 24 Jun 2014 14:10:47 +0200
Message-Id: <1403611847-14700-1-git-send-email-david.henningsson@canonical.com>
Subject: [alsa-devel] [PATCH] ALSA: hda - Add pin quirk for Dell XPS 15
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, 1331915@bugs.launchpad.net, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-ID: <alsa-devel@alsa-project.org>

Two bug reporters with Dell XPS 15 report that they need to use the
dell-headset-multi model to get the headset mic working.

The two bug reporters have different PCI SSID (1028:05fd and 1028:05fe)
but this pin quirk matches both.

BugLink: https://bugs.launchpad.net/bugs/1331915
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f52f096..229a189 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6258,6 +6258,27 @@ static const struct snd_hda_pin_quirk alc662_pin_fixup_tbl[] = {
 		},
 		.value = ALC668_FIXUP_AUTO_MUTE,
 	},
+	{
+		.codec = 0x10ec0668,
+		.subvendor = 0x1028,
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		.name = "Dell XPS 15",
+#endif
+		.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x90a60130},
+			{0x14, 0x90170110},
+			{0x15, 0x0321101f},
+			{0x16, 0x40000000},
+			{0x18, 0x411111f0},
+			{0x19, 0x411111f0},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x411111f0},
+			{0x1d, 0x40d6832d},
+			{0x1e, 0x411111f0},
+			{0x1f, 0x411111f0},
+		},
+		.value = ALC668_FIXUP_AUTO_MUTE,
+	},
 	{}
 };
 
-- 
1.9.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
