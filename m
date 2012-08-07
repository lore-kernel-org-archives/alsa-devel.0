From: m.kiepfer@fs-net.de
Subject: [PATCH] ALSA: Initialize power-down register on AC97
	codec wm9711/12/15.
Date: Tue,  7 Aug 2012 16:14:01 +0200
Message-ID: <1344348841-28886-1-git-send-email-m.kiepfer@fs-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 5823B265FE1
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 20:15:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: m.kiepfer@fs-net.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Martin Kiepfer <m.kiepfer@fs-net.de>

Signed-off-by: Martin Kiepfer <m.kiepfer@fs-net.de>
---
 sound/pci/ac97/ac97_patch.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index a872d0a..b8e493ac 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -697,6 +697,8 @@ static int patch_wolfson11(struct snd_ac97 * ac97)
 
 	ac97->flags |= AC97_HAS_NO_REC_GAIN | AC97_STEREO_MUTES | AC97_HAS_NO_MIC |
 		AC97_HAS_NO_PC_BEEP | AC97_HAS_NO_VIDEO | AC97_HAS_NO_CD;
+
+	snd_ac97_write_cache(ac97, AC97_POWERDOWN, 0);
 	
 	return 0;
 }
-- 
1.7.4.4
