From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: Re: [PATCH] salsa-lib: Add seq_midi_event.h
Date: Mon, 25 Mar 2013 23:50:22 +0000
Message-ID: <CAD-m0i9puLWgXgkrN66+km0_oAuQsp3n8jUv5kpzpfHw3Z6HHQ@mail.gmail.com>
References: <CAD-m0i9nfOnZ3dq3NS5hhVG+Dqf=Za7A6mTPxbfwnW-VQCDpoQ@mail.gmail.com>
 <s5hsj3qghc8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id EF5CE264EF9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 00:50:23 +0100 (CET)
Received: by mail-pd0-f173.google.com with SMTP id v10so2771285pde.4
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 16:50:23 -0700 (PDT)
In-Reply-To: <s5hsj3qghc8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I apologize for a delay with the answer. Do you have any plans about
inclusion of the minimum support of alsa-seq? Support of alsa-seq
would allow to use salsa together with jack/pulsaudio or other audio
server as full replacement of alsa-lib.


--- salsa-lib-9e6b52f148fb5a6352f441d0b5a41419c3a57c79/configure.ac
+++ salsa-lib-9e6b52f148fb5a6352f441d0b5a41419c3a57c79-1/configure.ac
@@ -273,6 +273,7 @@
 test "$sndseq" = "yes" && echo "#include \"seq_event.h\"" >> src/asoundlib.h
 test "$sndseq" = "yes" && echo "#include \"seq.h\"" >> src/asoundlib.h
 test "$sndseq" = "yes" && echo "#include \"seqmid.h\"" >> src/asoundlib.h
+test "$sndseq" = "yes" && echo "#include \"seq_midi_event.h\"" >>
src/asoundlib.h
 cat "$srcdir"/src/asoundlib-tail.h >> src/asoundlib.h

 echo "SALSA-Lib build configuration:"
--- salsa-lib-9e6b52f148fb5a6352f441d0b5a41419c3a57c79/src/Makefile.am
+++ salsa-lib-9e6b52f148fb5a6352f441d0b5a41419c3a57c79-1/src/Makefile.am
@@ -60,7 +60,7 @@
 endif
 if BUILD_SEQ
 alsainclude_HEADERS += \
-	seq.h seq_event.h seqmid.h
+	seq.h seq_event.h seqmid.h seq_midi_event.h
 endif

 noinst_HEADERS = local.h
--- /dev/null
+++ salsa-lib-9e6b52f148fb5a6352f441d0b5a41419c3a57c79-1/src/seq_midi_event.h
@@ -0,0 +1,52 @@
+#ifndef __ALSA_SEQ_MIDI_EVENT_H
+#define __ALSA_SEQ_MIDI_EVENT_H
+
+typedef struct snd_midi_event snd_midi_event_t;
+
+__SALSA_EXPORT_FUNC
+int snd_midi_event_new(size_t bufsize, snd_midi_event_t **rdev)
+{
+	return -ENOMEM;
+}
+__SALSA_EXPORT_FUNC
+int snd_midi_event_resize_buffer(snd_midi_event_t *dev, size_t bufsize)
+{
+	return -ENOMEM;
+}
+__SALSA_EXPORT_FUNC
+void snd_midi_event_free(snd_midi_event_t *dev)
+{
+}
+__SALSA_EXPORT_FUNC
+void snd_midi_event_init(snd_midi_event_t *dev)
+{
+}
+__SALSA_EXPORT_FUNC
+void snd_midi_event_reset_encode(snd_midi_event_t *dev)
+{
+}
+__SALSA_EXPORT_FUNC
+void snd_midi_event_reset_decode(snd_midi_event_t *dev)
+{
+}
+__SALSA_EXPORT_FUNC
+void snd_midi_event_no_status(snd_midi_event_t *dev, int on)
+{
+}
+__SALSA_EXPORT_FUNC
+long snd_midi_event_encode(snd_midi_event_t *dev, const unsigned char
*buf, long count, snd_seq_event_t *ev)
+{
+	return -EINVAL;
+}
+__SALSA_EXPORT_FUNC
+int snd_midi_event_encode_byte(snd_midi_event_t *dev, int c,
snd_seq_event_t *ev)
+{
+	return -EINVAL;
+}
+__SALSA_EXPORT_FUNC
+long snd_midi_event_decode(snd_midi_event_t *dev, unsigned char *buf,
long count, const snd_seq_event_t *ev)
+{
+	return -ENOENT;
+}
+
+#endif /* __ALSA_SEQ_MIDI_EVENT_H */
