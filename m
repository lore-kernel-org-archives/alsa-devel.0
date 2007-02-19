From: "Nicholas Kain" <njkain@gmail.com>
Subject: [PATCH] Replace libsamplerate resampler with libavcodec
Date: Mon, 19 Feb 2007 01:14:11 -0500
Message-ID: <c43861e80702182214k31b442b1j6b2589277c03b1e@mail.gmail.com>
References: <20070219060932.GA24147@kain.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070219060932.GA24147@kain.us>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

libsamplerate does a nice job of upsampling audio while retaining quality, but
is rather inefficient and is GPL-licensed.  libavcodec includes a resampler of
equivalent quality that is about an order of magnitude faster in my tests.

ALSA is already using libavcodec for its a52 plugin, but it is important to
note that the a52 code in libavcodec is one of a few parts in lavc that is
licensed under the GPL.  The resampling code is LGPL licensed, so it's
available under much more flexible terms.

I've written a patch that replaces the use of libsamplerate with libavcodec's
resampler.  It is currently a drop-in replacement that uses the exact same
interfaces and dynamically links to libavcodec.  It is easily possible to pull
the LGPL resampling code out of libavcodec and include it directly with the
plugin if that is desirable -- it would not require invasive modifications --
but I have not done so yet.

Direct performance comparison:
a64@1GHz, x86-64 kernel/userspace, emu10k card
source: Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

hardware baseline: 0.21s user 0.01s system 0% cpu 40.801 total

libsamplerate sinc_fastest: 3.02s user 0.05s system 7% cpu 40.831 total
libavcodec default: 0.55s user 0.03s system 1% cpu 40.823 total

libsamplerate best: 13.62s user 0.11s system 33% cpu 40.915 total
libavcodec best: 0.81s user 0.02s system 2% cpu 40.892 total

Note that 'libavcodec best' is not entirely fair -- libavcodec's resampler
dynamically builds a polyphase filter at startup time (which is of course
included in these benchmarks -- I'm just using 'time aplay').  The parameters
of this filter are configurable, so quality can be user configured.  That said,
I haven't found a good way to grab configuration information from .asoundrc
with a rate plugin, so currently only presets are available.

Also, it's worth noting that lavc does its resampling using fixed point math,
whereas libsamplerate uses floating point extensively.  On very low-end
machines, this will yield an even greater performance difference than is seen
here.

Please CC any responses since I'm not subscribed to the list.


diff -purN alsa-plugins-1.0.14rc2/configure.in
alsa-plugins-1.0.14rc2-nk/configure.in
--- alsa-plugins-1.0.14rc2/configure.in 2007-01-15 08:38:28.000000000 -0500
+++ alsa-plugins-1.0.14rc2-nk/configure.in      2007-02-19
00:07:02.000000000 -0500
@@ -21,9 +21,6 @@ AM_CONDITIONAL(HAVE_JACK, test x$HAVE_JA
 PKG_CHECK_MODULES(pulseaudio, [libpulse >= 0.9.2], [HAVE_PULSE=yes],
[HAVE_PULSE=no])
 AM_CONDITIONAL(HAVE_PULSE, test x$HAVE_PULSE = xyes)

-PKG_CHECK_MODULES(samplerate, [samplerate], [HAVE_SAMPLERATE=yes],
[HAVE_SAMPLERATE=no])
-AM_CONDITIONAL(HAVE_SAMPLERATE, test x$HAVE_SAMPLERATE = xyes)
-
 PKG_CHECK_MODULES(DBUS, [dbus-1], [HAVE_DBUS=yes], [HAVE_DBUS=no])
 AM_CONDITIONAL(HAVE_DBUS, test x$HAVE_DBUS = xyes)

diff -purN alsa-plugins-1.0.14rc2/Makefile.am
alsa-plugins-1.0.14rc2-nk/Makefile.am
--- alsa-plugins-1.0.14rc2/Makefile.am  2007-01-15 08:38:28.000000000 -0500
+++ alsa-plugins-1.0.14rc2-nk/Makefile.am       2007-02-19
00:10:06.000000000 -0500
@@ -4,10 +4,8 @@ endif
 if HAVE_PULSE
 PULSEDIR = pulse
 endif
-if HAVE_SAMPLERATE
-SAMPLERATEDIR = rate
-endif
 if HAVE_AVCODEC
+SAMPLERATEDIR = rate
 A52DIR = a52
 endif
 if HAVE_DBUS
diff -purN alsa-plugins-1.0.14rc2/Makefile.in
alsa-plugins-1.0.14rc2-nk/Makefile.in
--- alsa-plugins-1.0.14rc2/Makefile.in  2007-01-15 08:39:17.000000000 -0500
+++ alsa-plugins-1.0.14rc2-nk/Makefile.in       2007-02-19
00:10:48.000000000 -0500
@@ -115,8 +115,6 @@ HAVE_JACK_FALSE = @HAVE_JACK_FALSE@
 HAVE_JACK_TRUE = @HAVE_JACK_TRUE@
 HAVE_PULSE_FALSE = @HAVE_PULSE_FALSE@
 HAVE_PULSE_TRUE = @HAVE_PULSE_TRUE@
-HAVE_SAMPLERATE_FALSE = @HAVE_SAMPLERATE_FALSE@
-HAVE_SAMPLERATE_TRUE = @HAVE_SAMPLERATE_TRUE@
 INSTALL_DATA = @INSTALL_DATA@
 INSTALL_PROGRAM = @INSTALL_PROGRAM@
 INSTALL_SCRIPT = @INSTALL_SCRIPT@
@@ -194,7 +192,7 @@ sysconfdir = @sysconfdir@
 target_alias = @target_alias@
 @HAVE_JACK_TRUE@JACKDIR = jack
 @HAVE_PULSE_TRUE@PULSEDIR = pulse
-@HAVE_SAMPLERATE_TRUE@SAMPLERATEDIR = rate
+@HAVE_AVCODEC_TRUE@SAMPLERATEDIR = rate
 @HAVE_AVCODEC_TRUE@A52DIR = a52
 @HAVE_DBUS_TRUE@MAEMODIR = maemo
 SUBDIRS = oss mix $(JACKDIR) $(PULSEDIR) $(SAMPLERATEDIR) $(A52DIR)
$(MAEMODIR) doc
diff -purN alsa-plugins-1.0.14rc2/rate/Makefile.am
alsa-plugins-1.0.14rc2-nk/rate/Makefile.am
--- alsa-plugins-1.0.14rc2/rate/Makefile.am     2007-01-15
08:38:28.000000000 -0500
+++ alsa-plugins-1.0.14rc2-nk/rate/Makefile.am  2007-02-18
01:30:27.000000000 -0500
@@ -2,11 +2,11 @@ asound_module_rate_samplerate_LTLIBRARIE

 asound_module_rate_sampleratedir = $(libdir)/alsa-lib

-AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ $(samplerate_CFLAGS)
+AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @AVCODEC_CFLAGS@
 AM_LDFLAGS = -module -avoid-version -export-dynamic

 libasound_module_rate_samplerate_la_SOURCES = rate_samplerate.c
-libasound_module_rate_samplerate_la_LIBADD = @ALSA_LIBS@ @samplerate_LIBS@
+libasound_module_rate_samplerate_la_LIBADD = @ALSA_LIBS@ @AVCODEC_LIBS@

 install-exec-hook:
        rm -f $(DESTDIR)$(libdir)/alsa-lib/libasound_module_rate_samplerate_*.so
diff -purN alsa-plugins-1.0.14rc2/rate/Makefile.in
alsa-plugins-1.0.14rc2-nk/rate/Makefile.in
--- alsa-plugins-1.0.14rc2/rate/Makefile.in     2007-01-15
08:39:16.000000000 -0500
+++ alsa-plugins-1.0.14rc2-nk/rate/Makefile.in  2007-02-18
01:32:25.000000000 -0500
@@ -197,10 +201,10 @@ sysconfdir = @sysconfdir@
 target_alias = @target_alias@
 asound_module_rate_samplerate_LTLIBRARIES = libasound_module_rate_samplerate.la
 asound_module_rate_sampleratedir = $(libdir)/alsa-lib
-AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ $(samplerate_CFLAGS)
+AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ @AVCODEC_CFLAGS@
 AM_LDFLAGS = -module -avoid-version -export-dynamic
 libasound_module_rate_samplerate_la_SOURCES = rate_samplerate.c
-libasound_module_rate_samplerate_la_LIBADD = @ALSA_LIBS@ @samplerate_LIBS@
+libasound_module_rate_samplerate_la_LIBADD = @ALSA_LIBS@ @AVCODEC_LIBS@
 all: all-am

 .SUFFIXES:
diff -purN alsa-plugins-1.0.14rc2/rate/rate_samplerate.c
alsa-plugins-1.0.14rc2-nk/rate/rate_samplerate.c
--- alsa-plugins-1.0.14rc2/rate/rate_samplerate.c       2007-01-15
08:38:28.000000000 -0500
+++ alsa-plugins-1.0.14rc2-nk/rate/rate_samplerate.c    2007-02-18
23:59:34.000000000 -0500
@@ -1,6 +1,8 @@
 /*
- * Rate converter plugin using libsamplerate
+ * Rate converter plugin using libavcodec's resampler
+ * Copyright (c) 2007 by Nicholas Kain <njkain@gmail.com>
  *
+ * based on rate converter that uses libsamplerate
  * Copyright (c) 2006 by Takashi Iwai <tiwai@suse.de>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -19,80 +21,94 @@
  */

 #include <stdio.h>
-#include <samplerate.h>
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_rate.h>
+#include <ffmpeg/avcodec.h>
+
+static int filter_size = 16;
+static int phase_shift = 10;
+static double cutoff = 0; /* auto-adjusts */

 struct rate_src {
-       double ratio;
-       int converter;
+       struct AVResampleContext *context;
+       int in_rate;
+       int out_rate;
+       int overflow;
+       int16_t **out;
+       int16_t **in;
        unsigned int channels;
-       float *src_buf;
-       float *dst_buf;
-       SRC_STATE *state;
-       SRC_DATA data;
 };

 static snd_pcm_uframes_t input_frames(void *obj, snd_pcm_uframes_t frames)
 {
-       struct rate_src *rate = obj;
-       if (frames == 0)
-               return 0;
-       return (snd_pcm_uframes_t)(frames * rate->ratio);
+       return frames;
 }

 static snd_pcm_uframes_t output_frames(void *obj, snd_pcm_uframes_t frames)
 {
-       struct rate_src *rate = obj;
-       if (frames == 0)
-               return 0;
-       return (snd_pcm_uframes_t)(frames / rate->ratio);
+       return frames;
 }

 static void pcm_src_free(void *obj)
 {
        struct rate_src *rate = obj;
+       int i;

-       free(rate->src_buf);
-       free(rate->dst_buf);
-       rate->src_buf = rate->dst_buf = NULL;
-
-       if (rate->state) {
-               src_delete(rate->state);
-               rate->state = NULL;
+       if (rate->out) {
+               for (i=0; i<rate->channels; i++) {
+                       free(rate->out[i]);
+               }
+               free(rate->out);
+       }
+       if (rate->in) {
+               for (i=0; i<rate->channels; i++) {
+                       free(rate->in[i]);
+               }
+               free(rate->in);
+       }
+       rate->out = rate->in = NULL;
+
+       if (rate->context) {
+               av_resample_close(rate->context);
+               rate->context = NULL;
        }
 }

 static int pcm_src_init(void *obj, snd_pcm_rate_info_t *info)
 {
        struct rate_src *rate = obj;
-       int err;
+       int i;

-       if (! rate->state || rate->channels != info->channels) {
-               if (rate->state)
-                       src_delete(rate->state);
+       if (! rate->context || rate->channels != info->channels) {
+               pcm_src_free(rate);
                rate->channels = info->channels;
-               rate->state = src_new(rate->converter, rate->channels, &err);
-               if (! rate->state)
+               rate->in_rate = info->in.rate;
+               rate->out_rate = info->out.rate;
+               if (cutoff <= 0.0) {
+                       cutoff = 1.0 - 1.0/filter_size;
+                       if (cutoff < 0.80)
+                               cutoff = 0.80;
+               }
+               rate->context = av_resample_init(info->out.rate, info->in.rate,
+                       filter_size, phase_shift,
+                       (info->out.rate >= info->in.rate ? 0 : 1), cutoff);
+               if (!rate->context)
                        return -EINVAL;
        }

-       rate->ratio = (double)info->out.rate / (double)info->in.rate;
-
-       free(rate->src_buf);
-       rate->src_buf = malloc(sizeof(float) * rate->channels *
info->in.period_size);
-       free(rate->dst_buf);
-       rate->dst_buf = malloc(sizeof(float) * rate->channels *
info->out.period_size);
-       if (! rate->src_buf || ! rate->dst_buf) {
+       rate->out = malloc(rate->channels * sizeof(int16_t *));
+       rate->in = malloc(rate->channels * sizeof(int16_t *));
+       for (i=0; i<rate->channels; i++) {
+               rate->out[i] = calloc(info->out.period_size * 2,
+                       sizeof(int16_t));
+               rate->in[i] = calloc(info->in.period_size * 2,
+                       sizeof(int16_t));
+       }
+       if (!rate->out || !rate->in) {
                pcm_src_free(rate);
                return -ENOMEM;
        }

-       rate->data.data_in = rate->src_buf;
-       rate->data.data_out = rate->dst_buf;
-       rate->data.src_ratio = rate->ratio;
-       rate->data.end_of_input = 0;
-
        return 0;
 }

@@ -100,35 +116,86 @@ static int pcm_src_adjust_pitch(void *ob
 {
        struct rate_src *rate = obj;

-       rate->ratio = ((double)info->out.period_size /
(double)info->in.period_size);
-       rate->data.src_ratio = rate->ratio;
+       if (info->out.rate != rate->out_rate || info->in.rate != rate->in_rate)
+               pcm_src_init(obj, info);
        return 0;
 }

 static void pcm_src_reset(void *obj)
 {
        struct rate_src *rate = obj;
+       rate->overflow = 0;
+}

-       src_reset(rate->state);
+static void deinterleave(const int16_t *src, int16_t **dst, unsigned
int frames,
+       unsigned int chans, int overflow)
+{
+       int i, j;
+
+       if (chans == 1) {
+               memcpy(dst + overflow, src, (frames-overflow)*sizeof(int16_t));
+       } else if (chans == 2) {
+               for (j=overflow; j< (frames + overflow); j++) {
+                       dst[0][j] = *(src++);
+                       dst[1][j] = *(src++);
+               }
+       } else {
+               for (j=overflow; j< (frames + overflow); j++) {
+                       for (i=0; i<chans; i++) {
+                               dst[i][j] = *(src++);
+                       }
+               }
+       }
 }

-static void pcm_src_convert_s16(void *obj, int16_t *dst, unsigned int
dst_frames,
-                               const int16_t *src, unsigned int src_frames)
+static void reinterleave(int16_t **src, int16_t *dst, unsigned int frames,
+       unsigned int chans)
+{
+       int i, j;
+
+       if (chans == 1) {
+               memcpy(dst, src, frames*sizeof(int16_t));
+       } else if (chans == 2) {
+               for (j=0; j<frames; j++) {
+                       *(dst++) = src[0][j];
+                       *(dst++) = src[1][j];
+               }
+       } else {
+               for (j=0; j<frames; j++) {
+                       for (i=0; i<chans; i++) {
+                               *(dst++) = src[i][j];
+                       }
+               }
+       }
+}
+
+static void pcm_src_convert_s16(void *obj, int16_t *dst, unsigned int
+       dst_frames, const int16_t *src, unsigned int src_frames)
 {
        struct rate_src *rate = obj;
+       int consumed = 0, chans=rate->channels, ret, i, j, k=0;
+       int total_in = src_frames+rate->overflow;

-       rate->data.input_frames = src_frames;
-       rate->data.output_frames = dst_frames;
-       rate->data.end_of_input = 0;
-
-       src_short_to_float_array(src, rate->src_buf, src_frames *
rate->channels);
-       src_process(rate->state, &rate->data);
-       src_float_to_short_array(rate->dst_buf, dst, dst_frames *
rate->channels);
+       deinterleave(src, rate->in, src_frames, chans, rate->overflow);
+       for (i=0; i<chans; ++i) {
+               ret = av_resample(rate->context, rate->out[i], rate->in[i],
+                       &consumed, total_in, dst_frames, i == (chans - 1));
+               for (j=0, k=0; ret+j<dst_frames; j++) {
+                       rate->out[i][ret+j] =rate->in[i][consumed+k];
+                       if (consumed+k<src_frames)
+                               k++;
+               }
+               memmove(rate->in[i], rate->in[i]+consumed+k,
+                       (src_frames-consumed-k)*sizeof(int16_t));
+       }
+       av_resample_compensate(rate->context, src_frames-consumed, src_frames);
+       reinterleave(rate->out, dst, dst_frames, chans);
+       rate->overflow = src_frames-consumed-k;
 }

 static void pcm_src_close(void *obj)
 {
-       free(obj);
+       pcm_src_free(obj);
 }

 static snd_pcm_rate_ops_t pcm_src_ops = {
@@ -142,8 +209,8 @@ static snd_pcm_rate_ops_t pcm_src_ops =
        .output_frames = output_frames,
 };

-static int pcm_src_open(unsigned int version, void **objp,
-                       snd_pcm_rate_ops_t *ops, int type)
+int pcm_src_open(unsigned int version, void **objp, snd_pcm_rate_ops_t *ops)
+
 {
        struct rate_src *rate;

@@ -153,41 +220,47 @@ static int pcm_src_open(unsigned int ver
        }

        rate = calloc(1, sizeof(*rate));
-       if (! rate)
+       if (!rate)
                return -ENOMEM;
-       rate->converter = type;

        *objp = rate;
+       rate->context = NULL;
        *ops = pcm_src_ops;
        return 0;
 }

-int SND_PCM_RATE_PLUGIN_ENTRY(samplerate) (unsigned int version, void **objp,
-                                          snd_pcm_rate_ops_t *ops)
+int SND_PCM_RATE_PLUGIN_ENTRY(samplerate)(unsigned int version, void **objp,
+                       snd_pcm_rate_ops_t *ops)
 {
-       return pcm_src_open(version, objp, ops, SRC_SINC_FASTEST);
+       return pcm_src_open(version, objp, ops);
 }
-
-int SND_PCM_RATE_PLUGIN_ENTRY(samplerate_best) (unsigned int version,
void **objp,
-                                               snd_pcm_rate_ops_t *ops)
+int SND_PCM_RATE_PLUGIN_ENTRY(samplerate_best)(unsigned int version,
+                       void **objp, snd_pcm_rate_ops_t *ops)
 {
-       return pcm_src_open(version, objp, ops, SRC_SINC_BEST_QUALITY);
+       filter_size = 24;
+       phase_shift = 12;
+       return pcm_src_open(version, objp, ops);
 }
-
-int SND_PCM_RATE_PLUGIN_ENTRY(samplerate_medium) (unsigned int
version, void **objp,
-                                                 snd_pcm_rate_ops_t *ops)
+int SND_PCM_RATE_PLUGIN_ENTRY(samplerate_medium)(unsigned int version,
+                       void **objp, snd_pcm_rate_ops_t *ops)
 {
-       return pcm_src_open(version, objp, ops, SRC_SINC_MEDIUM_QUALITY);
+       filter_size = 20;
+       phase_shift = 11;
+       return pcm_src_open(version, objp, ops);
 }
-
-int SND_PCM_RATE_PLUGIN_ENTRY(samplerate_order) (unsigned int
version, void **objp,
-                                                snd_pcm_rate_ops_t *ops)
+int SND_PCM_RATE_PLUGIN_ENTRY(samplerate_order)(unsigned int version,
+                       void **objp, snd_pcm_rate_ops_t *ops)
 {
-       return pcm_src_open(version, objp, ops, SRC_ZERO_ORDER_HOLD);
+       filter_size = 12;
+       phase_shift = 8;
+       return pcm_src_open(version, objp, ops);
 }
-
-int SND_PCM_RATE_PLUGIN_ENTRY(samplerate_linear) (unsigned int
version, void **objp,
-                                                 snd_pcm_rate_ops_t *ops)
+int SND_PCM_RATE_PLUGIN_ENTRY(samplerate_linear)(unsigned int version,
+                       void **objp, snd_pcm_rate_ops_t *ops)
 {
-       return pcm_src_open(version, objp, ops, SRC_LINEAR);
+       filter_size = 8;
+       phase_shift = 6;
+       return pcm_src_open(version, objp, ops);
 }
+
+
--
Nicholas J. Kain <nicholas at kain dot us>
http://brightrain.aerifal.cx/~niklata/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
