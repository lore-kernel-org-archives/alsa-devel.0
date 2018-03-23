From: <twischer@de.adit-jv.com>
Subject: [PATCH - PCM HW APPEND 1/1] pcm: hw: Keep control data
	from kernel when SND_PCM_APPEND
Date: Fri, 23 Mar 2018 15:27:23 +0100
Message-ID: <1521815243-30432-1-git-send-email-twischer@de.adit-jv.com>
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
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Without this fix the application pointer would be reseted
whenever an application opens a device with SND_PCM_APPEND.

This would result in an Xrun if the device is already opened and
in running state and the appl_ptr is use.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index b93926c..65b198c 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1004,16 +1004,28 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 		hw->sync_ptr = NULL;
 	}
 
-	/* Initialize the data. */
-	hw->mmap_control->appl_ptr = 0;
-	hw->mmap_control->avail_min = 1;
+	/* do not initialize in case of append and keep the values from the
+	 * kernel
+	 */
+	if (!(pcm->mode & SND_PCM_APPEND)) {
+		/* Initialize the data. */
+		hw->mmap_control->appl_ptr = 0;
+		hw->mmap_control->avail_min = 1;
+	}
 	snd_pcm_set_hw_ptr(pcm, &hw->mmap_status->hw_ptr, hw->fd,
 			   SNDRV_PCM_MMAP_OFFSET_STATUS +
 				offsetof(struct snd_pcm_mmap_status, hw_ptr));
 	snd_pcm_set_appl_ptr(pcm, &hw->mmap_control->appl_ptr, hw->fd,
 			     SNDRV_PCM_MMAP_OFFSET_CONTROL);
 	if (hw->mmap_control_fallbacked) {
-		err = sync_ptr1(hw, 0);
+		unsigned int flags;
+		/* read appl_ptr and avail_min from kernel when device opened
+		 * with SND_PCM_APPEND flag
+		 */
+		if (pcm->mode & SND_PCM_APPEND)
+			flags = SNDRV_PCM_SYNC_PTR_APPL |
+				SNDRV_PCM_SYNC_PTR_AVAIL_MIN;
+		err = sync_ptr1(hw, flags);
 		if (err < 0)
 			return err;
 	}
@@ -1539,6 +1551,8 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd,
 		mode |= SND_PCM_NONBLOCK;
 	if (fmode & O_ASYNC)
 		mode |= SND_PCM_ASYNC;
+	if (fmode & O_APPEND)
+		mode |= SND_PCM_APPEND;
 
 	if (ioctl(fd, SNDRV_PCM_IOCTL_PVERSION, &ver) < 0) {
 		ret = -errno;
-- 
2.7.4
