From: Pontus Oldberg <pontus.oldberg@axis.com>
Subject: Retrieving original timestamps in dsnoop.
Date: Fri, 29 Oct 2010 11:58:55 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC749BEFE4D78@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by alsa0.perex.cz (Postfix) with ESMTP id DB8702433A
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 11:58:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 558A411F91
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 11:58:56 +0200 (CEST)
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8UqMFJNrw5v2 for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 11:58:55 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by ra.se.axis.com (Postfix) with ESMTP id 9A2D211F8C
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 11:58:55 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by seth.se.axis.com (Postfix) with ESMTP id 725AA3E097
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 11:58:55 +0200 (CEST)
Content-Language: sv-SE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,
I am working in a gstreamer based project where we are using alsasrc to feed the audio pipeline. On of the things that we need to be able to do is to get the monotonic timestamp from the alsalib in order for our video and audio to be perfectly synchronized. This worked fine until we introduced the dsnoop plug-in which creates its own timestamp reference. I have played around with the dsnoop plugin and created a preliminary fix that gives us the result that we want.

I'd like to know if this looks like the way to go or if this can be obtained in any other way. We are using dsnoop in order to be able to create two separate audio pipelines, we don't care about stereo, just simple mono streams.  

? libs/alsa-lib/build
? libs/alsa-lib/alsa-lib/autom4te.cache
? libs/alsa-lib/alsa-lib/src/control/ctl_symbols_list.c
? libs/alsa-lib/alsa-lib/src/pcm/pcm_symbols_list.c
Index: libs/alsa-lib/alsa-lib/src/pcm/pcm_direct.h
===================================================================
RCS file: /usr/local/cvs/linux/libs/alsa-lib/alsa-lib/src/pcm/pcm_direct.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 pcm_direct.h
--- libs/alsa-lib/alsa-lib/src/pcm/pcm_direct.h	6 Sep 2010 08:18:20 -0000	1.1.1.2
+++ libs/alsa-lib/alsa-lib/src/pcm/pcm_direct.h	29 Oct 2010 09:56:08 -0000
@@ -114,6 +114,14 @@
 	} u;
 } snd_pcm_direct_share_t;
 
+/*
+ * Defines the clock type to use
+ */
+enum snd_pcm_sub_clock_type {
+  SND_PCM_SLAVE_CLOCK_DEFAULT = 0x00,
+  SND_PCM_SLAVE_CLOCK_SUB =0x01,
+};
+
 typedef struct snd_pcm_direct snd_pcm_direct_t;
 
 struct snd_pcm_direct {
@@ -153,6 +161,7 @@
 	int max_periods;		/* max periods (-1 = fixed periods, 0 = max buffer size) */
 	unsigned int channels;		/* client's channels */
 	unsigned int *bindings;
+	int sub_clock;
 	union {
 		struct {
 			int shmid_sum;			/* IPC global sum ring buffer memory identification */
Index: libs/alsa-lib/alsa-lib/src/pcm/pcm_dsnoop.c
===================================================================
RCS file: /usr/local/cvs/linux/libs/alsa-lib/alsa-lib/src/pcm/pcm_dsnoop.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 pcm_dsnoop.c
--- libs/alsa-lib/alsa-lib/src/pcm/pcm_dsnoop.c	6 Sep 2010 08:18:20 -0000	1.1.1.2
+++ libs/alsa-lib/alsa-lib/src/pcm/pcm_dsnoop.c	29 Oct 2010 09:56:08 -0000
@@ -51,7 +51,7 @@
 #endif
 
 /*
- *
+ * Handles packing and formating of buffers
  */
 
 static void snoop_areas(snd_pcm_direct_t *dsnoop,
@@ -168,11 +168,18 @@
 	default:
 		break;
 	}
-	memset(status, 0, sizeof(*status));
+
+	memset(status, 0, sizeof(status));
 	state = snd_pcm_state(dsnoop->spcm);
 	status->state = state == SND_PCM_STATE_RUNNING ? dsnoop->state : state;
-	status->trigger_tstamp = dsnoop->trigger_tstamp;
-	gettimestamp(&status->tstamp, pcm->monotonic);
+
+	if (dsnoop->sub_clock == SND_PCM_SLAVE_CLOCK_SUB) {
+		snd_pcm_status(dsnoop->spcm, status);
+	} else {
+		status->trigger_tstamp = dsnoop->trigger_tstamp;
+		gettimestamp(&status->tstamp, pcm->monotonic);
+	}
+
 	status->avail = snd_pcm_mmap_capture_avail(pcm);
 	status->avail_max = status->avail > dsnoop->avail_max ? status->avail : dsnoop->avail_max;
 	dsnoop->avail_max = 0;
@@ -197,18 +204,21 @@
 static int snd_pcm_dsnoop_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
 {
 	snd_pcm_direct_t *dsnoop = pcm->private_data;
-	int err;
+	int err = 0;
 	
 	switch(dsnoop->state) {
 	case SNDRV_PCM_STATE_DRAINING:
 	case SNDRV_PCM_STATE_RUNNING:
-		err = snd_pcm_dsnoop_sync_ptr(pcm);
+	  err = snd_pcm_dsnoop_sync_ptr(pcm);
 		if (err < 0)
 			return err;
 	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_SUSPENDED:
-		*delayp = snd_pcm_mmap_capture_hw_avail(pcm);
-		return 0;
+		if (dsnoop->sub_clock == SND_PCM_SLAVE_CLOCK_SUB)
+			err = dsnoop->spcm->fast_ops->delay(dsnoop->spcm, delayp);
+		else
+			*delayp = snd_pcm_mmap_capture_hw_avail(pcm);
+		return err;
 	case SNDRV_PCM_STATE_XRUN:
 		return -EPIPE;
 	case SNDRV_PCM_STATE_DISCONNECTED:
@@ -271,7 +281,12 @@
 	if (err < 0)
 		return err;
 	dsnoop->state = SND_PCM_STATE_RUNNING;
-	gettimestamp(&dsnoop->trigger_tstamp, pcm->monotonic);
+	if (dsnoop->sub_clock == SND_PCM_SLAVE_CLOCK_SUB) {
+		snd_pcm_status_t status;
+		snd_pcm_status(dsnoop->spcm, &status);
+		dsnoop->trigger_tstamp = status.trigger_tstamp;
+	} else
+		gettimestamp(&dsnoop->trigger_tstamp, pcm->monotonic);
 	return 0;
 }
 
@@ -421,6 +436,7 @@
 	return snd_pcm_mmap_capture_avail(pcm);
 }
 
+/* TODO: This function is faulty, needs fixing */
 static int snd_pcm_dsnoop_htimestamp(snd_pcm_t *pcm,
 				     snd_pcm_uframes_t *avail,
 				     snd_htimestamp_t *tstamp)
@@ -673,6 +689,9 @@
 	if (dsnoop->channels == UINT_MAX)
 		dsnoop->channels = dsnoop->shmptr->s.channels;
 	
+	/* TODO: Needs to be loaded from the config file */	
+	dsnoop->sub_clock = SND_PCM_SLAVE_CLOCK_SUB;
+
 	snd_pcm_direct_semaphore_up(dsnoop, DIRECT_IPC_SEM_CLIENT);
 
 	*pcmp = pcm;

/Regards
/Pontus
