From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add support for Realtek ALC292
Date: Wed, 21 Nov 2012 08:57:58 +0100
Message-ID: <1353484678-2836-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 327DF261794
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 08:58:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, 1081466@bugs.launchpad.net, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

We found a new codec ID 292, and that just a simple quirk would enable
sound output/input on this ALC292 chip.

BugLink: https://bugs.launchpad.net/bugs/1081466
Cc: stable@vger.kernel.org
Tested-by: Acelan Kao <acelan.kao@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4d26852..f1ca742 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7099,6 +7099,7 @@ static const struct hda_codec_preset snd_hda_preset_realtek[] = {
 	{ .id = 0x10ec0282, .name = "ALC282", .patch = patch_alc269 },
 	{ .id = 0x10ec0283, .name = "ALC283", .patch = patch_alc269 },
 	{ .id = 0x10ec0290, .name = "ALC290", .patch = patch_alc269 },
+	{ .id = 0x10ec0292, .name = "ALC292", .patch = patch_alc269 },
 	{ .id = 0x10ec0861, .rev = 0x100340, .name = "ALC660",
 	  .patch = patch_alc861 },
 	{ .id = 0x10ec0660, .name = "ALC660-VD", .patch = patch_alc861vd },
-- 
1.7.9.5
