From: linux@audioscience.com
Subject: [PATCH - asihpi 3/4] Subsystem message now outside
 adapter#0 mutex. Fixes segfault when no adapter#0 present.
Date: Wed, 09 Jul 2008 11:10:40 +1200
Message-ID: <1215558641-19514-3-git-send-email-linux@audioscience.com>
References: <1215558641-19514-1-git-send-email-linux@audioscience.com>
	<1215558641-19514-2-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1215558641-19514-2-git-send-email-linux@audioscience.com>
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
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index 5192db3..a13748d 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -106,20 +106,11 @@ int asihpi_hpi_release(
 	return 0;
 }
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 11)
 long asihpi_hpi_ioctl(
 	struct file *file,
 	unsigned int cmd,
 	unsigned long arg
 )
-#else
-int asihpi_hpi_ioctl(
-	struct inode *inode,
-	struct file *file,
-	unsigned int cmd,
-	unsigned long arg
-)
-#endif
 {
 	struct hpi_ioctl_linux __user *phpi_ioctl_data;
 	void __user *phm;
@@ -127,7 +118,7 @@ int asihpi_hpi_ioctl(
 	struct hpi_message hm;
 	struct hpi_response hr;
 	u32 uncopied_bytes;
-	struct hpi_adapter *pa;
+	struct hpi_adapter *pa = NULL;
 
 	if (cmd != HPI_IOCTL_LINUX)
 		return -EINVAL;
@@ -145,27 +136,29 @@ int asihpi_hpi_ioctl(
 		return -EFAULT;
 
 	pa = &adapters[hm.wAdapterIndex];
-
-	if ((hm.wAdapterIndex > HPI_MAX_ADAPTERS) || (!pa->type)) {
-		HPI_InitResponse(&hr, HPI_OBJ_ADAPTER, HPI_ADAPTER_OPEN,
-			HPI_ERROR_BAD_ADAPTER_NUMBER);
-
-		uncopied_bytes = copy_to_user(phr, &hr, sizeof(hr));
-		if (uncopied_bytes)
-			return -EFAULT;
-		return 0;
-	}
-
 	hr.wSize = 0;
-	/* Response filled either copy from cache, or by HPI_Message() */
-	{
-		/* Dig out any pointers embedded in the message.  */
+	if (hm.wObject == HPI_OBJ_SUBSYSTEM) {
+		HPI_MessageF(&hm, &hr, file);
+	} else {
 		u16 __user *ptr = NULL;
 		u32 size = 0;
 
 		/* -1=no data 0=read from user mem, 1=write to user mem */
 		int wrflag = -1;
 		u32 nAdapter = hm.wAdapterIndex;
+
+		if ((hm.wAdapterIndex > HPI_MAX_ADAPTERS) || (!pa->type)) {
+			HPI_InitResponse(&hr, HPI_OBJ_ADAPTER,
+				HPI_ADAPTER_OPEN,
+				HPI_ERROR_BAD_ADAPTER_NUMBER);
+
+			uncopied_bytes = copy_to_user(phr, &hr, sizeof(hr));
+			if (uncopied_bytes)
+				return -EFAULT;
+			return 0;
+		}
+
+		/* Dig out any pointers embedded in the message.  */
 		switch (hm.wFunction) {
 		case HPI_SUBSYS_CREATE_ADAPTER:
 		case HPI_SUBSYS_DELETE_ADAPTER:
-- 
1.5.4.3
