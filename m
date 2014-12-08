From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 2/4] add support for
	get/set_audio_htstamp_config
Date: Mon,  8 Dec 2014 16:28:44 -0600
Message-ID: <1418077726-8516-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1418077726-8516-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BD87B265325
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:29:03 +0100 (CET)
In-Reply-To: <1418077726-8516-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Enable kernel-side functionality by letting user select what sort of
timestamp it desires

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/pcm.h | 38 ++++++++++++++++++++++++++++++++++++++
 src/pcm/pcm.c | 24 ++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/pcm.h b/include/pcm.h
index 0655e7f..f963b92 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -330,6 +330,22 @@ typedef enum _snd_pcm_tstamp_type {
 	SND_PCM_TSTAMP_TYPE_LAST = SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 } snd_pcm_tstamp_type_t;
 
+typedef struct _snd_pcm_audio_tstamp_config {
+	/* input from user space*/
+	unsigned int type_requested:4; /* will be overridden and DEFAULT tstamp reported if not supported */
+	unsigned int report_delay:1; /* add delay to A/D or D/A */
+} snd_pcm_audio_tstamp_config_t;
+
+typedef struct _snd_pcm_audio_tstamp_report {
+	/* actual type if hardware could not support requested timestamp */
+	unsigned int actual_type:4;
+
+	/* returned to userspace, accuracy represented in mantissa/exponent form */
+	unsigned int accuracy_report:1; /* 0 if accuracy unknown, 1 if rest of structure is valid */
+	unsigned int accuracy_m:7; /* 0..127, ~3 significant digit for mantissa */
+	unsigned int accuracy_e:4; /* base10 exponent, 0 for ns, 3 for us, 6 for ms, 9 for s */
+} snd_pcm_audio_tstamp_report_t;
+
 /** Unsigned frames quantity */
 typedef unsigned long snd_pcm_uframes_t;
 /** Signed frames quantity */
@@ -980,6 +996,28 @@ void snd_pcm_status_get_trigger_htstamp(const snd_pcm_status_t *obj, snd_htimest
 void snd_pcm_status_get_tstamp(const snd_pcm_status_t *obj, snd_timestamp_t *ptr);
 void snd_pcm_status_get_htstamp(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr);
 void snd_pcm_status_get_audio_htstamp(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr);
+void snd_pcm_status_get_audio_htstamp_report(const snd_pcm_status_t *obj,
+					     snd_pcm_audio_tstamp_report_t *audio_tstamp_report);
+void snd_pcm_status_set_audio_htstamp_config(snd_pcm_status_t *obj,
+					     snd_pcm_audio_tstamp_config_t *audio_tstamp_config);
+
+static inline void snd_pcm_pack_audio_tstamp_config(unsigned int *data,
+						snd_pcm_audio_tstamp_config_t *config)
+{
+	*data = config->report_delay;
+	*data <<= 4;
+	*data |= config->type_requested;
+}
+
+static inline void snd_pcm_unpack_audio_tstamp_report(unsigned int data,
+						snd_pcm_audio_tstamp_report_t *report)
+{
+	report->actual_type = data & 0xFF;
+	report->accuracy_report = (data >> 4) & 1;
+	report->accuracy_m = (data >> 7) & 0x7F;
+	report->accuracy_e = (data >> 12) & 0xF;
+}
+
 snd_pcm_sframes_t snd_pcm_status_get_delay(const snd_pcm_status_t *obj);
 snd_pcm_uframes_t snd_pcm_status_get_avail(const snd_pcm_status_t *obj);
 snd_pcm_uframes_t snd_pcm_status_get_avail_max(const snd_pcm_status_t *obj);
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index baa47c7..af7d8c9 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -6334,6 +6334,30 @@ void snd_pcm_status_get_audio_htstamp(const snd_pcm_status_t *obj, snd_htimestam
 }
 
 /**
+ * \brief Get audio_tstamp_report from a PCM status container
+ * \param obj pointer to #snd_pcm_status_t
+ * \param ptr Pointer to returned report (valid fields are accuracy and type)
+ */
+void snd_pcm_status_get_audio_htstamp_report(const snd_pcm_status_t *obj,
+					     snd_pcm_audio_tstamp_report_t *audio_tstamp_report)
+{
+	assert(obj && audio_tstamp_report);
+	snd_pcm_unpack_audio_tstamp_report(obj->audio_tstamp_data, audio_tstamp_report);
+}
+
+/**
+ * \brief set audio_tstamp_config from a PCM status container
+ * \param obj pointer to #snd_pcm_status_t
+ * \param ptr Pointer to config (valid fields are type and report_analog_delay)
+ */
+void snd_pcm_status_set_audio_htstamp_config(snd_pcm_status_t *obj,
+					     snd_pcm_audio_tstamp_config_t *audio_tstamp_config)
+{
+	assert(obj && audio_tstamp_config);
+	snd_pcm_pack_audio_tstamp_config(&obj->audio_tstamp_data, audio_tstamp_config);
+}
+
+/**
  * \brief Get delay from a PCM status container (see #snd_pcm_delay)
  * \return Delay in frames
  *
-- 
2.1.0
