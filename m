From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Run without optimizations
Date: Mon, 04 Apr 2011 08:47:41 +0200
Message-ID: <4D99698D.4070200@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020500080700030001070405"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D2D524434
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 08:47:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020500080700030001070405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This one has been lying in my local tree for a while. Feel free to apply 
if you think it makes sense.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------020500080700030001070405
Content-Type: text/x-patch;
 name="0001-hda-emu-Run-without-optimizations.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-hda-emu-Run-without-optimizations.patch"

>From dc0cfae4d2d81a8cdc9eed93be9dee90f5e724ed Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 4 Apr 2011 08:18:24 +0200
Subject: [PATCH] hda-emu: Run without optimizations

hda-emu does not need the extra performance, better have all more
reliable debugging.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index c964761..a8c3308 100644
--- a/configure.ac
+++ b/configure.ac
@@ -13,7 +13,7 @@ WFLAGS="-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -f
 WFLAGS="$WFLAGS -Wdeclaration-after-statement"
 WFLAGS="$WFLAGS -Wno-pointer-sign"
 WFLAGS="$WFLAGS -fwrapv"
-OPTFLAGS="-O2 -g"
+OPTFLAGS="-O0 -g"
 CFLAGS="$CFLAGS $OPTFLAGS $WFLAGS"
 
 AC_ARG_ENABLE(old-workq,
-- 
1.7.4.1


--------------020500080700030001070405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020500080700030001070405--
