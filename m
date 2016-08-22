From: Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] pcm: Fix shm initialization race-condition
Date: Mon, 22 Aug 2016 13:04:33 -0300
Message-ID: <20160822160433.27598-1-ismael@iodev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iodev.co.uk (iodev.co.uk [82.211.30.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 832D9266A40
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 18:04:48 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Ismael Luceno <ismael@iodev.co.uk>
List-Id: alsa-devel@alsa-project.org

Easily seen when two threads try at the same time, one of them will fail.

The bug was identified by using apulse with Skype.

Fixes: dec428c35221 ("pcm: fix 'unable to create IPC shm instance' caused by fork from a thread")
Fixes: https://github.com/i-rinat/apulse/issues/38
Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 src/pcm/pcm_direct.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index c3925cc20fd3..643498375b34 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -96,11 +96,12 @@ int snd_pcm_direct_shm_create_or_connect(snd_pcm_direct_t *dmix)
 retryget:
 	dmix->shmid = shmget(dmix->ipc_key, sizeof(snd_pcm_direct_share_t),
 			     dmix->ipc_perm);
-	if (dmix->shmid < 0) {
-		if (errno == ENOENT)
+	if (dmix->shmid < 0 && errno == ENOENT) {
 		if ((dmix->shmid = shmget(dmix->ipc_key, sizeof(snd_pcm_direct_share_t),
 					     IPC_CREAT | IPC_EXCL | dmix->ipc_perm)) != -1)
 			first_instance = 1;
+		else if (errno == EEXIST)
+			goto retryget;
 	}
 	err = -errno;
 	if (dmix->shmid < 0) {
-- 
2.9.2
