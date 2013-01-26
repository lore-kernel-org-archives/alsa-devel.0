From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some information about UsbPre2 UAC2 support
Date: Sat, 26 Jan 2013 21:29:10 +0100
Message-ID: <51043C96.40508@ladisch.de>
References: <199306935.463022264.1359222606997.JavaMail.root@spooler2-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 040F6262600
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 21:30:03 +0100 (CET)
In-Reply-To: <199306935.463022264.1359222606997.JavaMail.root@spooler2-g27.priv.proxad.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: shal@free.fr
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

shal@free.fr wrote:
> For some compatibility raison, Sound device developer want only send a UAC1 configuration when the Operating system is Windows.
> The used method is based on the length of the  setup packet during the device get_descriptor function.
> If the length is 64, the OS is considered as Windows.
> Linux have choosen also this value.

Because there are buggy devices that haven been tested only with Windows
and will blow up if other values are chosen.

I guess somebody has to add a quirk for this device to the driver.

> Now, the USB device descriptor has two configuration descriptors :the first is a UAC1 and the second is a UAC2.
>
> As UAC1 is a valid configuration descriptor, the usb stack choose this configuration.
>
> I have patched the usb_choose_configuration() function in file driver/usb/core/generic.c for overwrite the value with the good one.

This can be changed later in the driver with usb_driver_set_configuration().


Regards,
Clemens
