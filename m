From: Daniel Griscom <griscom@suitable.com>
Subject: Re: USB hardware that supports implicit feedback?
Date: Thu, 15 Nov 2012 21:41:35 -0500
Message-ID: <p06240806cccb568404f5@[192.168.1.12]>
References: <p06240805cccafc72f23b@[192.168.1.36]>
 <alpine.LNX.2.00.1211152158440.2632@xoschi>
 <p06240809cccb09820207@[192.168.1.8]>
 <alpine.LNX.2.00.1211160159040.1157@xoschi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway02.websitewelcome.com (gateway02.websitewelcome.com
 [67.18.36.20]) by alsa0.perex.cz (Postfix) with ESMTP id 5D541265D4E
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 03:41:39 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway02.websitewelcome.com (Postfix) with ESMTP id D67ED74A8741F
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 20:41:37 -0600 (CST)
In-Reply-To: <alpine.LNX.2.00.1211160159040.1157@xoschi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

At 3:08 AM +0100 11/16/12, Eldad Zack wrote:
>I think that Autodiscovery should fail with this amtel device because
>the number of endpoints is 1 for the playback ep (this is what I encountered
>with the C400).
>Maybe a info message could be added in case the attributes do say
>implicit feedback, but bNumEndpoints < 2?

Good point. I'll look into changing that.

At 3:10 AM +0100 11/16/12, Eldad Zack wrote:
>Hi Daniel,
>On Thu, 15 Nov 2012, Daniel Griscom wrote:
>>  The audio output stream (from the computer to my device) runs at a 
>>few frames
>>  per second higher or lower rate than that of the input stream 
>>(from my device
>>  to the computer). The actual difference seems to be stable on a specific
>>  machine, but varies greatly between machines (I've seen 
>>differences from +7fps
>>  to -2fps; I presume this is due to differences in CPU clock frequencies).
>
>Looking at the lsusb output, I assume that the sink/source coupling
>doesn't work, because it's not in an interface group.

And, good point number 2.

>  > >I'm not an ALSA dev, but I recently posted a series of patches for the
>>  >M-Audio Fast Track C400, which uses the implicit feedback code that was
>>  >already in the tree for other devices.
>>  So, this device uses implicit feedback to tell ALSA to send output 
>>data at the
>>  same rate as its input data? Very cool; I've ordered one to test.
>
>Yes, and it seems to work very good with my hardware. But I'm not 
>actually sure
>I want to recommend a device with broken descriptors...
>
>Try this, it *MIGHT* work (applies against mainline 3.7-rc5) -
>completely untested, btw.
>
>Cheers,
>Eldad
>
>diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
>index 5c12a3f..fd766a3 100644
>--- a/sound/usb/pcm.c
>+++ b/sound/usb/pcm.c
>@@ -372,6 +372,19 @@ static int set_format(struct snd_usb_substream 
>*subs, struct audioformat *fmt)
>  			alts = &iface->altsetting[1];
>  			goto add_sync_ep;
>  		}
>+		break;
>+	case USB_ID(0x03eb, 0x2311): /* AMTEL === UNTESTED === */
>+		if (is_playback) {
>+			implicit_fb = 1;
>+			ep = 0x82;
>+			iface = usb_ifnum_to_if(dev, 2);
>+
>+			if (!iface || iface->num_altsetting == 0)
>+				return -EINVAL;
>+
>+			alts = &iface->altsetting[1];
>+			goto add_sync_ep;
>+		}
>  	}
>
>  	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||

Very, ultra, mega-cool. Even if it doesn't work as-is, this will give 
me big hints on how to get it done.


Thanks for all the help,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
