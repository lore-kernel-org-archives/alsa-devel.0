From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix mic regression by ASRock mobo
	fixup
Date: Fri, 11 Nov 2016 17:04:41 +0100
Message-ID: <20161111160441.3734-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CB03267415
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2016 17:04:43 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 34D27AD48
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2016 16:04:43 +0000 (UTC)
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

The commit [1a3f099101b8: ALSA: hda - Fix surround output pins for
ASRock B150M mobo] introduced a fixup of pin configs for ASRock
mobos to fix the surround outputs.  However, this overrides the pin
configs of the mic pins as if they are outputs-only, effectively
disabling the mic inputs.  Of course, it's a regression wrt mic
functionality.

Actually the pins 0x18 and 0x1a don't need to be changed; we just need
to disable the bogus pins 0x14 and 0x15.  Then the auto-parser will
pick up mic pins as switchable and assign the surround outputs there.

This patch removes the incorrect pin overrides of NID 0x18 and 0x1a
from the ASRock fixup.

Fixes: 1a3f099101b8 ('ALSA: hda - Fix surround output pins for ASRock...')
Reported-and-tested-by: Vitor Antunes <vitor.hda@gmail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=187431
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2f909dd8b7b8..ea81c08ddc7a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6907,8 +6907,6 @@ static const struct hda_fixup alc662_fixups[] = {
 		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x15, 0x40f000f0 }, /* disabled */
 			{ 0x16, 0x40f000f0 }, /* disabled */
-			{ 0x18, 0x01014011 }, /* LO */
-			{ 0x1a, 0x01014012 }, /* LO */
 			{ }
 		}
 	},
-- 
2.10.2
