From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] core/seq/seq.c: change snd_seq_client_load parameter
Date: Mon, 22 Jul 2002 10:30:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3BC2B7.584FEC86@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
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


The snd_seq_client_load module parameter is an array.


Index: core/seq/seq.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq.c,v
retrieving revision 1.4
diff -u -r1.4 seq.c
--- core/seq/seq.c	4 Jan 2002 14:17:54 -0000	1.4
+++ core/seq/seq.c	22 Jul 2002 08:14:46 -0000
@@ -48,7 +48,7 @@
 MODULE_CLASSES("{sound}");
 MODULE_SUPPORTED_DEVICE("sound");
 
-MODULE_PARM(snd_seq_client_load, "i");
+MODULE_PARM(snd_seq_client_load, "1-64i");
 MODULE_PARM_DESC(snd_seq_client_load, "The numbers of global (system) clients to load through kmod.");
 MODULE_PARM(snd_seq_default_timer_class, "i");
 MODULE_PARM_DESC(snd_seq_default_timer_class, "The default timer class.");


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
