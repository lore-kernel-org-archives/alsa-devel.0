From: Johannes Erdfelt <johannes@erdfelt.com>
Subject: Re: uhci.c Fix for an UHCI error -EILSEQ on a VIA Controller during BULK IN transfer
Date: Sat, 23 Aug 2003 00:41:34 -0400
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <20030823004134.E30680@sventech.com>
References: <200308221450.50730.annabellesgarden@yahoo.de> <Pine.LNX.4.44L0.0308222244420.11957-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0308222244420.11957-100000@netrider.rowland.org>; from stern@rowland.harvard.edu on Fri, Aug 22, 2003 at 10:59:10PM -0400
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, "'us428@drehmoment.org'" <us428@drehmoment.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 22, 2003, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 22 Aug 2003, Karsten Wiese wrote:
> 
> > hi Maintainers,
> > 
> > I'm developing a driver for the tascam us428 audio/midi controller. it works 
> > on intel USB BX440 Host controller, but has problems with one VIA USB 
> > Controller (others unknown).
> > kernel is 2.4.21. module is uhci. (usb-uhci behaves similarly.)
> > 
> > the error shows up like this:
> > uhci.c: uhci_result_interrupt/bulk() failed with status 440000
> > [cf7a50c0] link (0f7a5092) element (02ecf1e0)
> >   0: [c2ecf1e0] link (00000001) e0 IOC Stalled CRC/Timeo Length=7ff MaxLen=3f 
> > DT0 EndPt=6 Dev=2, PID=69(IN) (buf=0e01cc54)
> > 
> > the FIX is to initialise status in uhci_submit_bulk() like this:
> > /* 3 errors if there is a timeout else 0; 
> >    UHCI Spec says: 0 == unlimited errors
> >    VIA-chip 1106:3038 needs 0 for urbs that should not timeout!
> >    */
> > status = TD_CTRL_ACTIVE | ((urb->timeout ? 3 : 0) << TD_CTRL_C_ERR_SHIFT);
> > 
> > the urb in question should stay in the queue until the extern midi device 
> > submits an event.
> > It seams intels HC ignores the spec, while Via's obeys here?
> > 
> > Please apply the fix in uhci.c, usb-uhci.c and for 2.6!
> 
> This proposed change is incorrect.
> 
> In general urb->timeout is almost never set.  It's only supported by the
> UHCI drivers, so device drivers can't rely on it.  Nevertheless,
> practically every TD needs to have the 3-error limit, not unlimited
> errors.
> 
> A properly working HC will not decrease the error count if the device 
> replies correctly (with a NAK if no data is available).  Only if the 
> device fails to reply at all, or sends an illegal reply, will the error 
> count be decremented.
> 
> The error message shown above has CRC/Timeout set for an IN packet.  This 
> means that the HC either thinks the device didn't reply at all -- not even 
> with a NAK -- or sent data with an invalid checksum.  If that's what 
> actually happened then the HC is right to call it an error.  If that's not 
> what happened then the VIA UHCI chip has a serious flaw, one that the 
> driver can't compensate for.
> 
> Note that urb->timeout means something completely different from the UHCI
> Timeout error.  urb->timeout puts a limit on long the device may continue
> to NAK -- typically on the order of seconds.  The UHCI timeout is a limit
> on how long the device can delay before returning a handshake token -- its
> value is given in the USB specification, on the order of a few
> microseconds.

I agree with your analysis.

What I am curious about is why this does fix the problem for Karsten? He
only has problems with VIA and not Intel.

It could be some sort of weird device compability issue with VIA
chipsets, but I can't imagine what the problem really could be.

I hate that UHCI doesn't differentiate between a CRC error and a
timeout. I'd be curious to know what the actual problem is to see if we
could develop a workaround.

Karsten, you wouldn't happen to have a USB bus analyzer, would you?

JE



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
