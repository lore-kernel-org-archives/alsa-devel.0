From: Daniel Griscom <griscom@suitable.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Tue, 27 Nov 2012 12:01:59 -0500
Message-ID: <p06240808ccdaa0a47bbb@[192.168.1.8]>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]>
 <50AE99E7.6080008@gmail.com> <p06240802ccd72a8f5c3e@[192.168.1.12]>
 <50B21255.8080202@gmail.com> <p06240812ccd8489d6378@[192.168.1.12]>
 <50B31800.2000000@gmail.com> <p06240804ccd98cef996c@[192.168.1.8]>
 <50B4A870.7040201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway13.websitewelcome.com (gateway13.websitewelcome.com
 [69.93.243.26]) by alsa0.perex.cz (Postfix) with ESMTP id 1035E260305
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 18:02:04 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway13.websitewelcome.com (Postfix) with ESMTP id 8D1F388FF695A
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 11:02:01 -0600 (CST)
In-Reply-To: <50B4A870.7040201@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

At 12:48 PM +0100 11/27/12, Daniel Mack wrote:
>As Clemens said, check the error fields in the isochronous frames when
>the urb is given back to the driver. For isochronous data, there's
>nothing the driver can do about failed transmissions, hence there's no
>code to handle such conditions. But it might help understand what's
>going on.

Well, I inserted code into retire_playback_urb() as Clemens suggested 
a few days ago:

>	int est_delay, i;
>
>	/* Check status of submitted urbs */
>	for (i = 0; i < urb->number_of_packets; i++) {
>		if (urb->iso_frame_desc[i].status) {
>			snd_printk(KERN_ERR "packet %d failed: %d\n", 
>i, urb->iso_frame_desc[i].status);
>		}
>	}
>
>	/* ignore the delay accounting when procssed=0 is given, i.e.

And, hit gold (lead?):

>[  432.591698] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>[  432.591702] ALSA sound/usb/pcm.c:1163 packet 1 failed: -18
>[  432.592684] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>[  432.592702] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>[  432.592706] ALSA sound/usb/pcm.c:1163 packet 1 failed: -18
>[  432.593684] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>[  432.593701] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>[  432.593705] ALSA sound/usb/pcm.c:1163 packet 1 failed: -18
>[  432.594680] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18

Error 18 is EXDEV: "Cross-device link". From an alsa-user post by 
Clemens a couple of years ago:

>This error code is documented in Documentation/usb/error-codes.txt:
>| -EXDEV                  ISO transfer only partially completed
>|                         look at individual frame status for details
>
>Well, this _is_ the individual frame status.
>
>Anyway, a look at the source code shows that several HCDs use this code
>for frames that were not handled by the controller, probably because
>they were submitted too late.
>
>Which controller are you using?
>
>Is there anything that could cause the controller to skip frames, such
>as high traffic on the (PCI) bus?

The answer to that final question: I don't know, but I've been 
concerned about PCI traffic for a while, and I don't know how I'll 
address it.


So, is it clear that this is a USB (software or hardware) problem? 
Should I move this discussion to the linux-usb list?


Thanks for all the help,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
