From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 3/3] Subject: ALSA: seq: Remove autoload
	locks in driver registration
Date: Fri, 17 Oct 2014 10:50:07 +0200
Message-ID: <1413535807-21017-4-git-send-email-tiwai@suse.de>
References: <1413535807-21017-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C312264F31
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 10:50:13 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4848DACD6
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

Since we're calling request_module() asynchronously now, we can get
rid of the autoload lock in snd_seq_device_register_driver(), as well
as in the snd-seq driver registration itself.  This enables the
automatic loading of dependent sequencer modules, such as
snd-seq-virmidi from snd-emu10k1-synth.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq.c        | 2 --
 sound/core/seq/seq_device.c | 7 +------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/core/seq/seq.c b/sound/core/seq/seq.c
index bebdd2e920ca..7e0aabb808a6 100644
--- a/sound/core/seq/seq.c
+++ b/sound/core/seq/seq.c
@@ -86,7 +86,6 @@ static int __init alsa_seq_init(void)
 {
 	int err;
 
-	snd_seq_autoload_lock();
 	if ((err = client_init_data()) < 0)
 		goto error;
 
@@ -112,7 +111,6 @@ static int __init alsa_seq_init(void)
 
 	snd_seq_autoload_init();
  error:
-	snd_seq_autoload_unlock();
 	return err;
 }
 
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index ebee034f8ab5..6b31ca09caf7 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -360,16 +360,12 @@ int snd_seq_device_register_driver(char *id, struct snd_seq_dev_ops *entry,
 	    entry->init_device == NULL || entry->free_device == NULL)
 		return -EINVAL;
 
-	snd_seq_autoload_lock();
 	ops = find_driver(id, 1);
-	if (ops == NULL) {
-		snd_seq_autoload_unlock();
+	if (ops == NULL)
 		return -ENOMEM;
-	}
 	if (ops->driver & DRIVER_LOADED) {
 		pr_warn("ALSA: seq: driver_register: driver '%s' already exists\n", id);
 		unlock_driver(ops);
-		snd_seq_autoload_unlock();
 		return -EBUSY;
 	}
 
@@ -386,7 +382,6 @@ int snd_seq_device_register_driver(char *id, struct snd_seq_dev_ops *entry,
 	mutex_unlock(&ops->reg_mutex);
 
 	unlock_driver(ops);
-	snd_seq_autoload_unlock();
 
 	return 0;
 }
-- 
2.1.2
