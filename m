From: Aldrin Martoq <amartoq@dcc.uchile.cl>
Subject: Re: [PATCH] alsa-lib: issues in snd_seq_change_bit	and
	some enhancements
Date: Fri, 22 Feb 2008 02:25:06 -0300
Message-ID: <1203657906.6438.22.camel@localhost>
References: <1203577712.13752.33.camel@localhost> <47BD2F61.7070103@ladisch.de>
	<17eedd8a0802210112k548c1e0fx4c6cf04bfc9ae780@mail.gmail.com>
	<s5htzk2o81w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id B02F124561
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 06:25:14 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so63068ana.80
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 21:25:13 -0800 (PST)
In-Reply-To: <s5htzk2o81w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-02-21 at 12:36 +0100, Takashi Iwai wrote:
> Could you split the patches?
Hi Takashi, glad to do.

> I applied the fix for
> snd_seq_change_bit() to HG tree now, as it's an obvious bug.
> The others are rather extensions.
> 
> - a patch to add snd_seq_unset_bit()
> - a patch to add new *_event_filter_*() APIs
> - a patch to add new test code
> 
> Don't forget to give a proper changelog for each.

By proper changelog is sufficient the comments for each patch?

So, here we come. Each patch must be applied in the following order.

Patch 1
=======

Added snd_seq_unset_bit() to alsa sequencer API

Signed-off-by: Aldrin Martoq <amartoq@dcc.uchile.cl>
---
diff --git a/include/seq.h b/include/seq.h
--- a/include/seq.h
+++ b/include/seq.h
@@ -575,6 +575,7 @@ int snd_seq_remove_events(snd_seq_t *han
  */
 
 void snd_seq_set_bit(int nr, void *array);
+void snd_seq_unset_bit(int nr, void *array);
 int snd_seq_change_bit(int nr, void *array);
 int snd_seq_get_bit(int nr, void *array);
 
diff --git a/src/seq/seq.c b/src/seq/seq.c
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -4663,6 +4663,14 @@ void snd_seq_set_bit(int nr, void *array
 }
 
 /**
+ * \brief unset a bit flag
+ */
+void snd_seq_unset_bit(int nr, void *array)
+{
+       ((unsigned int *)array)[nr >> 5] &= ~(1UL << (nr & 31));
+}
+
+/**
  * \brief change a bit flag
  */
 int snd_seq_change_bit(int nr, void *array)



Patch 2
=======

Added snd_seq_client_info_event_filter_{clear,add,del,check} to alsa
sequencer API

Signed-off-by: Aldrin Martoq <amartoq@dcc.uchile.cl>
---
diff -r a002b0270947 include/seq.h
--- a/include/seq.h	Fri Feb 22 01:48:15 2008 -0300
+++ b/include/seq.h	Fri Feb 22 01:59:28 2008 -0300
@@ -152,6 +152,11 @@ void snd_seq_client_info_set_broadcast_f
 void snd_seq_client_info_set_broadcast_filter(snd_seq_client_info_t
*info, int val);
 void snd_seq_client_info_set_error_bounce(snd_seq_client_info_t *info,
int val);
 void snd_seq_client_info_set_event_filter(snd_seq_client_info_t *info,
unsigned char *filter);
+
+void snd_seq_client_info_event_filter_clear(snd_seq_client_info_t
*info);
+void snd_seq_client_info_event_filter_add(snd_seq_client_info_t *info,
int event_type);
+void snd_seq_client_info_event_filter_del(snd_seq_client_info_t *info,
int event_type);
+int snd_seq_client_info_event_filter_check(snd_seq_client_info_t *info,
int event_type);
 
 int snd_seq_get_client_info(snd_seq_t *handle, snd_seq_client_info_t
*info);
 int snd_seq_get_any_client_info(snd_seq_t *handle, int client,
snd_seq_client_info_t *info);
diff -r a002b0270947 src/seq/seq.c
--- a/src/seq/seq.c	Fri Feb 22 01:48:15 2008 -0300
+++ b/src/seq/seq.c	Fri Feb 22 01:59:28 2008 -0300
@@ -1538,6 +1538,87 @@ const unsigned char *snd_seq_client_info
 }
 
 /**
+ * \brief Disable event filtering of a client_info container
+ * \param info client_info container
+ *
+ * Remove all event types added with
#snd_seq_client_info_event_filter_add and clear
+ * the event filtering flag of this client_info container.
+ * 
+ * \sa snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_get_client_info(),
+ *     snd_seq_set_client_info()
+ */
+void snd_seq_client_info_event_filter_clear(snd_seq_client_info_t
*info)
+{
+       assert(info);
+       info->filter &= ~SNDRV_SEQ_FILTER_USE_EVENT;
+       memset(info->event_filter, 0, sizeof(info->event_filter));
+}
+
+/**
+ * \brief Add an event type to the event filtering of a client_info
container
+ * \param info client_info container
+ * \param event_type event type to be added
+ * 
+ * Set the event filtering flag of this client_info and add the
specified event type to the 
+ * filter bitmap of this client_info container.
+ *
+ * \sa snd_seq_get_client_info(),
+ *     snd_seq_set_client_info(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_client_info_event_filter_clear()
+ */
+void snd_seq_client_info_event_filter_add(snd_seq_client_info_t *info,
int event_type)
+{
+       assert(info);
+       info->filter |= SNDRV_SEQ_FILTER_USE_EVENT;
+       snd_seq_set_bit(event_type, info->event_filter);
+}
+
+/**
+ * \brief Remove an event type from the event filtering of a
client_info container
+ * \param info client_info container
+ * \param event_type event type to be removed
+ *
+ * Removes the specified event from the filter bitmap of this
client_info container. It will
+ * not clear the event filtering flag, use
#snd_seq_client_info_event_filter_clear instead.
+ *
+ * \sa snd_seq_get_client_info(),
+ *     snd_seq_set_client_info(),
+ *     snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_client_info_event_filter_clear()
+ */
+void snd_seq_client_info_event_filter_del(snd_seq_client_info_t *info,
int event_type)
+{
+       assert(info);
+       snd_seq_unset_bit(event_type, info->event_filter);
+}
+
+/**
+ * \brief Check if an event type is present in the event filtering of a
client_info container
+ * \param info client_info container
+ * \param event_type event type to be checked
+ * \return 1 if the event type is present, 0 otherwise
+ *
+ * Test if the event type is in the filter bitamp of this client_info
container.
+ *
+ * \sa snd_seq_get_client_info(),
+ *     snd_seq_set_client_info(),
+ *     snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_clear()
+ */
+int snd_seq_client_info_event_filter_check(snd_seq_client_info_t *info,
int event_type)
+{
+       assert(info);
+       return snd_seq_get_bit(event_type, info->event_filter);
+} 
+
+/**
  * \brief Get the number of opened ports of a client_info container
  * \param info client_info container
  * \return number of opened ports



PATCH 3
=======

Added test code for
snd_seq_client_info_event_filter_{clear,add,del,check}

Signed-off-by: Aldrin Martoq <amartoq@dcc.uchile.cl>
---
diff -r d6d0af1de86d test/Makefile.am
--- a/test/Makefile.am	Fri Feb 22 02:01:06 2008 -0300
+++ b/test/Makefile.am	Fri Feb 22 02:10:43 2008 -0300
@@ -1,6 +1,6 @@ check_PROGRAMS=control pcm pcm_min laten
 check_PROGRAMS=control pcm pcm_min latency seq \
 	       playmidi1 timer rawmidi midiloop \
-	       oldapi queue_timer namehint
+	       oldapi queue_timer namehint client_event_filter
 
 control_LDADD=../src/libasound.la
 pcm_LDADD=../src/libasound.la
@@ -14,6 +14,7 @@ oldapi_LDADD=../src/libasound.la
 oldapi_LDADD=../src/libasound.la
 queue_timer_LDADD=../src/libasound.la
 namehint_LDADD=../src/libasound.la
+client_event_filter_LDADD=../src/libasound.la
 code_CFLAGS=-Wall -pipe -g -O2
 
 INCLUDES=-I$(top_srcdir)/include
diff -r d6d0af1de86d test/client_event_filter.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/test/client_event_filter.c	Fri Feb 22 02:10:43 2008 -0300
@@ -0,0 +1,46 @@
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
+	snd_seq_client_info_t *client_info;
+
+	snd_seq_client_info_alloca(&client_info);
+
+	printf("first client_info_event_filter                   :\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_add(client_info,
SND_SEQ_EVENT_NOTEON);
+	printf("after snd_seq_client_info_event_filter_add(client_info,
SND_SEQ_EVENT_NOTEON);\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_add(client_info,
SND_SEQ_EVENT_PGMCHANGE);
+	printf("after snd_seq_client_info_event_filter_add(client_info,
SND_SEQ_EVENT_PGMCHANGE);\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_del(client_info,
SND_SEQ_EVENT_NOTEON);
+	printf("after snd_seq_client_info_event_filter_del(client_info,
SND_SEQ_EVENT_NOTEON);\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_clear(client_info);
+	printf("after snd_seq_client_info_event_filter_clear(client_info);
\n");
+	dump_event_filter(client_info);
+
+	snd_seq_client_info_event_filter_add(client_info,
SND_SEQ_EVENT_NOTEON);
+	printf("after snd_seq_client_info_event_filter_add(client_info,
SND_SEQ_EVENT_NOTEON);\n");
+	dump_event_filter(client_info);
+
+	return 0;
+}
+


PATCH 4
=======

Change snd_seq_set_client_event_filter to use the new
snd_seq_client_info_event_filter_* API

Signed-off-by: Aldrin Martoq <amartoq@dcc.uchile.cl>
---
diff -r a6718b9edd30 src/seq/seqmid.c
--- a/src/seq/seqmid.c	Fri Feb 22 02:12:53 2008 -0300
+++ b/src/seq/seqmid.c	Fri Feb 22 02:15:00 2008 -0300
@@ -251,8 +251,7 @@ int snd_seq_set_client_event_filter(snd_
 
 	if ((err = snd_seq_get_client_info(seq, &info)) < 0)
 		return err;
-	info.filter |= SNDRV_SEQ_FILTER_USE_EVENT;
-	snd_seq_set_bit(event_type, info.event_filter);
+	snd_seq_client_info_event_filter_add(&info, event_type);
 	return snd_seq_set_client_info(seq, &info);
 }



PATCH 5
=======

Mark snd_seq_client_info_{get,set}_event_filter deprecated

Signed-off-by: Aldrin Martoq <amartoq@dcc.uchile.cl>
---
diff -r 442154337bdf src/seq/seq.c
--- a/src/seq/seq.c	Fri Feb 22 02:15:58 2008 -0300
+++ b/src/seq/seq.c	Fri Feb 22 02:22:53 2008 -0300
@@ -1522,11 +1522,17 @@ int snd_seq_client_info_get_error_bounce
 }
 
 /**
- * \brief Get the event filter bitmap of a client_info container
+ * \brief (DEPRECATED) Get the event filter bitmap of a client_info
container
  * \param info client_info container
  * \return NULL if no event filter, or pointer to event filter bitmap
  *
- * \sa snd_seq_get_client_info(),
snd_seq_client_info_set_event_filter()
+ * Use #snd_seq_client_info_event_filter_check() instead.
+ *
+ * \sa snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_client_info_event_filter_clear(),
+ *     snd_seq_get_client_info()
  */
 const unsigned char *snd_seq_client_info_get_event_filter(const
snd_seq_client_info_t *info)
 {
@@ -1704,12 +1710,17 @@ void snd_seq_client_info_set_error_bounc
 }
 
 /**
- * \brief Set the event filter bitmap of a client_info container
+ * \brief (DEPRECATED) Set the event filter bitmap of a client_info
container
  * \param info client_info container
- * \param filter event filter bitmap
- *
- * \sa snd_seq_get_client_info(),
snd_seq_client_info_get_event_filger(),
- *     snd_seq_set_client_event_filter()
+ * \param filter event filter bitmap, pass NULL for no event filtering
+ *
+ * Use #snd_seq_client_info_event_filter_add instead.
+ *
+ * \sa snd_seq_client_info_event_filter_add(),
+ *     snd_seq_client_info_event_filter_del(),
+ *     snd_seq_client_info_event_filter_check(),
+ *     snd_seq_client_info_event_filter_clear(),
+ *     snd_seq_set_client_info()
  */
 void snd_seq_client_info_set_event_filter(snd_seq_client_info_t *info,
unsigned char *filter)
 {




Regards,

-- 
Aldrin Martoq <amartoq@dcc.uchile.cl>
