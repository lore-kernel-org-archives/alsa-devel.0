From: Aldrin Martoq <amartoq@dcc.uchile.cl>
Subject: [PATCH] alsa-lib: issues in snd_seq_change_bit and
	some	enhancements
Date: Thu, 21 Feb 2008 04:08:32 -0300
Message-ID: <1203577712.13752.33.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HC6QF1sxU7dSICgYFOOF"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id C76652412E
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 08:08:44 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so651030ana.80
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 23:08:43 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org


--=-HC6QF1sxU7dSICgYFOOF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello hackers,

I found two issues in sequencer part of alsa-lib while working with the
python binding:
1) snd_seq_change_bit is not working as expected.
2) There is no sane way to clear the event_filter of
snd_seq_client_info_t structure. Because the structure is opaque, we
cannot memset to zero because the user doesn't know the size of the
bitmap.

The first attached patch is a demo of both issues. For 1) please apply
snd_seq_change_bit.txt patch. For 2) I propose to clear the bitmap if
NULL is passed, see snd_seq_client_info_set_event_filter.txt patch.



Also, I think it makes no sense that the bitmap is returned or expected
to be given in both snd_seq_client_info_{set,get}_event_filter; the
client_info structure is opaque and the alsa-lib user can't/shouldn't
known the bitmap size. The only sane way is to use the middle interface
function snd_seq_set_client_event_filter(), but it only can be used for
an opened sequencer's client_info.

So, the last patch is a proposal for changing this:
- mark as deprecated both snd_seq_client_info_{set,get}_event_filter
- snd_seq_client_info_event_filter_clear() clears the event_filter
- snd_seq_client_info_event_filter_add() add an event to the event
filter
- snd_seq_client_info_event_filter_del() removes an event from the event
filter
- snd_seq_client_info_event_filter_check() test if an event is present
in the filtering

Any comments? Thanks!



-- 
Aldrin Martoq <amartoq@dcc.uchile.cl>

--=-HC6QF1sxU7dSICgYFOOF
Content-Disposition: attachment; filename=event_filter.txt
Content-Type: text/x-patch; name=event_filter.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/test/Makefile.am b/test/Makefile.am
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -1,6 +1,6 @@ check_PROGRAMS=control pcm pcm_min laten
 check_PROGRAMS=control pcm pcm_min latency seq \
 	       playmidi1 timer rawmidi midiloop \
-	       oldapi queue_timer namehint
+	       oldapi queue_timer namehint event_filter
 
 control_LDADD=../src/libasound.la
 pcm_LDADD=../src/libasound.la
@@ -15,6 +15,7 @@ queue_timer_LDADD=../src/libasound.la
 queue_timer_LDADD=../src/libasound.la
 namehint_LDADD=../src/libasound.la
 code_CFLAGS=-Wall -pipe -g -O2
+event_filter_LDADD=../src/libasound.la
 
 INCLUDES=-I$(top_srcdir)/include
 AM_CFLAGS=-Wall -pipe -g
diff --git a/test/event_filter.c b/test/event_filter.c
new file mode 100644
--- /dev/null
+++ b/test/event_filter.c
@@ -0,0 +1,49 @@
+#include <alsa/asoundlib.h>
+
+int main(void) {
+	snd_seq_t *seq;
+	snd_seq_client_info_t *client_info;
+	const unsigned char *event_filter;
+	int isnote;
+	int ispgmc;
+	int oldnote;
+
+	snd_seq_client_info_alloca(&client_info);
+	snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0);
+
+	snd_seq_get_client_info(seq, client_info);
+	event_filter = snd_seq_client_info_get_event_filter(client_info);
+	printf("Initial event_filter=0x%p\n", event_filter);
+
+	snd_seq_set_client_event_filter(seq, SND_SEQ_EVENT_NOTEON);
+	snd_seq_get_client_info(seq, client_info);
+	event_filter = snd_seq_client_info_get_event_filter(client_info);
+	isnote = snd_seq_get_bit(SND_SEQ_EVENT_NOTEON, (void *) event_filter);
+	printf("after snd_seq_set_client_event (EVENT_NOTEON)    : "
+		"event_filter=0x%p isnote=%d\n",
+		event_filter, isnote);
+	oldnote = snd_seq_change_bit(SND_SEQ_EVENT_NOTEON, (void *) event_filter);
+	isnote = snd_seq_get_bit(SND_SEQ_EVENT_NOTEON, (void *) event_filter);
+	printf("after snd_seq_change_bit                         : "
+		"event_filter=0x%p isnote=%d oldnote=%d\n ==> %s %s\n",
+		event_filter, isnote, oldnote, "snd_seq_change_bit",
+		(isnote == 0 ? "changed" : "ERROR: NOT CHANGED"));
+
+	snd_seq_get_client_info(seq, client_info);
+	snd_seq_client_info_set_event_filter(client_info, NULL);
+	snd_seq_set_client_info(seq, client_info);
+	event_filter = snd_seq_client_info_get_event_filter(client_info);
+	printf("after snd_seq_client_info_set_event_filter(NULL) : "
+		"event_filter=0x%p\n",
+		event_filter);
+	
+	snd_seq_set_client_event_filter(seq, SND_SEQ_EVENT_PGMCHANGE);
+	snd_seq_get_client_info(seq, client_info);
+	event_filter = snd_seq_client_info_get_event_filter(client_info);
+	isnote = snd_seq_get_bit(SND_SEQ_EVENT_NOTEON, (void *) event_filter);
+	ispgmc = snd_seq_get_bit(SND_SEQ_EVENT_PGMCHANGE, (void *) event_filter);
+	printf("after snd_seq_set_client_event (EVENT_PGMCHANGE) : "
+		"event_filter=0x%p isnote=%d ispgmc=%d\n ==> %s %s\n",
+		event_filter, isnote, ispgmc, "snd_seq_client_info_set_event_filter(NULL)",
+		(isnote == 0 ? "cleared" : "ERROR: NOT CLEARED"));
+}

--=-HC6QF1sxU7dSICgYFOOF
Content-Disposition: attachment; filename=snd_seq_change_bit.txt
Content-Type: text/x-patch; name=snd_seq_change_bit.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/src/seq/seq.c b/src/seq/seq.c
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -4670,7 +4670,7 @@ int snd_seq_change_bit(int nr, void *arr
 	int result;
 
 	result = ((((unsigned int *)array)[nr >> 5]) & (1UL << (nr & 31))) ? 1 : 0;
-	((unsigned int *)array)[nr >> 5] |= 1UL << (nr & 31);
+	((unsigned int *)array)[nr >> 5] ^= 1UL << (nr & 31);
 	return result;
 }
 

--=-HC6QF1sxU7dSICgYFOOF
Content-Disposition: attachment; filename=snd_seq_client_info_set_event_filter.txt
Content-Type: text/x-patch; name=snd_seq_client_info_set_event_filter.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/src/seq/seq.c b/src/seq/seq.c
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -1633,9 +1633,10 @@ void snd_seq_client_info_set_event_filte
 void snd_seq_client_info_set_event_filter(snd_seq_client_info_t *info, unsigned char *filter)
 {
 	assert(info);
-	if (! filter)
+	if (! filter) {
 		info->filter &= ~SNDRV_SEQ_FILTER_USE_EVENT;
-	else {
+		memset(info->event_filter, 0, sizeof(info->event_filter));
+	} else {
 		info->filter |= SNDRV_SEQ_FILTER_USE_EVENT;
 		memcpy(info->event_filter, filter, sizeof(info->event_filter));
 	}

--=-HC6QF1sxU7dSICgYFOOF
Content-Disposition: attachment; filename=proposed.txt
Content-Type: text/x-patch; name=proposed.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/include/seq.h b/include/seq.h
--- a/include/seq.h
+++ b/include/seq.h
@@ -152,6 +152,11 @@ void snd_seq_client_info_set_broadcast_f
 void snd_seq_client_info_set_broadcast_filter(snd_seq_client_info_t *info, int val);
 void snd_seq_client_info_set_error_bounce(snd_seq_client_info_t *info, int val);
 void snd_seq_client_info_set_event_filter(snd_seq_client_info_t *info, unsigned char *filter);
+
+void snd_seq_client_info_event_filter_clear(snd_seq_client_info_t *info);
+void snd_seq_client_info_event_filter_add(snd_seq_client_info_t *info, int event_type);
+void snd_seq_client_info_event_filter_del(snd_seq_client_info_t *info, int event_type);
+int snd_seq_client_info_event_filter_check(snd_seq_client_info_t *info, int event_type);
 
 int snd_seq_get_client_info(snd_seq_t *handle, snd_seq_client_info_t *info);
 int snd_seq_get_any_client_info(snd_seq_t *handle, int client, snd_seq_client_info_t *info);
@@ -575,6 +580,7 @@ int snd_seq_remove_events(snd_seq_t *han
  */
 
 void snd_seq_set_bit(int nr, void *array);
+void snd_seq_unset_bit(int nr, void *array);
 int snd_seq_change_bit(int nr, void *array);
 int snd_seq_get_bit(int nr, void *array);
 
diff --git a/src/seq/seq.c b/src/seq/seq.c
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -1522,11 +1522,16 @@ int snd_seq_client_info_get_error_bounce
 }
 
 /**
- * \brief Get the event filter bitmap of a client_info container
+ * \brief (DEPRECATED) Get the event filter bitmap of a client_info container
  * \param info client_info container
  * \return NULL if no event filter, or pointer to event filter bitmap
  *
- * \sa snd_seq_get_client_info(), snd_seq_client_info_set_event_filter()
+ * \sa snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_client_info_event_filter_clear(),
+ *     snd_seq_get_client_info(),
+ *     snd_seq_client_info_set_event_filter()
  */
 const unsigned char *snd_seq_client_info_get_event_filter(const snd_seq_client_info_t *info)
 {
@@ -1623,23 +1628,110 @@ void snd_seq_client_info_set_error_bounc
 }
 
 /**
- * \brief Set the event filter bitmap of a client_info container
+ * \brief (DEPRECATED) Set the event filter bitmap of a client_info container
  * \param info client_info container
- * \param filter event filter bitmap
- *
- * \sa snd_seq_get_client_info(), snd_seq_client_info_get_event_filger(),
+ * \param filter event filter bitmap, pass NULL for clearing the bitmap and disable event filtering
+ *
+ * \sa snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_client_info_event_filter_clear(),
+ *     snd_seq_get_client_info(),
+ *     snd_seq_client_info_get_event_filter(),
  *     snd_seq_set_client_event_filter()
  */
 void snd_seq_client_info_set_event_filter(snd_seq_client_info_t *info, unsigned char *filter)
 {
 	assert(info);
-	if (! filter)
+	if (! filter) {
 		info->filter &= ~SNDRV_SEQ_FILTER_USE_EVENT;
-	else {
+		memset(info->event_filter, 0, sizeof(info->event_filter));
+	} else {
 		info->filter |= SNDRV_SEQ_FILTER_USE_EVENT;
 		memcpy(info->event_filter, filter, sizeof(info->event_filter));
 	}
 }
+
+/**
+ * \brief Disable event filtering of a client_info container
+ * \param info client_info container
+ *
+ * Remove all event types added with #snd_seq_client_info_event_filter_add and clear
+ * the event filtering flag of this client_info container.
+ * 
+ * \sa snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_get_client_info(),
+ *     snd_seq_set_client_info()
+ */
+void snd_seq_client_info_event_filter_clear(snd_seq_client_info_t *info)
+{
+	assert(info);
+	info->filter &= ~SNDRV_SEQ_FILTER_USE_EVENT;
+	memset(info->event_filter, 0, sizeof(info->event_filter));
+}
+
+/**
+ * \brief Add an event type to the event filtering of a client_info container
+ * \param info client_info container
+ * \param event_type event type to be added
+ * 
+ * Set the event filtering flag of this client_info and add the specified event type to the 
+ * filter bitmap of this client_info container.
+ *
+ * \sa snd_seq_get_client_info(),
+ *     snd_seq_set_client_info(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_client_info_event_filter_clear()
+ */
+void snd_seq_client_info_event_filter_add(snd_seq_client_info_t *info, int event_type)
+{
+	assert(info);
+	info->filter |= SNDRV_SEQ_FILTER_USE_EVENT;
+	snd_seq_set_bit(event_type, info->event_filter);
+}
+
+/**
+ * \brief Remove an event type from the event filtering of a client_info container
+ * \param info client_info container
+ * \param event_type event type to be removed
+ *
+ * Removes the specified event from the filter bitmap of this client_info container. It will
+ * not clear the event filtering flag, for this see #snd_seq_client_info_event_filter_clear
+ *
+ * \sa snd_seq_get_client_info(),
+ *     snd_seq_set_client_info(),
+ *     snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_client_info_event_filter_clear()
+ */
+void snd_seq_client_info_event_filter_del(snd_seq_client_info_t *info, int event_type)
+{
+	assert(info);
+	snd_seq_unset_bit(event_type, info->event_filter);
+}
+
+/**
+ * \brief Check if an event type is present in the event filtering of a client_info container
+ * \param info client_info container
+ * \param event_type event_type to be checked
+ * \return 1 if the event type is present, 0 otherwise
+ *
+ * Test if the event type is in the filter bitamp of this client_info container.
+ *
+ * \sa snd_seq_get_client_info(),
+ *     snd_seq_set_client_info(),
+ *     snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_clear()
+ */
+int snd_seq_client_info_event_filter_check(snd_seq_client_info_t *info, int event_type)
+{
+	assert(info);
+	return snd_seq_get_bit(event_type, info->event_filter);
+} 
 
 
 /**
@@ -4663,6 +4755,14 @@ void snd_seq_set_bit(int nr, void *array
 }
 
 /**
+ * \brief unset a bit flag
+ */
+void snd_seq_unset_bit(int nr, void *array)
+{
+	((unsigned int *)array)[nr >> 5] &= ~(1UL << (nr & 31));
+}
+
+/**
  * \brief change a bit flag
  */
 int snd_seq_change_bit(int nr, void *array)
@@ -4670,7 +4770,7 @@ int snd_seq_change_bit(int nr, void *arr
 	int result;
 
 	result = ((((unsigned int *)array)[nr >> 5]) & (1UL << (nr & 31))) ? 1 : 0;
-	((unsigned int *)array)[nr >> 5] |= 1UL << (nr & 31);
+	((unsigned int *)array)[nr >> 5] ^= 1UL << (nr & 31);
 	return result;
 }
 
diff --git a/src/seq/seqmid.c b/src/seq/seqmid.c
--- a/src/seq/seqmid.c
+++ b/src/seq/seqmid.c
@@ -251,8 +251,7 @@ int snd_seq_set_client_event_filter(snd_
 
 	if ((err = snd_seq_get_client_info(seq, &info)) < 0)
 		return err;
-	info.filter |= SNDRV_SEQ_FILTER_USE_EVENT;
-	snd_seq_set_bit(event_type, info.event_filter);
+	snd_seq_client_info_event_filter_add(&info, event_type);
 	return snd_seq_set_client_info(seq, &info);
 }
 
diff --git a/test/Makefile.am b/test/Makefile.am
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -1,6 +1,6 @@ check_PROGRAMS=control pcm pcm_min laten
 check_PROGRAMS=control pcm pcm_min latency seq \
 	       playmidi1 timer rawmidi midiloop \
-	       oldapi queue_timer namehint
+	       oldapi queue_timer namehint event_filter
 
 control_LDADD=../src/libasound.la
 pcm_LDADD=../src/libasound.la
@@ -15,6 +15,7 @@ queue_timer_LDADD=../src/libasound.la
 queue_timer_LDADD=../src/libasound.la
 namehint_LDADD=../src/libasound.la
 code_CFLAGS=-Wall -pipe -g -O2
+event_filter_LDADD=../src/libasound.la
 
 INCLUDES=-I$(top_srcdir)/include
 AM_CFLAGS=-Wall -pipe -g
diff --git a/test/event_filter.c b/test/event_filter.c
new file mode 100644
--- /dev/null
+++ b/test/event_filter.c
@@ -0,0 +1,86 @@
+#include <alsa/asoundlib.h>
+
+void dump_event_filter(snd_seq_client_info_t *client_info) {
+	int i, b;
+
+	for (i = 0; i <= 255;) {
+		b = snd_seq_client_info_event_filter_check(client_info, i);
+		i++;
+		printf("%c%s%s", (b ? 'X' : '.'),
+			(i % 8 == 0 ? " " : ""),
+			(i % 32 == 0 ? "\n" : ""));
+	}
+	printf("\n");
+}
+
+int main(void) {
+	snd_seq_t *seq;
+	snd_seq_client_info_t *client_info;
+	const unsigned char *event_filter;
+	int isnote;
+	int ispgmc;
+	int oldnote;
+
+	snd_seq_client_info_alloca(&client_info);
+	snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0);
+
+	snd_seq_get_client_info(seq, client_info);
+	event_filter = snd_seq_client_info_get_event_filter(client_info);
+	printf("Initial event_filter=0x%p\n", event_filter);
+
+	snd_seq_set_client_event_filter(seq, SND_SEQ_EVENT_NOTEON);
+	snd_seq_get_client_info(seq, client_info);
+	event_filter = snd_seq_client_info_get_event_filter(client_info);
+	isnote = snd_seq_get_bit(SND_SEQ_EVENT_NOTEON, (void *) event_filter);
+	printf("after snd_seq_set_client_event (EVENT_NOTEON)    : "
+		"event_filter=0x%p isnote=%d\n",
+		event_filter, isnote);
+	oldnote = snd_seq_change_bit(SND_SEQ_EVENT_NOTEON, (void *) event_filter);
+	isnote = snd_seq_get_bit(SND_SEQ_EVENT_NOTEON, (void *) event_filter);
+	printf("after snd_seq_change_bit                         : "
+		"event_filter=0x%p isnote=%d oldnote=%d\n ==> %s %s\n",
+		event_filter, isnote, oldnote, "snd_seq_change_bit",
+		(isnote == 0 ? "changed" : "ERROR: NOT CHANGED"));
+
+	snd_seq_get_client_info(seq, client_info);
+	snd_seq_client_info_set_event_filter(client_info, NULL);
+	snd_seq_set_client_info(seq, client_info);
+	event_filter = snd_seq_client_info_get_event_filter(client_info);
+	printf("after snd_seq_client_info_set_event_filter(NULL) : "
+		"event_filter=0x%p\n",
+		event_filter);
+	
+	snd_seq_set_client_event_filter(seq, SND_SEQ_EVENT_PGMCHANGE);
+	snd_seq_get_client_info(seq, client_info);
+	event_filter = snd_seq_client_info_get_event_filter(client_info);
+	isnote = snd_seq_get_bit(SND_SEQ_EVENT_NOTEON, (void *) event_filter);
+	ispgmc = snd_seq_get_bit(SND_SEQ_EVENT_PGMCHANGE, (void *) event_filter);
+	printf("after snd_seq_set_client_event (EVENT_PGMCHANGE) : "
+		"event_filter=0x%p isnote=%d ispgmc=%d\n ==> %s %s\n",
+		event_filter, isnote, ispgmc, "snd_seq_client_info_set_event_filter(NULL)",
+		(isnote == 0 ? "cleared" : "ERROR: NOT CLEARED"));
+
+	snd_seq_client_info_event_filter_clear(client_info);
+	printf("after snd_seq_client_info_event_filter_clear(client_info);\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_add(client_info, SND_SEQ_EVENT_NOTEON);
+	printf("after snd_seq_client_info_event_filter_add(client_info, SND_SEQ_EVENT_NOTEON);\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_add(client_info, SND_SEQ_EVENT_PGMCHANGE);
+	printf("after snd_seq_client_info_event_filter_add(client_info, SND_SEQ_EVENT_PGMCHANGE);\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_del(client_info, SND_SEQ_EVENT_NOTEON);
+	printf("after snd_seq_client_info_event_filter_del(client_info, SND_SEQ_EVENT_NOTEON);\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_clear(client_info);
+	printf("after snd_seq_client_info_event_filter_clear(client_info);\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_add(client_info, SND_SEQ_EVENT_NOTEON);
+	printf("after snd_seq_client_info_event_filter_add(client_info, SND_SEQ_EVENT_NOTEON);\n");
+	dump_event_filter(client_info);
+}

--=-HC6QF1sxU7dSICgYFOOF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-HC6QF1sxU7dSICgYFOOF--
