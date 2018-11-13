From: <twischer@de.adit-jv.com>
Subject: [PATCH - dmix v5 1/1] pcm: dmix: Add option to allow
	alignment of slave pointers
Date: Tue, 13 Nov 2018 08:43:00 +0100
Message-ID: <1542094980-9389-2-git-send-email-twischer@de.adit-jv.com>
References: <1542094980-9389-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1542094980-9389-1-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org, tiwai@suse.de
Cc: Laxmi Devi <Laxmi.Devi@in.bosch.com>, alsa-devel@alsa-project.org, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Laxmi Devi <Laxmi.Devi@in.bosch.com>

These changes are required due to the kernel
commit 07b7acb51d283d8469696c906b91f1882696a4d4
("ASoC: rsnd: update pointer more accurate")

Issue is that snd_pcm_wait() goes back to waiting because the hw_ptr
is not period aligned. Therefore snd_pcm_wait() will block for a longer
time as required.

With these rcar driver changes the exact position of the dma is returned.
During snd_pcm_start they read hw_ptr as reference, and this hw_ptr
is now not period aligned, and is a little ahead over the period while it
is read. Therefore when the avail is calculated during snd_pcm_wait(),
it is missing the avail_min by a few frames.

An additional option hw_ptr_alignment is provided to dmix configuration,
to allow the user to configure the slave application and hw pointer
alignment at startup


Signed-off-by: Laxmi Devi <Laxmi.Devi@in.bosch.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 091fd78..a264197 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1883,6 +1883,7 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 	rec->max_periods = 0;
 	rec->var_periodsize = 0;
 	rec->direct_memory_access = 1;
+	rec->hw_ptr_alignment = SND_PCM_HW_PTR_ALIGNMENT_AUTO;
 
 	/* read defaults */
 	if (snd_config_search(root, "defaults.pcm.dmix_max_periods", &n) >= 0) {
@@ -1924,6 +1925,28 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 			rec->ipc_perm = perm;
 			continue;
 		}
+		if (strcmp(id, "hw_ptr_alignment") == 0) {
+			const char *str;
+			err = snd_config_get_string(n, &str);
+			if (err < 0) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+			if (strcmp(str, "no") == 0)
+				rec->hw_ptr_alignment = SND_PCM_HW_PTR_ALIGNMENT_NO;
+			else if (strcmp(str, "roundup") == 0)
+				rec->hw_ptr_alignment = SND_PCM_HW_PTR_ALIGNMENT_ROUNDUP;
+			else if (strcmp(str, "rounddown") == 0)
+				rec->hw_ptr_alignment = SND_PCM_HW_PTR_ALIGNMENT_ROUNDDOWN;
+			else if (strcmp(str, "auto") == 0)
+				rec->hw_ptr_alignment = SND_PCM_HW_PTR_ALIGNMENT_AUTO;
+			else {
+				SNDERR("The field hw_ptr_alignment is invalid : %s", str);
+				return -EINVAL;
+			}
+
+			continue;
+		}
 		if (strcmp(id, "ipc_gid") == 0) {
 			char *group;
 			char *endp;
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index 582f055..a487616 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -49,6 +49,13 @@ typedef void (mix_areas_u8_t)(unsigned int size,
 			      volatile signed int *sum, size_t dst_step,
 			      size_t src_step, size_t sum_step);
 
+typedef enum snd_pcm_direct_hw_ptr_alignment {
+	SND_PCM_HW_PTR_ALIGNMENT_NO = 0,	/* use the hw_ptr as is and do no rounding */
+	SND_PCM_HW_PTR_ALIGNMENT_ROUNDUP = 1,	/* round the slave_appl_ptr up to slave_period */
+	SND_PCM_HW_PTR_ALIGNMENT_ROUNDDOWN = 2,	/* round slave_hw_ptr and slave_appl_ptr down to slave_period */
+	SND_PCM_HW_PTR_ALIGNMENT_AUTO = 3	/* automatic selection */
+} snd_pcm_direct_hw_ptr_alignment_t;
+
 struct slave_params {
 	snd_pcm_format_t format;
 	int rate;
@@ -159,6 +166,7 @@ struct snd_pcm_direct {
 	unsigned int *bindings;
 	unsigned int recoveries;	/* mirror of executed recoveries on slave */
 	int direct_memory_access;	/* use arch-optimized buffer RW */
+	snd_pcm_direct_hw_ptr_alignment_t hw_ptr_alignment;
 	union {
 		struct {
 			int shmid_sum;			/* IPC global sum ring buffer memory identification */
@@ -341,6 +349,7 @@ struct snd_pcm_direct_open_conf {
 	int max_periods;
 	int var_periodsize;
 	int direct_memory_access;
+	snd_pcm_direct_hw_ptr_alignment_t hw_ptr_alignment;
 	snd_config_t *slave;
 	snd_config_t *bindings;
 };
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 881154e..567aad3 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -55,6 +55,9 @@ const char *_snd_module_pcm_dmix = "";
 #define STATE_RUN_PENDING	1024
 #endif
 
+#define SEC_TO_MS	1000			/* Seconds representing in Milli seconds */
+#define LOW_LATENCY_PERIOD_TIME	10	/* slave_period time for low latency requirements in ms */
+
 /*
  *
  */
@@ -560,14 +563,17 @@ static int snd_pcm_dmix_hwsync(snd_pcm_t *pcm)
 static void reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
 {
 	dmix->slave_appl_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
-	if (pcm->buffer_size > pcm->period_size * 2)
-		return;
-	/* If we have too litte periods, better to align the start position
-	 * to the period boundary so that the interrupt can be handled properly
-	 * at the right time.
-	 */
-	dmix->slave_appl_ptr = ((dmix->slave_appl_ptr + dmix->slave_period_size - 1)
+
+	if (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_ROUNDUP ||
+			(dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_AUTO &&
+			pcm->buffer_size <= pcm->period_size * 2))
+		dmix->slave_appl_ptr = ((dmix->slave_appl_ptr + dmix->slave_period_size - 1)
 				/ dmix->slave_period_size) * dmix->slave_period_size;
+	else if (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_ROUNDDOWN ||
+			(dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_AUTO &&
+			(((dmix->slave_period_size * SEC_TO_MS) / pcm->rate) < LOW_LATENCY_PERIOD_TIME)))
+		dmix->slave_appl_ptr = dmix->slave_hw_ptr = ((dmix->slave_hw_ptr
+				/ dmix->slave_period_size) * dmix->slave_period_size);
 }
 
 static int snd_pcm_dmix_reset(snd_pcm_t *pcm)
@@ -1086,6 +1092,7 @@ int snd_pcm_dmix_open(snd_pcm_t **pcmp, const char *name,
 	dmix->slowptr = opts->slowptr;
 	dmix->max_periods = opts->max_periods;
 	dmix->var_periodsize = opts->var_periodsize;
+	dmix->hw_ptr_alignment = opts->hw_ptr_alignment;
 	dmix->sync_ptr = snd_pcm_dmix_sync_ptr;
 	dmix->direct_memory_access = opts->direct_memory_access;
 
@@ -1241,6 +1248,12 @@ pcm.name {
 	ipc_key INT		# unique IPC key
 	ipc_key_add_uid BOOL	# add current uid to unique IPC key
 	ipc_perm INT		# IPC permissions (octal, default 0600)
+	hw_ptr_alignment STR	# Slave application and hw pointer alignment type
+						# STR can be one of the below strings :
+						# no
+						# roundup
+						# rounddown
+						# auto (default)
 	slave STR
 	# or
 	slave {			# Slave definition
@@ -1273,6 +1286,24 @@ added to the value set in <code>ipc_key</code>.  This will
 avoid the confliction of the same IPC key with different users
 concurrently.
 
+<code>hw_ptr_alignment</code> specifies slave application and hw pointer alignment
+type. By default hw_ptr_alignment is auto. Below are the possible configurations :
+- no : minimal latency with minimal frames dropped at startup. But wakeup of
+	application (return from snd_pcm_wait() or poll()) can take up to 2 * period.
+- roundup : It is guaranteed that all frames will be played at startup. But the
+	latency will increase upto period-1 frames.
+- rounddown : It is guaranteed that a wakeup will happen for each period and
+	frames can be written from application. But on startup upto period-1 frames
+	will be dropped.
+- auto : Selects the best approach depending on the used period and buffer size.
+	If the application buffer size is < 2 * application period, "roundup"
+	will be selected to avoid under runs. If the slave_period is < 10ms we
+	could expect that there are low latency requirements. Therefore "rounddown"
+	will be chosen to avoid long wakeup times. Such wakeup delay could otherwise
+	end up with Xruns in case of a dependency to another sound device
+	(e.g. forwarding of microphone to speaker). Else "no"
+	will be chosen.
+
 Note that the dmix plugin itself supports only a single configuration.
 That is, it supports only the fixed rate (default 48000), format
 (\c S16), channels (2), and period_time (125000).
-- 
2.7.4
