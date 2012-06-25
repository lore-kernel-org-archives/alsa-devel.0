From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add Realtek ALC280 codec support
Date: Mon, 25 Jun 2012 19:49:28 +0200
Message-ID: <1340646568-2533-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 2A1282443D
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2012 19:49:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This chip looks very similar to ALC269 and ALC27* variants. The bug reporter
has verified that sound was working after this patch had been applied.

Cc: stable@kernel.org
BugLink: https://bugs.launchpad.net/bugs/1017017
Tested-by: Richard Crossley <richardcrossley@o2.co.uk>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

Alsa info available at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1017017/+attachment/3202012/+files/alsa-info.txt.6Uupl5Ch1L

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 41475ae..a5534b3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6800,6 +6800,7 @@ static const struct hda_codec_preset snd_hda_preset_realtek[] = {
 	{ .id = 0x10ec0272, .name = "ALC272", .patch = patch_alc662 },
 	{ .id = 0x10ec0275, .name = "ALC275", .patch = patch_alc269 },
 	{ .id = 0x10ec0276, .name = "ALC276", .patch = patch_alc269 },
+	{ .id = 0x10ec0280, .name = "ALC280", .patch = patch_alc269 },
 	{ .id = 0x10ec0861, .rev = 0x100340, .name = "ALC660",
 	  .patch = patch_alc861 },
 	{ .id = 0x10ec0660, .name = "ALC660-VD", .patch = patch_alc861vd },
-- 
1.7.9.5
