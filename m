From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][RFC][PATCH 3/9] pcm: handle status/control
	mapping independently
Date: Thu, 22 Jun 2017 23:43:28 +0900
Message-ID: <20170622144334.1306-4-o-takashi@sakamocchi.jp>
References: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C86C9266838
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 16:43:43 +0200 (CEST)
In-Reply-To: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In ALSA PCM interface, status/control data of PCM substream can be mapped
into process' VMA of application. This has an advantage to share
information of the PCM substream. This operation has limitation depending
on running architecture and handled device. In this case, for convenience
to applications, SNDRV_PCM_IOCTL_SYNC_PTR command is available as a
fallback.

In current implementation, mapping operation for status/control data of
PCM substream depends each other. If the operation for one side results
in failure, operation for the another side is cancelled, thus no mapping
is available. However, mapping for one side has advantages because nature
of these two types of data is essentially different.

This commit handles these two mapping operations independently.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 201 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 126 insertions(+), 75 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index cf143f2f..7da2db5b 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -90,11 +90,14 @@ typedef struct {
 	int version;
 	int fd;
 	int card, device, subdevice;
-	int sync_ptr_ioctl;
-	int sync_applptr;
-	volatile struct snd_pcm_mmap_status * mmap_status;
-	struct snd_pcm_mmap_control *mmap_control;
+
 	struct snd_pcm_sync_ptr *sync_ptr;
+	volatile struct snd_pcm_mmap_status *mmap_status;
+	struct snd_pcm_mmap_control *mmap_control;
+	int mmap_status_fallbacked;
+	int mmap_control_fallbacked;
+	int sync_applptr;
+
 	int period_event;
 	snd_timer_t *period_timer;
 	struct pollfd period_timer_pfd;
@@ -878,96 +881,149 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
 	return xfern.result;
 }
 
-static int snd_pcm_hw_mmap_status(snd_pcm_t *pcm)
+static int map_status(snd_pcm_t *pcm, struct snd_pcm_sync_ptr *sync_ptr,
+		      int force_fallback)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	struct snd_pcm_sync_ptr sync_ptr;
-	void *ptr;
-	int err;
-	ptr = MAP_FAILED;
-	if (hw->sync_ptr_ioctl == 0)
-		ptr = mmap(NULL, page_align(sizeof(struct snd_pcm_mmap_status)),
-			   PROT_READ, MAP_FILE|MAP_SHARED, 
-			   hw->fd, SNDRV_PCM_MMAP_OFFSET_STATUS);
-	if (ptr == MAP_FAILED || ptr == NULL) {
-		memset(&sync_ptr, 0, sizeof(sync_ptr));
-		sync_ptr.c.control.appl_ptr = 0;
-		sync_ptr.c.control.avail_min = 1;
-		err = ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, &sync_ptr);
-		if (err < 0) {
-			err = -errno;
-			SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", err);
-			return err;
-		}
-		hw->sync_ptr = calloc(1, sizeof(struct snd_pcm_sync_ptr));
-		if (hw->sync_ptr == NULL)
-			return -ENOMEM;
-		hw->mmap_status = &hw->sync_ptr->s.status;
-		hw->mmap_control = &hw->sync_ptr->c.control;
-		hw->sync_ptr_ioctl = 1;
+	struct snd_pcm_mmap_status *mmap_status;
+	int fallbacked;
+
+	mmap_status = MAP_FAILED;
+	if (!force_fallback) {
+		mmap_status = mmap(NULL, page_align(sizeof(*mmap_status)),
+				   PROT_READ, MAP_FILE|MAP_SHARED,
+				   hw->fd, SNDRV_PCM_MMAP_OFFSET_STATUS);
+	}
+
+	/* Switch to fallback mode. */
+	if (mmap_status == MAP_FAILED || mmap_status == NULL) {
+		mmap_status = &sync_ptr->s.status;
+		fallbacked = 1;
 	} else {
-		hw->mmap_status = ptr;
+		fallbacked = 0;
 	}
-	snd_pcm_set_hw_ptr(pcm, &hw->mmap_status->hw_ptr, hw->fd, SNDRV_PCM_MMAP_OFFSET_STATUS + offsetof(struct snd_pcm_mmap_status, hw_ptr));
-	return 0;
+
+	/* Initialization. */
+	snd_pcm_set_hw_ptr(pcm, &mmap_status->hw_ptr, hw->fd,
+			   SNDRV_PCM_MMAP_OFFSET_STATUS +
+			   offsetof(struct snd_pcm_mmap_status, hw_ptr));
+
+	hw->mmap_status = mmap_status;
+	return fallbacked;
 }
 
-static int snd_pcm_hw_mmap_control(snd_pcm_t *pcm)
+static int map_control(snd_pcm_t *pcm, struct snd_pcm_sync_ptr *sync_ptr,
+		       int force_fallback)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	void *ptr;
-	int err;
-	if (hw->sync_ptr == NULL) {
-		ptr = mmap(NULL, page_align(sizeof(struct snd_pcm_mmap_control)),
-			   PROT_READ|PROT_WRITE, MAP_FILE|MAP_SHARED, 
+	struct snd_pcm_mmap_control *mmap_control;
+	int fallbacked;
+
+	mmap_control = MAP_FAILED;
+	if (!force_fallback) {
+		mmap_control = mmap(NULL, page_align(sizeof(*mmap_control)),
+			   PROT_READ|PROT_WRITE, MAP_FILE|MAP_SHARED,
 			   hw->fd, SNDRV_PCM_MMAP_OFFSET_CONTROL);
-		if (ptr == MAP_FAILED || ptr == NULL) {
-			err = -errno;
-			SYSMSG("control mmap failed (%i)", err);
-			return err;
-		}
-		hw->mmap_control = ptr;
+	}
+
+	/* Switch to fallback mode. */
+	if (mmap_control == MAP_FAILED || mmap_control == NULL) {
+		mmap_control = &sync_ptr->c.control;
+		fallbacked = 1;
 	} else {
-		hw->mmap_control->avail_min = 1;
+		fallbacked = 0;
 	}
-	snd_pcm_set_appl_ptr(pcm, &hw->mmap_control->appl_ptr, hw->fd, SNDRV_PCM_MMAP_OFFSET_CONTROL);
-	return 0;
+
+	/* Initialization. */
+	mmap_control->appl_ptr = 0;
+	mmap_control->avail_min = 1;
+	snd_pcm_set_appl_ptr(pcm, &mmap_control->appl_ptr, hw->fd,
+			     SNDRV_PCM_MMAP_OFFSET_CONTROL);
+
+	hw->mmap_control = mmap_control;
+	return fallbacked;
 }
 
-static int snd_pcm_hw_munmap_status(snd_pcm_t *pcm)
+static int map_status_and_control_data(snd_pcm_t *pcm, int force_fallback)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	int err;
-	if (hw->sync_ptr_ioctl) {
-		free(hw->sync_ptr);
-		hw->sync_ptr = NULL;
+	struct snd_pcm_sync_ptr *sync_ptr;
+
+	/* Preparation for fallback from failure of mmap(2). */
+	sync_ptr = malloc(sizeof(*sync_ptr));
+	if (sync_ptr == NULL)
+		return -ENOMEM;
+	memset(sync_ptr, 0, sizeof(*sync_ptr));
+
+	hw->mmap_status_fallbacked = map_status(pcm, sync_ptr, force_fallback);
+	hw->mmap_control_fallbacked = map_control(pcm, sync_ptr, force_fallback);
+
+	/* Any fallback mode needs to keep the buffer. */
+	if (hw->mmap_status_fallbacked > 0 || hw->mmap_control_fallbacked > 0) {
+		hw->sync_ptr = sync_ptr;
 	} else {
-		if (munmap((void*)hw->mmap_status, page_align(sizeof(*hw->mmap_status))) < 0) {
-			err = -errno;
-			SYSMSG("status munmap failed (%i)", err);
-			return err;
+		free(sync_ptr);
+		hw->sync_ptr = NULL;
+	}
+
+	/* Initialize when control mapping is fallbacked. */
+	if (hw->mmap_control_fallbacked > 0) {
+		int err = ioctl(hw->fd, SNDRV_PCM_IOCTL_SYNC_PTR, &hw->sync_ptr);
+		if (err < 0) {
+			SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed (%i)", -errno);
+			return -errno;
 		}
 	}
+
 	return 0;
 }
 
-static int snd_pcm_hw_munmap_control(snd_pcm_t *pcm)
+static int unmap_status(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	int err;
-	if (hw->sync_ptr_ioctl) {
-		free(hw->sync_ptr);
-		hw->sync_ptr = NULL;
-	} else {
-		if (munmap(hw->mmap_control, page_align(sizeof(*hw->mmap_control))) < 0) {
-			err = -errno;
-			SYSMSG("control munmap failed (%i)", err);
-			return err;
+
+	if (!hw->mmap_status_fallbacked) {
+		if (munmap((void*)hw->mmap_status,
+			   page_align(sizeof(*hw->mmap_status))) < 0) {
+			SYSMSG("status munmap failed (%i)", -errno);
+			return -errno;
 		}
 	}
+
+	hw->mmap_status = NULL;
+	hw->mmap_status_fallbacked = 0;
+
 	return 0;
 }
 
+static int unmap_control(snd_pcm_t *pcm)
+{
+	snd_pcm_hw_t *hw = pcm->private_data;
+
+	if (!hw->mmap_control_fallbacked) {
+		if (munmap((void *)hw->mmap_control,
+			   page_align(sizeof(*hw->mmap_control))) < 0) {
+			SYSMSG("control munmap failed (%i)", -errno);
+			return -errno;
+		}
+	}
+
+	hw->mmap_control = NULL;
+	hw->mmap_control_fallbacked = 0;
+
+	return 0;
+}
+
+static void unmap_status_and_control_data(snd_pcm_t *pcm)
+{
+	snd_pcm_hw_t *hw = pcm->private_data;
+
+	unmap_status(pcm);
+	unmap_control(pcm);
+	if (hw->sync_ptr)
+		free(hw->sync_ptr);
+}
+
 static int snd_pcm_hw_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
 {
 	return 0;
@@ -986,8 +1042,9 @@ static int snd_pcm_hw_close(snd_pcm_t *pcm)
 		err = -errno;
 		SYSMSG("close failed (%i)\n", err);
 	}
-	snd_pcm_hw_munmap_status(pcm);
-	snd_pcm_hw_munmap_control(pcm);
+
+	unmap_status_and_control_data(pcm);
+
 	free(hw);
 	return err;
 }
@@ -1509,7 +1566,6 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd,
 	hw->device = info.device;
 	hw->subdevice = info.subdevice;
 	hw->fd = fd;
-	hw->sync_ptr_ioctl = sync_ptr_ioctl;
 	/* no restriction */
 	hw->format = SND_PCM_FORMAT_UNKNOWN;
 	hw->rate = 0;
@@ -1533,12 +1589,7 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd,
 #endif
 	pcm->own_state_check = 1; /* skip the common state check */
 
-	ret = snd_pcm_hw_mmap_status(pcm);
-	if (ret < 0) {
-		snd_pcm_close(pcm);
-		return ret;
-	}
-	ret = snd_pcm_hw_mmap_control(pcm);
+	ret = map_status_and_control_data(pcm, sync_ptr_ioctl);
 	if (ret < 0) {
 		snd_pcm_close(pcm);
 		return ret;
-- 
2.11.0
