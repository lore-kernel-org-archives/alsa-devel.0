From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH v3 alsa-lib 3/3] Support snd_pcm_status_dump()
Date: Fri,  6 Feb 2015 16:16:01 +0000
Message-ID: <1423239361-17655-3-git-send-email-timcussins@eml.cc>
References: <1423239361-17655-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6175A2651CE
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 17:16:14 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id F37E620B3B
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 11:16:13 -0500 (EST)
In-Reply-To: <1423239361-17655-1-git-send-email-timcussins@eml.cc>
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
Cc: Tim Cussins <timcussins@eml.cc>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Tim Cussins <timcussins@eml.cc>

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index f2cbd8e..656e521 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1559,11 +1559,13 @@ int snd_pcm_poll_descriptors_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsign
 #define SW_PARAM(v) [SND_PCM_SW_PARAM_##v] = #v
 #define FORMAT(v) [SND_PCM_FORMAT_##v] = #v
 #define SUBFORMAT(v) [SND_PCM_SUBFORMAT_##v] = #v 
+#define STARTAT_CLOCK(v) [SND_PCM_STARTAT_CLOCK_TYPE_##v] = #v
 
 #define FORMATD(v, d) [SND_PCM_FORMAT_##v] = d
 #define SUBFORMATD(v, d) [SND_PCM_SUBFORMAT_##v] = d 
 
 
+
 static const char *const snd_pcm_stream_names[] = {
 	STREAM(PLAYBACK),
 	STREAM(CAPTURE),
@@ -1651,6 +1653,12 @@ static const char *const snd_pcm_format_aliases[SND_PCM_FORMAT_LAST+1] = {
 	FORMAT(IEC958_SUBFRAME),
 };
 
+static const char *const snd_pcm_startat_clock_names[SND_PCM_STARTAT_CLOCK_TYPE_LAST+1] = {
+	STARTAT_CLOCK(GETTIMEOFDAY),
+	STARTAT_CLOCK(MONOTONIC),
+	STARTAT_CLOCK(LINK),
+};
+
 static const char *const snd_pcm_format_descriptions[] = {
 	FORMATD(S8, "Signed 8 bit"), 
 	FORMATD(U8, "Unsigned 8 bit"),
@@ -1949,6 +1957,18 @@ const char *snd_pcm_type_name(snd_pcm_type_t type)
 use_default_symbol_version(__snd_pcm_type_name, snd_pcm_type_name, ALSA_0.9.0);
 
 /**
+ * \brief get name of startat clock
+ * \param clock_type type of startat clock
+ * \return ascii name of startat clock
+ */
+const char *snd_pcm_startat_clock_name(snd_pcm_startat_clock_type_t clock_type)
+{
+	if (clock_type > SND_PCM_STARTAT_CLOCK_TYPE_LAST)
+		return NULL;
+	return snd_pcm_startat_clock_names[clock_type];
+}
+
+/**
  * \brief Dump current hardware setup for PCM
  * \param pcm PCM handle
  * \param out Output handle
@@ -2035,6 +2055,13 @@ int snd_pcm_status_dump(snd_pcm_status_t *status, snd_output_t *out)
 	snd_output_printf(out, "  delay       : %ld\n", (long)status->delay);
 	snd_output_printf(out, "  avail       : %ld\n", (long)status->avail);
 	snd_output_printf(out, "  avail_max   : %ld\n", (long)status->avail_max);
+	if (status->start_at_pending == 1) {
+		snd_output_printf(out, "  start_at    : %s %ld.%06ld\n", snd_pcm_startat_clock_name(status->start_at_clock_type),
+			status->start_at_start_time.tv_sec, status->start_at_start_time.tv_nsec);
+	}
+	else {
+		snd_output_printf(out, "  start_at    : disabled\n");
+	}
 	return 0;
 }
 
-- 
1.9.1
