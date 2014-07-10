From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 3/5] pcm: Add sw_params API functions
	to get/set timestamp type
Date: Thu, 10 Jul 2014 15:09:15 +0200
Message-ID: <1404997757-15500-4-git-send-email-tiwai@suse.de>
References: <1404997757-15500-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E445C26109E
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 15:09:19 +0200 (CEST)
In-Reply-To: <1404997757-15500-1-git-send-email-tiwai@suse.de>
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
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

For obtaining / changing the timestamp type, add the corresponding
sw_params accessor API functions together with the public definitions
of timestamp types.

This patch only adds the functions and defines but doesn't bring the
functional changes yet.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/pcm.h       |  9 +++++++++
 src/pcm/pcm.c       | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/pcm/pcm_local.h |  1 +
 3 files changed, 63 insertions(+)

diff --git a/include/pcm.h b/include/pcm.h
index 95b8aed6de2a..11e9f0dfba13 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -317,6 +317,13 @@ typedef enum _snd_pcm_tstamp {
 	SND_PCM_TSTAMP_LAST = SND_PCM_TSTAMP_ENABLE
 } snd_pcm_tstamp_t;
 
+typedef enum _snd_pcm_tstamp_type {
+	SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/** gettimeofday equivalent */
+	SND_PCM_TSTAMP_TYPE_MONOTONIC,	/** posix_clock_monotonic equivalent */
+	SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/** monotonic_raw (no NTP) */
+	SND_PCM_TSTAMP_TYPE_LAST = SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
+} snd_pcm_tstamp_type_t;
+
 /** Unsigned frames quantity */
 typedef unsigned long snd_pcm_uframes_t;
 /** Signed frames quantity */
@@ -844,6 +851,8 @@ int snd_pcm_sw_params_get_boundary(const snd_pcm_sw_params_t *params, snd_pcm_uf
 
 int snd_pcm_sw_params_set_tstamp_mode(snd_pcm_t *pcm, snd_pcm_sw_params_t *params, snd_pcm_tstamp_t val);
 int snd_pcm_sw_params_get_tstamp_mode(const snd_pcm_sw_params_t *params, snd_pcm_tstamp_t *val);
+int snd_pcm_sw_params_set_tstamp_type(snd_pcm_t *pcm, snd_pcm_sw_params_t *params, snd_pcm_tstamp_type_t val);
+int snd_pcm_sw_params_get_tstamp_type(const snd_pcm_sw_params_t *params, snd_pcm_tstamp_type_t *val);
 int snd_pcm_sw_params_set_avail_min(snd_pcm_t *pcm, snd_pcm_sw_params_t *params, snd_pcm_uframes_t val);
 int snd_pcm_sw_params_get_avail_min(const snd_pcm_sw_params_t *params, snd_pcm_uframes_t *val);
 int snd_pcm_sw_params_set_period_event(snd_pcm_t *pcm, snd_pcm_sw_params_t *params, int val);
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 7e46014627c2..1ec67fb405d7 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1483,6 +1483,7 @@ int snd_pcm_poll_descriptors_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsign
 #define XRUN(v) [SND_PCM_XRUN_##v] = #v
 #define SILENCE(v) [SND_PCM_SILENCE_##v] = #v
 #define TSTAMP(v) [SND_PCM_TSTAMP_##v] = #v
+#define TSTAMP_TYPE(v) [SND_PCM_TSTAMP_TYPE_##v] = #v
 #define ACCESS(v) [SND_PCM_ACCESS_##v] = #v
 #define START(v) [SND_PCM_START_##v] = #v
 #define HW_PARAM(v) [SND_PCM_HW_PARAM_##v] = #v
@@ -1680,6 +1681,12 @@ static const char *const snd_pcm_tstamp_mode_names[] = {
 	TSTAMP(NONE),
 	TSTAMP(ENABLE),
 };
+
+static const char *const snd_pcm_tstamp_type_names[] = {
+	TSTAMP_TYPE(GETTIMEOFDAY),
+	TSTAMP_TYPE(MONOTONIC),
+	TSTAMP_TYPE(MONOTONIC_RAW),
+};
 #endif
 
 /**
@@ -1826,6 +1833,18 @@ const char *snd_pcm_tstamp_mode_name(snd_pcm_tstamp_t mode)
 }
 
 /**
+ * \brief get name of PCM tstamp type setting
+ * \param mode PCM tstamp type
+ * \return ascii name of PCM tstamp type setting
+ */
+const char *snd_pcm_tstamp_type_name(snd_pcm_tstamp_t type)
+{
+	if (type > SND_PCM_TSTAMP_TYPE_LAST)
+		return NULL;
+	return snd_pcm_tstamp_type_names[type];
+}
+
+/**
  * \brief get name of PCM state
  * \param state PCM state
  * \return ascii name of PCM state
@@ -1899,6 +1918,7 @@ int snd_pcm_dump_sw_setup(snd_pcm_t *pcm, snd_output_t *out)
 		return -EIO;
 	}
 	snd_output_printf(out, "  tstamp_mode  : %s\n", snd_pcm_tstamp_mode_name(pcm->tstamp_mode));
+	snd_output_printf(out, "  tstamp_type  : %s\n", snd_pcm_tstamp_type_name(pcm->tstamp_mode));
 	snd_output_printf(out, "  period_step  : %d\n", pcm->period_step);
 	snd_output_printf(out, "  avail_min    : %ld\n", pcm->avail_min);
 	snd_output_printf(out, "  period_event : %i\n", pcm->period_event);
@@ -5591,6 +5611,7 @@ int snd_pcm_sw_params_current(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 		return -EIO;
 	}
 	params->tstamp_mode = pcm->tstamp_mode;
+	params->tstamp_type = pcm->tstamp_type;
 	params->period_step = pcm->period_step;
 	params->sleep_min = 0;
 	params->avail_min = pcm->avail_min;
@@ -5613,6 +5634,7 @@ int snd_pcm_sw_params_current(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 int snd_pcm_sw_params_dump(snd_pcm_sw_params_t *params, snd_output_t *out)
 {
 	snd_output_printf(out, "tstamp_mode: %s\n", snd_pcm_tstamp_mode_name(params->tstamp_mode));
+	snd_output_printf(out, "tstamp_type: %s\n", snd_pcm_tstamp_type_name(params->tstamp_mode));
 	snd_output_printf(out, "period_step: %u\n", params->period_step);
 	snd_output_printf(out, "avail_min: %lu\n", params->avail_min);
 	snd_output_printf(out, "start_threshold: %ld\n", params->start_threshold);
@@ -5811,6 +5833,37 @@ int snd_pcm_sw_params_get_tstamp_mode(const snd_pcm_sw_params_t *params, snd_pcm
 }
 
 /**
+ * \brief Set timestamp type inside a software configuration container
+ * \param pcm PCM handle
+ * \param params Software configuration container
+ * \param val Timestamp type
+ * \return 0 otherwise a negative error code
+ */
+int snd_pcm_sw_params_set_tstamp_type(snd_pcm_t *pcm, snd_pcm_sw_params_t *params, snd_pcm_tstamp_type_t val)
+{
+	assert(pcm && params);
+	if (CHECK_SANITY(val > SND_PCM_TSTAMP_TYPE_LAST)) {
+		SNDMSG("invalid tstamp_type value %d", val);
+		return -EINVAL;
+	}
+	params->tstamp_type = val;
+	return 0;
+}
+
+/**
+ * \brief Get timestamp type from a software configuration container
+ * \param params Software configuration container
+ * \param val Returned timestamp type
+ * \return 0 otherwise a negative error code
+ */
+int snd_pcm_sw_params_get_tstamp_type(const snd_pcm_sw_params_t *params, snd_pcm_tstamp_type_t *val)
+{
+	assert(params && val);
+	*val = params->tstamp_type;
+	return 0;
+}
+
+/**
  * \brief (DEPRECATED) Set minimum number of ticks to sleep inside a software configuration container
  * \param pcm PCM handle
  * \param params Software configuration container
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 8a6c7431cc40..3ed7e1a88792 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -202,6 +202,7 @@ struct _snd_pcm {
 	unsigned int period_time;	/* period duration */
 	snd_interval_t periods;
 	snd_pcm_tstamp_t tstamp_mode;	/* timestamp mode */
+	snd_pcm_tstamp_type_t tstamp_type;	/* timestamp type */
 	unsigned int period_step;
 	snd_pcm_uframes_t avail_min;	/* min avail frames for wakeup */
 	int period_event;
-- 
2.0.1
