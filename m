From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/2] sst: remove the kernel locking in ioctl
Date: Thu, 14 Oct 2010 16:59:38 +0100
Message-ID: <20101014155933.27495.51005.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 7058024430
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 18:51:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

kernel locking in ioctl was introduced when ioctl function was
moved from ioctl to unlocked ioctl
This is no longer required hence removed

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 .../staging/intel_sst/intel_sst_app_interface.c    |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)


diff --git a/drivers/staging/intel_sst/intel_sst_app_interface.c b/drivers/staging/intel_sst/intel_sst_app_interface.c
index baf0ddc..82768fa 100644
--- a/drivers/staging/intel_sst/intel_sst_app_interface.c
+++ b/drivers/staging/intel_sst/intel_sst_app_interface.c
@@ -812,8 +812,6 @@ long intel_sst_ioctl(struct file *file_ptr, unsigned int cmd, unsigned long arg)
 	struct ioctl_pvt_data *data = NULL;
 	int str_id = 0, minor = 0;
 
-	lock_kernel();
-
 	data = file_ptr->private_data;
 	if (data) {
 		minor = 0;
@@ -821,10 +819,8 @@ long intel_sst_ioctl(struct file *file_ptr, unsigned int cmd, unsigned long arg)
 	} else
 		minor = 1;
 
-	if (sst_drv_ctx->sst_state != SST_FW_RUNNING) {
-		unlock_kernel();
+	if (sst_drv_ctx->sst_state != SST_FW_RUNNING)
 		return -EBUSY;
-	}
 
 	switch (_IOC_NR(cmd)) {
 	case _IOC_NR(SNDRV_SST_STREAM_PAUSE):
@@ -1227,7 +1223,6 @@ long intel_sst_ioctl(struct file *file_ptr, unsigned int cmd, unsigned long arg)
 	default:
 		retval = -EINVAL;
 	}
-	unlock_kernel();
 	pr_debug("sst: intel_sst_ioctl:complete ret code = %d\n", retval);
 	return retval;
 }
