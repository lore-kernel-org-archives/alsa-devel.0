From: Paul Davis <paul@linuxaudiosystems.com>
Subject: hdsp patch part II
Date: Sat, 14 Jun 2003 01:14:01 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306140514.h5E5E1d15272@linuxaudiosystems.com>
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

i just realized that y'all will need this too:

Index: hdsp.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/hdsp.h,v
retrieving revision 1.1
diff -u -u -r1.1 hdsp.h
--- hdsp.h      7 Apr 2003 15:32:31 -0000       1.1
+++ hdsp.h      14 Jun 2003 05:08:59 -0000
@@ -24,6 +24,7 @@
 typedef enum {
        Digiface,
        Multiface,
+       H9652,
        Undefined,
 } HDSP_IO_Type;


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
