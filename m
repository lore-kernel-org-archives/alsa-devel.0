From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH - alsa-lib 3/4] pcm: add mmap_begin callback to
	snd_pcm_fast_ops_t api
Date: Tue, 21 May 2019 15:33:29 +0200
Message-ID: <1558445609-11567-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

main motivation for adding the callback is to use it to enable operation
on mmaped buffer before user access for pcm_file plugin

support for MMAP read access with masking by data from input file is not
implemented for pcm_file plugin, by adding this callback implementing
such feature can be done by rewriting next continuous portion of buffer
on each mmap_begin call

plugins like softvol use pcm_plugin interface and overwrite the buffer by
looping around it in avail_update callback, this patch hopes to simplify
the task by adding new api callback, removing the need for rewriting
pcm_file (to use pcm_plugin callbacks) and careful checking when looping
around whole mmaped buffer

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 3a71d79..323926e 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -7129,7 +7129,13 @@ int __snd_pcm_mmap_begin(snd_pcm_t *pcm, const snd_pcm_channel_area_t **areas,
 	snd_pcm_uframes_t f;
 	snd_pcm_uframes_t avail;
 	const snd_pcm_channel_area_t *xareas;
+
 	assert(pcm && areas && offset && frames);
+
+	if (pcm->fast_ops->mmap_begin)
+		return pcm->fast_ops->mmap_begin(pcm->fast_op_arg, areas, offset, frames);
+
+	/* fallback for plugins that do not specify new callback */
 	xareas = snd_pcm_mmap_areas(pcm);
 	if (xareas == NULL)
 		return -EBADFD;
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 274726e..96049e0 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -990,6 +990,7 @@ static const snd_pcm_fast_ops_t snd_pcm_dmix_fast_ops = {
 	.poll_descriptors = snd_pcm_direct_poll_descriptors,
 	.poll_descriptors_count = NULL,
 	.poll_revents = snd_pcm_dmix_poll_revents,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index b75809c..328ef83 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -667,6 +667,7 @@ static const snd_pcm_fast_ops_t snd_pcm_dshare_fast_ops = {
 	.poll_descriptors = snd_pcm_direct_poll_descriptors,
 	.poll_descriptors_count = NULL,
 	.poll_revents = snd_pcm_direct_poll_revents,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 58b1e53..5b9d9f5 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -544,6 +544,7 @@ static const snd_pcm_fast_ops_t snd_pcm_dsnoop_fast_ops = {
 	.poll_descriptors = snd_pcm_direct_poll_descriptors,
 	.poll_descriptors_count = NULL,
 	.poll_revents = snd_pcm_direct_poll_revents,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index dcaa41d..10d227b 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -773,6 +773,7 @@ static const snd_pcm_fast_ops_t snd_pcm_file_fast_ops = {
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_generic_poll_revents,
 	.htimestamp = snd_pcm_generic_htimestamp,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_generic.h b/src/pcm/pcm_generic.h
index dfbe21a..683e60b 100644
--- a/src/pcm/pcm_generic.h
+++ b/src/pcm/pcm_generic.h
@@ -161,4 +161,3 @@ snd_pcm_chmap_query_t **snd_pcm_generic_query_chmaps(snd_pcm_t *pcm);
 snd_pcm_chmap_t *snd_pcm_generic_get_chmap(snd_pcm_t *pcm);
 int snd_pcm_generic_set_chmap(snd_pcm_t *pcm, const snd_pcm_chmap_t *map);
 int snd_pcm_generic_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail);
-
diff --git a/src/pcm/pcm_hooks.c b/src/pcm/pcm_hooks.c
index 4416d36..14396fa 100644
--- a/src/pcm/pcm_hooks.c
+++ b/src/pcm/pcm_hooks.c
@@ -200,6 +200,7 @@ static const snd_pcm_fast_ops_t snd_pcm_hooks_fast_ops = {
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_generic_poll_revents,
 	.may_wait_for_avail_min = snd_pcm_generic_may_wait_for_avail_min,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 91370a8..8ee1d69 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1481,6 +1481,7 @@ static const snd_pcm_fast_ops_t snd_pcm_hw_fast_ops = {
 	.poll_descriptors = NULL,
 	.poll_descriptors_count = NULL,
 	.poll_revents = NULL,
+	.mmap_begin = NULL,
 };
 
 static const snd_pcm_fast_ops_t snd_pcm_hw_fast_ops_timer = {
@@ -1512,6 +1513,7 @@ static const snd_pcm_fast_ops_t snd_pcm_hw_fast_ops_timer = {
 	.poll_descriptors = snd_pcm_hw_poll_descriptors,
 	.poll_descriptors_count = snd_pcm_hw_poll_descriptors_count,
 	.poll_revents = snd_pcm_hw_poll_revents,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index a437ca3..3e19499 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -940,6 +940,7 @@ static const snd_pcm_fast_ops_t snd_pcm_ioplug_fast_ops = {
 	.poll_descriptors_count = snd_pcm_ioplug_poll_descriptors_count,
 	.poll_descriptors = snd_pcm_ioplug_poll_descriptors,
 	.poll_revents = snd_pcm_ioplug_poll_revents,
+	.mmap_begin = NULL,
 };
 
 #endif /* !DOC_HIDDEN */
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index d52229d..d5726eb 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -184,6 +184,7 @@ typedef struct {
 	int (*poll_descriptors)(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space); /* locked */
 	int (*poll_revents)(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents); /* locked */
 	int (*may_wait_for_avail_min)(snd_pcm_t *pcm, snd_pcm_uframes_t avail);
+	int (*mmap_begin)(snd_pcm_t *pcm, const snd_pcm_channel_area_t **areas, snd_pcm_uframes_t *offset, snd_pcm_uframes_t *frames); /* locked */
 } snd_pcm_fast_ops_t;
 
 struct _snd_pcm {
diff --git a/src/pcm/pcm_meter.c b/src/pcm/pcm_meter.c
index 20b4187..28bb578 100644
--- a/src/pcm/pcm_meter.c
+++ b/src/pcm/pcm_meter.c
@@ -548,6 +548,7 @@ static const snd_pcm_fast_ops_t snd_pcm_meter_fast_ops = {
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_generic_poll_revents,
 	.may_wait_for_avail_min = snd_pcm_generic_may_wait_for_avail_min,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_mmap_emul.c b/src/pcm/pcm_mmap_emul.c
index 009cebb..6fa5fe6 100644
--- a/src/pcm/pcm_mmap_emul.c
+++ b/src/pcm/pcm_mmap_emul.c
@@ -401,6 +401,7 @@ static const snd_pcm_fast_ops_t snd_pcm_mmap_emul_fast_ops = {
 	.poll_descriptors_count = snd_pcm_generic_poll_descriptors_count,
 	.poll_revents = snd_pcm_generic_poll_revents,
 	.may_wait_for_avail_min = snd_pcm_generic_may_wait_for_avail_min,
+	.mmap_begin = NULL,
 };
 
 #ifndef DOC_HIDDEN
diff --git a/src/pcm/pcm_multi.c b/src/pcm/pcm_multi.c
index 53c414d..069d224 100644
--- a/src/pcm/pcm_multi.c
+++ b/src/pcm/pcm_multi.c
@@ -1042,6 +1042,7 @@ static const snd_pcm_fast_ops_t snd_pcm_multi_fast_ops = {
 	.poll_descriptors = snd_pcm_multi_poll_descriptors,
 	.poll_revents = snd_pcm_multi_poll_revents,
 	.may_wait_for_avail_min = snd_pcm_multi_may_wait_for_avail_min,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_null.c b/src/pcm/pcm_null.c
index 1d81548..e6fa049 100644
--- a/src/pcm/pcm_null.c
+++ b/src/pcm/pcm_null.c
@@ -361,6 +361,7 @@ static const snd_pcm_fast_ops_t snd_pcm_null_fast_ops = {
 	.avail_update = snd_pcm_null_avail_update,
 	.mmap_commit = snd_pcm_null_mmap_commit,
 	.htimestamp = snd_pcm_generic_real_htimestamp,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index ea60eb9..0714d2c 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -646,6 +646,7 @@ const snd_pcm_fast_ops_t snd_pcm_plugin_fast_ops = {
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_generic_poll_revents,
 	.may_wait_for_avail_min = snd_pcm_plugin_may_wait_for_avail_min,
+	.mmap_begin = NULL,
 };
 
 #endif
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 5dc8a92..f29739b 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1217,6 +1217,7 @@ static const snd_pcm_fast_ops_t snd_pcm_rate_fast_ops = {
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_rate_poll_revents,
 	.may_wait_for_avail_min = snd_pcm_plugin_may_wait_for_avail_min,
+	.mmap_begin = NULL,
 };
 
 static const snd_pcm_ops_t snd_pcm_rate_ops = {
diff --git a/src/pcm/pcm_share.c b/src/pcm/pcm_share.c
index 5a540c4..b803a82 100644
--- a/src/pcm/pcm_share.c
+++ b/src/pcm/pcm_share.c
@@ -1346,6 +1346,7 @@ static const snd_pcm_fast_ops_t snd_pcm_share_fast_ops = {
 	.avail_update = snd_pcm_share_avail_update,
 	.htimestamp = snd_pcm_share_htimestamp,
 	.mmap_commit = snd_pcm_share_mmap_commit,
+	.mmap_begin = NULL,
 };
 
 /**
diff --git a/src/pcm/pcm_shm.c b/src/pcm/pcm_shm.c
index 26a27a5..a18720f 100644
--- a/src/pcm/pcm_shm.c
+++ b/src/pcm/pcm_shm.c
@@ -629,6 +629,7 @@ static const snd_pcm_fast_ops_t snd_pcm_shm_fast_ops = {
 	.avail_update = snd_pcm_shm_avail_update,
 	.mmap_commit = snd_pcm_shm_mmap_commit,
 	.htimestamp = snd_pcm_shm_htimestamp,
+	.mmap_begin = NULL,
 };
 
 static int make_local_socket(const char *filename)
-- 
2.7.4
