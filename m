From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix for the id-table termination fix
Date: Mon, 14 Apr 2003 08:29:25 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304140827330.3123-100000@studcom.urz.uni-halle.de>
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


There's still another loop in pnp_register_card_driver() ...


Index: alsa-driver/support/pnp/pnp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/support/pnp/pnp.c,v
retrieving revision 1.4
diff -u -r1.4 pnp.c
--- alsa-driver/support/pnp/pnp.c	11 Apr 2003 07:33:16 -0000	1.4
+++ alsa-driver/support/pnp/pnp.c	14 Apr 2003 06:25:47 -0000
@@ -155,7 +155,7 @@
 	struct pnp_dev *dev;
 	struct pnp_card_driver_instance *ninst = NULL;

-	for (cid = drv->id_table; cid->id; cid++) {
+	for (cid = drv->id_table; cid->id[0] != '\0'; cid++) {
 	      __next_card:
 		card = NULL;
 		do {




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
