From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: PATCH: fix compat22 layer
Date: Thu, 23 May 2002 11:33:08 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205231132090.879-100000@sculpster.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
List-Id: alsa-devel@alsa-project.org

Here's a patch against current CVS-tree to make
alsa-driver again work with 2.2.x kernels (acore/misc.c
only defines snd_compat_request_region()):

--cut--
RCS file: /cvsroot/alsa/alsa-driver/include/compat_22.h,v
retrieving revision 1.41
diff -u -r1.41 compat_22.h
--- compat_22.h	7 May 2002 15:45:47 -0000	1.41
+++ compat_22.h	20 May 2002 10:37:08 -0000
@@ -168,7 +168,7 @@
 void snd_wrapper_request_region(unsigned long from, unsigned long extent, const char *name);
 #undef request_region
 #define request_region(start,size,name) snd_compat_request_region(start,size,name,0)
-#define request_mem_region(start,size,name) snd_compat_request_mem_region(start,size,name,1)
+#define request_mem_region(start,size,name) snd_compat_request_region(start,size,name,1)
 #define release_resource(res) snd_compat_release_resource(res)
 
 struct resource *snd_compat_request_region(unsigned long start, unsigned long size, const char *name, int is_memory);
--cut--

-- 
 http://www.eca.cx
 Audio software for Linux!









_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
