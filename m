From: sutar.mounesh@gmail.com
Subject: [PATCH 1/4] alsa-lib:pcm: returning semop error code
	for semaphore up/down failures.
Date: Tue, 10 Jan 2017 12:03:17 +0530
Message-ID: <1484029997-11107-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: Mounesh Sutar <sutar.mounesh@gmail.com>, alsa-devel@alsa-project.org, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Mounesh Sutar <sutar.mounesh@gmail.com>

Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>

diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index 91e816c..aee38c5 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -263,7 +263,10 @@ static inline int snd_pcm_direct_semaphore_down(snd_pcm_direct_t *dmix, int sem_
 {
 	struct sembuf op[2] = { { sem_num, 0, 0 }, { sem_num, 1, SEM_UNDO } };
 	int err = semop(dmix->semid, op, 2);
-	if (err == 0) dmix->locked[sem_num]++;
+	if (err == 0)
+		dmix->locked[sem_num]++;
+	else if (err == -1)
+		err = -errno;
 	return err;
 }
 
@@ -271,7 +274,10 @@ static inline int snd_pcm_direct_semaphore_up(snd_pcm_direct_t *dmix, int sem_nu
 {
 	struct sembuf op = { sem_num, -1, SEM_UNDO | IPC_NOWAIT };
 	int err = semop(dmix->semid, &op, 1);
-	if (err == 0) dmix->locked[sem_num]--;
+	if (err == 0)
+		dmix->locked[sem_num]--;
+	else if (err == -1)
+		err = -errno;
 	return err;
 }
 
-- 
2.7.4
