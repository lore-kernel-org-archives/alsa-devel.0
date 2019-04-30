From: <vanitha.channaiah@in.bosch.com>
Subject: [PATCH 5/5] pcm: Update pcm->avail_min with
	needed_slave_avail_min, after reading unaligned frames
Date: Tue, 30 Apr 2019 13:08:43 +0530
Message-ID: <1556609923-14093-5-git-send-email-vanitha.channaiah@in.bosch.com>
References: <1556609923-14093-1-git-send-email-vanitha.channaiah@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1556609923-14093-1-git-send-email-vanitha.channaiah@in.bosch.com>
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

Issue: After partial read of unaligned frames, snd_pcm_wait()
would block for the pcm->avail_min which would result in
blocking of snd_pcm_wait() for longer periods i.e more than
one period as specified by avail_min

Fix: After reading unaligned frames, set the pcm->avail_min
to the needed available frames so that snd_pcm_wait() blocks till
needed available frames.
Once needed available frames are read, set back the original
pcm->avail_min

Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
---
 src/pcm/pcm.c       | 21 +++++++++++++++++++++
 src/pcm/pcm_local.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index f0db545..f361eb1 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -973,6 +973,7 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 		__snd_pcm_unlock(pcm);
 		return err;
 	}
+	pcm->original_avail_min = pcm->avail_min;
 	__snd_pcm_unlock(pcm);
 	return 0;
 }
@@ -7267,6 +7268,17 @@ void snd_pcm_areas_from_bufs(snd_pcm_t *pcm, snd_pcm_channel_area_t *areas,
 	snd_pcm_unlock(pcm);
 }
 
+static void snd_pcm_set_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail)
+{
+	if (avail != pcm->avail_min) {
+		snd_pcm_sw_params_t swparams;
+
+		snd_pcm_sw_params_current(pcm, &swparams);
+		swparams.avail_min = avail;
+		_snd_pcm_sw_params_internal(pcm, &swparams);
+	}
+}
+
 snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_t *areas,
 				     snd_pcm_uframes_t offset, snd_pcm_uframes_t size,
 				     snd_pcm_xfer_areas_func_t func)
@@ -7274,6 +7286,7 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 	snd_pcm_uframes_t xfer = 0;
 	snd_pcm_sframes_t err = 0;
 	snd_pcm_state_t state;
+	snd_pcm_uframes_t needed_slave_avail_min = 0;
 
 	if (size == 0)
 		return 0;
@@ -7332,6 +7345,14 @@ snd_pcm_sframes_t snd_pcm_read_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_
 		if (err < 0)
 			break;
 		frames = err;
+		pcm->unaligned_frames += frames;
+		pcm->unaligned_frames %= pcm->period_size;
+		if (pcm->unaligned_frames) {
+			needed_slave_avail_min = pcm->period_size - pcm->unaligned_frames;
+			snd_pcm_set_avail_min(pcm, needed_slave_avail_min);
+		} else {
+			snd_pcm_set_avail_min(pcm, pcm->original_avail_min);
+		}
 		offset += frames;
 		size -= frames;
 		xfer += frames;
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index e103f72..3fdffb4 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -210,6 +210,8 @@ struct _snd_pcm {
 	snd_pcm_tstamp_type_t tstamp_type;	/* timestamp type */
 	unsigned int period_step;
 	snd_pcm_uframes_t avail_min;	/* min avail frames for wakeup */
+	snd_pcm_uframes_t unaligned_frames;
+	snd_pcm_uframes_t original_avail_min;
 	int period_event;
 	snd_pcm_uframes_t start_threshold;
 	snd_pcm_uframes_t stop_threshold;
-- 
2.7.4
