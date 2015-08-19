From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Fix runtime PM unbalance
Date: Wed, 19 Aug 2015 07:33:23 +0200
Message-ID: <1439962403-23785-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BAC02625C4
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 07:33:25 +0200 (CEST)
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
Cc: Hans Yang <hansy@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The fix for deadlock in PM in commit [1ee23fe07ee8: ALSA: usb-audio:
Fix deadlocks at resuming] introduced a new check of in_pm flag.
However, the brainless patch author evaluated it in a wrong way
(logical AND instead of logical OR), thus usb_autopm_get_interface()
is never called, leading to unbalance of runtime PM refcount.

This patch fixes it by correcting the logic.

Reported-by: Hans Yang <hansy@nvidia.com>
Fixes: 1ee23fe07ee8 ('ALSA: usb-audio: Fix deadlocks at resuming')
Cc: <stable@vger.kernel.org> [v3.15+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 1fab9778807a..0450593980fd 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -638,7 +638,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
 	int err = -ENODEV;
 
 	down_read(&chip->shutdown_rwsem);
-	if (chip->probing && chip->in_pm)
+	if (chip->probing || chip->in_pm)
 		err = 0;
 	else if (!chip->shutdown)
 		err = usb_autopm_get_interface(chip->pm_intf);
-- 
2.5.0
