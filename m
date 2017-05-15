From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: cs4281: Fix the leftover comment
Date: Mon, 15 May 2017 11:33:38 +0200
Message-ID: <20170515093338.21220-3-tiwai@suse.de>
References: <20170515093338.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 24B112673C9
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:33:43 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 03E31AC04
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 09:33:43 +0000 (UTC)
In-Reply-To: <20170515093338.21220-1-tiwai@suse.de>
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

The comment at endif line was forgotten to be corrected when the
condition was converted to IS_REACHABLE().  Fix it, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cs4281.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index f870697aca67..ee7ba4b0b47b 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1296,7 +1296,7 @@ static void snd_cs4281_free_gameport(struct cs4281 *chip)
 #else
 static inline int snd_cs4281_create_gameport(struct cs4281 *chip) { return -ENOSYS; }
 static inline void snd_cs4281_free_gameport(struct cs4281 *chip) { }
-#endif /* CONFIG_GAMEPORT || (MODULE && CONFIG_GAMEPORT_MODULE) */
+#endif /* IS_REACHABLE(CONFIG_GAMEPORT) */
 
 static int snd_cs4281_free(struct cs4281 *chip)
 {
-- 
2.12.2
