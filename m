From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [PATCH 3/10] Gameport: connect() is mandatory
Date: Fri, 11 Feb 2005 02:00:59 -0500
Message-ID: <200502110201.00916.dtor_core@ameritech.net>
References: <200502110158.47872.dtor_core@ameritech.net> <200502110159.51020.dtor_core@ameritech.net> <200502110200.28299.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp817.mail.sc5.yahoo.com (smtp817.mail.sc5.yahoo.com [66.163.170.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 4D25B22D
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2005 08:05:36 +0100 (MET)
In-Reply-To: <200502110200.28299.dtor_core@ameritech.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
List-Id: alsa-devel@alsa-project.org


===================================================================


ChangeSet@1.2151, 2005-02-11 01:18:29-05:00, dtor_core@ameritech.net
  Input: make connect and disconnect methods mandatory for gameport
         drivers since that's where gameport_{open|close} are called
         from to actually bind driver to a port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 gameport.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)


===================================================================



diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2005-02-11 01:35:40 -05:00
+++ b/drivers/input/gameport/gameport.c	2005-02-11 01:35:40 -05:00
@@ -107,8 +107,7 @@
         list_for_each_entry(drv, &gameport_driver_list, node) {
 		if (gameport->drv)
 			break;
-		if (drv->connect)
-                	drv->connect(gameport, drv);
+               	drv->connect(gameport, drv);
         }
 }
 
@@ -128,7 +127,7 @@
 void gameport_unregister_port(struct gameport *gameport)
 {
 	list_del_init(&gameport->node);
-	if (gameport->drv && gameport->drv->disconnect)
+	if (gameport->drv)
 		gameport->drv->disconnect(gameport);
 }
 
@@ -138,7 +137,7 @@
 
 	list_add_tail(&drv->node, &gameport_driver_list);
 	list_for_each_entry(gameport, &gameport_list, node)
-		if (!gameport->drv && drv->connect)
+		if (!gameport->drv)
 			drv->connect(gameport, drv);
 }
 
@@ -148,7 +147,7 @@
 
 	list_del_init(&drv->node);
 	list_for_each_entry(gameport, &gameport_list, node) {
-		if (gameport->drv == drv && drv->disconnect)
+		if (gameport->drv == drv)
 			drv->disconnect(gameport);
 		gameport_find_driver(gameport);
 	}


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
