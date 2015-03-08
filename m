From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix regression of HD-audio
	controller fallback modes
Date: Sun,  8 Mar 2015 18:41:51 +0100
Message-ID: <1425836511-16400-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 51BBD2604C7
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 18:41:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0B9FBAD4F
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 17:41:55 +0000 (UTC)
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

The commit [63e51fd708f5: ALSA: hda - Don't take unresponsive D3
transition too serious] introduced a conditional fallback behavior to
the HD-audio controller depending on the flag set.  However, it
introduced a silly bug, too, that the flag was evaluated in a reverse
way.  This resulted in a regression of HD-audio controller driver
where it can't go to the fallback mode at communication errors.

Unfortunately (or fortunately?) this didn't come up until recently
because the affected code path is an error handling that happens only
on an unstable hardware chip.  Most of recent chips work stably, thus
they didn't hit this problem.  Now, we've got a regression report with
a VIA chip, and this seems indeed requiring the fallback to the
polling mode, and finally the bug was revealed.

The fix is a oneliner to remove the wrong logical NOT in the check.
(Lesson learned - be careful about double negation.)

The bug should be backported to stable, but the patch won't be
applicable to 3.13 or earlier because of the code splits.  The stable
fix patches for earlier kernels will be posted later manually.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=94021
Fixes: 63e51fd708f5 ('ALSA: hda - Don't take unresponsive D3 transition too serious')
Cc: <stable@vger.kernel.org> # v3.14+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index a2ce773bdc62..17c2637d842c 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1164,7 +1164,7 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 		}
 	}
 
-	if (!bus->no_response_fallback)
+	if (bus->no_response_fallback)
 		return -1;
 
 	if (!chip->polling_mode && chip->poll_count < 2) {
-- 
2.3.1
