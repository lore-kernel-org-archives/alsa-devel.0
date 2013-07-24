From: Eldad Zack <eldad@fogrefinery.com>
Subject: usb-audio: capture/playback break (implicit feedback
	related?)
Date: Wed, 24 Jul 2013 21:26:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307242033330.2133@xoschi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
 [209.85.215.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B276265554
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 21:27:03 +0200 (CEST)
Received: by mail-ea0-f177.google.com with SMTP id f15so446811eak.8
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 12:27:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm still trying to figure out the issue with the capture and playback 
breaking with implicit feedback.

I've disabled setting the sync ep for my device and did the following:
 start capture
 start playback
 stop playback
Now, after a while, capture stops.

I sniffed the usb traffic, and saw this:
When I stop the traffic, the driver sets the alternate setting to 0 on 
the playback interface (2 for my device). So far so good.

The first iso inbound packet has data in it, but starting from the 
second packet, it's all zero (in length). After a while, the device
stops sending packets completely.
The driver still tries, and evetually sets the alternate setting to 0
on the capture interface (3 for my device).
Again, there is no implicit feedback involved here.

I also ruled out playback interface being put into altsetting 1 
(without us knowing it) when the capture was put into altsetting 1
by doing a GET_INTERFACE in set_format().

I am not sure if this an M-Audio issue, just my specific device 
(Fast Track C400) or maybe it appears in other devices. 

Anyone has an idea why this happens?
I'd appreciate if anyone can test this on other devices.

Clemens, since you recently added support for Roland devices that use
implicit feedback, would you please test it and see if you get the same
results, if you have time?

If it helps, I can send the capture.

Cheers,
Eldad

P.S. GET_INTERFACE adapted from drivers/usb/misc/usbtest.c:

static int snd_usb_get_interface(struct usb_device *dev, struct usb_interface *iface)
{
	int ret;
	char buf;

	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
			      USB_REQ_GET_INTERFACE, USB_DIR_IN|USB_RECIP_INTERFACE,
			      0, iface->altsetting[0].desc.bInterfaceNumber,
			      &buf, sizeof(buf), USB_CTRL_GET_TIMEOUT);

	if (ret == sizeof(buf))
		return buf;

	return -ERANGE;
}
