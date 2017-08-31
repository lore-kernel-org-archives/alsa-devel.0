From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: opl3: Put missing KERN_CONT prefix
Date: Thu, 31 Aug 2017 11:33:29 +0200
Message-ID: <20170831093334.9050-2-tiwai@suse.de>
References: <20170831093334.9050-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B7BA267256
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:33:37 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 29CF0ACF2
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 09:33:37 +0000 (UTC)
In-Reply-To: <20170831093334.9050-1-tiwai@suse.de>
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

The opl3 driver has a debug printk code without proper KERN_ prefix.
On recent kernels, KERN_CONT prefix is mandatory for continued output
lines.  Put it properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl3/opl3_midi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index 7821b07415a7..13c0a7e1bc2b 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -131,8 +131,8 @@ static void debug_alloc(struct snd_opl3 *opl3, char *s, int voice) {
 
 	printk(KERN_DEBUG "time %.5i: %s [%.2i]: ", opl3->use_time, s, voice);
 	for (i = 0; i < opl3->max_voices; i++)
-		printk("%c", *(str + opl3->voices[i].state + 1));
-	printk("\n");
+		printk(KERN_CONT "%c", *(str + opl3->voices[i].state + 1));
+	printk(KERN_CONT "\n");
 }
 #endif
 
-- 
2.14.1
