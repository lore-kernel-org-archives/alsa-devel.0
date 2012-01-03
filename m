From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix typo for ALC269VB_FIXUP_DMIC
Date: Tue,  3 Jan 2012 08:45:56 +0100
Message-ID: <1325576756-2433-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id E866D103842
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 08:46:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This fixup is not actually used, so in practice this is just a
cosmetic fix.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d24adbd..5e82acf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5320,7 +5320,7 @@ static const struct alc_fixup alc269_fixups[] = {
 			{ }
 		},
 	},
-	[ALC269_FIXUP_DMIC] = {
+	[ALC269VB_FIXUP_DMIC] = {
 		.type = ALC_FIXUP_PINS,
 		.v.pins = (const struct alc_pincfg[]) {
 			{ 0x12, 0x99a3092f }, /* int-mic */
-- 
1.7.5.4
