From: Paul Davis <paul@linuxaudiosystems.com>
Subject: patch for hammerfall driver
Date: Sun, 2 Feb 2003 16:37:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302022137.h12LbkD30723@linuxaudiosystems.com>
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

i don't know how we ended up with such incorrect values for the
period/buffer size limits, but this corrects them. this previously
prevented applications from requesting a period size of 8192
frames. an identical patch is needed for the hdsp driver. i'll post
one tomorrow if jaroslav or takashi don't want to just hand-apply this
one. let me know.

--p


Index: rme9652.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/rme9652.c,v
retrieving revision 1.22
diff -u -u -r1.22 rme9652.c
--- rme9652.c   14 Jul 2002 21:01:18 -0000      1.22
+++ rme9652.c   2 Feb 2003 21:31:49 -0000
@@ -2279,9 +2279,9 @@
        rate_max:               96000,
        channels_min:           10,
        channels_max:           26,
-       buffer_bytes_max:       1024*1024,
-       period_bytes_min:       1,
-       period_bytes_max:       1024*1024,
+       buffer_bytes_max:       RME9652_CHANNEL_BUFFER_BYTES * 26,
+       period_bytes_min:       (64 * sizeof(int)) * 10,
+       period_bytes_max:       (8192 * sizeof(int)) * 26,
        periods_min:            2,
        periods_max:            2,
        fifo_size:              0,
@@ -2302,9 +2302,9 @@
        rate_max:               96000,
        channels_min:           10,
        channels_max:           26,
-       buffer_bytes_max:       1024*1024,
-       period_bytes_min:       1,
-       period_bytes_max:       1024*1024,
+       buffer_bytes_max:       RME9652_CHANNEL_BUFFER_BYTES *26,
+       period_bytes_min:       (64 * sizeof(int)) * 10,
+       period_bytes_max:       (8192 * sizeof(int)) * 26,
        periods_min:            2,
        periods_max:            2,
        fifo_size:              0,



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
