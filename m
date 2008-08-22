From: linux@audioscience.com
Subject: [PATCH - asihpi 4/6] Mem buffer alloc inside adapter
	mutex.
Date: Fri, 22 Aug 2008 17:26:31 +1200
Message-ID: <1219382793-21272-1-git-send-email-linux@audioscience.com>
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
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index 8222178..cf7c702 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -139,7 +139,20 @@ long asihpi_hpi_ioctl(
 	pa = &adapters[hm.wAdapterIndex];
 	hr.wSize = 0;
 	if (hm.wObject == HPI_OBJ_SUBSYSTEM) {
-		HPI_MessageF(&hm, &hr, file);
+		switch (hm.wFunction) {
+		case HPI_SUBSYS_CREATE_ADAPTER:
+		case HPI_SUBSYS_DELETE_ADAPTER:
+			/* Application must not use these functions! */
+			hr.wSize = sizeof(struct hpi_response_header);
+			hr.wError = HPI_ERROR_INVALID_OPERATION;
+			hr.wFunction = hm.wFunction;
+			uncopied_bytes = copy_to_user(phr, &hr, hr.wSize);
+			if (uncopied_bytes)
+				return -EFAULT;
+			return 0;
+		default:
+			HPI_MessageF(&hm, &hr, file);
+		}
 	} else {
 		u16 __user *ptr = NULL;
 		u32 size = 0;
@@ -164,16 +177,6 @@ long asihpi_hpi_ioctl(
 
 		/* Dig out any pointers embedded in the message.  */
 		switch (hm.wFunction) {
-		case HPI_SUBSYS_CREATE_ADAPTER:
-		case HPI_SUBSYS_DELETE_ADAPTER:
-			/* Application must not use these functions! */
-			hr.wSize = sizeof(struct hpi_response_header);
-			hr.wError = HPI_ERROR_INVALID_OPERATION;
-			hr.wFunction = hm.wFunction;
-			uncopied_bytes = copy_to_user(phr, &hr, hr.wSize);
-			if (uncopied_bytes)
-				return -EFAULT;
-			return 0;
 		case HPI_OSTREAM_WRITE:
 		case HPI_ISTREAM_READ:
 			/* Yes, sparse, this is correct. */
@@ -202,6 +205,9 @@ long asihpi_hpi_ioctl(
 						"HPI could not allocate "
 						"stream buffer size %d\n",
 						size);
+
+					mutex_unlock(&adapters[nAdapter].
+						mutex);
 					return -EINVAL;
 				}
 
@@ -216,10 +222,11 @@ long asihpi_hpi_ioctl(
 			break;
 
 		default:
+			size = 0;
 			break;
 		}
 
-		if (wrflag == 0) {
+		if (size && (wrflag == 0)) {
 			uncopied_bytes =
 				copy_from_user(pa->pBuffer, ptr, size);
 			if (uncopied_bytes)
@@ -231,7 +238,7 @@ long asihpi_hpi_ioctl(
 
 		HPI_MessageF(&hm, &hr, file);
 
-		if (wrflag == 1) {
+		if (size && (wrflag == 1)) {
 			uncopied_bytes = copy_to_user(ptr, pa->pBuffer, size);
 			if (uncopied_bytes)
 				HPI_DEBUG_LOG(WARNING,
-- 
1.5.4.3
