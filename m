From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix for snd-vxp-lib Modules.dep entry
Date: Tue, 03 Dec 2002 09:27:02 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212030921320.17800-100000@studcom.urz.uni-halle.de>
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


snd-vxp-lib isn't a card driver


Index: alsa-driver/utils/Modules.dep
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/utils/Modules.dep,v
retrieving revision 1.13
diff -u -r1.13 Modules.dep
--- alsa-driver/utils/Modules.dep	30 Oct 2002 16:44:22 -0000	1.13
+++ alsa-driver/utils/Modules.dep	3 Dec 2002 08:16:11 -0000
@@ -18,6 +18,6 @@
 |snd-msnd-pinnacle snd-pcm snd-seq-midi

 %dir linux/pcmcia/vx
-|snd-vxp-lib snd-pcm
+snd-vxp-lib snd-pcm
 |snd-vxpocket snd-vxp-lib
 |snd-vxp440 snd-vxp-lib




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
