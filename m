From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 4/5] Allow hint for ctl, hwdep,
	timer and seq
Date: Thu, 30 Apr 2015 15:06:17 +0200
Message-ID: <1430399178-15173-5-git-send-email-tiwai@suse.de>
References: <1430399178-15173-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 01106261600
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 15:06:20 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3AF52AC48
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 13:06:19 +0000 (UTC)
In-Reply-To: <1430399178-15173-1-git-send-email-tiwai@suse.de>
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

Like pcm and rawmidi, each object parser needs to accept the hint
component.  Now a new local function _snd_conf_generic_id() was
introduced to replace each call of "comment" and "type" field checks.

Also, the two existing identical functions for pcm and rawmidi are
removed and the new function is used commonly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/local.h             |  2 ++
 src/confmisc.c              | 13 +++++++++++++
 src/control/control_hw.c    |  4 +---
 src/control/control_shm.c   |  7 ++-----
 src/hwdep/hwdep_hw.c        |  4 +---
 src/pcm/pcm.c               | 12 ------------
 src/pcm/pcm_local.h         |  5 ++---
 src/rawmidi/rawmidi.c       | 18 ------------------
 src/rawmidi/rawmidi_local.h |  2 +-
 src/seq/seq_hw.c            |  4 +---
 src/timer/timer_hw.c        |  4 +---
 src/timer/timer_query_hw.c  |  4 +---
 12 files changed, 25 insertions(+), 54 deletions(-)

diff --git a/include/local.h b/include/local.h
index 2fe9a273f0b0..660081638a1c 100644
--- a/include/local.h
+++ b/include/local.h
@@ -348,4 +348,6 @@ int snd_config_search_alias_hooks(snd_config_t *config,
                                   const char *base, const char *key,
 				  snd_config_t **result);
 
+int _snd_conf_generic_id(const char *id);
+
 #endif
diff --git a/src/confmisc.c b/src/confmisc.c
index af686bea323c..1fb4f282217e 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -1302,3 +1302,16 @@ int snd_func_refer(snd_config_t **dst, snd_config_t *root, snd_config_t *src,
 #ifndef DOC_HIDDEN
 SND_DLSYM_BUILD_VERSION(snd_func_refer, SND_CONFIG_DLSYM_VERSION_EVALUATE);
 #endif
+
+#ifndef DOC_HIDDEN
+int _snd_conf_generic_id(const char *id)
+{
+	static const char ids[3][8] = { "comment", "type", "hint" };
+	unsigned int k;
+	for (k = 0; k < sizeof(ids) / sizeof(ids[0]); ++k) {
+		if (strcmp(id, ids[k]) == 0)
+			return 1;
+	}
+	return 0;
+}
+#endif
diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index dfc9dcd51e20..7d23151c7d75 100644
--- a/src/control/control_hw.c
+++ b/src/control/control_hw.c
@@ -446,9 +446,7 @@ int _snd_ctl_hw_open(snd_ctl_t **handlep, char *name, snd_config_t *root ATTRIBU
 		const char *id;
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
-		if (strcmp(id, "comment") == 0)
-			continue;
-		if (strcmp(id, "type") == 0)
+		if (_snd_conf_generic_id(id))
 			continue;
 		if (strcmp(id, "card") == 0) {
 			err = snd_config_get_integer(n, &card);
diff --git a/src/control/control_shm.c b/src/control/control_shm.c
index 40bc705d8036..bd07d4af503a 100644
--- a/src/control/control_shm.c
+++ b/src/control/control_shm.c
@@ -551,10 +551,7 @@ int _snd_ctl_shm_open(snd_ctl_t **handlep, char *name, snd_config_t *root, snd_c
 		const char *id;
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
-		if (strcmp(id, "comment") == 0)
-			continue;
-		if (strcmp(id, "type") == 0)
-			continue;
+		if (_snd_conf_generic_id(id))
 		if (strcmp(id, "server") == 0) {
 			err = snd_config_get_string(n, &server);
 			if (err < 0) {
@@ -597,7 +594,7 @@ int _snd_ctl_shm_open(snd_ctl_t **handlep, char *name, snd_config_t *root, snd_c
 		const char *id;
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
-		if (strcmp(id, "comment") == 0)
+		if (_snd_conf_generic_id(id))
 			continue;
 		if (strcmp(id, "host") == 0)
 			continue;
diff --git a/src/hwdep/hwdep_hw.c b/src/hwdep/hwdep_hw.c
index 4314e32bade6..12528c55bac7 100644
--- a/src/hwdep/hwdep_hw.c
+++ b/src/hwdep/hwdep_hw.c
@@ -158,9 +158,7 @@ int _snd_hwdep_hw_open(snd_hwdep_t **hwdep, char *name,
 		const char *id;
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
-		if (strcmp(id, "comment") == 0)
-			continue;
-		if (strcmp(id, "type") == 0)
+		if (_snd_conf_generic_id(id))
 			continue;
 		if (strcmp(id, "card") == 0) {
 			err = snd_config_get_integer(n, &card);
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index e74e02fc568f..bc18954b92da 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -7059,18 +7059,6 @@ int snd_pcm_slave_conf(snd_config_t *root, snd_config_t *conf,
 	return err;
 }
 		
-
-int snd_pcm_conf_generic_id(const char *id)
-{
-	static const char ids[3][8] = { "comment", "type", "hint" };
-	unsigned int k;
-	for (k = 0; k < sizeof(ids) / sizeof(ids[0]); ++k) {
-		if (strcmp(id, ids[k]) == 0)
-			return 1;
-	}
-	return 0;
-}
-
 static void snd_pcm_set_ptr(snd_pcm_t *pcm, snd_pcm_rbptr_t *rbptr,
 			    volatile snd_pcm_uframes_t *hw_ptr, int fd, off_t offset)
 {
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 394505f978ac..326618ecd0c0 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -262,8 +262,6 @@ struct _snd_pcm {
 	snd1_pcm_areas_from_bufs
 #define snd_pcm_open_named_slave \
 	snd1_pcm_open_named_slave
-#define snd_pcm_conf_generic_id \
-	snd1_pcm_conf_generic_id
 #define snd_pcm_hw_open_fd \
 	snd1_pcm_hw_open_fd
 #define snd_pcm_wait_nocheck \
@@ -882,7 +880,8 @@ snd_pcm_open_slave(snd_pcm_t **pcmp, snd_config_t *root,
 	return snd_pcm_open_named_slave(pcmp, NULL, root, conf, stream,
 					mode, parent_conf);
 }
-int snd_pcm_conf_generic_id(const char *id);
+
+#define snd_pcm_conf_generic_id(id) _snd_conf_generic_id(id)
 
 int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd, int mmap_emulation, int sync_ptr_ioctl);
 int __snd_pcm_mmap_emul_open(snd_pcm_t **pcmp, const char *name,
diff --git a/src/rawmidi/rawmidi.c b/src/rawmidi/rawmidi.c
index ac699b439b11..0c89b8b984b9 100644
--- a/src/rawmidi/rawmidi.c
+++ b/src/rawmidi/rawmidi.c
@@ -990,21 +990,3 @@ ssize_t snd_rawmidi_read(snd_rawmidi_t *rawmidi, void *buffer, size_t size)
 	assert(buffer || size == 0);
 	return (rawmidi->ops->read)(rawmidi, buffer, size);
 }
-
-#ifndef DOC_HIDDEN
-int snd_rawmidi_conf_generic_id(const char *id)
-{
-	static const char ids[][8] = {
-		"comment",
-		"type",
-		"hint",
-	};
-	unsigned int k;
-
-	for (k = 0; k < sizeof ids / sizeof *ids; ++k) {
-		if (strcmp(id, ids[k]) == 0)
-			return 1;
-	}
-	return 0;
-}
-#endif
diff --git a/src/rawmidi/rawmidi_local.h b/src/rawmidi/rawmidi_local.h
index 3388502cece0..8992771eb5d3 100644
--- a/src/rawmidi/rawmidi_local.h
+++ b/src/rawmidi/rawmidi_local.h
@@ -58,4 +58,4 @@ int snd_rawmidi_virtual_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
 			     const char *name, snd_seq_t *seq_handle, int port,
 			     int merge, int mode);
 
-int snd_rawmidi_conf_generic_id(const char *id);
+#define snd_rawmidi_conf_generic_id(id)	_snd_conf_generic_id(id)
diff --git a/src/seq/seq_hw.c b/src/seq/seq_hw.c
index 6cb31d6f4c25..d03336738944 100644
--- a/src/seq/seq_hw.c
+++ b/src/seq/seq_hw.c
@@ -546,9 +546,7 @@ int _snd_seq_hw_open(snd_seq_t **handlep, char *name,
 		const char *id;
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
-		if (strcmp(id, "comment") == 0)
-			continue;
-		if (strcmp(id, "type") == 0)
+		if (_snd_conf_generic_id(id))
 			continue;
 		return -EINVAL;
 	}
diff --git a/src/timer/timer_hw.c b/src/timer/timer_hw.c
index aa6a0b1b42f1..e833fc8cbb41 100644
--- a/src/timer/timer_hw.c
+++ b/src/timer/timer_hw.c
@@ -299,9 +299,7 @@ int _snd_timer_hw_open(snd_timer_t **timer, char *name,
 		const char *id;
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
-		if (strcmp(id, "comment") == 0)
-			continue;
-		if (strcmp(id, "type") == 0)
+		if (_snd_conf_generic_id(id))
 			continue;
 		if (strcmp(id, "class") == 0) {
 			err = snd_config_get_integer(n, &dev_class);
diff --git a/src/timer/timer_query_hw.c b/src/timer/timer_query_hw.c
index 9f62b78aeb2e..289ca52f2afa 100644
--- a/src/timer/timer_query_hw.c
+++ b/src/timer/timer_query_hw.c
@@ -134,9 +134,7 @@ int _snd_timer_query_hw_open(snd_timer_query_t **timer, char *name,
 		const char *id;
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
-		if (strcmp(id, "comment") == 0)
-			continue;
-		if (strcmp(id, "type") == 0)
+		if (_snd_conf_generic_id(id))
 			continue;
 		SNDERR("Unexpected field %s", id);
 		return -EINVAL;
-- 
2.3.6
