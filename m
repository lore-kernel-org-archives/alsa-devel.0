From: Martin Stransky <stransky@redhat.com>
Subject: alsa-lib patches
Date: Fri, 29 Apr 2005 15:57:52 +0200
Message-ID: <42723D60.4030208@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020009040209060407000700"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020009040209060407000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

there are some patches for alsa-lib (1.0.9rc2), we use them in Fedora 4. 
About mixer patch - some user had a problem with ICH6 and this patch helped.

Otherwise, we try to use dmix as the default pcm device in FC4, we have 
experimental ainit tool for run-time creation of ~/.asoundrc file with 
safely generated IPC keys for dmix/dsnoop/dshare plugins. Every feedback 
is welcome...

Ma.

--------------020009040209060407000700
Content-Type: text/x-patch;
 name="alsa-lib-alpha.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-alpha.patch"

--- alsa-lib-1.0.6/include/alsa-symbols.h.orig	2004-11-30 17:40:41.543824072 +0300
+++ alsa-lib-1.0.6/include/alsa-symbols.h	2004-11-30 17:42:34.828002372 +0300
@@ -57,10 +57,16 @@
 	__asm__ (".set " #name "," #real);		\
 	__asm__ (".set ." #name ",." #real)
 #else
+#ifdef __alpha__
+#define use_default_symbol_version(real, name, version) \
+        __asm__ (".weak " #name); \
+        __asm__ (#name " = " #real)
+#else
 #define use_default_symbol_version(real, name, version) \
 	__asm__ (".weak " #name); \
 	__asm__ (".set " #name "," #real)
 #endif
 #endif
+#endif
 
 #endif /* __ALSA_SYMBOLS_H */

--------------020009040209060407000700
Content-Type: text/x-patch;
 name="alsa-lib-gcc4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-gcc4.patch"

--- alsa-lib-1.0.9rc2/src/control/control.c.gcc4	2005-01-03 12:52:40.000000000 +0100
+++ alsa-lib-1.0.9rc2/src/control/control.c	2005-04-22 14:33:49.000000000 +0200
@@ -560,7 +560,7 @@
 int snd_ctl_read(snd_ctl_t *ctl, snd_ctl_event_t *event)
 {
 	assert(ctl && event);
-	return ctl->ops->read(ctl, event);
+	return (ctl->ops->read)(ctl, event);
 }
 
 /**
--- alsa-lib-1.0.9rc2/src/timer/timer.c.gcc4	2004-05-24 16:57:48.000000000 +0200
+++ alsa-lib-1.0.9rc2/src/timer/timer.c	2005-04-22 14:33:49.000000000 +0200
@@ -876,7 +876,7 @@
 	assert(timer);
 	assert(((timer->mode & O_ACCMODE) == O_RDONLY) || ((timer->mode & O_ACCMODE) == O_RDWR));
 	assert(buffer || size == 0);
-	return timer->ops->read(timer, buffer, size);
+	return (timer->ops->read)(timer, buffer, size);
 }
 
 /**
--- alsa-lib-1.0.9rc2/src/conf.c.gcc4	2005-02-14 16:09:10.000000000 +0100
+++ alsa-lib-1.0.9rc2/src/conf.c	2005-04-22 14:33:49.000000000 +0200
@@ -2506,9 +2506,11 @@
  *               specified by \p result.
  * \return Zero if successful, otherwise a negative error code.
  */
+
+static int snd_config_hooks(snd_config_t *config, snd_config_t *private_data);
+
 int snd_config_search_hooks(snd_config_t *config, const char *key, snd_config_t **result)
 {
-	static int snd_config_hooks(snd_config_t *config, snd_config_t *private_data);
 	SND_CONFIG_SEARCH(config, key, result, \
 					err = snd_config_hooks(config, NULL); \
 					if (err < 0) \
@@ -2526,9 +2528,10 @@
  *               specified by \p result.
  * \return Zero if successful, otherwise a negative error code.
  */
+static int snd_config_hooks(snd_config_t *config, snd_config_t *private_data);
+
 int snd_config_searcha_hooks(snd_config_t *root, snd_config_t *config, const char *key, snd_config_t **result)
 {
-	static int snd_config_hooks(snd_config_t *config, snd_config_t *private_data);
 	SND_CONFIG_SEARCHA(root, config, key, result,
 					snd_config_searcha_hooks,
 					err = snd_config_hooks(config, NULL); \
--- alsa-lib-1.0.9rc2/src/pcm/pcm_dmix_generic.c.gcc4	2005-02-08 21:28:31.000000000 +0100
+++ alsa-lib-1.0.9rc2/src/pcm/pcm_dmix_generic.c	2005-04-22 14:49:57.000000000 +0200
@@ -72,9 +72,9 @@
 		} while (*sum != old_sample);
 		if (!--size)
 			return;
-		src += src_step;
-		dst += dst_step;
-		sum += sum_step;
+		src = (signed short *) ((char *)src + src_step);
+		dst = (signed short *) ((char *)dst + dst_step);
+		sum = (signed int *)   ((char *)sum + sum_step);
 	}
 }
 
@@ -106,9 +106,9 @@
 		} while (*sum != old_sample);
 		if (!--size)
 			return;
-		src += src_step;
-		dst += dst_step;
-		sum += sum_step;
+		src = (signed int *) ((char *)src + src_step);
+		dst = (signed int *) ((char *)dst + dst_step);
+		sum = (signed int *) ((char *)sum + sum_step);
 	}
 }
 
--- alsa-lib-1.0.9rc2/src/pcm/pcm_plugin.c.gcc4	2005-01-20 16:07:59.000000000 +0100
+++ alsa-lib-1.0.9rc2/src/pcm/pcm_plugin.c	2005-04-22 14:33:49.000000000 +0200
@@ -316,7 +316,7 @@
 		snd_pcm_mmap_begin(slave, &slave_areas, &slave_offset, &slave_frames);
 		if (slave_frames == 0)
 			break;
-		frames = plugin->read(pcm, areas, offset, frames,
+		frames = (plugin->read)(pcm, areas, offset, frames,
 				      slave_areas, slave_offset, &slave_frames);
 		if (CHECK_SANITY(slave_frames > snd_pcm_mmap_capture_avail(slave))) {
 			SNDMSG("read overflow %ld > %ld", slave_frames,
@@ -488,7 +488,7 @@
 				return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
 			if (frames > cont)
 				frames = cont;
-			frames = plugin->read(pcm, areas, hw_offset, frames,
+			frames = (plugin->read)(pcm, areas, hw_offset, frames,
 					      slave_areas, slave_offset, &slave_frames);
 			snd_atomic_write_begin(&plugin->watom);
 			snd_pcm_mmap_hw_forward(pcm, frames);
--- alsa-lib-1.0.9rc2/src/hwdep/hwdep.c.gcc4	2004-05-24 16:57:47.000000000 +0200
+++ alsa-lib-1.0.9rc2/src/hwdep/hwdep.c	2005-04-22 14:33:49.000000000 +0200
@@ -485,7 +485,7 @@
 	assert(hwdep);
 	assert(((hwdep->mode & O_ACCMODE) == O_RDONLY) || ((hwdep->mode & O_ACCMODE) == O_RDWR));
 	assert(buffer || size == 0);
-	return hwdep->ops->read(hwdep, buffer, size);
+	return (hwdep->ops->read)(hwdep, buffer, size);
 }
 
 /**
--- alsa-lib-1.0.9rc2/src/rawmidi/rawmidi.c.gcc4	2004-09-28 12:45:33.000000000 +0200
+++ alsa-lib-1.0.9rc2/src/rawmidi/rawmidi.c	2005-04-22 14:33:49.000000000 +0200
@@ -987,5 +987,5 @@
 	assert(rawmidi);
 	assert(rawmidi->stream == SND_RAWMIDI_STREAM_INPUT);
 	assert(buffer || size == 0);
-	return rawmidi->ops->read(rawmidi, buffer, size);
+	return (rawmidi->ops->read)(rawmidi, buffer, size);
 }
--- alsa-lib-1.0.9rc2/src/seq/seq.c.gcc4	2004-03-23 16:15:21.000000000 +0100
+++ alsa-lib-1.0.9rc2/src/seq/seq.c	2005-04-22 14:33:49.000000000 +0200
@@ -3914,7 +3914,7 @@
 static ssize_t snd_seq_event_read_buffer(snd_seq_t *seq)
 {
 	ssize_t len;
-	len = seq->ops->read(seq, seq->ibuf, seq->ibufsize * sizeof(snd_seq_event_t));
+	len = (seq->ops->read)(seq, seq->ibuf, seq->ibufsize * sizeof(snd_seq_event_t));
 	if (len < 0)
 		return len;
 	seq->ibuflen = len / sizeof(snd_seq_event_t);

--------------020009040209060407000700
Content-Type: text/x-patch;
 name="alsa-lib-mixer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-mixer.patch"

--- alsa-lib-1.0.9rc2/src/mixer/mixer.c.old	2005-04-22 14:15:33.000000000 +0200
+++ alsa-lib-1.0.9rc2/src/mixer/mixer.c	2005-04-22 14:27:40.000000000 +0200
@@ -520,14 +520,22 @@
 	return c1->class->compare(c1, c2);
 }
 
+static snd_mixer_t *qsort_mixer;
 typedef int (*qsort_func)(const void *, const void *);
+
+static int compar(const void *a, const void *b) {
+       return qsort_mixer->compare(*(const snd_mixer_elem_t * const *) a,
+                                   *(const snd_mixer_elem_t * const *) b);
+}
+
 static int snd_mixer_sort(snd_mixer_t *mixer)
 {
 	unsigned int k;
 	assert(mixer);
 	assert(mixer->compare);
 	INIT_LIST_HEAD(&mixer->elems);
-	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*), (qsort_func)mixer->compare);
+        qsort_mixer = mixer;
+	qsort(mixer->pelems, mixer->count, sizeof(snd_mixer_elem_t*), compar);
 	for (k = 0; k < mixer->count; k++)
 		list_add_tail(&mixer->pelems[k]->list, &mixer->elems);
 	return 0;

--------------020009040209060407000700--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
