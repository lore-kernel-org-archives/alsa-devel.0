From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [linux-usb-devel] uhci.c Fix for an UHCI error -EILSEQ on a VIA Controller during BULK IN transfer
Date: Sat, 23 Aug 2003 19:05:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308231905.12801.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johannes Erdfelt <johannes@erdfelt.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: alsa-devel@lists.sourceforge.net, "'us428@drehmoment.org'" <us428@drehmoment.org>alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>On Sat, 23 Aug 2003, Wolfgang Mes wrote:
>
>> On Fri, 22 Aug 2003, Karsten Wiese wrote:
>> 
>> > the FIX is to initialise status in uhci_submit_bulk() like this:
>> > /* 3 errors if there is a timeout else 0;
>> >    UHCI Spec says: 0 == unlimited errors
>> >    VIA-chip 1106:3038 needs 0 for urbs that should not timeout!
>> >    */
>> > status = TD_CTRL_ACTIVE | ((urb->timeout ? 3 : 0) <<
>> > TD_CTRL_C_ERR_SHIFT);
>> 
>> I have seen these sort of errors when there was an EMI spike. I got this 
with 
>> a device which is self powered and has a connection to the ground of the 
>> power supply cable. The spike was induced in the ground loop of PC, device 
>> and USB cable. This spike maybe last 10 ms. If an USB transfer gets no NAK 
>> from the device due to the spike, the transfer is retried and the error 
count 
>> decremented. My VIA controller does all 3 retries very fast, back-to-back.
>> So the third try timed out before the spike was gone. 
>
>I was just going to write a similar reply. IMHO this is an issue which is 
>generally underestimated. Any long-living transfer might run into this 
>problem. F.e. if there is an INT IN scheduled to poll some input activity, 
>this transfer might be active for seconds, minutes or even longer. All it 
>needs is three spikes on the wire to make the urb failing with EILSEQ.
>
>Ok, seems VIA does the retries fast enough so a single spike could be 
>sufficient. This explains why this is sometimes seen with VIA but not 
>Intel. However the issue is still there anyway. It's just depending on how 
>noisy the environment is.
>
>IMHO it's the drivers job to be prepared to get these errors and recover 
>appropriately. IIRC there is also an Application Note on Cypress' website 
>describing this issue and how driver should be prepared to handle this, 
>particularly for long-living transfers.
>
>> I think it would be wise to add another level of retries on top of the 
>> controller timeout, in the HCD. If you have no HCD support for this sort of 
>> failure, you can try to use a kernel timer and retry the URB from within 
your 
>> driver. (Note that for this to work, the device must be able to resend the
>> information from the last transfer).
>
>Not sure about this. This might get pretty messy with queued requests. 
>IMHO when the urb gets stopped due to error retry count reached, the HCD
>should just stop further urbs queued for this endpoint and let the driver 
>recover.
>
You are right:
The USB device is self powered. Measuring the passed usb-frames versus urb 
errors,
I found about 80ms from one C_ERR decrease to the next. If I simply insert the 
power adapter the other way round, this rate drops to 1ms and lower.
So it is my noisy hardware letting those urbs fail.
A sensible patch would enable HCDs to log a warning if the amount of C_ERR 
decreases per time surpassed a certain value. If C_ERR decreases stayed below 
that certain value, the failing urb might also be resubmitted without 
bothering the higherlevel-driver.

Thanks!
Karsten



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
