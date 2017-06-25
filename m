From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 alsa-lib 3/6] pcm: hw: deallocate fallback
	buffer when trials of unmapping finished
Date: Sun, 25 Jun 2017 13:41:21 +0900
Message-ID: <20170625044124.22234-4-o-takashi@sakamocchi.jp>
References: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id EB753266B50
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

In current implementation, deallocation of fallback buffer is done at
several places.

This commit unifies these deallocations in one place.
---
 src/pcm/pcm_hw.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index c60a521b..1d34956c 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -943,44 +943,35 @@ static int map_status_and_control_data(snd_pcm_t *pcm, bool force_fallback)
 	return 0;
 }
 
-static int unmap_status_data(snd_pcm_hw_t *hw)
+static void unmap_status_data(snd_pcm_hw_t *hw)
 {
-	int err;
-
-	if (hw->sync_ptr_ioctl) {
-		free(hw->sync_ptr);
-		hw->sync_ptr = NULL;
-	} else {
-		if (munmap((void*)hw->mmap_status, page_align(sizeof(*hw->mmap_status))) < 0) {
-			err = -errno;
-			SYSMSG("status munmap failed (%i)", err);
-			return err;
-		}
+	if (!hw->sync_ptr) {
+		if (munmap((void *)hw->mmap_status,
+			   page_align(sizeof(*hw->mmap_status))) < 0)
+			SYSMSG("status munmap failed (%u)", errno);
 	}
-	return 0;
 }
 
-static int unmap_control_data(snd_pcm_hw_t *hw)
+static void unmap_control_data(snd_pcm_hw_t *hw)
 {
-	int err;
-
-	if (hw->sync_ptr_ioctl) {
-		free(hw->sync_ptr);
-		hw->sync_ptr = NULL;
-	} else {
-		if (munmap(hw->mmap_control, page_align(sizeof(*hw->mmap_control))) < 0) {
-			err = -errno;
-			SYSMSG("control munmap failed (%i)", err);
-			return err;
-		}
+	if (!hw->sync_ptr) {
+		if (munmap((void *)hw->mmap_control,
+			   page_align(sizeof(*hw->mmap_control))) < 0)
+			SYSMSG("control munmap failed (%u)", errno);
 	}
-	return 0;
 }
 
 static void unmap_status_and_control_data(snd_pcm_hw_t *hw)
 {
 	unmap_status_data(hw);
 	unmap_control_data(hw);
+
+	if (hw->sync_ptr)
+		free(hw->sync_ptr);
+
+	hw->mmap_status = NULL;
+	hw->mmap_control = NULL;
+	hw->sync_ptr = NULL;
 }
 
 static int snd_pcm_hw_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
-- 
2.11.0
