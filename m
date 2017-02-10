From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: dmix: Allow disabling x86 optimizations
Date: Fri, 10 Feb 2017 12:27:52 +0100
Message-ID: <20170210112752.12864-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 394AB26683E
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 12:27:55 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D24F4AD78
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 11:27:54 +0000 (UTC)
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

The dmix plugin has some optimized implementations for x86 using the
direct memory accesses, which was rather the original version, in
addition to the "generic" implementation using the semaphore
blocking.  The x86 implementation relies on the memory coherency *and*
the fast read/write on it.

For other architectures, this has been always disabled just because of
memory coherency.  But, the recent LPE audio development revealed
that, even on x86 platforms, the read/write performance might become
extremely bad when the buffer is marked as uncached.  Some drivers
already know the buffer is uncached, we need to switch to the generic
mode in such a case.

This patch introduces yet another flag to dmix configuration,
direct_memory_access, that indicates whether the x86-specific
optimization can be used or not.  Each driver can set the flag in its
cards config namespace, and the default dmix config refers to it.

As of this patch, only HDMI LPE Audio driver sets it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/conf/cards/HdmiLpeAudio.conf |  3 +++
 src/conf/pcm/dmix.conf           | 15 +++++++++++++++
 src/pcm/pcm_direct.c             |  8 ++++++++
 src/pcm/pcm_direct.h             |  2 ++
 src/pcm/pcm_dmix.c               |  1 +
 src/pcm/pcm_dmix_i386.c          |  5 +++++
 src/pcm/pcm_dmix_x86_64.c        |  5 +++++
 7 files changed, 39 insertions(+)

diff --git a/src/conf/cards/HdmiLpeAudio.conf b/src/conf/cards/HdmiLpeAudio.conf
index f5836c05219e..61bdfeae2917 100644
--- a/src/conf/cards/HdmiLpeAudio.conf
+++ b/src/conf/cards/HdmiLpeAudio.conf
@@ -20,6 +20,9 @@ HdmiLpeAudio.pcm.front.0 {
 	}
 }
 
+# uncached memory reads have a high penalty
+HdmiLpeAudio.dmix.direct_memory_access false
+
 # default with dmix+softvol
 HdmiLpeAudio.pcm.default {
 	@args [ CARD ]
diff --git a/src/conf/pcm/dmix.conf b/src/conf/pcm/dmix.conf
index 7d0aa0158c42..2d3b329e533a 100644
--- a/src/conf/pcm/dmix.conf
+++ b/src/conf/pcm/dmix.conf
@@ -49,6 +49,21 @@ pcm.!dmix {
 		@func refer
 		name defaults.pcm.ipc_perm
 	}
+	direct_memory_access {
+		@func refer
+		name {
+			@func concat
+			strings [
+				"cards."
+				{
+					@func card_driver
+					card $CARD
+				}
+				".dmix.direct_memory_access"
+			]
+		}
+		default true
+	}
 	slave {
 		pcm {
 			type hw
diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index e4bef7860d01..364191b20bab 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1861,6 +1861,7 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 	rec->slowptr = 1;
 	rec->max_periods = 0;
 	rec->var_periodsize = 1;
+	rec->direct_memory_access = 1;
 
 	/* read defaults */
 	if (snd_config_search(root, "defaults.pcm.dmix_max_periods", &n) >= 0) {
@@ -1974,6 +1975,13 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 			rec->var_periodsize = err;
 			continue;
 		}
+		if (strcmp(id, "direct_memory_access") == 0) {
+			err = snd_config_get_bool(n);
+			if (err < 0)
+				return err;
+			rec->direct_memory_access = err;
+			continue;
+		}
 		SNDERR("Unknown field %s", id);
 		return -EINVAL;
 	}
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index 66107ec07477..fba55fdcb5b3 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -159,6 +159,7 @@ struct snd_pcm_direct {
 	unsigned int channels;		/* client's channels */
 	unsigned int *bindings;
 	unsigned int recoveries;	/* mirror of executed recoveries on slave */
+	int direct_memory_access;	/* use arch-optimized buffer RW */
 	union {
 		struct {
 			int shmid_sum;			/* IPC global sum ring buffer memory identification */
@@ -340,6 +341,7 @@ struct snd_pcm_direct_open_conf {
 	int slowptr;
 	int max_periods;
 	int var_periodsize;
+	int direct_memory_access;
 	snd_config_t *slave;
 	snd_config_t *bindings;
 };
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 2ef61599f4b0..dd0356e9114d 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -1065,6 +1065,7 @@ int snd_pcm_dmix_open(snd_pcm_t **pcmp, const char *name,
 	dmix->max_periods = opts->max_periods;
 	dmix->var_periodsize = opts->var_periodsize;
 	dmix->sync_ptr = snd_pcm_dmix_sync_ptr;
+	dmix->direct_memory_access = opts->direct_memory_access;
 
  retry:
 	if (first_instance) {
diff --git a/src/pcm/pcm_dmix_i386.c b/src/pcm/pcm_dmix_i386.c
index dcc6b9a4222e..1ab983a8a373 100644
--- a/src/pcm/pcm_dmix_i386.c
+++ b/src/pcm/pcm_dmix_i386.c
@@ -87,6 +87,11 @@ static void mix_select_callbacks(snd_pcm_direct_t *dmix)
 {
 	static int smp = 0, mmx = 0, cmov = 0;
 
+	if (!dmix->direct_memory_access) {
+		generic_mix_select_callbacks(dmix);
+		return;
+	}
+
 	if (!((1ULL<< dmix->shmptr->s.format) & i386_dmix_supported_format)) {
 		generic_mix_select_callbacks(dmix);
 		return;
diff --git a/src/pcm/pcm_dmix_x86_64.c b/src/pcm/pcm_dmix_x86_64.c
index 831046d909a4..34c40d4e9d1d 100644
--- a/src/pcm/pcm_dmix_x86_64.c
+++ b/src/pcm/pcm_dmix_x86_64.c
@@ -70,6 +70,11 @@ static void mix_select_callbacks(snd_pcm_direct_t *dmix)
 {
 	static int smp = 0;
 	
+	if (!dmix->direct_memory_access) {
+		generic_mix_select_callbacks(dmix);
+		return;
+	}
+
 	if (!((1ULL<< dmix->shmptr->s.format) & x86_64_dmix_supported_format)) {
 		generic_mix_select_callbacks(dmix);
 		return;
-- 
2.11.0
