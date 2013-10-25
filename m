From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: include/uapi/firewire.h for other firewire drivers
Date: Fri, 25 Oct 2013 23:54:12 +0900
Message-ID: <526A8614.20908@sakamocchi.jp>
References: <526A6092.4030709@sakamocchi.jp> <526A6C50.2000901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 07FE02655CE
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 16:54:19 +0200 (CEST)
In-Reply-To: <526A6C50.2000901@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

Thanks for your quick reply.

> When a control panel wants to change several settings, it should not
> need to establish a CMP connection just to be able to prevent the driver
> from starting streaming at the same time.

There is no need to establish connection. The control panel just check 
the value of "peer-to-peer connection counter" field in iPCR/oPCR.

But anyway, it's better to give an easy way via the interface. I agree.

> When this is possible, the kernel FireWire framework should be extended
> to allow the driver to prevent FFADO from using the device.  However, it
> would be hard for the kernel to differentiate between FFADO and some
> control panel, so I guess FFADO should be changed to not attach to
> a device that already has a kernel driver.

I'm not a developer for Juju so cannot have any idea for kernel land at 
all. But for FFADO, I can put your idea as my future commitment.

> For Fireworks devices, applications will need to send EFC commands, but
> will not be able to allocate the same 0xecc080000000 address, so the
> driver needs a SEND_EFC ioctl.  (That's the same reason why snd-dice has
> DICE_NOTIFICATION.)

Now I understand the reason DICE_NOTIFICATION exists. Dice also have the 
similar issue as Fireworks has. For EFC, I'm willing to keep FFADO using 
"EFC over AVC" but I found this is not enough for some models with 
latest firmware.

Well, you said "The primary purpose is to support control panel/mixer". 
But this interface can also be good for prevention of conflict with 
FFADO driver. I wonder why you mention this first. Are there any thoughts?


Thanks

Takashi Sakamoto
