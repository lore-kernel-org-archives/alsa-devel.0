From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [partialy fixed] Creamware Noah,
 snd-usb-audio capable?
Date: Thu, 26 Feb 2004 11:39:09 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402261136150.25586-100000@studcom.urz.uni-halle.de>
References: <1077558366.2725.6.camel@chief.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1077558366.2725.6.camel@chief.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hartmut Geissbauer <nwgbh@swissonline.ch>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hartmut Geissbauer wrote:
> Clemens Ladisch wrote:
> > Hartmut Geissbauer wrote:
> > > > > The only thing that's missing now are the two playback ports.
> > > >
> > > > Please show the output of "lsusb -v".
> >
> > The descriptors look OK.

But only at first sight.

Please try this patch.


HTH
Clemens

-- 

Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.81
diff -u -r1.81 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	24 Feb 2004 08:44:33 -0000	1.81
+++ alsa-kernel/usb/usbaudio.c	26 Feb 2004 10:21:55 -0000
@@ -2324,6 +2324,9 @@
 		}

 		csep = snd_usb_find_desc(alts->endpoint[0].extra, alts->endpoint[0].extralen, NULL, USB_DT_CS_ENDPOINT);
+		/* Creamware Noah has this descriptor after the 2nd endpoint */
+		if (!csep && altsd->bNumEndpoints >= 2)
+			csep = snd_usb_find_desc(alts->endpoint[1].extra, alts->endpoint[1].extralen, NULL, USB_DT_CS_ENDPOINT);
 		if (!csep || csep[0] < 7 || csep[2] != EP_GENERAL) {
 			snd_printk(KERN_ERR "%d:%u:%d : no or invalid class specific endpoint descriptor\n",
 				   dev->devnum, iface_no, altno);




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
