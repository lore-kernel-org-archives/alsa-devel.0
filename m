From: <vanitha.channaiah@in.bosch.com>
Subject: [PATCH 1/5] pcm: direct: Add generic hw_ptr_alignment
	function for dmix, dshare and dsnoop
Date: Tue, 30 Apr 2019 13:08:39 +0530
Message-ID: <1556609923-14093-1-git-send-email-vanitha.channaiah@in.bosch.com>
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
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org, Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
List-Id: alsa-devel@alsa-project.org

From: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>

This patch is same as the fix in below commit
commit 6b058fda9dce ("pcm: dmix: Add option to allow alignment of slave
pointers")

Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
---
 src/pcm/pcm_direct.c | 19 +++++++++++++++++++
 src/pcm/pcm_direct.h |  8 ++++++++
 src/pcm/pcm_dmix.c   | 25 ++-----------------------
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 666a8ce..411a035 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -2040,3 +2040,22 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 
 	return 0;
 }
+
+void snd_pcm_direct_reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
+{
+	dmix->slave_appl_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
+
+	if (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_ROUNDUP ||
+		(dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_AUTO &&
+		pcm->buffer_size <= pcm->period_size * 2))
+		dmix->slave_appl_ptr =
+			((dmix->slave_appl_ptr + dmix->slave_period_size - 1) /
+			dmix->slave_period_size) * dmix->slave_period_size;
+	else if (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_ROUNDDOWN ||
+		(dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_AUTO &&
+		(dmix->slave_period_size * SEC_TO_MS) /
+		pcm->rate < LOW_LATENCY_PERIOD_TIME))
+		dmix->slave_appl_ptr = dmix->slave_hw_ptr =
+			((dmix->slave_hw_ptr / dmix->slave_period_size) *
+			dmix->slave_period_size);
+}
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index da5e280..a71aab1 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -24,6 +24,11 @@
 
 #define DIRECT_IPC_SEMS         1
 #define DIRECT_IPC_SEM_CLIENT   0
+/* Seconds representing in Milli seconds */
+#define SEC_TO_MS               1000
+/* slave_period time for low latency requirements in ms */
+#define LOW_LATENCY_PERIOD_TIME 10
+
 
 typedef void (mix_areas_t)(unsigned int size,
 			   volatile void *dst, void *src,
@@ -257,6 +262,8 @@ struct snd_pcm_direct {
 	snd1_pcm_direct_get_chmap
 #define snd_pcm_direct_set_chmap \
 	snd1_pcm_direct_set_chmap
+#define snd_pcm_direct_reset_slave_ptr \
+	snd1_pcm_direct_reset_slave_ptr
 
 int snd_pcm_direct_semaphore_create_or_connect(snd_pcm_direct_t *dmix);
 
@@ -341,6 +348,7 @@ int snd_pcm_direct_slave_recover(snd_pcm_direct_t *direct);
 int snd_pcm_direct_client_chk_xrun(snd_pcm_direct_t *direct, snd_pcm_t *pcm);
 int snd_timer_async(snd_timer_t *timer, int sig, pid_t pid);
 struct timespec snd_pcm_hw_fast_tstamp(snd_pcm_t *pcm);
+void snd_pcm_direct_reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t *dmix);
 
 struct snd_pcm_direct_open_conf {
 	key_t ipc_key;
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index c5592cd..dcde40d 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -55,9 +55,6 @@ const char *_snd_module_pcm_dmix = "";
 #define STATE_RUN_PENDING	1024
 #endif
 
-#define SEC_TO_MS	1000			/* Seconds representing in Milli seconds */
-#define LOW_LATENCY_PERIOD_TIME	10	/* slave_period time for low latency requirements in ms */
-
 /*
  *
  */
@@ -560,30 +557,12 @@ static int snd_pcm_dmix_hwsync(snd_pcm_t *pcm)
 	}
 }
 
-static void reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
-{
-	dmix->slave_appl_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
-
-	if (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_ROUNDUP ||
-	    (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_AUTO &&
-	     pcm->buffer_size <= pcm->period_size * 2))
-		dmix->slave_appl_ptr =
-			((dmix->slave_appl_ptr + dmix->slave_period_size - 1)
-			 / dmix->slave_period_size) * dmix->slave_period_size;
-	else if (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_ROUNDDOWN ||
-		 (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_AUTO &&
-		  (dmix->slave_period_size * SEC_TO_MS) / pcm->rate < LOW_LATENCY_PERIOD_TIME))
-		dmix->slave_appl_ptr = dmix->slave_hw_ptr =
-			((dmix->slave_hw_ptr / dmix->slave_period_size) *
-			 dmix->slave_period_size);
-}
-
 static int snd_pcm_dmix_reset(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
 	dmix->hw_ptr %= pcm->period_size;
 	dmix->appl_ptr = dmix->last_appl_ptr = dmix->hw_ptr;
-	reset_slave_ptr(pcm, dmix);
+	snd_pcm_direct_reset_slave_ptr(pcm, dmix);
 	return 0;
 }
 
@@ -592,7 +571,7 @@ static int snd_pcm_dmix_start_timer(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
 	int err;
 
 	snd_pcm_hwsync(dmix->spcm);
-	reset_slave_ptr(pcm, dmix);
+	snd_pcm_direct_reset_slave_ptr(pcm, dmix);
 	err = snd_timer_start(dmix->timer);
 	if (err < 0)
 		return err;
-- 
2.7.4
