From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: surround51 problems.
Date: Sun, 02 Oct 2005 20:05:50 +0100
Message-ID: <43402F8E.3010806@superbug.demon.co.uk>
References: <433EC154.60206@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030802020701020801050708"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <433EC154.60206@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030802020701020801050708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

James Courtier-Dutton wrote:

> Hi,
>
> Has something changed in alsa-lib recently.
> I am using the latest alsa-cvs, and I cannot get surround51 to work.
> All these work:
> speaker-test -c2 -Dfront
> speaker-test -c2 -Dcenter_lfe
> speaker-test -c2 -Drear
> But the following fails and only outputs a distorted sound to the 
> front right speaker irrespective of the speaker it should come out of.
> speaker-test -c6 -Dsurround51
>
> James
>
>
In addition to the above. alsa-lib-1.0.10rc1 works fine.
If one applies the attached patch (diff between 1.0.10rc1 and current
CVS) one gets the problems I describe above.

James



--------------030802020701020801050708
Content-Type: text/plain;
 name="fail.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fail.diff"

Only in /u/alsacvs/alsa-lib/doc: doxygen
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/include/config.h /u/alsacvs/alsa-lib/include/config.h
--- alsa-lib-1.0.10rc1/include/config.h	2005-10-01 22:00:20.000000000 +0100
+++ /u/alsacvs/alsa-lib/include/config.h	2005-10-01 21:33:40.000000000 +0100
@@ -88,6 +88,8 @@
 /* Define to empty if `const' does not conform to ANSI C. */
 /* #undef const */
 
-/* Define as `__inline' if that's what the C compiler calls it, or to nothing
-   if it is not supported. */
+/* Define to `__inline__' or `__inline' if that's what the C compiler
+   calls it, or to nothing if 'inline' is not supported under any name.  */
+#ifndef __cplusplus
 /* #undef inline */
+#endif
Only in alsa-lib-1.0.10rc1/include: config.h.orig
Only in alsa-lib-1.0.10rc1/include: config.h.rej
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/include/local.h /u/alsacvs/alsa-lib/include/local.h
--- alsa-lib-1.0.10rc1/include/local.h	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/include/local.h	2005-09-29 20:11:50.000000000 +0100
@@ -73,6 +73,14 @@
 #define _snd_seq_remove_events sndrv_seq_remove_events
 #define _snd_instr_header sndrv_seq_instr_header
 
+#define sndrv_seq_addr	snd_seq_addr
+#define sndrv_seq_tick_time_t	snd_seq_tick_time_t
+#define sndrv_seq_real_time	snd_seq_real_time
+#define sndrv_seq_timestamp	snd_seq_timestamp
+#define sndrv_seq_instr		snd_seq_instr
+#define sndrv_seq_event		snd_seq_event
+#define sndrv_seq_instr_cluster_t	snd_seq_instr_cluster_t
+
 #if 0
 typedef struct sndrv_seq_addr snd_seq_addr_t;
 #define snd_seq_tick_time_t sndrv_seq_tick_time_t
@@ -96,7 +104,6 @@
 
 #include <sound/asound.h>
 #include <sound/asoundef.h>
-#include <sound/asequencer.h>
 #include "alsa-symbols.h"
 #include "version.h"
 #include "global.h"
@@ -113,6 +120,7 @@
 #include "mixer.h"
 #include "seq_event.h"
 #include "seq.h"
+#include <sound/asequencer.h>
 #include "seqmid.h"
 #include "seq_midi_event.h"
 #include "conv.h"
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/include/mixer.h /u/alsacvs/alsa-lib/include/mixer.h
--- alsa-lib-1.0.10rc1/include/mixer.h	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/include/mixer.h	2005-08-24 11:41:16.000000000 +0100
@@ -282,6 +282,8 @@
 					     long min, long max);
 
 int snd_mixer_selem_is_enumerated(snd_mixer_elem_t *elem);
+int snd_mixer_selem_is_enum_playback(snd_mixer_elem_t *elem);
+int snd_mixer_selem_is_enum_capture(snd_mixer_elem_t *elem);
 int snd_mixer_selem_get_enum_items(snd_mixer_elem_t *elem);
 int snd_mixer_selem_get_enum_item_name(snd_mixer_elem_t *elem, unsigned int idx, size_t maxlen, char *str);
 int snd_mixer_selem_get_enum_item(snd_mixer_elem_t *elem, snd_mixer_selem_channel_id_t channel, unsigned int *idxp);
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/include/mixer_abst.h /u/alsacvs/alsa-lib/include/mixer_abst.h
--- alsa-lib-1.0.10rc1/include/mixer_abst.h	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/include/mixer_abst.h	2005-08-24 11:41:16.000000000 +0100
@@ -50,7 +50,8 @@
 #define SM_CAP_CSWITCH		(1<<9) 
 #define SM_CAP_CSWITCH_JOIN	(1<<10)
 #define SM_CAP_CSWITCH_EXCL	(1<<11)
-#define SM_CAP_ENUM		(1<<12)
+#define SM_CAP_PENUM		(1<<12)
+#define SM_CAP_CENUM		(1<<13)
 /* SM_CAP_* 24-31 => private for module use */
 
 #define SM_OPS_IS_ACTIVE	0
@@ -96,6 +97,8 @@
 
 int snd_mixer_sbasic_info(const snd_mixer_class_t *class, sm_class_basic_t *info);
 void *snd_mixer_sbasic_get_private(const snd_mixer_class_t *class);
+void snd_mixer_sbasic_set_private(const snd_mixer_class_t *class, void *private_data);
+void snd_mixer_sbasic_set_private_free(const snd_mixer_class_t *class, void (*private_free)(snd_mixer_class_t *class));
 
 /** \} */
 
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/include/pcm.h /u/alsacvs/alsa-lib/include/pcm.h
--- alsa-lib-1.0.10rc1/include/pcm.h	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/include/pcm.h	2005-09-21 09:24:31.000000000 +0100
@@ -305,7 +305,7 @@
 	SND_PCM_TYPE_HW = 0,
 	/** Hooked PCM */
 	SND_PCM_TYPE_HOOKS,
-	/** One ore more linked PCM with exclusive access to selected
+	/** One or more linked PCM with exclusive access to selected
 	    channels */
 	SND_PCM_TYPE_MULTI,
 	/** File writing plugin */
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/include/sound/asequencer.h /u/alsacvs/alsa-lib/include/sound/asequencer.h
--- alsa-lib-1.0.10rc1/include/sound/asequencer.h	2004-08-23 08:24:54.000000000 +0100
+++ /u/alsacvs/alsa-lib/include/sound/asequencer.h	2005-09-29 20:11:50.000000000 +0100
@@ -31,6 +31,7 @@
 /** version of the sequencer */
 #define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 1)
 
+#ifdef __KERNEL__
 /**
  * definition of sequencer event types
  */
@@ -474,6 +475,8 @@
 /* queue sync port */
 #define sndrv_seq_queue_sync_port(q)	((q) + 16)
 
+#endif /* __KERNEL__ */
+
 	/* system information */
 struct sndrv_seq_system_info {
 	int queues;			/* maximum queues count */
Only in /u/alsacvs/alsa-lib/include: stamp-vh
Only in /u/alsacvs/alsa-lib: modules
Files alsa-lib-1.0.10rc1/src/.libs/libasound.so.2 and /u/alsacvs/alsa-lib/src/.libs/libasound.so.2 differ
Files alsa-lib-1.0.10rc1/src/.libs/libasound.so.2.0.0 and /u/alsacvs/alsa-lib/src/.libs/libasound.so.2.0.0 differ
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/confmisc.c /u/alsacvs/alsa-lib/src/confmisc.c
--- alsa-lib-1.0.10rc1/src/confmisc.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/confmisc.c	2005-09-29 12:46:59.000000000 +0100
@@ -854,6 +854,123 @@
 #endif
 
 /**
+ * \brief Returns the pcm card and device arguments (in form CARD=N,DEV=M)
+ *                for pcm specified by class and index.
+ * \param dst The function puts the handle to the result configuration node
+ *            (with type string) at the address specified by \p dst.
+ * \param root Handle to the root source node.
+ * \param src Handle to the source node, with definitions for \c class
+ *            and \c index.
+ * \param private_data Handle to the \c private_data node.
+ * \return A non-negative value if successful, otherwise a negative error code.
+ *
+ * Example:
+\code
+	{
+		@func pcm_args_by_class
+		class 0
+		index 0
+	}
+\endcode
+ */ 
+int snd_func_pcm_args_by_class(snd_config_t **dst, snd_config_t *root, snd_config_t *src, void *private_data)
+{
+	snd_config_t *n;
+	snd_ctl_t *ctl = NULL;
+	snd_pcm_info_t *info;
+	const char *id;
+	int card = -1, dev;
+	long class, index;
+	int idx = 0;
+	int err;
+
+	err = snd_config_search(src, "class", &n);
+	if (err < 0) {
+		SNDERR("field class not found");
+		goto __out;
+	}
+	err = snd_config_evaluate(n, root, private_data, NULL);
+	if (err < 0) {
+		SNDERR("error evaluating class");
+		goto __out;
+	}
+	err = snd_config_get_integer(n, &class);
+	if (err < 0) {
+		SNDERR("field class is not an integer");
+		goto __out;
+	}
+	err = snd_config_search(src, "index", &n);
+	if (err < 0) {
+		SNDERR("field index not found");
+		goto __out;
+	}
+	err = snd_config_evaluate(n, root, private_data, NULL);
+	if (err < 0) {
+		SNDERR("error evaluating index");
+		goto __out;
+	}
+	err = snd_config_get_integer(n, &index);
+	if (err < 0) {
+		SNDERR("field index is not an integer");
+		goto __out;
+	}
+
+	snd_pcm_info_alloca(&info);
+	while(1) {
+		err = snd_card_next(&card);
+		if (err < 0) {
+			SNDERR("could not get next card");
+			goto __out;
+		}
+		if (card < 0)
+			break;
+		err = open_ctl(card, &ctl);
+		if (err < 0) {
+			SNDERR("could not open control for card %li", card);
+			goto __out;
+		}
+		dev = -1;
+		memset(info, 0, snd_pcm_info_sizeof());
+		while(1) {
+			err = snd_ctl_pcm_next_device(ctl, &dev);
+			if (err < 0) {
+				SNDERR("could not get next pcm for card %li", card);
+				goto __out;
+			}
+			if (dev < 0)
+				break;
+			snd_pcm_info_set_device(info, dev);
+			err = snd_ctl_pcm_info(ctl, info);
+			if (err < 0)
+				continue;
+			if (snd_pcm_info_get_class(info) == (snd_pcm_class_t)class &&
+					index == idx++)
+				goto __out;
+		}
+      		snd_ctl_close(ctl);
+		ctl = NULL;
+	}
+	err = -ENODEV;
+
+      __out:
+      	if (ctl)
+      		snd_ctl_close(ctl);
+	if (err < 0)
+		return err;
+	if((err = snd_config_get_id(src, &id)) >= 0) {
+		char name[32], *s;
+		snprintf(name, sizeof(name), "CARD=%i,DEV=%i", card, dev);
+		if (!(s = strdup(name)))
+			return -ENOMEM;
+		err = snd_config_imake_string(dst, id, s);
+	}
+	return err;
+}
+#ifndef DOC_HIDDEN
+SND_DLSYM_BUILD_VERSION(snd_func_pcm_args_by_class, SND_CONFIG_DLSYM_VERSION_EVALUATE);
+#endif
+
+/**
  * \brief Returns the PCM subdevice from \c private_data.
  * \param dst The function puts the handle to the result configuration node
  *            (with type integer) at the address specified by \p dst.
Only in alsa-lib-1.0.10rc1/src/mixer: simple
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/mixer/simple.c /u/alsacvs/alsa-lib/src/mixer/simple.c
--- alsa-lib-1.0.10rc1/src/mixer/simple.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/mixer/simple.c	2005-08-24 11:41:16.000000000 +0100
@@ -102,7 +102,7 @@
 }
 
 #define CHECK_ENUM(xelem) \
-	if (!((sm_selem_t *)(elem)->private_data)->caps & SM_CAP_ENUM) \
+	if (!((sm_selem_t *)(elem)->private_data)->caps & (SM_CAP_PENUM|SM_CAP_CENUM)) \
 		return -EINVAL;
 
 #define COND_CAPS(xelem, what) \
@@ -822,6 +822,30 @@
 }
 
 /**
+ * \brief Return true if mixer simple enumerated element belongs to the playback direction
+ * \param elem Mixer simple element handle
+ * \return 0 no playback direction, 1 playback direction
+ */
+int snd_mixer_selem_is_enum_playback(snd_mixer_elem_t *elem)
+{
+	CHECK_BASIC(elem);
+	CHECK_ENUM(elem);
+	return sm_selem_ops(elem)->is(elem, SM_PLAY, SM_OPS_IS_ENUMERATED, 1);
+}
+
+/**
+ * \brief Return true if mixer simple enumerated element belongs to the capture direction
+ * \param elem Mixer simple element handle
+ * \return 0 no capture direction, 1 capture direction
+ */
+int snd_mixer_selem_is_enum_capture(snd_mixer_elem_t *elem)
+{
+	CHECK_BASIC(elem);
+	CHECK_ENUM(elem);
+	return sm_selem_ops(elem)->is(elem, SM_CAPT, SM_OPS_IS_ENUMERATED, 1);
+}
+
+/**
  * \brief Return the number of enumerated items of the given mixer simple element
  * \param elem Mixer simple element handle
  * \return the number of enumerated items, otherwise a negative error code
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/mixer/simple_none.c /u/alsacvs/alsa-lib/src/mixer/simple_none.c
--- alsa-lib-1.0.10rc1/src/mixer/simple_none.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/mixer/simple_none.c	2005-08-24 11:41:16.000000000 +0100
@@ -721,7 +721,8 @@
 	if (ctl->elem) {
 		if (pchannels < ctl->values)
 			pchannels = ctl->values;
-		caps |= SM_CAP_ENUM;
+		/* FIXME: differentiate some controls */
+		caps |= SM_CAP_PENUM|SM_CAP_CENUM;
 	}
 	if (pchannels > 32)
 		pchannels = 32;
@@ -910,6 +911,11 @@
 		return (unsigned int) val < s->str[dir].channels;
 
 	case SM_OPS_IS_ENUMERATED:
+		if (val == 1) {
+			if (dir == SM_PLAY && (s->selem.caps & SM_CAP_PENUM))
+				return 1;
+			return !!(s->selem.caps & SM_CAP_CENUM);
+		}
 		return s->ctls[CTL_ENUMLIST].elem != 0;
 	
 	case SM_OPS_IS_ENUMCNT:
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm.c /u/alsacvs/alsa-lib/src/pcm/pcm.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm.c	2005-09-29 20:11:50.000000000 +0100
@@ -745,9 +745,9 @@
 		return -EBADFD;
 	memset(params, 0, snd_pcm_hw_params_sizeof());
 	params->flags = pcm->hw_flags;
-	snd_mask_copy(&params->masks[SND_PCM_HW_PARAM_ACCESS - SND_PCM_HW_PARAM_FIRST_MASK], (snd_mask_t *)&pcm->access);
-	snd_mask_copy(&params->masks[SND_PCM_HW_PARAM_FORMAT - SND_PCM_HW_PARAM_FIRST_MASK], (snd_mask_t *)&pcm->format);
-	snd_mask_copy(&params->masks[SND_PCM_HW_PARAM_SUBFORMAT - SND_PCM_HW_PARAM_FIRST_MASK], (snd_mask_t *)&pcm->subformat);
+	snd_mask_set(&params->masks[SND_PCM_HW_PARAM_ACCESS - SND_PCM_HW_PARAM_FIRST_MASK], pcm->access);
+	snd_mask_set(&params->masks[SND_PCM_HW_PARAM_FORMAT - SND_PCM_HW_PARAM_FIRST_MASK], pcm->format);
+	snd_mask_set(&params->masks[SND_PCM_HW_PARAM_SUBFORMAT - SND_PCM_HW_PARAM_FIRST_MASK], pcm->subformat);
 	frame_bits = snd_pcm_format_physical_width(pcm->format) * pcm->channels;
 	snd_interval_set_value(&params->intervals[SND_PCM_HW_PARAM_FRAME_BITS - SND_PCM_HW_PARAM_FIRST_INTERVAL], frame_bits);
 	snd_interval_set_value(&params->intervals[SND_PCM_HW_PARAM_CHANNELS - SND_PCM_HW_PARAM_FIRST_INTERVAL], pcm->channels);
@@ -1516,7 +1516,12 @@
 	PCMTYPE(LINEAR_FLOAT), 
 	PCMTYPE(LADSPA), 
 	PCMTYPE(DMIX), 
-	PCMTYPE(JACK), 
+	PCMTYPE(JACK),
+        PCMTYPE(DSNOOP),
+        PCMTYPE(IEC958),
+	PCMTYPE(SOFTVOL),
+        PCMTYPE(IOPLUG),
+        PCMTYPE(EXTPLUG),
 };
 
 static const char *snd_pcm_subformat_names[] = {
@@ -2239,15 +2244,18 @@
 		return -EIO;
 	}
 	do {
+		pollio = 0;
 		err_poll = poll(pfd, npfds, timeout);
-		if (err_poll < 0)
+		if (err_poll < 0) {
+		        if (errno == EINTR)
+		                continue;
 			return -errno;
+                }
 		if (! err_poll)
 			break;
 		err = snd_pcm_poll_descriptors_revents(pcm, pfd, npfds, revents);
 		if (err < 0)
 			return err;
-		pollio = 0;
 		for (i = 0; i < npfds; i++) {
 			if (revents[i] & (POLLERR | POLLNVAL)) {
 				/* check more precisely */
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_direct.c /u/alsacvs/alsa-lib/src/pcm/pcm_direct.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_direct.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_direct.c	2005-09-19 13:37:08.000000000 +0100
@@ -42,6 +42,12 @@
  *
  */
  
+union semun {
+	int              val;    /* Value for SETVAL */
+	struct semid_ds *buf;    /* Buffer for IPC_STAT, IPC_SET */
+	unsigned short  *array;  /* Array for GETALL, SETALL */
+	struct seminfo  *__buf;  /* Buffer for IPC_INFO (Linux specific) */
+};
  
 /*
  * FIXME:
@@ -50,6 +56,7 @@
 
 int snd_pcm_direct_semaphore_create_or_connect(snd_pcm_direct_t *dmix)
 {
+	union semun s;
 	struct semid_ds buf;
 	int i;
 
@@ -60,49 +67,19 @@
 	if (dmix->ipc_gid < 0)
 		return 0;
 	for (i = 0; i < DIRECT_IPC_SEMS; i++) {
-		if (semctl(dmix->semid, i, IPC_STAT, &buf) < 0) {
+		s.buf = &buf;
+		if (semctl(dmix->semid, i, IPC_STAT, s) < 0) {
 			int err = -errno;
 			snd_pcm_direct_semaphore_discard(dmix);
 			return err;
 		}
 		buf.sem_perm.gid = dmix->ipc_gid;
-		semctl(dmix->semid, i, IPC_SET, &buf);
+		s.buf = &buf;
+		semctl(dmix->semid, i, IPC_SET, s);
 	}
 	return 0;
 }
 
-int snd_pcm_direct_semaphore_discard(snd_pcm_direct_t *dmix)
-{
-	int i;
-
-	if (dmix->semid < 0)
-		return -EINVAL;
-	for (i = 0; i < DIRECT_IPC_SEMS; i++) {
-		if (semctl(dmix->semid, i, IPC_RMID, NULL) < 0)
-			return -errno;
-	}
-	dmix->semid = -1;
-	return 0;
-}
-
-int snd_pcm_direct_semaphore_down(snd_pcm_direct_t *dmix, int sem_num)
-{
-	struct sembuf op[2] = { { sem_num, 0, 0 }, { sem_num, 1, SEM_UNDO } };
-	assert(dmix->semid >= 0);
-	if (semop(dmix->semid, op, 2) < 0)
-		return -errno;
-	return 0;
-}
-
-int snd_pcm_direct_semaphore_up(snd_pcm_direct_t *dmix, int sem_num)
-{
-	struct sembuf op = { sem_num, -1, SEM_UNDO | IPC_NOWAIT };
-	assert(dmix->semid >= 0);
-	if (semop(dmix->semid, &op, 1) < 0)
-		return -errno;
-	return 0;
-}
-
 /*
  *  global shared memory area 
  */
@@ -147,7 +124,14 @@
 	return 0;
 }
 
-int snd_pcm_direct_shm_discard(snd_pcm_direct_t *dmix)
+/* discard shared memory */
+/*
+ * Define snd_* functions to be used in server.
+ * Since objects referred in a plugin can be released dynamically, a forked
+ * server should have statically linked functions.
+ * (e.g. Novell bugzilla #105772)
+ */
+static int _snd_pcm_direct_shm_discard(snd_pcm_direct_t *dmix)
 {
 	struct shmid_ds buf;
 	int ret = 0;
@@ -168,6 +152,12 @@
 	return ret;
 }
 
+/* ... and an exported version */
+int snd_pcm_direct_shm_discard(snd_pcm_direct_t *dmix)
+{
+	return _snd_pcm_direct_shm_discard(dmix);
+}
+
 /*
  *  server side
  */
@@ -182,7 +172,7 @@
 	return 0;
 }
 
-static int make_local_socket(const char *filename, int server, mode_t ipc_perm)
+static int make_local_socket(const char *filename, int server, mode_t ipc_perm, int ipc_gid)
 {
 	size_t l = strlen(filename);
 	size_t size = offsetof(struct sockaddr_un, sun_path) + l;
@@ -213,7 +203,17 @@
 				int result = -errno;
 				SYSERR("chmod failed: %s", filename);
 				close(sock);
+				unlink(filename);
+				return result;
+			}
+			if (chown(filename, -1, ipc_gid) < 0) {
+#if 0 /* it's not fatal */
+				int result = -errno;
+				SYSERR("chown failed: %s", filename);
+				close(sock);
+				unlink(filename);
 				return result;
+#endif
 			}
 		}
 	} else {
@@ -244,7 +244,7 @@
 	if (dmix->server_free)
 		dmix->server_free(dmix);
 	unlink(dmix->shmptr->socket_name);
-	snd_pcm_direct_shm_discard(dmix);
+	_snd_pcm_direct_shm_discard(dmix);
 	snd_pcm_direct_semaphore_discard(dmix);
 }
 
@@ -256,6 +256,40 @@
 	_exit(EXIT_SUCCESS);
 }
 
+/* This is a copy from ../socket.c, provided here only for a server job
+ * (see the comment above)
+ */
+static int _snd_send_fd(int sock, void *data, size_t len, int fd)
+{
+	int ret;
+	size_t cmsg_len = CMSG_LEN(sizeof(int));
+	struct cmsghdr *cmsg = alloca(cmsg_len);
+	int *fds = (int *) CMSG_DATA(cmsg);
+	struct msghdr msghdr;
+	struct iovec vec;
+
+	vec.iov_base = (void *)&data;
+	vec.iov_len = len;
+
+	cmsg->cmsg_len = cmsg_len;
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	*fds = fd;
+
+	msghdr.msg_name = NULL;
+	msghdr.msg_namelen = 0;
+	msghdr.msg_iov = &vec;
+ 	msghdr.msg_iovlen = 1;
+	msghdr.msg_control = cmsg;
+	msghdr.msg_controllen = cmsg_len;
+	msghdr.msg_flags = 0;
+
+	ret = sendmsg(sock, &msghdr, 0 );
+	if (ret < 0)
+		return -errno;
+	return ret;
+}
+
 static void server_job(snd_pcm_direct_t *dmix)
 {
 	int ret, sck, i;
@@ -299,7 +333,7 @@
 			struct shmid_ds buf;
 			snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT);
 			if (shmctl(dmix->shmid, IPC_STAT, &buf) < 0) {
-				snd_pcm_direct_shm_discard(dmix);
+				_snd_pcm_direct_shm_discard(dmix);
 				snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT);
 				continue;
 			}
@@ -320,7 +354,7 @@
 					unsigned char buf = 'A';
 					pfds[current+1].fd = sck;
 					pfds[current+1].events = POLLIN | POLLERR | POLLHUP;
-					snd_send_fd(sck, &buf, 1, dmix->hw_fd);
+					_snd_send_fd(sck, &buf, 1, dmix->hw_fd);
 					server_printf("DIRECT SERVER: fd sent ok\n");
 					current++;
 				}
@@ -368,7 +402,7 @@
 	if (ret < 0)
 		return ret;
 	
-	ret = make_local_socket(dmix->shmptr->socket_name, 1, dmix->ipc_perm);
+	ret = make_local_socket(dmix->shmptr->socket_name, 1, dmix->ipc_perm, dmix->ipc_gid);
 	if (ret < 0)
 		return ret;
 	dmix->server_fd = ret;
@@ -420,7 +454,7 @@
 	int ret;
 	unsigned char buf;
 
-	ret = make_local_socket(dmix->shmptr->socket_name, 0, dmix->ipc_perm);
+	ret = make_local_socket(dmix->shmptr->socket_name, 0, -1, -1);
 	if (ret < 0)
 		return ret;
 	dmix->comm_fd = ret;
@@ -760,13 +794,19 @@
 	ret = snd_pcm_hw_params_set_format(spcm, hw_params, params->format);
 	if (ret < 0) {
 		snd_pcm_format_t format;
-		switch (params->format) {
-		case SND_PCM_FORMAT_S32: format = SND_PCM_FORMAT_S16; break;
-		case SND_PCM_FORMAT_S16: format = SND_PCM_FORMAT_S32; break;
-		default:
-			SNDERR("invalid format");
-			return -EINVAL;
+		if (dmix->type == SND_PCM_TYPE_DMIX) {
+			switch (params->format) {
+			case SND_PCM_FORMAT_S32_LE:
+			case SND_PCM_FORMAT_S32_BE:
+			case SND_PCM_FORMAT_S16_LE:
+			case SND_PCM_FORMAT_S16_BE:
+				break;
+			default:
+				SNDERR("invalid format");
+				return -EINVAL;
+			}
 		}
+		format = params->format;
 		ret = snd_pcm_hw_params_set_format(spcm, hw_params, format);
 		if (ret < 0) {
 			SNDERR("requested or auto-format is not available");
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_direct.h /u/alsacvs/alsa-lib/src/pcm/pcm_direct.h
--- alsa-lib-1.0.10rc1/src/pcm/pcm_direct.h	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_direct.h	2005-09-01 18:31:52.000000000 +0100
@@ -131,9 +131,29 @@
 };
 
 int snd_pcm_direct_semaphore_create_or_connect(snd_pcm_direct_t *dmix);
-int snd_pcm_direct_semaphore_discard(snd_pcm_direct_t *dmix);
-int snd_pcm_direct_semaphore_down(snd_pcm_direct_t *dmix, int sem_num);
-int snd_pcm_direct_semaphore_up(snd_pcm_direct_t *dmix, int sem_num);
+
+static inline int snd_pcm_direct_semaphore_discard(snd_pcm_direct_t *dmix)
+{
+	if (dmix->semid >= 0) {
+		if (semctl(dmix->semid, 0, IPC_RMID, NULL) < 0)
+			return -errno;
+		dmix->semid = -1;
+	}
+	return 0;
+}
+
+static inline int snd_pcm_direct_semaphore_down(snd_pcm_direct_t *dmix, int sem_num)
+{
+	struct sembuf op[2] = { { sem_num, 0, 0 }, { sem_num, 1, SEM_UNDO } };
+	return semop(dmix->semid, op, 2);
+}
+
+static inline int snd_pcm_direct_semaphore_up(snd_pcm_direct_t *dmix, int sem_num)
+{
+	struct sembuf op = { sem_num, -1, SEM_UNDO | IPC_NOWAIT };
+	return semop(dmix->semid, &op, 1);
+}
+
 int snd_pcm_direct_shm_create_or_connect(snd_pcm_direct_t *dmix);
 int snd_pcm_direct_shm_discard(snd_pcm_direct_t *dmix);
 int snd_pcm_direct_server_create(snd_pcm_direct_t *dmix);
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_dmix.c /u/alsacvs/alsa-lib/src/pcm/pcm_dmix.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_dmix.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_dmix.c	2005-09-19 13:37:08.000000000 +0100
@@ -159,7 +159,8 @@
 	unsigned int chn, dchn, channels;
 	
 	channels = dmix->channels;
-	if (dmix->shmptr->s.format == SND_PCM_FORMAT_S16) {
+	if (dmix->shmptr->s.format == SND_PCM_FORMAT_S16_LE ||
+	    dmix->shmptr->s.format == SND_PCM_FORMAT_S16_BE) {
 		signed short *src;
 		volatile signed short *dst;
 		if (dmix->interleaved) {
@@ -1171,9 +1172,8 @@
 		params.period_time = 125000;    /* 0.125 seconds */
 
 	/* sorry, limited features */
-        if (params.format != SND_PCM_FORMAT_S16 &&
-            params.format != SND_PCM_FORMAT_S32) {
-		SNDERR("invalid format, specify s16 or s32");
+	if (! (dmix_supported_format & (1ULL << params.format))) {
+		SNDERR("Unsupported format");
 		snd_config_delete(sconf);
 		return -EINVAL;
 	}
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_dmix_generic.c /u/alsacvs/alsa-lib/src/pcm/pcm_dmix_generic.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_dmix_generic.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_dmix_generic.c	2005-09-19 13:37:08.000000000 +0100
@@ -47,6 +47,7 @@
 #define IS_CONCURRENT	0	/* no race check */
 #endif
 
+#if IS_CONCURRENT
 static void mix_areas1(unsigned int size,
 		       volatile signed short *dst, signed short *src,
 		       volatile signed int *sum, size_t dst_step,
@@ -114,3 +115,146 @@
 	dmix->u.dmix.mix_areas1 = mix_areas1;
 	dmix->u.dmix.mix_areas2 = mix_areas2;
 }
+
+#else
+
+/* non-concurrent version, supporting both endians */
+static unsigned long long dmix_supported_format =
+	(1ULL << SND_PCM_FORMAT_S16_LE) | (1ULL << SND_PCM_FORMAT_S32_LE) |
+	(1ULL << SND_PCM_FORMAT_S16_BE) | (1ULL << SND_PCM_FORMAT_S32_BE);
+
+#include <byteswap.h>
+
+static void mix_areas1_native(unsigned int size,
+			      volatile signed short *dst, signed short *src,
+			      volatile signed int *sum, size_t dst_step,
+			      size_t src_step, size_t sum_step)
+{
+	register signed int sample;
+
+	for (;;) {
+		sample = *src;
+		if (! *dst) {
+			*sum = sample;
+			*dst = *src;
+		} else {
+			sample += *sum;
+			*sum = sample;
+			if (sample > 0x7fff)
+				sample = 0x7fff;
+			else if (sample < -0x8000)
+				sample = -0x8000;
+			*dst = sample;
+		}
+		if (!--size)
+			return;
+		src = (signed short *) ((char *)src + src_step);
+		dst = (signed short *) ((char *)dst + dst_step);
+		sum = (signed int *)   ((char *)sum + sum_step);
+	}
+}
+
+static void mix_areas2_native(unsigned int size,
+			      volatile signed int *dst, signed int *src,
+			      volatile signed int *sum, size_t dst_step,
+			      size_t src_step, size_t sum_step)
+{
+	register signed int sample;
+
+	for (;;) {
+		sample = *src / 256;
+		if (! *dst) {
+			*sum = sample;
+			*dst = *src;
+		} else {
+			sample += *sum;
+			*sum = sample;
+			if (sample > 0x7fffff)
+				sample = 0x7fffffff;
+			else if (sample < -0x800000)
+				sample = -0x80000000;
+			else
+				sample *= 256;
+			*dst = sample;
+		}
+		if (!--size)
+			return;
+		src = (signed int *) ((char *)src + src_step);
+		dst = (signed int *) ((char *)dst + dst_step);
+		sum = (signed int *) ((char *)sum + sum_step);
+	}
+}
+
+static void mix_areas1_swap(unsigned int size,
+			    volatile signed short *dst, signed short *src,
+			    volatile signed int *sum, size_t dst_step,
+			    size_t src_step, size_t sum_step)
+{
+	register signed int sample;
+
+	for (;;) {
+		sample = bswap_16(*src);
+		if (! *dst) {
+			*sum = sample;
+			*dst = *src;
+		} else {
+			sample += *sum;
+			*sum = sample;
+			if (sample > 0x7fff)
+				sample = 0x7fff;
+			else if (sample < -0x8000)
+				sample = -0x8000;
+			*dst = bswap_16((signed short)sample);
+		}
+		if (!--size)
+			return;
+		src = (signed short *) ((char *)src + src_step);
+		dst = (signed short *) ((char *)dst + dst_step);
+		sum = (signed int *)   ((char *)sum + sum_step);
+	}
+}
+
+static void mix_areas2_swap(unsigned int size,
+			    volatile signed int *dst, signed int *src,
+			    volatile signed int *sum, size_t dst_step,
+			    size_t src_step, size_t sum_step)
+{
+	register signed int sample;
+
+	for (;;) {
+		sample = bswap_32(*src) / 256;
+		if (! *dst) {
+			*sum = sample;
+			*dst = *src;
+		} else {
+			sample += *sum;
+			*sum = sample;
+			if (sample > 0x7fffff)
+				sample = 0x7fffffff;
+			else if (sample < -0x800000)
+				sample = -0x80000000;
+			else
+				sample *= 256;
+			*dst = bswap_32(sample);
+		}
+		if (!--size)
+			return;
+		src = (signed int *) ((char *)src + src_step);
+		dst = (signed int *) ((char *)dst + dst_step);
+		sum = (signed int *) ((char *)sum + sum_step);
+	}
+}
+
+
+static void mix_select_callbacks(snd_pcm_direct_t *dmix)
+{
+	if (snd_pcm_format_cpu_endian(dmix->shmptr->s.format)) {
+		dmix->u.dmix.mix_areas1 = mix_areas1_native;
+		dmix->u.dmix.mix_areas2 = mix_areas2_native;
+	} else {
+		dmix->u.dmix.mix_areas1 = mix_areas1_swap;
+		dmix->u.dmix.mix_areas2 = mix_areas2_swap;
+	}
+}
+
+#endif
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_dmix_i386.c /u/alsacvs/alsa-lib/src/pcm/pcm_dmix_i386.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_dmix_i386.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_dmix_i386.c	2005-09-19 13:37:08.000000000 +0100
@@ -22,6 +22,9 @@
 #undef MIX_AREAS2
 #undef LOCK_PREFIX
  
+static unsigned long long dmix_supported_format =
+	(1ULL << SND_PCM_FORMAT_S16_LE) | (1ULL << SND_PCM_FORMAT_S32_LE);
+
 static void mix_select_callbacks(snd_pcm_direct_t *dmix)
 {
 	FILE *in;
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_dmix_x86_64.c /u/alsacvs/alsa-lib/src/pcm/pcm_dmix_x86_64.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_dmix_x86_64.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_dmix_x86_64.c	2005-09-19 13:37:08.000000000 +0100
@@ -18,6 +18,9 @@
 #undef MIX_AREAS2
 #undef LOCK_PREFIX
  
+static unsigned long long dmix_supported_format =
+	(1ULL << SND_PCM_FORMAT_S16_LE) | (1ULL << SND_PCM_FORMAT_S32_LE);
+
 static void mix_select_callbacks(snd_pcm_direct_t *dmix)
 {
 	FILE *in;
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_dsnoop.c /u/alsacvs/alsa-lib/src/pcm/pcm_dsnoop.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_dsnoop.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_dsnoop.c	2005-09-12 18:50:57.000000000 +0100
@@ -338,13 +338,6 @@
 	return frames;
 }
 
-static int snd_pcm_dsnoop_resume(snd_pcm_t *pcm)
-{
-	snd_pcm_direct_t *dsnoop = pcm->private_data;
-	snd_pcm_resume(dsnoop->spcm);
-	return 0;
-}
-
 static snd_pcm_sframes_t snd_pcm_dsnoop_writei(snd_pcm_t *pcm ATTRIBUTE_UNUSED, const void *buffer ATTRIBUTE_UNUSED, snd_pcm_uframes_t size ATTRIBUTE_UNUSED)
 {
 	return -ENODEV;
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_file.c /u/alsacvs/alsa-lib/src/pcm/pcm_file.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_file.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_file.c	2005-09-02 17:36:40.000000000 +0100
@@ -302,26 +302,6 @@
 	return 0;
 }
 
-static int snd_pcm_file_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
-{
-	snd_pcm_file_t *file = pcm->private_data;
-	snd_pcm_t *slave = file->gen.slave;
-	pcm->running_areas = slave->running_areas;
-	pcm->stopped_areas = slave->stopped_areas;
-	pcm->mmap_channels = slave->mmap_channels;
-	pcm->mmap_shadow = 1;
-	return 0;
-}
-
-static int snd_pcm_file_munmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
-{
-	pcm->mmap_channels = NULL;
-	pcm->running_areas = NULL;
-	pcm->stopped_areas = NULL;
-	pcm->mmap_shadow = 0;
-	return 0;
-}
-
 static void snd_pcm_file_dump(snd_pcm_t *pcm, snd_output_t *out)
 {
 	snd_pcm_file_t *file = pcm->private_data;
@@ -348,8 +328,8 @@
 	.dump = snd_pcm_file_dump,
 	.nonblock = snd_pcm_generic_nonblock,
 	.async = snd_pcm_generic_async,
-	.mmap = snd_pcm_file_mmap,
-	.munmap = snd_pcm_file_munmap,
+	.mmap = snd_pcm_generic_mmap,
+	.munmap = snd_pcm_generic_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_file_fast_ops = {
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_generic.c /u/alsacvs/alsa-lib/src/pcm/pcm_generic.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_generic.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_generic.c	2005-09-02 17:36:40.000000000 +0100
@@ -113,7 +113,16 @@
 int snd_pcm_generic_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info)
 {
 	snd_pcm_generic_t *generic = pcm->private_data;
-	return snd_pcm_channel_info(generic->slave, info);
+	if (pcm->mmap_shadow) {
+		/* No own buffer is required - the plugin won't change
+		 * the data on the buffer, or do safely on-the-place
+		 * conversion
+		 */
+		return snd_pcm_channel_info(generic->slave, info);
+	} else {
+		/* Allocate own buffer */
+		return snd_pcm_channel_info_shm(generic->slave, info, -1);
+	}
 }
 
 int snd_pcm_generic_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
@@ -290,13 +299,26 @@
 	return snd_pcm_avail_update(generic->slave);
 }
 
-int snd_pcm_generic_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
+int snd_pcm_generic_mmap(snd_pcm_t *pcm)
 {
+	if (pcm->mmap_shadow) {
+		/* Copy the slave mmapped buffer data */
+		snd_pcm_generic_t *generic = pcm->private_data;
+		pcm->mmap_channels = generic->slave->mmap_channels;
+		pcm->running_areas = generic->slave->running_areas;
+		pcm->stopped_areas = generic->slave->stopped_areas;
+	}
 	return 0;
 }
 
-int snd_pcm_generic_munmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
+int snd_pcm_generic_munmap(snd_pcm_t *pcm)
 {
+	if (pcm->mmap_shadow) {
+		/* Clean up */
+		pcm->mmap_channels = NULL;
+		pcm->running_areas = NULL;
+		pcm->stopped_areas = NULL;
+	}
 	return 0;
 }
 
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_generic.h /u/alsacvs/alsa-lib/src/pcm/pcm_generic.h
--- alsa-lib-1.0.10rc1/src/pcm/pcm_generic.h	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_generic.h	2005-09-02 17:36:40.000000000 +0100
@@ -36,6 +36,7 @@
 int snd_pcm_generic_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
 int snd_pcm_generic_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
 int snd_pcm_generic_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t * info);
+int snd_pcm_generic_channel_info_no_buffer(snd_pcm_t *pcm, snd_pcm_channel_info_t * info);
 int snd_pcm_generic_status(snd_pcm_t *pcm, snd_pcm_status_t * status);
 snd_pcm_state_t snd_pcm_generic_state(snd_pcm_t *pcm);
 int snd_pcm_generic_prepare(snd_pcm_t *pcm);
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_hooks.c /u/alsacvs/alsa-lib/src/pcm/pcm_hooks.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_hooks.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_hooks.c	2005-09-12 11:35:07.000000000 +0100
@@ -469,7 +469,7 @@
 		return err;
 	}
 	if (!hooks)
-		return 0;
+		goto _done;
 	snd_config_for_each(i, next, hooks) {
 		snd_config_t *n = snd_config_iterator_entry(i);
 		const char *str;
@@ -488,6 +488,7 @@
 			return err;
 		}
 	}
+ _done:
 	*pcmp = rpcm;
 	return 0;
 }
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_local.h /u/alsacvs/alsa-lib/src/pcm/pcm_local.h
--- alsa-lib-1.0.10rc1/src/pcm/pcm_local.h	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_local.h	2005-09-02 17:36:40.000000000 +0100
@@ -212,7 +212,9 @@
 	snd_pcm_rbptr_t hw;
 	snd_pcm_uframes_t min_align;
 	unsigned int mmap_rw: 1;	/* use always mmapped buffer */
-	unsigned int mmap_shadow: 1;	/* don't call actual mmap */
+	unsigned int mmap_shadow: 1;	/* don't call actual mmap,
+					 * use the mmaped buffer of the slave
+					 */
 	unsigned int donot_close: 1;	/* don't close this PCM */
 	snd_pcm_channel_info_t *mmap_channels;
 	snd_pcm_channel_area_t *running_areas;
@@ -266,7 +268,10 @@
 				      snd_pcm_xfer_areas_func_t func);
 snd_pcm_sframes_t snd_pcm_read_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t size);
 snd_pcm_sframes_t snd_pcm_write_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t size);
-int snd_pcm_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info);
+static inline int snd_pcm_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info)
+{
+	return pcm->ops->channel_info(pcm, info);
+}
 int snd_pcm_channel_info_shm(snd_pcm_t *pcm, snd_pcm_channel_info_t *info, int shmid);
 int _snd_pcm_poll_descriptor(snd_pcm_t *pcm);
 int _snd_pcm_link_descriptors(snd_pcm_t *pcm, int *fds, int size, int (**failed)(snd_pcm_t *, int));
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_misc.c /u/alsacvs/alsa-lib/src/pcm/pcm_misc.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_misc.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_misc.c	2005-09-29 20:11:50.000000000 +0100
@@ -623,38 +623,24 @@
 	return 0;
 }
 
-static int linear_formats[4*2*2] = {
-	SNDRV_PCM_FORMAT_S8,
-	SNDRV_PCM_FORMAT_S8,
-	SNDRV_PCM_FORMAT_U8,
-	SNDRV_PCM_FORMAT_U8,
-	SNDRV_PCM_FORMAT_S16_LE,
-	SNDRV_PCM_FORMAT_S16_BE,
-	SNDRV_PCM_FORMAT_U16_LE,
-	SNDRV_PCM_FORMAT_U16_BE,
-	SNDRV_PCM_FORMAT_S24_LE,
-	SNDRV_PCM_FORMAT_S24_BE,
-	SNDRV_PCM_FORMAT_U24_LE,
-	SNDRV_PCM_FORMAT_U24_BE,
-	SNDRV_PCM_FORMAT_S32_LE,
-	SNDRV_PCM_FORMAT_S32_BE,
-	SNDRV_PCM_FORMAT_U32_LE,
-	SNDRV_PCM_FORMAT_U32_BE
+static int linear_formats[4][2][2] = {
+	{ { SNDRV_PCM_FORMAT_S8, SNDRV_PCM_FORMAT_S8 },
+	  { SNDRV_PCM_FORMAT_U8, SNDRV_PCM_FORMAT_U8 } },
+	{ { SNDRV_PCM_FORMAT_S16_LE, SNDRV_PCM_FORMAT_S16_BE },
+	  { SNDRV_PCM_FORMAT_U16_LE, SNDRV_PCM_FORMAT_U16_BE } },
+	{ { SNDRV_PCM_FORMAT_S24_LE, SNDRV_PCM_FORMAT_S24_BE },
+	  { SNDRV_PCM_FORMAT_U24_LE, SNDRV_PCM_FORMAT_U24_BE } },
+	{ { SNDRV_PCM_FORMAT_S32_LE, SNDRV_PCM_FORMAT_S32_BE },
+	  { SNDRV_PCM_FORMAT_U32_LE, SNDRV_PCM_FORMAT_U32_BE } }
 };
 
-static int linear24_formats[3*2*2] = {
-	SNDRV_PCM_FORMAT_S24_3LE,
-	SNDRV_PCM_FORMAT_S24_3BE,
-	SNDRV_PCM_FORMAT_U24_3LE,
-	SNDRV_PCM_FORMAT_U24_3BE,
-	SNDRV_PCM_FORMAT_S20_3LE,
-	SNDRV_PCM_FORMAT_S20_3BE,
-	SNDRV_PCM_FORMAT_U20_3LE,
-	SNDRV_PCM_FORMAT_U20_3BE,
-	SNDRV_PCM_FORMAT_S18_3LE,
-	SNDRV_PCM_FORMAT_S18_3BE,
-	SNDRV_PCM_FORMAT_U18_3LE,
-	SNDRV_PCM_FORMAT_U18_3BE,
+static int linear24_formats[3][2][2] = {
+	{ { SNDRV_PCM_FORMAT_S24_3LE, SNDRV_PCM_FORMAT_S24_3BE },
+	  { SNDRV_PCM_FORMAT_U24_3LE, SNDRV_PCM_FORMAT_U24_3BE } },
+	{ { SNDRV_PCM_FORMAT_S20_3LE, SNDRV_PCM_FORMAT_S20_3BE },
+	  { SNDRV_PCM_FORMAT_U20_3LE, SNDRV_PCM_FORMAT_U20_3BE } },
+	{ { SNDRV_PCM_FORMAT_S18_3LE, SNDRV_PCM_FORMAT_S18_3BE },
+	  { SNDRV_PCM_FORMAT_U18_3LE, SNDRV_PCM_FORMAT_U18_3BE } },
 };
 
 /**
@@ -681,7 +667,7 @@
 		default:
 			return SND_PCM_FORMAT_UNKNOWN;
 		}
-		return ((int(*)[2][2])linear24_formats)[width][!!unsignd][!!big_endian];
+		return linear24_formats[width][!!unsignd][!!big_endian];
 	} else {
 		switch (width) {
 		case 8:
@@ -699,7 +685,7 @@
 		default:
 			return SND_PCM_FORMAT_UNKNOWN;
 		}
-		return ((int(*)[2][2])linear_formats)[width][!!unsignd][!!big_endian];
+		return linear_formats[width][!!unsignd][!!big_endian];
 	}
 }
 
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_mmap.c /u/alsacvs/alsa-lib/src/pcm/pcm_mmap.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_mmap.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_mmap.c	2005-09-02 17:36:40.000000000 +0100
@@ -262,11 +262,6 @@
 				  snd_pcm_mmap_read_areas);
 }
 
-int snd_pcm_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info)
-{
-	return pcm->ops->channel_info(pcm, info);
-}
-
 int snd_pcm_channel_info_shm(snd_pcm_t *pcm, snd_pcm_channel_info_t *info, int shmid)
 {
 	switch (pcm->access) {
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_null.c /u/alsacvs/alsa-lib/src/pcm/pcm_null.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_null.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_null.c	2005-09-02 17:36:40.000000000 +0100
@@ -79,11 +79,6 @@
 	return 0;
 }
 
-static int snd_pcm_null_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t * info)
-{
-	return snd_pcm_channel_info_shm(pcm, info, -1);
-}
-
 static int snd_pcm_null_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 {
 	snd_pcm_null_t *null = pcm->private_data;
@@ -276,16 +271,6 @@
 	return 0;
 }
 
-static int snd_pcm_null_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
-{
-	return 0;
-}
-
-static int snd_pcm_null_munmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
-{
-	return 0;
-}
-
 static void snd_pcm_null_dump(snd_pcm_t *pcm, snd_output_t *out)
 {
 	snd_output_printf(out, "Null PCM\n");
@@ -302,12 +287,12 @@
 	.hw_params = snd_pcm_null_hw_params,
 	.hw_free = snd_pcm_null_hw_free,
 	.sw_params = snd_pcm_null_sw_params,
-	.channel_info = snd_pcm_null_channel_info,
+	.channel_info = snd_pcm_generic_channel_info,
 	.dump = snd_pcm_null_dump,
 	.nonblock = snd_pcm_null_nonblock,
 	.async = snd_pcm_null_async,
-	.mmap = snd_pcm_null_mmap,
-	.munmap = snd_pcm_null_munmap,
+	.mmap = snd_pcm_generic_mmap,
+	.munmap = snd_pcm_generic_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_null_fast_ops = {
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_plug.c /u/alsacvs/alsa-lib/src/pcm/pcm_plug.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_plug.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_plug.c	2005-09-02 17:36:40.000000000 +0100
@@ -917,26 +917,6 @@
 	return err;
 }
 
-static int snd_pcm_plug_mmap(snd_pcm_t *pcm)
-{
-	snd_pcm_plug_t *plug = pcm->private_data;
-	pcm->mmap_channels = plug->gen.slave->mmap_channels;
-	pcm->running_areas = plug->gen.slave->running_areas;
-	pcm->stopped_areas = plug->gen.slave->stopped_areas;
-	pcm->mmap_shadow = 1;
-	return 0;
-}
-
-static int snd_pcm_plug_munmap(snd_pcm_t *pcm)
-{
-	// snd_pcm_plug_t *plug = pcm->private_data;
-	pcm->mmap_channels = NULL;
-	pcm->running_areas = NULL;
-	pcm->stopped_areas = NULL;
-	pcm->mmap_shadow = 0;
-	return 0;
-}
-
 static void snd_pcm_plug_dump(snd_pcm_t *pcm, snd_output_t *out)
 {
 	snd_pcm_plug_t *plug = pcm->private_data;
@@ -955,8 +935,8 @@
 	.dump = snd_pcm_plug_dump,
 	.nonblock = snd_pcm_generic_nonblock,
 	.async = snd_pcm_generic_async,
-	.mmap = snd_pcm_plug_mmap,
-	.munmap = snd_pcm_plug_munmap,
+	.mmap = snd_pcm_generic_mmap,
+	.munmap = snd_pcm_generic_munmap,
 };
 
 /**
@@ -1010,6 +990,7 @@
 	pcm->private_data = plug;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
+	pcm->mmap_shadow = 1;
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	*pcmp = pcm;
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_rate.c /u/alsacvs/alsa-lib/src/pcm/pcm_rate.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_rate.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_rate.c	2005-09-02 17:36:40.000000000 +0100
@@ -620,11 +620,6 @@
 	return snd_pcm_hw_free(rate->gen.slave);
 }
 
-static int snd_pcm_rate_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t * info)
-{
-	return snd_pcm_channel_info_shm(pcm, info, -1);
-}
-
 static void recalc(snd_pcm_t *pcm, snd_pcm_uframes_t *val)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
@@ -1393,7 +1388,7 @@
 	.hw_params = snd_pcm_rate_hw_params,
 	.hw_free = snd_pcm_rate_hw_free,
 	.sw_params = snd_pcm_rate_sw_params,
-	.channel_info = snd_pcm_rate_channel_info,
+	.channel_info = snd_pcm_generic_channel_info,
 	.dump = snd_pcm_rate_dump,
 	.nonblock = snd_pcm_generic_nonblock,
 	.async = snd_pcm_generic_async,
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/pcm/pcm_softvol.c /u/alsacvs/alsa-lib/src/pcm/pcm_softvol.c
--- alsa-lib-1.0.10rc1/src/pcm/pcm_softvol.c	2005-10-01 22:00:45.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/pcm/pcm_softvol.c	2005-09-02 17:36:40.000000000 +0100
@@ -658,6 +658,12 @@
 	pcm->private_data = svol;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
+	/*
+	 * Since the softvol converts on the place, and the format/channels
+	 * must be identical between source and destination, we don't need
+	 * an extra buffer.
+	 */
+	pcm->mmap_shadow = 1;
 	snd_pcm_set_hw_ptr(pcm, &svol->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &svol->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/seq/seq.c /u/alsacvs/alsa-lib/src/seq/seq.c
--- alsa-lib-1.0.10rc1/src/seq/seq.c	2005-05-24 15:14:37.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/seq/seq.c	2005-09-29 20:11:50.000000000 +0100
@@ -1790,7 +1790,7 @@
 const snd_seq_addr_t *snd_seq_port_info_get_addr(const snd_seq_port_info_t *info)
 {
 	assert(info);
-	return (snd_seq_addr_t *)&info->addr;
+	return &info->addr;
 }
 
 /**
@@ -1985,7 +1985,7 @@
 void snd_seq_port_info_set_addr(snd_seq_port_info_t *info, const snd_seq_addr_t *addr)
 {
 	assert(info);
-	info->addr = *(struct sndrv_seq_addr *)addr;
+	info->addr = *addr;
 }
 
 /**
@@ -2333,7 +2333,7 @@
 const snd_seq_addr_t *snd_seq_port_subscribe_get_sender(const snd_seq_port_subscribe_t *info)
 {
 	assert(info);
-	return (snd_seq_addr_t *)&info->sender;
+	return &info->sender;
 }
 
 /**
@@ -2345,7 +2345,7 @@
 const snd_seq_addr_t *snd_seq_port_subscribe_get_dest(const snd_seq_port_subscribe_t *info)
 {
 	assert(info);
-	return (snd_seq_addr_t *)&info->dest;
+	return &info->dest;
 }
 
 /**
@@ -2618,7 +2618,7 @@
 const snd_seq_addr_t *snd_seq_query_subscribe_get_root(const snd_seq_query_subscribe_t *info)
 {
 	assert(info);
-	return (snd_seq_addr_t *)&info->root;
+	return &info->root;
 }
 
 /**
@@ -2670,7 +2670,7 @@
 const snd_seq_addr_t *snd_seq_query_subscribe_get_addr(const snd_seq_query_subscribe_t *info)
 {
 	assert(info);
-	return (snd_seq_addr_t *)&info->addr;
+	return &info->addr;
 }
 
 /**
@@ -2761,7 +2761,7 @@
 void snd_seq_query_subscribe_set_root(snd_seq_query_subscribe_t *info, const snd_seq_addr_t *addr)
 {
 	assert(info);
-	info->root = *(struct sndrv_seq_addr *)addr;
+	info->root = *addr;
 }
 
 /**
@@ -3240,7 +3240,7 @@
 const snd_seq_real_time_t *snd_seq_queue_status_get_real_time(const snd_seq_queue_status_t *info)
 {
 	assert(info);
-	return (snd_seq_real_time_t *)&info->time;
+	return &info->time;
 }
 
 /**
@@ -3687,7 +3687,7 @@
 {
 	ssize_t len = sizeof(snd_seq_event_t);
 	assert(ev);
-	if (sndrv_seq_ev_is_variable(ev))
+	if (snd_seq_ev_is_variable(ev))
 		len += ev->data.ext.len;
 	return len;
 }
@@ -3753,7 +3753,7 @@
 		return -EAGAIN;
 	memcpy(seq->obuf + seq->obufused, ev, sizeof(snd_seq_event_t));
 	seq->obufused += sizeof(snd_seq_event_t);
-	if (sndrv_seq_ev_is_variable(ev)) {
+	if (snd_seq_ev_is_variable(ev)) {
 		memcpy(seq->obuf + seq->obufused, ev->data.ext.ptr, ev->data.ext.len);
 		seq->obufused += ev->data.ext.len;
 	}
@@ -3882,7 +3882,7 @@
 		*ev_res = NULL;
 	if ((olen = seq->obufused) < sizeof(snd_seq_event_t))
 		return -ENOENT;
-	memcpy(&ev, (snd_seq_event_t*)seq->obuf, sizeof(snd_seq_event_t));
+	memcpy(&ev, seq->obuf, sizeof(snd_seq_event_t));
 	len = snd_seq_event_length(&ev);
 	if (ev_res) {
 		/* extract the event */
@@ -3924,7 +3924,7 @@
 	*retp = ev = &seq->ibuf[seq->ibufptr];
 	seq->ibufptr++;
 	seq->ibuflen--;
-	if (! sndrv_seq_ev_is_variable(ev))
+	if (! snd_seq_ev_is_variable(ev))
 		return 1;
 	ncells = (ev->data.ext.len + sizeof(snd_seq_event_t) - 1) / sizeof(snd_seq_event_t);
 	if (seq->ibuflen < ncells) {
@@ -4178,7 +4178,7 @@
 const snd_seq_timestamp_t *snd_seq_remove_events_get_time(const snd_seq_remove_events_t *info)
 {
 	assert(info);
-	return (snd_seq_timestamp_t *)&info->time;
+	return &info->time;
 }
 
 /**
@@ -4191,7 +4191,7 @@
 const snd_seq_addr_t *snd_seq_remove_events_get_dest(const snd_seq_remove_events_t *info)
 {
 	assert(info);
-	return (snd_seq_addr_t *)&info->dest;
+	return &info->dest;
 }
 
 /**
@@ -4269,7 +4269,7 @@
 void snd_seq_remove_events_set_time(snd_seq_remove_events_t *info, const snd_seq_timestamp_t *time)
 {
 	assert(info);
-	info->time = *(union sndrv_seq_timestamp *)time;
+	info->time = *time;
 }
 
 /**
@@ -4282,7 +4282,7 @@
 void snd_seq_remove_events_set_dest(snd_seq_remove_events_t *info, const snd_seq_addr_t *addr)
 {
 	assert(info);
-	info->dest = *(struct sndrv_seq_addr *)addr;
+	info->dest = *addr;
 }
 
 /**
@@ -4354,7 +4354,7 @@
 			return 0;
 	}
 	if (info->remove_mode & SNDRV_SEQ_REMOVE_DEST_CHANNEL) {
-		if (! sndrv_seq_ev_is_channel_type(ev))
+		if (! snd_seq_ev_is_channel_type(ev))
 			return 0;
 		/* data.note.channel and data.control.channel are identical */
 		if (ev->data.note.channel != info->channel)
@@ -4362,17 +4362,17 @@
 	}
 	if (info->remove_mode & SNDRV_SEQ_REMOVE_TIME_AFTER) {
 		if (info->remove_mode & SNDRV_SEQ_REMOVE_TIME_TICK)
-			res = snd_seq_compare_tick_time(&ev->time.tick, (snd_seq_tick_time_t *)&info->time.tick);
+			res = snd_seq_compare_tick_time(&ev->time.tick, &info->time.tick);
 		else
-			res = snd_seq_compare_real_time(&ev->time.time, (snd_seq_real_time_t *)&info->time.time);
+			res = snd_seq_compare_real_time(&ev->time.time, &info->time.time);
 		if (!res)
 			return 0;
 	}
 	if (info->remove_mode & SNDRV_SEQ_REMOVE_TIME_BEFORE) {
 		if (info->remove_mode & SNDRV_SEQ_REMOVE_TIME_TICK)
-			res = snd_seq_compare_tick_time(&ev->time.tick, (snd_seq_tick_time_t *)&info->time.tick);
+			res = snd_seq_compare_tick_time(&ev->time.tick, &info->time.tick);
 		else
-			res = snd_seq_compare_real_time(&ev->time.time, (snd_seq_real_time_t *)&info->time.time);
+			res = snd_seq_compare_real_time(&ev->time.time, &info->time.time);
 		if (res)
 			return 0;
 	}
@@ -4383,8 +4383,8 @@
 	if (info->remove_mode & SNDRV_SEQ_REMOVE_IGNORE_OFF) {
 		/* Do not remove off events */
 		switch (ev->type) {
-		case SNDRV_SEQ_EVENT_NOTEOFF:
-		/* case SNDRV_SEQ_EVENT_SAMPLE_STOP: */
+		case SND_SEQ_EVENT_NOTEOFF:
+		/* case SND_SEQ_EVENT_SAMPLE_STOP: */
 			return 0;
 		default:
 			break;
@@ -4435,7 +4435,7 @@
 			ep = seq->obuf;
 			while (ep - seq->obuf < (ssize_t)seq->obufused) {
 
-				ev = (snd_seq_event_t *) ep;
+				ev = ep;
 				len = snd_seq_event_length(ev);
 
 				if (remove_match(rmp, ev)) {
@@ -4721,7 +4721,7 @@
 const snd_seq_instr_t *snd_instr_header_get_id(const snd_instr_header_t *info)
 {
 	assert(info);
-	return (snd_seq_instr_t *)&info->id.instr;
+	return &info->id.instr;
 }
 
 /**
@@ -4798,7 +4798,7 @@
 const snd_seq_instr_t *snd_instr_header_get_alias(const snd_instr_header_t *info)
 {
 	assert(info);
-	return (snd_seq_instr_t *)&info->data.data.alias;
+	return &info->data.data.alias;
 }
 
 /**
@@ -4831,7 +4831,7 @@
 void snd_instr_header_set_id(snd_instr_header_t *info, const snd_seq_instr_t *id)
 {
 	assert(info && id);
-	info->id.instr = *(struct sndrv_seq_instr *)id;
+	info->id.instr = *id;
 }
 
 /**
@@ -4908,7 +4908,7 @@
 void snd_instr_header_set_alias(snd_instr_header_t *info, const snd_seq_instr_t *instr)
 {
 	assert(info && instr);
-	info->data.data.alias = *(struct sndrv_seq_instr *)instr;
+	info->data.data.alias = *instr;
 }
 
 /**
diff -ur --exclude-from=ignore alsa-lib-1.0.10rc1/src/seq/seq_midi_event.c /u/alsacvs/alsa-lib/src/seq/seq_midi_event.c
--- alsa-lib-1.0.10rc1/src/seq/seq_midi_event.c	2005-05-24 15:14:37.000000000 +0100
+++ /u/alsacvs/alsa-lib/src/seq/seq_midi_event.c	2005-09-29 20:11:50.000000000 +0100
@@ -307,8 +307,8 @@
 	if (c >= MIDI_CMD_COMMON_CLOCK) {
 		/* real-time event */
 		ev->type = status_event[ST_SPECIAL + c - 0xf0].event;
-		ev->flags &= ~SNDRV_SEQ_EVENT_LENGTH_MASK;
-		ev->flags |= SNDRV_SEQ_EVENT_LENGTH_FIXED;
+		ev->flags &= ~SND_SEQ_EVENT_LENGTH_MASK;
+		ev->flags |= SND_SEQ_EVENT_LENGTH_FIXED;
 		return 1;
 	}
 
@@ -335,17 +335,17 @@
 	}
 	if (dev->qlen == 0) {
 		ev->type = status_event[dev->type].event;
-		ev->flags &= ~SNDRV_SEQ_EVENT_LENGTH_MASK;
-		ev->flags |= SNDRV_SEQ_EVENT_LENGTH_FIXED;
+		ev->flags &= ~SND_SEQ_EVENT_LENGTH_MASK;
+		ev->flags |= SND_SEQ_EVENT_LENGTH_FIXED;
 		if (status_event[dev->type].encode) /* set data values */
 			status_event[dev->type].encode(dev, ev);
 		rc = 1;
 	} else 	if (dev->type == ST_SYSEX) {
 		if (c == MIDI_CMD_COMMON_SYSEX_END ||
 		    dev->read >= dev->bufsize) {
-			ev->flags &= ~SNDRV_SEQ_EVENT_LENGTH_MASK;
-			ev->flags |= SNDRV_SEQ_EVENT_LENGTH_VARIABLE;
-			ev->type = SNDRV_SEQ_EVENT_SYSEX;
+			ev->flags &= ~SND_SEQ_EVENT_LENGTH_MASK;
+			ev->flags |= SND_SEQ_EVENT_LENGTH_VARIABLE;
+			ev->type = SND_SEQ_EVENT_SYSEX;
 			ev->data.ext.len = dev->read;
 			ev->data.ext.ptr = dev->buf;
 			if (c != MIDI_CMD_COMMON_SYSEX_END)
@@ -417,7 +417,7 @@
 	long qlen;
 	unsigned int type;
 
-	if (ev->type == SNDRV_SEQ_EVENT_NONE)
+	if (ev->type == SND_SEQ_EVENT_NONE)
 		return -ENOENT;
 
 	for (type = 0; type < numberof(status_event); type++) {
@@ -442,8 +442,8 @@
 		qlen = ev->data.ext.len;
 		if (count < qlen)
 			return -ENOMEM;
-		switch (ev->flags & SNDRV_SEQ_EVENT_LENGTH_MASK) {
-		case SNDRV_SEQ_EVENT_LENGTH_FIXED:
+		switch (ev->flags & SND_SEQ_EVENT_LENGTH_MASK) {
+		case SND_SEQ_EVENT_LENGTH_FIXED:
 			return -EINVAL;	/* invalid event */
 		}
 		memcpy(buf, ev->data.ext.ptr, qlen);


--------------030802020701020801050708--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
