From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: Re: [PATCH] salsa-lib: Add seq_midi_event.h
Date: Tue, 2 Apr 2013 11:56:50 +0000
Message-ID: <CAD-m0i89tPMuOCQ==LY4FqfJgakN4xhxX0Kc+Lab=9gJ7j3Bkw@mail.gmail.com>
References: <CAD-m0i9nfOnZ3dq3NS5hhVG+Dqf=Za7A6mTPxbfwnW-VQCDpoQ@mail.gmail.com>
 <s5hsj3qghc8.wl%tiwai@suse.de>
 <CAD-m0i9puLWgXgkrN66+km0_oAuQsp3n8jUv5kpzpfHw3Z6HHQ@mail.gmail.com>
 <s5hfvz98ebp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 by alsa0.perex.cz (Postfix) with ESMTP id CA1D72651C0
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 13:56:51 +0200 (CEST)
Received: by mail-pb0-f44.google.com with SMTP id wz12so204596pbc.3
 for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2013 04:56:50 -0700 (PDT)
In-Reply-To: <s5hfvz98ebp.wl%tiwai@suse.de>
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

This patch add seq_midi_event.h. All replaced with dummy functions.

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
@@ -0,0 +1,54 @@
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
+long snd_midi_event_encode(snd_midi_event_t *dev, const unsigned char *buf,
+			   long count, snd_seq_event_t *ev)
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
+			   long count, const snd_seq_event_t *ev)
+{
+	return -ENOENT;
+}
+
+#endif /* __ALSA_SEQ_MIDI_EVENT_H */
