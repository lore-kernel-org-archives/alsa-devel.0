From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: [PATCH] deprecate (un)register_ioctl32_conversion
Date: Wed, 5 Jan 2005 16:40:43 +0200
Message-ID: <20050105144043.GB19434@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262455AbVAEOlM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050103011113.6f6c8f44.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Hello, Andrew, all!

Since in -mm1 we now have a race-free replacement (that being ioctl_compat),
here is a patch to deprecate (un)register_ioctl32_conversion.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>


diff -ruI -u linux-2.6.10/include/linux/ioctl32.h linux-2.6.10-ioctls/include/linux/ioctl32.h
--- linux-2.6.10/include/linux/ioctl32.h	2004-12-24 23:33:49.000000000 +0200
+++ linux-2.6.10-ioctls/include/linux/ioctl32.h	2005-01-05 20:19:46.716664232 +0200
@@ -23,9 +23,12 @@
  */ 
 
 #ifdef CONFIG_COMPAT
-extern int register_ioctl32_conversion(unsigned int cmd,
+
+/* The following two calls trigger an unfixable module unload race. */
+/* Deprecated in favor of ioctl_compat in struct file_operations. */
+extern int __deprecated register_ioctl32_conversion(unsigned int cmd,
 				ioctl_trans_handler_t handler);
-extern int unregister_ioctl32_conversion(unsigned int cmd);
+extern int __deprecated unregister_ioctl32_conversion(unsigned int cmd);
 
 #else
 
