From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH] move a bit more old stuff into alsa-driver
Date: Sat, 24 May 2003 18:46:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ECFF635.4080405@rogers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070506010808020002000507"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070506010808020002000507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patches move snd_info_entry_inode_operations out of 
alsa-kernel/core/info.c into alsa-driver/acore/info.c

-Jeff

--------------070506010808020002000507
Content-Type: text/plain;
 name="info-cleanup-driver.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="info-cleanup-driver.diff"

Index: acore/info.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/acore/info.c,v
retrieving revision 1.3
diff -u -r1.3 info.c
--- acore/info.c	14 May 2003 15:31:48 -0000	1.3
+++ acore/info.c	24 May 2003 22:40:47 -0000
@@ -88,6 +88,12 @@
 		proc_unregister(parent, de->low_ino);
 	}
 }
+
+static struct inode_operations snd_info_entry_inode_operations =
+{
+	        &snd_info_entry_operations,     /* default sound info directory file-ops */
+};
+
 #endif /* LINUX_VERSION_CODE < 2.4.0 */
 
 #include "../alsa-kernel/core/info.c"

--------------070506010808020002000507
Content-Type: text/plain;
 name="info-cleanup-kernel.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="info-cleanup-kernel.diff"

Index: core/info.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/info.c,v
retrieving revision 1.36
diff -u -r1.36 info.c
--- core/info.c	14 May 2003 15:30:58 -0000	1.36
+++ core/info.c	24 May 2003 22:42:09 -0000
@@ -508,13 +508,6 @@
 	.release =	snd_info_entry_release,
 };
 
-#ifdef LINUX_2_2
-static struct inode_operations snd_info_entry_inode_operations =
-{
-	&snd_info_entry_operations,	/* default sound info directory file-ops */
-};
-#endif	/* LINUX_2_2 */
-
 /**
  * snd_create_proc_entry - create a procfs entry
  * @name: the name of the proc file

--------------070506010808020002000507--



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
