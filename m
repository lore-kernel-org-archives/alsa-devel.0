From: Ian Grant <Ian.Grant@cl.cam.ac.uk>
Subject: alsa-driver-0.9.0rc3 patch
Date: Thu, 12 Sep 2002 16:23:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17pVoy-0001vd-00@wisbech.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Ian.Grant@cl.cam.ac.uk
List-Id: alsa-devel@alsa-project.org

Hello ALSA people

Thanks for making ALSA.

Here is a patch for the toplevel Makefile to remove the $DESTDIR from the path 
of the System.map file where we check for its existence. This makes the 
existence check test the same file location as is used in the subsequent -F 
option to depmod. It works for me!

Thanks again,
Ian

PS. You will need to apply this manually - my mailer will most likely have 
broken the patch.

--- Makefile.orig	Thu Sep 12 16:09:18 2002
+++ Makefile	Thu Sep 12 16:09:52 2002
@@ -117,7 +117,7 @@
 		done \
 	fi
 
-ifeq ($(DESTDIR)$(CONFIG_SND_KERNELDIR)/System.map,$(wildcard 
$(DESTDIR)$(CONFIG_SND_KERNELDIR)/System.map))
+ifeq ($(CONFIG_SND_KERNELDIR)/System.map,$(wildcard 
$(CONFIG_SND_KERNELDIR)/System.map))
 SYSTEM_MAP_OPT = -F $(CONFIG_SND_KERNELDIR)/System.map
 endif
 

-- 
Ian Grant, Computer Lab., William Gates Building, JJ Thomson Ave., Cambridge
Phone: +44 1223 334420




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
