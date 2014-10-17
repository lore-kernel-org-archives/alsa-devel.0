From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/3] ALSA: seq: Use atomic ops for autoload
	refcount
Date: Fri, 17 Oct 2014 10:50:05 +0200
Message-ID: <1413535807-21017-2-git-send-email-tiwai@suse.de>
References: <1413535807-21017-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AAAC2625CF
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 10:50:13 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1DEE4AC8E
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 08:50:13 +0000 (UTC)
In-Reply-To: <1413535807-21017-1-git-send-email-tiwai@suse.de>
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

... just to robustify for races.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 91a786a783e1..775ea9390110 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -127,15 +127,15 @@ static void snd_seq_device_info(struct snd_info_entry *entry,
 
 #ifdef CONFIG_MODULES
 /* avoid auto-loading during module_init() */
-static int snd_seq_in_init;
+static atomic_t snd_seq_in_init = ATOMIC_INIT(0);
 void snd_seq_autoload_lock(void)
 {
-	snd_seq_in_init++;
+	atomic_inc(&snd_seq_in_init);
 }
 
 void snd_seq_autoload_unlock(void)
 {
-	snd_seq_in_init--;
+	atomic_dec(&snd_seq_in_init);
 }
 #endif
 
@@ -147,7 +147,7 @@ void snd_seq_device_load_drivers(void)
 	/* Calling request_module during module_init()
 	 * may cause blocking.
 	 */
-	if (snd_seq_in_init)
+	if (atomic_read(&snd_seq_in_init))
 		return;
 
 	mutex_lock(&ops_mutex);
-- 
2.1.2
