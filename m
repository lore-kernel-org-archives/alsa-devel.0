From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix alsa-lib documentation references
Date: Tue, 01 Jul 2003 10:36:15 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0307011034410.28783-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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
List-Id: alsa-devel@alsa-project.org


fix some wrong section/file/reference names


Index: alsa-lib/src/pcm/pcm_dmix.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dmix.c,v
retrieving revision 1.37
diff -u -r1.37 pcm_dmix.c
--- alsa-lib/src/pcm/pcm_dmix.c	23 Apr 2003 12:41:58 -0000	1.37
+++ alsa-lib/src/pcm/pcm_dmix.c	1 Jul 2003 08:17:25 -0000
@@ -1093,7 +1093,7 @@
 }
 \endcode

-\subsection pcm_plugins_hw_funcref Function reference
+\subsection pcm_plugins_dmix_funcref Function reference

 <UL>
   <LI>snd_pcm_dmix_open()
Index: alsa-lib/src/pcm/pcm_dshare.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dshare.c,v
retrieving revision 1.4
diff -u -r1.4 pcm_dshare.c
--- alsa-lib/src/pcm/pcm_dshare.c	23 Apr 2003 12:41:58 -0000	1.4
+++ alsa-lib/src/pcm/pcm_dshare.c	1 Jul 2003 08:17:25 -0000
@@ -885,7 +885,7 @@
 }
 \endcode

-\subsection pcm_plugins_hw_funcref Function reference
+\subsection pcm_plugins_dshare_funcref Function reference

 <UL>
   <LI>snd_pcm_dshare_open()
Index: alsa-lib/src/pcm/pcm_dsnoop.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dsnoop.c,v
retrieving revision 1.4
diff -u -r1.4 pcm_dsnoop.c
--- alsa-lib/src/pcm/pcm_dsnoop.c	23 Apr 2003 12:41:58 -0000	1.4
+++ alsa-lib/src/pcm/pcm_dsnoop.c	1 Jul 2003 08:17:28 -0000
@@ -1,5 +1,5 @@
 /**
- * \file pcm/pcm_snoop.c
+ * \file pcm/pcm_dsnoop.c
  * \ingroup PCM_Plugins
  * \brief PCM Capture Stream Snooping (dsnoop) Plugin Interface
  * \author Jaroslav Kysela <perex@suse.cz>
@@ -837,7 +837,7 @@
 }
 \endcode

-\subsection pcm_plugins_hw_funcref Function reference
+\subsection pcm_plugins_dsnoop_funcref Function reference

 <UL>
   <LI>snd_pcm_dsnoop_open()
Index: alsa-lib/src/pcm/pcm_share.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_share.c,v
retrieving revision 1.74
diff -u -r1.74 pcm_share.c
--- alsa-lib/src/pcm/pcm_share.c	7 Mar 2003 18:46:33 -0000	1.74
+++ alsa-lib/src/pcm/pcm_share.c	1 Jul 2003 08:17:29 -0000
@@ -1501,7 +1501,7 @@
 to each channel is exlusive (samples are not mixed together). It means, if
 the channel zero is used with first client, the channel cannot be used with
 second one. If you are looking for a mixing plugin, use the
-\ref pcm_plugins_smix "smix plugin".
+\ref pcm_plugins_dmix "dmix plugin".

 \code
 pcm.name {




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
