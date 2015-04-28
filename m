From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: emux: Fix mutex deadlock in OSS emulation
Date: Tue, 28 Apr 2015 17:46:32 +0200
Message-ID: <1430235992-3088-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CA41F261AA5
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 17:46:35 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B9CE8AB22
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 15:46:34 +0000 (UTC)
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

The OSS emulation in synth-emux helper has a potential AB/BA deadlock
at the simultaneous closing and opening:

  close ->
    snd_seq_release() ->
      sne_seq_free_client() ->
        snd_seq_delete_all_ports(): takes client->ports_mutex ->
	  port_delete() ->
	    snd_emux_unuse(): takes emux->register_mutex

  open ->
    snd_seq_oss_open() ->
      snd_emux_open_seq_oss(): takes emux->register_mutex ->
        snd_seq_event_port_attach() ->
	  snd_seq_create_port(): takes client->ports_mutex

This patch addresses the deadlock by reducing the rance taking
emux->register_mutex in snd_emux_open_seq_oss().  The lock is needed
for the refcount handling, so move it locally.  The calls in
emux_seq.c are already with the mutex, thus they are replaced with the
version without mutex lock/unlock.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/synth/emux/emux_oss.c | 11 +----------
 sound/synth/emux/emux_seq.c | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/sound/synth/emux/emux_oss.c b/sound/synth/emux/emux_oss.c
index ab37add269ae..82e350e9501c 100644
--- a/sound/synth/emux/emux_oss.c
+++ b/sound/synth/emux/emux_oss.c
@@ -118,12 +118,8 @@ snd_emux_open_seq_oss(struct snd_seq_oss_arg *arg, void *closure)
 	if (snd_BUG_ON(!arg || !emu))
 		return -ENXIO;
 
-	mutex_lock(&emu->register_mutex);
-
-	if (!snd_emux_inc_count(emu)) {
-		mutex_unlock(&emu->register_mutex);
+	if (!snd_emux_inc_count(emu))
 		return -EFAULT;
-	}
 
 	memset(&callback, 0, sizeof(callback));
 	callback.owner = THIS_MODULE;
@@ -135,7 +131,6 @@ snd_emux_open_seq_oss(struct snd_seq_oss_arg *arg, void *closure)
 	if (p == NULL) {
 		snd_printk(KERN_ERR "can't create port\n");
 		snd_emux_dec_count(emu);
-		mutex_unlock(&emu->register_mutex);
 		return -ENOMEM;
 	}
 
@@ -148,8 +143,6 @@ snd_emux_open_seq_oss(struct snd_seq_oss_arg *arg, void *closure)
 	reset_port_mode(p, arg->seq_mode);
 
 	snd_emux_reset_port(p);
-
-	mutex_unlock(&emu->register_mutex);
 	return 0;
 }
 
@@ -195,13 +188,11 @@ snd_emux_close_seq_oss(struct snd_seq_oss_arg *arg)
 	if (snd_BUG_ON(!emu))
 		return -ENXIO;
 
-	mutex_lock(&emu->register_mutex);
 	snd_emux_sounds_off_all(p);
 	snd_soundfont_close_check(emu->sflist, SF_CLIENT_NO(p->chset.port));
 	snd_seq_event_port_detach(p->chset.client, p->chset.port);
 	snd_emux_dec_count(emu);
 
-	mutex_unlock(&emu->register_mutex);
 	return 0;
 }
 
diff --git a/sound/synth/emux/emux_seq.c b/sound/synth/emux/emux_seq.c
index 188fda0effb0..a0209204ae48 100644
--- a/sound/synth/emux/emux_seq.c
+++ b/sound/synth/emux/emux_seq.c
@@ -267,8 +267,8 @@ snd_emux_event_input(struct snd_seq_event *ev, int direct, void *private_data,
 /*
  * increment usage count
  */
-int
-snd_emux_inc_count(struct snd_emux *emu)
+static int
+__snd_emux_inc_count(struct snd_emux *emu)
 {
 	emu->used++;
 	if (!try_module_get(emu->ops.owner))
@@ -282,12 +282,21 @@ snd_emux_inc_count(struct snd_emux *emu)
 	return 1;
 }
 
+int snd_emux_inc_count(struct snd_emux *emu)
+{
+	int ret;
+
+	mutex_lock(&emu->register_mutex);
+	ret = __snd_emux_inc_count(emu);
+	mutex_unlock(&emu->register_mutex);
+	return ret;
+}
 
 /*
  * decrease usage count
  */
-void
-snd_emux_dec_count(struct snd_emux *emu)
+static void
+__snd_emux_dec_count(struct snd_emux *emu)
 {
 	module_put(emu->card->module);
 	emu->used--;
@@ -296,6 +305,12 @@ snd_emux_dec_count(struct snd_emux *emu)
 	module_put(emu->ops.owner);
 }
 
+void snd_emux_dec_count(struct snd_emux *emu)
+{
+	mutex_lock(&emu->register_mutex);
+	__snd_emux_dec_count(emu);
+	mutex_unlock(&emu->register_mutex);
+}
 
 /*
  * Routine that is called upon a first use of a particular port
@@ -315,7 +330,7 @@ snd_emux_use(void *private_data, struct snd_seq_port_subscribe *info)
 
 	mutex_lock(&emu->register_mutex);
 	snd_emux_init_port(p);
-	snd_emux_inc_count(emu);
+	__snd_emux_inc_count(emu);
 	mutex_unlock(&emu->register_mutex);
 	return 0;
 }
@@ -338,7 +353,7 @@ snd_emux_unuse(void *private_data, struct snd_seq_port_subscribe *info)
 
 	mutex_lock(&emu->register_mutex);
 	snd_emux_sounds_off_all(p);
-	snd_emux_dec_count(emu);
+	__snd_emux_dec_count(emu);
 	mutex_unlock(&emu->register_mutex);
 	return 0;
 }
-- 
2.3.5
