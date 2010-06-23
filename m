From: Brad Figg <brad.figg@canonical.com>
Subject: [PATCH 1/1] Daily snapshot not building on 2.6.32
Date: Wed, 23 Jun 2010 11:37:16 -0700
Message-ID: <4C22545C.2060101@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 27BEB10391F
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 20:37:25 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1ORUpA-0001lV-0c
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 19:37:24 +0100
Received: from pool-98-108-129-180.ptldor.fios.verizon.net ([98.108.129.180]
	helo=[192.168.1.13]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <brad.figg@canonical.com>) id 1ORUp9-000521-PT
	for alsa-devel@alsa-project.org; Wed, 23 Jun 2010 19:37:23 +0100
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

I've had to apply the following patch to successfully build
the daily snapshot on 2.6.32. Without this patch I get:

CC [M]  /karmic/home/work/alsa/alsa-driver/usb/urb.o
/karmic/home/work/alsa/alsa-driver/usb/urb.c: In function =91release_urb_ct=
x=92:
/karmic/home/work/alsa/alsa-driver/usb/urb.c:112: error: implicit declarati=
on of function =91usb_free_
coherent=92
/karmic/home/work/alsa/alsa-driver/usb/urb.c: In function =91snd_usb_init_s=
ubstream_urbs=92:
/karmic/home/work/alsa/alsa-driver/usb/urb.c:327: error: implicit declarati=
on of function =91usb_alloc_coherent=92
/karmic/home/work/alsa/alsa-driver/usb/urb.c:328: warning: assignment makes=
 pointer from integer without a cast
/karmic/home/work/alsa/alsa-driver/usb/urb.c:341: warning: assignment makes=
 pointer from integer without a cast
make[3]: *** [/karmic/home/work/alsa/alsa-driver/usb/urb.o] Error 1


Note: I would have preferred to provide this as a git patch
       but I don't know where the repository for the daily
       snapshot files is located.


---
diff -ru a/usb/misc/Makefile b/usb/misc/Makefile
--- a/usb/misc/Makefile 2010-03-10 01:12:19.000000000 -0800
+++ b/usb/misc/Makefile 2010-06-23 11:25:33.176133657 -0700
@@ -7,4 +7,8 @@

  include $(SND_TOPDIR)/alsa-kernel/usb/misc/Makefile

+EXTRA_CFLAGS +=3D -I$(SND_TOPDIR)/usb
+
  include $(SND_TOPDIR)/Rules.make
+
+ua101.c: usbaudio.inc $(SND_TOPDIR)/alsa-kernel/usb/misc/ua101.c
diff -ru a/usb/misc/ua101.c b/usb/misc/ua101.c
--- a/usb/misc/ua101.c  2010-03-10 01:12:19.000000000 -0800
+++ b/usb/misc/ua101.c  2010-06-23 11:25:53.054884851 -0700
@@ -1,3 +1,5 @@
+#define __NO_VERSION__
+#include "usbaudio.inc"
  #include "adriver.h"
  #include "../../alsa-kernel/usb/misc/ua101.c"
  EXPORT_NO_SYMBOLS;


-- =

Brad Figg brad.figg@canonical.com http://www.canonical.com
