From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: [PATCH] reverted pcm_direct.c fixes
Date: Fri, 05 Mar 2004 19:28:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078511325.2751.64.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-99ChdSUw9zVg5gUto39e"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-99ChdSUw9zVg5gUto39e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Apparently these changes from pcm_direct.c revisions 1.12 and 1.14 were
accidentally reverted in revision 1.15. Please reapply.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

--=-99ChdSUw9zVg5gUto39e
Content-Disposition: inline; filename=alsa-lib-cvs.diff
Content-Type: text/x-patch; name=alsa-lib-cvs.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: src/pcm/pcm_direct.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_direct.c,v
retrieving revision 1.17
diff -p -u -r1.17 pcm_direct.c
--- src/pcm/pcm_direct.c	25 Feb 2004 11:24:30 -0000	1.17
+++ src/pcm/pcm_direct.c	5 Mar 2004 17:31:02 -0000
@@ -100,11 +100,21 @@ int snd_pcm_direct_semaphore_up(snd_pcm_
 int snd_pcm_direct_shm_create_or_connect(snd_pcm_direct_t *dmix)
 {
 	struct shmid_ds buf;
-	int ret = 0;
+	int tmpid, err;
 	
+retryget:
 	dmix->shmid = shmget(dmix->ipc_key, sizeof(snd_pcm_direct_share_t), IPC_CREAT | 0666);
-	if (dmix->shmid < 0)
-		return -errno;
+	err = -errno;
+	if (dmix->shmid < 0){
+		if (errno == EINVAL)
+		if ((tmpid = shmget(dmix->ipc_key, 0, 0666)) != -1)
+		if (!shmctl(tmpid, IPC_STAT, &buf))
+		if (!buf.shm_nattch)
+	    	/* no users so destroy the segment */
+		if (!shmctl(tmpid, IPC_RMID, NULL))
+		    goto retryget;
+		return err;
+	}
 	dmix->shmptr = shmat(dmix->shmid, 0, 0);
 	if (dmix->shmptr == (void *) -1) {
 		snd_pcm_direct_shm_discard(dmix);
@@ -117,9 +127,9 @@ int snd_pcm_direct_shm_create_or_connect
 	}
 	if (buf.shm_nattch == 1) {	/* we're the first user, clear the segment */
 		memset(dmix->shmptr, 0, sizeof(snd_pcm_direct_share_t));
-		ret = 1;
+		return 1;
 	}
-	return ret;
+	return 0;
 }
 
 int snd_pcm_direct_shm_discard(snd_pcm_direct_t *dmix)
@@ -409,15 +419,23 @@ int snd_pcm_direct_poll_revents(snd_pcm_
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
 	unsigned short events;
-	static snd_timer_read_t rbuf[5];	/* can be overwriten by multiple plugins, we don't need the value */
+	/* rbuf might be overwriten by multiple plugins */
+	/* we don't need the value */
+	static snd_timer_read_t rbuf[5];
 
 	assert(pfds && nfds == 1 && revents);
 	events = pfds[0].revents;
 	if (events & POLLIN) {
-		events |= POLLOUT;
-		events &= ~POLLIN;
+		int empty = 0;
+		if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
+			events |= POLLOUT;
+			events &= ~POLLIN;
+			empty = snd_pcm_mmap_playback_avail(pcm) < pcm->avail_min;
+		} else {
+			empty = snd_pcm_mmap_capture_avail(pcm) < pcm->avail_min;
+		}
 		/* empty the timer read queue */
-		while (snd_timer_read(dmix->timer, &rbuf, sizeof(rbuf)) == sizeof(rbuf)) ;
+		while (empty && snd_timer_read(dmix->timer, &rbuf, sizeof(rbuf)) == sizeof(rbuf)) ;
 	}
 	*revents = events;
 	return 0;

--=-99ChdSUw9zVg5gUto39e--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
