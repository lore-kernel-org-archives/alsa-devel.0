From: Karl Grill <kgrill@chello.at>
Subject: emi62 (may be slightly off-topic)
Date: Tue, 12 Feb 2013 09:17:54 +0100
Message-ID: <1360657074.2790.71.camel@chello084112006029.chello.at>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
 <4D821A18.30407@ladisch.de>
 <AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
 <4D894196.4040002@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Oq42THablX8586H5X/MP"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep16.mx.upcmail.net (fep16.mx.upcmail.net [62.179.121.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BE5826170F
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 08:34:26 +0100 (CET)
Received: from edge04.upcmail.net ([192.168.13.239]) by viefep16-int.chello.at
 (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
 id <20130212073425.FFLV2075.viefep16-int.chello.at@edge04.upcmail.net>
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 08:34:25 +0100
In-Reply-To: <4D894196.4040002@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-Oq42THablX8586H5X/MP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi all,
I'm not quite sure if this is really on-topic as the emi62 loader is not
in alsa-driver. On the other hand, the patch is small (changing only two
bytes in the sources, one in  the binary - as a matter of fact, I fixed
the driver for myself by directly patching the binary), so I'll attach
it here (against the alsa-kernel tree). The driver has been broken since
kernel 2.6.27 (http://xiphmont.livejournal.com/46858.html).
BTW, the firmware for both the 6|2m and the 2|6 in the alsa-firmware
package are in the wrong format (the kernel drivers don't work with raw
binaries but with the binary ihex .fw format), and it is installed in
the wrong place. This may create some confusion - it did so for me. As
the mainstream linux kernel already contains the proper firmware, it
might be the best solution to remove the emi_26_62 stuff altogether.

Regards
Karl


--=-Oq42THablX8586H5X/MP
Content-Disposition: attachment; filename="0001-emi62-fix.patch"
Content-Type: text/x-patch; name="0001-emi62-fix.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 850dfc9bd36b4d76d3bd4279028dd74bc3d7e170 Mon Sep 17 00:00:00 2001
From: Karl Grill <kgrill@chello.at>
Date: Sun, 10 Feb 2013 20:27:25 +0100
Subject: [PATCH] emi62-fix
 fix firmware loading for emi6|2m (was broken since 2.6.27)


Signed-off-by: Karl Grill <kgrill@chello.at>
---
 drivers/usb/misc/emi62.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/misc/emi62.c b/drivers/usb/misc/emi62.c
index ae794b9..4e94b60 100644
--- a/drivers/usb/misc/emi62.c
+++ b/drivers/usb/misc/emi62.c
@@ -197,7 +197,7 @@ static int emi62_load_firmware (struct usb_device *dev)
 		if (INTERNAL_RAM(be32_to_cpu(rec->addr))) {
 			err = emi62_writememory(dev, be32_to_cpu(rec->addr),
 						rec->data, be16_to_cpu(rec->len),
-						ANCHOR_LOAD_EXTERNAL);
+						ANCHOR_LOAD_INTERNAL);
 			if (err < 0)
 				goto wraperr;
 		}
-- 
1.7.2.5


--=-Oq42THablX8586H5X/MP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-Oq42THablX8586H5X/MP--
