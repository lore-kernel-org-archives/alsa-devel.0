From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: Re: alsa-driver-1.0.0pre3 - UltraSound PnP card not found?
Date: Fri, 09 Jan 2004 05:39:14 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040109053914.59CB14955@marimba.home.net>
References: <20031212023329.071274955@marimba.home.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: My message of "Fri, 12 Dec 2003 02:33:28 GMT."
             <20031212023329.071274955@marimba.home.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Ted <ted@nowtsfree.freeserve.co.uk>
List-Id: alsa-devel@alsa-project.org

I previously reported a problem on Thu, 27 Nov 2003,
with loading the snd-interwave module from alsa-driver-1.0.0pre3
into linux-2.2.25, and a "fix" for this on Fri, 12 Dec 2003.

I have looked harder at this now and think that the fix should be
to define CONFIG_ISAPNP in support/pnp/pnp.c, before including
<linux/isapnp.h>, rather than defining it in isapnp.h.

The problem is that pnp_register_card_driver() in support/pnp/pnp.c
is calling a dummy version of isapnp_find_dev(), defined isapnp.h,
because CONFIG_ISAPNP isn't defined when isapnp.h is included in
support/pnp/pnp.c.

The problem still remains in cvsexport-2004-01-02.

A better solution seems to be this:

$ diff -u4 alsa-driver/support/pnp/pnp.c.Orig alsa-driver/support/pnp/pnp.c
--- alsa-driver/support/pnp/pnp.c.Orig  Fri Oct 31 15:02:21 2003
+++ alsa-driver/support/pnp/pnp.c       Fri Jan  9 03:51:06 2004
@@ -57,8 +57,10 @@
 #ifndef ALSA_BUILD
 #include <linux/isapnp.h>
 #include <linux/pnp.h>
 #else
+#undef CONFIG_ISAPNP
+#define CONFIG_ISAPNP
 #include <linux/isapnp.h>
 #undef CONFIG_PNP
 #define CONFIG_PNP
 #include "pnp.h"

The driver module for my UltraSound PNP sound card will not load
without such a correction.

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
