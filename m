From: Sverker Wiberg <sverkerw@swipnet.se>
Subject: [PATCH] free_envelope() - bad free()
Date: Fri, 15 Nov 2002 01:00:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <15828.14649.17779.4054@catskinner.nonet.update.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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


This one I caught with Valgrind.

free_envelope(), as called by free_layer(), tries to free memory that
wasn't malloc()ed in its own right (instead it is a field inside a
malloc()ed struct). No other function calls free_envelope().

/Sverker Wiberg

Index: alsa-lib/src/instr/iwffff.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/instr/iwffff.c,v
retrieving revision 1.21
diff -u -r1.21 iwffff.c
--- alsa-lib/src/instr/iwffff.c	14 Nov 2002 08:48:29 -0000	1.21
+++ alsa-lib/src/instr/iwffff.c	14 Nov 2002 23:47:49 -0000
@@ -400,7 +400,6 @@
 		free(rec);
 		rec = nrec;
 	}
-	free(envp);
 }
 
 static void free_layer(iwffff_layer_t *layer)


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
