From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] cmipci: reduce stack usage
Date: Tue, 01 Jul 2003 10:42:23 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0307011036170.28783-100000@studcom.urz.uni-halle.de>
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


reduce stack usage


Index: alsa-kernel/pci/cmipci.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/cmipci.c,v
retrieving revision 1.46
diff -u -r1.46 cmipci.c
--- alsa-kernel/pci/cmipci.c	7 May 2003 15:51:33 -0000	1.46
+++ alsa-kernel/pci/cmipci.c	1 Jul 2003 08:06:19 -0000
@@ -1186,7 +1186,7 @@
 #ifndef USE_AES_IEC958
 	u16 *srcp = src, val;
 #else
-	char buf[1920];         /* bits can be divided by 20, 24, 16 */
+	char buf[480];		/* bits can be divided by 20, 24, 16 */
 	size_t bytes = frames_to_bytes(runtime, count);
 #endif

@@ -1245,7 +1245,7 @@
 	snd_pcm_uframes_t offset;
 	snd_pcm_runtime_t *runtime = subs->runtime;
 # ifdef USE_AES_IEC958
-	char buf[1920];		/* bits can be divided by 20, 24, 16 */
+	char buf[480];		/* bits can be divided by 20, 24, 16 */
 	size_t bytes = frames_to_bytes(runtime, count);
 # endif
 	if (! cm->channel[CM_CH_PLAY].ac3_shift)




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
