From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB audio kernel panic
Date: Fri, 21 May 2004 09:41:57 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405210935120.1699-100000@studcom.urz.uni-halle.de>
References: <40A2CAAD.7050603@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40A2CAAD.7050603@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> >>Using the latest usb-audio code from cvs I get a kernel panic when
> >>loading the drivers.
> >>
> >>I'm running kernel-2.2.21 with gcc-2.95.4
>
> Unable to handle kernel paging request at virtual address 28302e63
> EIP:    0010:[<e08eafc0>]    Tainted: PF
>
> e08e7060 __insmod_snd-usb-audio_S.text_L29104   [snd-usb-audio]
> e08eb02c snd_hack_usb_set_interface     [snd-usb-audio]

The 2.6.5-rc2 kernel introduced some API changes to work around
devices with broken descriptors.  The resulting changes in the ALSA
code broke ALSA's workaround for the same problem.

The fix below is now in CVS.


HTH
Clemens
-- 

Index: usbaudio.inc1
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbaudio.inc1,v
retrieving revision 1.5
diff -u -r1.5 usbaudio.inc1
--- alsa-driver/usb/usbaudio.inc1	23 Mar 2004 12:48:18 -0000	1.5
+++ alsa-driver/usb/usbaudio.inc1	21 May 2004 07:34:10 -0000
@@ -98,7 +98,7 @@
 				   interface, NULL, 0, HZ * 5)) < 0)
 		return ret;

-	iface->act_altsetting = alternate;
+	iface->act_altsetting = i;
 	for (i = 0; i < iface_as->bNumEndpoints; i++) {
 		u8 ep = iface_as->endpoint[i].bEndpointAddress;
 		usb_settoggle(dev, ep&USB_ENDPOINT_NUMBER_MASK, usb_endpoint_out(ep), 0);




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
