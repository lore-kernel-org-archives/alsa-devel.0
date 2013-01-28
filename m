From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some information about UsbPre2 UAC2 support
Date: Mon, 28 Jan 2013 14:10:06 +0100
Message-ID: <510678AE.7000204@ladisch.de>
References: <859779859.1409131.1359376918692.JavaMail.root@spooler2-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id BAD73265268
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 14:10:08 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D190F20814
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 08:10:07 -0500 (EST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6F7AF8E08B7
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 08:10:07 -0500 (EST)
In-Reply-To: <859779859.1409131.1359376918692.JavaMail.root@spooler2-g27.priv.proxad.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

shal@free.fr wrote:
>>
>> shal@free.fr wrote:
>>> For some compatibility raison, Sound device developer want only
>>> send a UAC1 configuration when the Operating system is Windows.
>>> The used method is based on the length of the  setup packet during
>>> the device get_descriptor function.
>>> If the length is 64, the OS is considered as Windows.
>>> Linux have choosen also this value.
>>
>> Because there are buggy devices that haven been tested only with Windows
>> and will blow up if other values are chosen.
>>
>> I guess somebody has to add a quirk for this device to the driver.
>
> It is more complicated: Sound Devices don't want the same behavior between Mac OSX and Windows.
> Some Windows does not support UAC2 by default (without ASIO driver).
>
> The Sound Devices guy says :
> "When the computer issues a STANDARD_REQUEST_GET_DESCRIPTOR we check the setupPacket.wLength field. If it is 64 then we limit the number of configurations to 1. Windows will only load the composite class driver if the configuration number is 1. (refer to
>  http://minilien.fr/a0m7pj - note the line which says 'The device must have a single configuration'. )"
>
> It's seems that the behavior of the sound card depends to the first get_configuration() and keep it until powered.
> I discovers that when I performs a reboot in order to test my modified kernel : The sound card remains in UAC1.


> I have to plug/unplug the sound card in order to have 2 configurations
> descriptor for this device.

That's strange; the get_descriptor request should be the same.

> Can we have the vendor/product ID before the first get_configuration() ?

No.

> A usb_reset() can be helpful, perhaps?

Perhaps.

> Perhaps, we can do the same thing that the ASIO driver.

That's what I meant with the quirk.  (The first configuration does have
endpoints for high sample rates, but these aren't marked as being
compatible with either UAC 1 or 2.)


Regards,
Clemens
