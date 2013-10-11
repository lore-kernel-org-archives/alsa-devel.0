From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Sony VAIO Pro 13 (haswell) now has
	a working headset jack
Date: Fri, 11 Oct 2013 13:46:04 +0200
Message-ID: <1381491964-4715-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E2A22261A3D
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 13:46:04 +0200 (CEST)
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Just got the positive confirmation from a tester:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1227093/comments/28

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 79e6fe7..bf313be 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3761,6 +3761,8 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x18, 0x01a1913c }, /* use as headset mic, without its own jack detect */
 			{ }
 		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
 	[ALC269_FIXUP_ASUS_X101_FUNC] = {
 		.type = HDA_FIXUP_FUNC,
-- 
1.7.9.5
