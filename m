From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 1.0.6rc1 packages
Date: Thu, 05 Aug 2004 12:17:08 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0408051208270.18069-100000@studcom.urz.uni-halle.de>
References: <s5hk6wdj4yt.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 54C0621F
	for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2004 12:17:11 +0200 (MEST)
In-reply-to: <s5hk6wdj4yt.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Martin Langer <martin-langer@gmx.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Martin Langer wrote:
> > usbusx2yaudio.c:492: __old_i_usX2Y_urb_complete undeclared
>
> This one should fix.
>
> -#define snd_usb_complete_callback(x) __old_ ## x
> +#define snd_usb_complete_callback(x) x ## __old_
>  static void i_usX2Y_urb_complete__old_(struct urb *urb);

Oops, I didn't read your mail before committing my patch which changes
the function names instead.  Well, now it's consistent with
usbaudio.c.  :-)


Clemens

-- 
Index: alsa-driver/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.18
retrieving revision 1.19
diff -u -r1.18 -r1.19
--- alsa-driver/usb/usx2y/usbusx2yaudio.c     3 Aug 2004 14:24:05 -0000       1.18
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c     5 Aug 2004 09:43:40 -0000       1.19
@@ -13,7 +13,7 @@

 #ifdef OLD_USB
 #define snd_usb_complete_callback(x) __old_ ## x
-static void i_usX2Y_urb_complete__old_(struct urb *urb);
+static void __old_i_usX2Y_urb_complete(struct urb *urb);
 #endif

 #include "../../alsa-kernel/usb/usx2y/usbusx2yaudio.c"
@@ -22,7 +22,7 @@
  * compatible layers
  */
 #ifdef OLD_USB
-static void i_usX2Y_urb_complete__old_(struct urb *urb)
+static void __old_i_usX2Y_urb_complete(struct urb *urb)
 {
 	i_usX2Y_urb_complete(urb, NULL);
 }




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
