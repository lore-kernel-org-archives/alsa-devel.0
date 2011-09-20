From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Add support for IDT 92HD93
Date: Tue, 20 Sep 2011 09:02:22 +0200
Message-ID: <1316502142-4037-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B091103857
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 09:02:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, stable@kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Cc: stable@kernel.org
BugLink: http://bugs.launchpad.net/bugs/854468
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 5145b66..7d8efab 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -6573,6 +6573,7 @@ static const struct hda_codec_preset snd_hda_preset_sigmatel[] = {
 	{ .id = 0x111d76cc, .name = "92HD89F3", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d76cd, .name = "92HD89F2", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d76ce, .name = "92HD89F1", .patch = patch_stac92hd73xx },
+	{ .id = 0x111d76df, .name = "92HD93BXX", .patch = patch_stac92hd83xxx}, 
 	{ .id = 0x111d76e0, .name = "92HD91BXX", .patch = patch_stac92hd83xxx},
 	{ .id = 0x111d76e3, .name = "92HD98BXX", .patch = patch_stac92hd83xxx},
 	{ .id = 0x111d76e5, .name = "92HD99BXX", .patch = patch_stac92hd83xxx},
-- 
1.7.5.4
