From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some information about UsbPre2 UAC2 support
Date: Mon, 28 Jan 2013 15:17:01 +0100
Message-ID: <5106885D.4050508@ladisch.de>
References: <1565248075.1826245.1359380896039.JavaMail.root@spooler2-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 3D2DA265220
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 15:17:04 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A460120CF9
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 09:17:03 -0500 (EST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id EFEBE8E08AE
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 09:17:02 -0500 (EST)
In-Reply-To: <1565248075.1826245.1359380896039.JavaMail.root@spooler2-g27.priv.proxad.net>
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
>>> I have to plug/unplug the sound card in order to have 2 configurations
>>> descriptor for this device.
>>
>> That's strange; the get_descriptor request should be the same.
>
> - I used a standard kernel (with 64 as get_descriptor buffer size)
> ...
> - I reboot with modified kernel (with 65 as get_descriptor buffer size)
> ...
> - Now the sound card provides a UAC1+UAC2 configuration

So the modified get_descriptor is stil necessary.

> - I performed a usb_reset()
> - I performed a get_descriptor using a usb_control() with 65 as buffer size

The USB core will already issue the get_descriptor request before
the driver gets informed that the device is there, so this won't
help.


Regards,
Clemens
