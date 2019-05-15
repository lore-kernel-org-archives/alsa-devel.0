From: <vanitha.channaiah@in.bosch.com>
Subject: [PATCH v2 5/6] pcm: restructuring sw params function
Date: Wed, 15 May 2019 11:56:36 +0530
Message-ID: <1557901597-19215-6-git-send-email-vanitha.channaiah@in.bosch.com>
References: <1557901597-19215-1-git-send-email-vanitha.channaiah@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1557901597-19215-1-git-send-email-vanitha.channaiah@in.bosch.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: tiwai@suse.de, patch@alsa-project.org
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org, Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
List-Id: alsa-devel@alsa-project.org

From: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>

snd_pcm_sw_params() is reformatted by using _snd_pcm_sw_params_internal()
function.
Critical section of snd_pcm_sw_param() is moved to
_snd_pcm_sw_params_internal(). This allows to call the snd_pcm_sw_params()
function from an internal function which has already locked the API mutex.
Calling snd_pcm_sw_params() from an internal function with locked
API mutex would end up in an deadlock because recursive locking is not
supported.
This patch doesnot change the behavior or the functionality.
To avoid double lock conditions, a separate _snd_pcm_sw_params_internal()
function is added which can be used internally by any other
functions in alsa-lib

Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
---
 src/pcm/pcm.c        | 12 +-----------
 src/pcm/pcm_local.h  |  1 +
 src/pcm/pcm_params.c | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 3a71d79..f0db545 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -968,21 +968,11 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 	}
 #endif
 	__snd_pcm_lock(pcm); /* forced lock due to pcm field change */
-	err = pcm->ops->sw_params(pcm->op_arg, params);
+	err = _snd_pcm_sw_params_internal(pcm, params);
 	if (err < 0) {
 		__snd_pcm_unlock(pcm);
 		return err;
 	}
-	pcm->tstamp_mode = params->tstamp_mode;
-	pcm->tstamp_type = params->tstamp_type;
-	pcm->period_step = params->period_step;
-	pcm->avail_min = params->avail_min;
-	pcm->period_event = sw_get_period_event(params);
-	pcm->start_threshold = params->start_threshold;
-	pcm->stop_threshold = params->stop_threshold;
-	pcm->silence_threshold = params->silence_threshold;
-	pcm->silence_size = params->silence_size;
-	pcm->boundary = params->boundary;
 	__snd_pcm_unlock(pcm);
 	return 0;
 }
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index d52229d..e103f72 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -661,6 +661,7 @@ static inline int muldiv_near(int a, int b, int c)
 	return n;
 }
 
+int _snd_pcm_sw_params_internal(snd_pcm_t *pcm, snd_pcm_sw_params_t *params);
 int snd_pcm_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
 int _snd_pcm_hw_params_internal(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
 #undef _snd_pcm_hw_params
diff --git a/src/pcm/pcm_params.c b/src/pcm/pcm_params.c
index 8826bc3..3ba05fb 100644
--- a/src/pcm/pcm_params.c
+++ b/src/pcm/pcm_params.c
@@ -2439,3 +2439,24 @@ int _snd_pcm_hw_params_internal(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 	return 0;
 }
 
+int _snd_pcm_sw_params_internal(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
+{
+	int err;
+
+	assert(pcm && params);
+	assert(pcm->setup);
+	err = pcm->ops->sw_params(pcm->op_arg, params);
+	if (err < 0)
+		return err;
+	pcm->tstamp_mode = params->tstamp_mode;
+	pcm->tstamp_type = params->tstamp_type;
+	pcm->period_step = params->period_step;
+	pcm->avail_min = params->avail_min;
+	pcm->period_event = sw_get_period_event(params);
+	pcm->start_threshold = params->start_threshold;
+	pcm->stop_threshold = params->stop_threshold;
+	pcm->silence_threshold = params->silence_threshold;
+	pcm->silence_size = params->silence_size;
+	pcm->boundary = params->boundary;
+	return 0;
+}
-- 
2.7.4
