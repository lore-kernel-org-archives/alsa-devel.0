From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] init.c: remove superfluous strcpy
Date: Tue, 03 Dec 2002 09:26:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212030919370.17800-100000@studcom.urz.uni-halle.de>
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


At this point in choose_default_id(), id points to card->id.


Index: alsa-kernel/core/init.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/init.c,v
retrieving revision 1.20
diff -u -r1.20 init.c
--- alsa-kernel/core/init.c	30 Nov 2002 10:14:03 -0000	1.20
+++ alsa-kernel/core/init.c	3 Dec 2002 08:16:51 -0000
@@ -393,8 +393,6 @@
 			idx_flag++;
 		}
 	}
-
-	strcpy(card->id, id);
 }

 int snd_card_register(snd_card_t * card)



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
