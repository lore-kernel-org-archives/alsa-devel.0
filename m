From: Javier Conti <av@labcc.ch>
Subject: Fix for dell inspiron 8100 maestro3
Date: Fri, 16 May 2003 16:32:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305161632.46562.av@labcc.ch>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OaPx+wuwnXD1hBQ"
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


--Boundary-00=_OaPx+wuwnXD1hBQ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, after a long and painful investigation on the maestro3 vs. irda problem on 
the dell inspiron 8100 notebook, I found the FIXME tag in the maestro3 
sources and, inspired by the 8000 fix right above, I applied the same fix for 
8100.

I'm no develper, but I think this should't break anything, and for me fixed 
the problem on my 8100. Maybe someone will find this useful.

Patch attached, bye, Javier
-- 
Javier Conti - Labcc
http://www.labcc.ch/

--Boundary-00=_OaPx+wuwnXD1hBQ
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="maestro3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="maestro3.patch"

--- maestro3.c	2003-04-23 12:06:36.000000000 +0200
+++ /usr/src/modules/alsa-driver/alsa-kernel/pci/maestro3.c	2003-05-14 17:19:35.000000000 +0200
@@ -949,6 +949,13 @@
 	},
 	/* FIXME: Inspiron 8100 id should probably be here, too
 	 * (8200 irrelevant: has intel8x0 with CS4205) */
+	{
+		.name = "Dell Inspiron 8100",
+		.vendor = 0x1028,
+		.device = 0x00a4,
+		.amp_gpio = -1,
+		.irda_workaround = 1,
+	},
 	/* NEC LM800J/7 */
 	{
 		.name = "NEC LM800J/7",

--Boundary-00=_OaPx+wuwnXD1hBQ--



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
