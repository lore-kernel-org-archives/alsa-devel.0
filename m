From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 alsa-lib 1/6] pcm: hw: add helper functions
	to map/unmap status/control data for runtime of PCM substream
Date: Sun, 25 Jun 2017 13:41:19 +0900
Message-ID: <20170625044124.22234-2-o-takashi@sakamocchi.jp>
References: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id E922C266B48
 for <alsa-devel@alsa-project.org>; Sun, 25 Jun 2017 06:41:34 +0200 (CEST)
In-Reply-To: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
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

Handling mapping operation for status/control data includes some
supplemental operations for fallback mode. It's better to have helper
functions for this purpose.

This commit adds the helper functions.
---
 src/pcm/pcm_hw.c | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index a648d12c..abf4afe0 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -31,6 +31,7 @@
 #include <stdlib.h>
 #include <stddef.h>
 #include <unistd.h>
+#include <stdbool.h>
 #include <signal.h>
 #include <string.h>
 #include <fcntl.h>
@@ -866,7 +867,7 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
 	return xfern.result;
 }
 
-static int snd_pcm_hw_mmap_status(snd_pcm_t *pcm)
+static int map_status_data(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
 	struct snd_pcm_sync_ptr sync_ptr;
@@ -900,7 +901,7 @@ static int snd_pcm_hw_mmap_status(snd_pcm_t *pcm)
 	return 0;
 }
 
-static int snd_pcm_hw_mmap_control(snd_pcm_t *pcm)
+static int map_control_data(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
 	void *ptr;
@@ -922,10 +923,28 @@ static int snd_pcm_hw_mmap_control(snd_pcm_t *pcm)
 	return 0;
 }
 
-static int snd_pcm_hw_munmap_status(snd_pcm_t *pcm)
+static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
 	int err;
+
+	hw->sync_ptr_ioctl = (int)force_fallback;
+
+	err = map_status_data(pcm);
+	if (err < 0)
+		return err;
+
+	err = map_control_data(pcm);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int unmap_status_data(snd_pcm_hw_t *hw)
+{
+	int err;
+
 	if (hw->sync_ptr_ioctl) {
 		free(hw->sync_ptr);
 		hw->sync_ptr = NULL;
@@ -939,10 +958,10 @@ static int snd_pcm_hw_munmap_status(snd_pcm_t *pcm)
 	return 0;
 }
 
-static int snd_pcm_hw_munmap_control(snd_pcm_t *pcm)
+static int unmap_control_data(snd_pcm_hw_t *hw)
 {
-	snd_pcm_hw_t *hw = pcm->private_data;
 	int err;
+
 	if (hw->sync_ptr_ioctl) {
 		free(hw->sync_ptr);
 		hw->sync_ptr = NULL;
@@ -956,6 +975,12 @@ static int snd_pcm_hw_munmap_control(snd_pcm_t *pcm)
 	return 0;
 }
 
+static void unmap_status_and_control_data(snd_pcm_hw_t *hw)
+{
+	unmap_status_data(hw);
+	unmap_control_data(hw);
+}
+
 static int snd_pcm_hw_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
 {
 	return 0;
@@ -974,8 +999,9 @@ static int snd_pcm_hw_close(snd_pcm_t *pcm)
 		err = -errno;
 		SYSMSG("close failed (%i)\n", err);
 	}
-	snd_pcm_hw_munmap_status(pcm);
-	snd_pcm_hw_munmap_control(pcm);
+
+	unmap_status_and_control_data(hw);
+
 	free(hw);
 	return err;
 }
@@ -1484,7 +1510,6 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd,
 	hw->device = info.device;
 	hw->subdevice = info.subdevice;
 	hw->fd = fd;
-	hw->sync_ptr_ioctl = sync_ptr_ioctl;
 	/* no restriction */
 	hw->format = SND_PCM_FORMAT_UNKNOWN;
 	hw->rate = 0;
@@ -1508,12 +1533,7 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd,
 #endif
 	pcm->own_state_check = 1; /* skip the common state check */
 
-	ret = snd_pcm_hw_mmap_status(pcm);
-	if (ret < 0) {
-		snd_pcm_close(pcm);
-		return ret;
-	}
-	ret = snd_pcm_hw_mmap_control(pcm);
+	ret = map_status_and_control_data(pcm, !!sync_ptr_ioctl);
 	if (ret < 0) {
 		snd_pcm_close(pcm);
 		return ret;
-- 
2.11.0
