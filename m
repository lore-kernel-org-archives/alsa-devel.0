From: Paul Davis <paul@linuxaudiosystems.com>
Subject: patch #1 for hdsp MIDI
Date: Mon, 13 Jan 2003 08:34:21 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301131334.h0DDYL810629@linuxaudiosystems.com>
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
Cc: Mark Knecht <markknecht@attbi.com>
List-Id: alsa-devel@alsa-project.org

Index: hdsp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.16
diff -u -u -r1.16 hdsp.c
--- hdsp.c      7 Jan 2003 10:36:32 -0000       1.16
+++ hdsp.c      13 Jan 2003 13:32:32 -0000
@@ -817,10 +817,18 @@
 
 static inline int snd_hdsp_midi_output_possible (hdsp_t *hdsp, int id)
 {
+       int fifo_bytes_used;
+
        if (id) {
-               return (hdsp_read(hdsp, HDSP_midiStatusOut1) & 0xff) < 128;
+               fifo_bytes_used = hdsp_read(hdsp, HDSP_midiStatusOut1) & 0xff;
        } else {
-               return (hdsp_read(hdsp, HDSP_midiStatusOut0) & 0xff)< 128;
+               fifo_bytes_used = hdsp_read(hdsp, HDSP_midiStatusOut0) & 0xff;
+       }
+
+       if (fifo_bytes_used < 128) {
+               return  128 - fifo_bytes_used;
+       } else {
+               return 0;
        }
 }


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
