From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add another headset pin quirk for
	some Dell machines
Date: Fri, 27 Jun 2014 08:41:59 +0200
Message-ID: <1403851319-3185-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AB241265053
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 08:42:04 +0200 (CEST)
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
Cc: Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>, 1297581@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

Another quirk to make the headset mic work on some new Dell machines.

Cc: Hui Wang <hui.wang@canonical.com>
BugLink: https://bugs.launchpad.net/bugs/1297581
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 60bf5ee..4ebbe03 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5199,6 +5199,18 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1b, 0x411111f0},
 		{0x1d, 0x40700001},
 		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x40000000},
+		{0x13, 0x90a60140},
+		{0x14, 0x90170110},
+		{0x15, 0x0221401f},
+		{0x16, 0x411111f0},
+		{0x18, 0x411111f0},
+		{0x19, 0x411111f0},
+		{0x1a, 0x411111f0},
+		{0x1b, 0x411111f0},
+		{0x1d, 0x40700001},
+		{0x1e, 0x411111f0}),
 	{}
 };
 
-- 
1.9.1
