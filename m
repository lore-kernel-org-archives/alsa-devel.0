From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH 4/4] Only export symbols needed by the plugins'
	interface.
Date: Thu, 20 Jan 2011 04:45:16 +0100
Message-ID: <1295495116-19937-4-git-send-email-flameeyes@gmail.com>
References: <1295495116-19937-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B6BA103A4C
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 04:46:44 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 15so152328wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 19:46:44 -0800 (PST)
In-Reply-To: <1295495116-19937-1-git-send-email-flameeyes@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This reduces the amount of symbols the loader has to resolve, which in turn
reduces the time taken by loading the plugins, and avoids possible symbol
collisions between the plugins and the host software loading them.
---
 a52/Makefile.am        |    2 +-
 arcam-av/Makefile.am   |    2 +-
 jack/Makefile.am       |    2 +-
 maemo/Makefile.am      |    2 +-
 mix/Makefile.am        |    2 +-
 oss/Makefile.am        |    2 +-
 pph/Makefile.am        |    2 +-
 pulse/Makefile.am      |    3 +++
 rate-lavc/Makefile.am  |    2 +-
 rate/Makefile.am       |    2 +-
 speex/Makefile.am      |    2 +-
 usb_stream/Makefile.am |    2 +-
 12 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/a52/Makefile.am b/a52/Makefile.am
index 48567b4..d8f9dc8 100644
--- a/a52/Makefile.am
+++ b/a52/Makefile.am
@@ -4,7 +4,7 @@ asound_module_pcm_a52dir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @AVCODEC_CFLAGS@ \
 	-DAVCODEC_HEADER="@AVCODEC_HEADER@"
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_pcm_a52_la_SOURCES = pcm_a52.c
 libasound_module_pcm_a52_la_LIBADD = @ALSA_LIBS@ @AVCODEC_LIBS@
diff --git a/arcam-av/Makefile.am b/arcam-av/Makefile.am
index a5da61b..dce49a7 100644
--- a/arcam-av/Makefile.am
+++ b/arcam-av/Makefile.am
@@ -3,7 +3,7 @@ asound_module_ctl_arcam_av_LTLIBRARIES = libasound_module_ctl_arcam_av.la
 asound_module_ctl_arcam_avdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_ctl_arcam_av_la_SOURCES = ctl_arcam_av.c arcam_av.c arcam_av.h
 libasound_module_ctl_arcam_av_la_LIBADD = @ALSA_LIBS@
diff --git a/jack/Makefile.am b/jack/Makefile.am
index f913cb6..fb54c4d 100644
--- a/jack/Makefile.am
+++ b/jack/Makefile.am
@@ -3,7 +3,7 @@ asound_module_pcm_jack_LTLIBRARIES = libasound_module_pcm_jack.la
 asound_module_pcm_jackdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @JACK_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_pcm_jack_la_SOURCES = pcm_jack.c
 libasound_module_pcm_jack_la_LIBADD = @ALSA_LIBS@ @JACK_LIBS@
diff --git a/maemo/Makefile.am b/maemo/Makefile.am
index 2684781..b1c5650 100644
--- a/maemo/Makefile.am
+++ b/maemo/Makefile.am
@@ -5,7 +5,7 @@ asound_module_pcm_alsa_dspdir = @ALSA_PLUGIN_DIR@
 asound_module_ctl_dsp_ctldir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -O2 @ALSA_CFLAGS@ $(DBUS_CFLAGS)
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_pcm_alsa_dsp_la_SOURCES = dsp-protocol.c alsa-dsp.c
 libasound_module_pcm_alsa_dsp_la_LIBADD = @ALSA_LIBS@ $(DBUS_LIBS) -lpthread 
diff --git a/mix/Makefile.am b/mix/Makefile.am
index e31839a..fc67643 100644
--- a/mix/Makefile.am
+++ b/mix/Makefile.am
@@ -5,7 +5,7 @@ asound_module_pcm_upmixdir = @ALSA_PLUGIN_DIR@
 asound_module_pcm_vdownmixdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_pcm_upmix_la_SOURCES = pcm_upmix.c
 libasound_module_pcm_upmix_la_LIBADD = @ALSA_LIBS@
diff --git a/oss/Makefile.am b/oss/Makefile.am
index 302538b..9ba33c5 100644
--- a/oss/Makefile.am
+++ b/oss/Makefile.am
@@ -5,7 +5,7 @@ asound_module_pcm_ossdir = @ALSA_PLUGIN_DIR@
 asound_module_ctl_ossdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_pcm_oss_la_SOURCES = pcm_oss.c
 libasound_module_pcm_oss_la_LIBADD = @ALSA_LIBS@
diff --git a/pph/Makefile.am b/pph/Makefile.am
index 551e5bd..5a14f59 100644
--- a/pph/Makefile.am
+++ b/pph/Makefile.am
@@ -3,7 +3,7 @@ asound_module_rate_speexrate_LTLIBRARIES = libasound_module_rate_speexrate.la
 asound_module_rate_speexratedir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -DVAR_ARRAYS -Wall -g @ALSA_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_rate_speexrate_la_SOURCES = rate_speexrate.c
 libasound_module_rate_speexrate_la_LIBADD = @ALSA_LIBS@
diff --git a/pulse/Makefile.am b/pulse/Makefile.am
index e89e8ee..dc41daf 100644
--- a/pulse/Makefile.am
+++ b/pulse/Makefile.am
@@ -11,9 +11,12 @@ AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUN
 
 libasound_module_pcm_pulse_la_SOURCES = pcm_pulse.c pulse.c pulse.h
 libasound_module_pcm_pulse_la_LIBADD = @ALSA_LIBS@ $(PTHREAD_LIBS) $(pulseaudio_LIBS)
+libasound_module_pcm_pulse_la_LDFLAGS = $(AM_LDFLAGS) -export-symbols-regex '^__?snd.*open'
 
 libasound_module_ctl_pulse_la_SOURCES = ctl_pulse.c pulse.c pulse.h
 libasound_module_ctl_pulse_la_LIBADD = @ALSA_LIBS@ $(PTHREAD_LIBS) $(pulseaudio_LIBS)
+libasound_module_ctl_pulse_la_LDFLAGS = $(AM_LDFLAGS) -export-symbols-regex '^__?snd.*open'
 
 libasound_module_conf_pulse_la_SOURCES = conf_pulse.c
 libasound_module_conf_pulse_la_LIBADD = @ALSA_LIBS@ $(PTHREAD_LIBS) $(pulseaudio_LIBS)
+libasound_module_conf_pulse_la_LDFLAGS = $(AM_LDFLAGS) -export-symbols-regex '^conf'
diff --git a/rate-lavc/Makefile.am b/rate-lavc/Makefile.am
index 5cffd44..a7b6d3a 100644
--- a/rate-lavc/Makefile.am
+++ b/rate-lavc/Makefile.am
@@ -4,7 +4,7 @@ asound_module_rate_lavcratedir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @AVCODEC_CFLAGS@ \
 	-DAVCODEC_HEADER="@AVCODEC_HEADER@"
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_rate_lavcrate_la_SOURCES = rate_lavcrate.c
 libasound_module_rate_lavcrate_la_LIBADD = @ALSA_LIBS@ @AVCODEC_LIBS@
diff --git a/rate/Makefile.am b/rate/Makefile.am
index 0605bfd..0c4b6fb 100644
--- a/rate/Makefile.am
+++ b/rate/Makefile.am
@@ -3,7 +3,7 @@ asound_module_rate_samplerate_LTLIBRARIES = libasound_module_rate_samplerate.la
 asound_module_rate_sampleratedir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ $(samplerate_CFLAGS)
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_rate_samplerate_la_SOURCES = rate_samplerate.c
 libasound_module_rate_samplerate_la_LIBADD = @ALSA_LIBS@ @samplerate_LIBS@
diff --git a/speex/Makefile.am b/speex/Makefile.am
index 7d84190..ae14189 100644
--- a/speex/Makefile.am
+++ b/speex/Makefile.am
@@ -3,7 +3,7 @@ asound_module_pcm_speex_LTLIBRARIES = libasound_module_pcm_speex.la
 asound_module_pcm_speexdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @speexdsp_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_pcm_speex_la_SOURCES = pcm_speex.c
 libasound_module_pcm_speex_la_LIBADD = @ALSA_LIBS@ @speexdsp_LIBS@
diff --git a/usb_stream/Makefile.am b/usb_stream/Makefile.am
index 50a98a0..6304bc7 100644
--- a/usb_stream/Makefile.am
+++ b/usb_stream/Makefile.am
@@ -3,7 +3,7 @@ asound_module_pcm_usb_stream_LTLIBRARIES = libasound_module_pcm_usb_stream.la
 asound_module_pcm_usb_streamdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic $(LDFLAGS_NOUNDEFINED)
+AM_LDFLAGS = -module -avoid-version -export-dynamic -export-symbols-regex '^__?snd.*open' $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_pcm_usb_stream_la_SOURCES = pcm_usb_stream.c
 libasound_module_pcm_usb_stream_la_LIBADD = @ALSA_LIBS@
-- 
1.7.4.rc2
