From: IceBsi <bsiice@msn.com>
Subject: [PATCH - pcm 1/1] pcm: fix "unable to create IPC shm
	instance" in some case
Date: Thu, 3 Mar 2016 07:40:42 -0500
Message-ID: <BLU437-SMTP418A25BEF034BD65DA159BD2BD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Qing Cai <caiqing@neusoft.com>, alsa-devel@alsa-project.org, Qing Cai <bsiice@msn.com>
List-Id: alsa-devel@alsa-project.org

From: Qing Cai <caiqing@neusoft.com>

As stated in manpage SHMCTL(2), shm_nattch is "No. of current attaches"
(i.e., number of processes attached to the shared memeory). If an
application uses alsa-lib and invokes fork() at some point, there should
be the following execution sequence:
 1. execute the following statement:
      pcm_direct.c:110: dmix->shmptr = shmat(dmix->shmid, 0, 0)
    (shm_nattch becomes 1)
 2. invoke fork() in some thread.
    (shm_nattch becomes 2)
 3. execute the following statement:
      pcm_direct.c:122: if (buf.shm_nattch == 1)
 4. execute the following statement:
      pcm_direct.c:131: if (dmix->shmptr->magic != SND_PCM_DIRECT_MAGIC)
    (As stated in manpage SHMGET(2), "When a new shared memory segment
     is created, its contents are initialized to zero values", so
     dmix->shmptr->magic is 0)
 5. execute the following statements:
      pcm_direct.c:132: snd_pcm_direct_shm_discard(dmix)
      pcm_direct.c:133: return -EINVAL
The above execution sequence will cause the following error:
  unable to create IPC shm instance
This error causes multimedia application has no sound. This error rarely
occurs, probability is about 1%.
Because the first user of the shared memory will get that
dmix->shmptr->magic is 0, check dmix->shmptr->magic's value to determine
if "we're the first user" is OK.
Tests have been made 400+ times after this fix, and the issue no longer
exists.

Signed-off-by: Qing Cai <bsiice@msn.com>
Signed-off-by: Qing Cai <caiqing@neusoft.com>

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index fd3877c..93d6f3c 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -119,7 +119,7 @@ retryget:
 		snd_pcm_direct_shm_discard(dmix);
 		return err;
 	}
-	if (buf.shm_nattch == 1) {	/* we're the first user, clear the segment */
+	if (dmix->shmptr->magic != SND_PCM_DIRECT_MAGIC) {	/* we're the first user, clear the segment */
 		memset(dmix->shmptr, 0, sizeof(snd_pcm_direct_share_t));
 		if (dmix->ipc_gid >= 0) {
 			buf.shm_perm.gid = dmix->ipc_gid;
-- 
2.7.2
