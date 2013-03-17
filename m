From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: [PATCH] salsa-lib: Add seq_midi_event.h
Date: Sun, 17 Mar 2013 14:57:31 +0000
Message-ID: <CAD-m0i9nfOnZ3dq3NS5hhVG+Dqf=Za7A6mTPxbfwnW-VQCDpoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id C5191265191
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 15:57:32 +0100 (CET)
Received: by mail-pd0-f169.google.com with SMTP id 3so609725pdj.0
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 07:57:31 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

--- salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884/configure.ac
+++ salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884-1/configure.ac
@@ -273,6 +273,7 @@
 test "$sndseq" = "yes" && echo "#include \"seq_event.h\"" >> src/asoundlib.h
 test "$sndseq" = "yes" && echo "#include \"seq.h\"" >> src/asoundlib.h
 test "$sndseq" = "yes" && echo "#include \"seqmid.h\"" >> src/asoundlib.h
+test "$sndseq" = "yes" && echo "#include \"seq_midi_event.h\"" >>
src/asoundlib.h
 cat "$srcdir"/src/asoundlib-tail.h >> src/asoundlib.h

 echo "SALSA-Lib build configuration:"
--- salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884/src/Makefile.am
+++ salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884-1/src/Makefile.am
@@ -60,7 +60,7 @@
 endif
 if BUILD_SEQ
 alsainclude_HEADERS += \
-	seq.h seq_event.h seqmid.h
+	seq.h seq_event.h seqmid.h seq_midi_event.h
 endif

 noinst_HEADERS = local.h
--- /dev/null
+++ salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884-1/src/seq_midi_event.h
@@ -0,0 +1,78 @@
+#ifndef __ALSA_SEQ_MIDI_EVENT_H
+#define __ALSA_SEQ_MIDI_EVENT_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ *  \defgroup MIDI_Event Sequencer event <-> MIDI byte stream coder
+ *  \ingroup Sequencer
+ *  Sequencer event <-> MIDI byte stream coder
+ *  \{
+ */
+
+/** container for sequencer midi event parsers */
+typedef struct snd_midi_event {
+	size_t qlen;
+	size_t read;
+	int type;
+	unsigned char lastcmd;
+	unsigned char nostat;
+	size_t bufsize;
+	unsigned char *buf;
+} snd_midi_event_t;
+
+__SALSA_EXPORT_FUNC
+int snd_midi_event_new(size_t bufsize, snd_midi_event_t **rdev)
+{
+	return 0;
+}
+__SALSA_EXPORT_FUNC
+int snd_midi_event_resize_buffer(snd_midi_event_t *dev, size_t bufsize)
+{
+	return 0;
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
+	return 0;
+}
+__SALSA_EXPORT_FUNC
+int snd_midi_event_encode_byte(snd_midi_event_t *dev, int c,
snd_seq_event_t *ev)
+{
+	return 0;
+}
+__SALSA_EXPORT_FUNC
+long snd_midi_event_decode(snd_midi_event_t *dev, unsigned char *buf,
long count, const snd_seq_event_t *ev)
+{
+	return 0;
+}
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __ALSA_SEQ_MIDI_EVENT_H */
+
