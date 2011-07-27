From: linux@audioscience.com
Subject: [PATCH] ALSA: asihpi - bug fix pa use before init.
Date: Wed, 27 Jul 2011 20:03:51 +1200
Message-ID: <1311753831-2529-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Fixes bug introduced by 1c073b67.
Also declare pa local to block in which it is used.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpioctl.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 65fcf47..e0cff0c 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -107,7 +107,6 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	union hpi_response_buffer_v1 *hr;
 	u16 res_max_size;
 	u32 uncopied_bytes;
-	struct hpi_adapter *pa = NULL;
 	int err = 0;
 
 	if (cmd != HPI_IOCTL_LINUX)
@@ -182,6 +181,7 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		/* -1=no data 0=read from user mem, 1=write to user mem */
 		int wrflag = -1;
 		u32 adapter = hm->h.adapter_index;
+		struct hpi_adapter *pa = &adapters[adapter];
 
 		if ((adapter > HPI_MAX_ADAPTERS) || (!pa->type)) {
 			hpi_init_response(&hr->r0, HPI_OBJ_ADAPTER,
@@ -197,9 +197,7 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			goto out;
 		}
 
-		pa = &adapters[adapter];
-
-		if (mutex_lock_interruptible(&adapters[adapter].mutex)) {
+		if (mutex_lock_interruptible(&pa->mutex)) {
 			err = -EINTR;
 			goto out;
 		}
@@ -235,8 +233,7 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 							"stream buffer size %d\n",
 							size);
 
-						mutex_unlock(&adapters
-							[adapter].mutex);
+						mutex_unlock(&pa->mutex);
 						err = -EINVAL;
 						goto out;
 					}
@@ -277,7 +274,7 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 					uncopied_bytes, size);
 		}
 
-		mutex_unlock(&adapters[adapter].mutex);
+		mutex_unlock(&pa->mutex);
 	}
 
 	/* on return response size must be set */
-- 
1.7.0.4
