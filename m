From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] usx2yloader prerequisities
Date: Wed, 3 Dec 2003 19:59:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031203185931.GB638@tuba.home>
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


it would be better to list all prerequisites for usx2yloader somewhere...

martin


--- alsa-tools/usx2yloader/INSTALL.ORIGINAL	Wed Dec  3 19:48:55 2003
+++ alsa-tools/usx2yloader/INSTALL	Wed Dec  3 19:52:46 2003
@@ -1,3 +1,18 @@
+
+Prerequisites
+-------------
+
+- a Linux kernel, with USB, usbfs and hotplugging support enabled
+  (2.2.18 or 2.4.18 or later should work)
+- hotplugging scripts from <http://linux-hotplug.sourceforge.net/>
+  (release dated 2002_08_26 or later)
+- the fxload package from <http://linux-hotplug.sourceforge.net/>
+  (release dated 2002_04_11 or later)
+
+
+Installing
+----------
+
 For Installing from CVS do:
 ./cvscompile
 make install


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
