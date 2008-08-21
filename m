From: linux@audioscience.com
Subject: [PATCH - asihpi 2/3] Include adapter buffer alloc
	inside adapter mutex
Date: Thu, 21 Aug 2008 13:29:55 +1200
Message-ID: <1219282196-20834-2-git-send-email-linux@audioscience.com>
References: <1219282196-20834-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1219282196-20834-1-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@zaphod.clear.net.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@zaphod.(none)>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index 27a273a..8222178 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -159,6 +159,9 @@ long asihpi_hpi_ioctl(
 			return 0;
 		}
 
+		if (mutex_lock_interruptible(&adapters[nAdapter].mutex))
+			return -EINTR;
+
 		/* Dig out any pointers embedded in the message.  */
 		switch (hm.wFunction) {
 		case HPI_SUBSYS_CREATE_ADAPTER:
@@ -216,9 +219,6 @@ long asihpi_hpi_ioctl(
 			break;
 		}
 
-		if (mutex_lock_interruptible(&adapters[nAdapter].mutex))
-			return -EINTR;
-
 		if (wrflag == 0) {
 			uncopied_bytes =
 				copy_from_user(pa->pBuffer, ptr, size);
@@ -246,11 +246,10 @@ long asihpi_hpi_ioctl(
 	/* on return response size must be set */
 	if (!hr.wSize)
 		return -EFAULT;
-
-	/* Copy the response back to user space.  */
 	uncopied_bytes = copy_to_user(phr, &hr, sizeof(hr));
 	if (uncopied_bytes)
 		return -EFAULT;
+
 	return 0;
 }
 
-- 
1.5.4.3
