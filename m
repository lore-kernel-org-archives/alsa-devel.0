From: Martin Langer <martin-langer@gmx.de>
Subject: kernel 2.2
Date: Wed, 7 Jan 2004 23:38:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040107223844.GA15133@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I have two warnings with 2.2. The first one is still not fixed:

pci_compat_22.c: In function snd_pci_compat_release_region':
pci_compat_22.c:384: warning: implicit declaration of function
release_mem_region'


... and the second one needs this fix:


--- pcm_native.c~	Thu Jan  1 22:06:44 2004
+++ pcm_native.c	Wed Jan  7 23:27:20 2004
@@ -2901,8 +2901,14 @@
 	if (size != PAGE_ALIGN(sizeof(snd_pcm_mmap_status_t)))
 		return -EINVAL;
 	area->vm_ops = &snd_pcm_vm_ops_status;
-	area->vm_private_data = substream;
-	area->vm_flags |= VM_RESERVED;
+#ifndef LINUX_2_2
+        area->vm_private_data = substream;
+#else
+        area->vm_private_data = (long)substream;
+#endif
+#ifdef VM_RESERVED
+        area->vm_flags |= VM_RESERVED;
+#endif
 	return 0;
 }
 


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
