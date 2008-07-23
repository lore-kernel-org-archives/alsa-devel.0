From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Add automatic model setting for the Acer
	Aspire 5920G	laptop
Date: Thu, 24 Jul 2008 03:24:04 +1000
Message-ID: <1216833844.27183.3.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ex+D+uKwiytOUX87RXra"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-101-244.auto.usertools.net
	[202.137.101.244])
	by alsa0.perex.cz (Postfix) with ESMTP id D81CD24525
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 19:23:36 +0200 (CEST)
Received: from [192.168.0.7] (unknown [192.168.0.200])
	by www.wishie.net (Postfix) with ESMTP id 272CF5B6BE
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 17:46:42 +1000 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-ex+D+uKwiytOUX87RXra
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Changelog: Make the Acer Aspire 5920G (1025:0121) select
ALC883_ACER_ASPIRE by default

Patch attached.

Signed-off-by: Travis Place <wishie@wishie.net>


--=-ex+D+uKwiytOUX87RXra
Content-Disposition: attachment; filename=acer-aspire-5920G.patch
Content-Type: text/x-patch; name=acer-aspire-5920G.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- patch_realtek.c	2008-07-24 03:21:35.000000000 +1000
+++ patch_realtek.c.wishie	2008-07-24 03:21:23.000000000 +1000
@@ -7907,6 +7907,7 @@
 	SND_PCI_QUIRK(0x1025, 0x006c, "Acer Aspire 9810", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0110, "Acer Aspire", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0112, "Acer Aspire 9303", ALC883_ACER_ASPIRE),
+	SND_PCI_QUIRK(0x1025, 0x0121, "Acer Aspire 5920G", ALC883_ACER_ASPIRE), 
 	SND_PCI_QUIRK(0x1025, 0, "Acer laptop", ALC883_ACER), /* default Acer */
 	SND_PCI_QUIRK(0x1028, 0x020d, "Dell Inspiron 530", ALC888_6ST_DELL),
 	SND_PCI_QUIRK(0x103c, 0x2a3d, "HP Pavillion", ALC883_6ST_DIG),

--=-ex+D+uKwiytOUX87RXra
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-ex+D+uKwiytOUX87RXra--
