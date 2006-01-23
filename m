From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda/patch-realtek.c: minor bug?
Date: Tue, 24 Jan 2006 10:06:07 +1030 (CST)
Message-ID: <200601232336.k0NNa781012323@auster.physics.adelaide.edu.au>
References: <s5h4q3urkkw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q3urkkw.wl%tiwai@suse.de> from "Takashi Iwai" at Jan 23, 2006 05:10:55 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

> > While looking through patch-realtek.c for a completely unrelated reason
> > I noticed what I think is a small bug in the setup of the initialisation
> > verbs.  This is in 1.0.11rc1.  I noticed the following fragment at line
> > 2474 in the alc260_init_verbs definition:
> > 
> >         /* LINE-2 is used for line-out in rear */
> >         {0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> >         /* select line-out */
> >         {0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
> > 
> > Obviously the intention is to select the LOUT1 sum widget to be the source
> > for the LINE-2 pin widget.  However, the input selector for the LINE-2 pin
> > widget isn't actually a part of the pin widget - it is a separate widget
> > with its own NID (0x0e).  This is apparent when looking at the "get/set
> > connection select" sections of the ALC260 datasheet; NID 0x15 does not
> > accept this verb, and NID 0x0e is described as the "LINE2 Selector". It
> > would of course be helpful and clearer if the selector NIDs were mentioned
> > on the block diagram of the datasheet.
> > 
> > Anyway, as far as my understanding goes, to select LOUT1 as the source for
> > the LINE-2 pin widget, the correct AC_VERB_SET_CONNECT_SEL entry should be
> > 
> >         {0x0e, AC_VERB_SET_CONNECT_SEL, 0x00},
> > 
> > As it stands things still work: the LINE-2 widget ignores the verb and
> > the default setting for the 0x0e selector is 0x00.  However, perhaps 
> > the initialisation verb list in the driver should still be corrected
> > for completeness?
> 
> Yep, seems you're right.  Could you create a patch to the latest ALSA
> version?  It'd be greatly appreciated.

Here's a patch against 1.0.11rc2.  If this is insufficiently recent let me
know and I'll drag a CVS version down.

--- patch_realtek.c-orig	2005-12-23 22:57:52.000000000 +1030
+++ patch_realtek.c	2006-01-24 10:01:04.000000000 +1030
@@ -2475,7 +2475,7 @@
 	/* LINE-2 is used for line-out in rear */
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	/* select line-out */
-	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x0e, AC_VERB_SET_CONNECT_SEL, 0x00},
 	/* LINE-OUT pin */
 	{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	/* enable HP */

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
