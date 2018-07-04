From: =?UTF-8?B?UmFwaGHDq2wgRGluZ8Op?= <raphael.dinge@ohmforce.com>
Subject: Re: Can't detect "XRUNs"
Date: Wed, 4 Jul 2018 18:06:57 +0200
Message-ID: <CAL-i0qGf1ASYDc0BT7X=O6B94xzKusnpLWVwvH91C+h=zM2bnA@mail.gmail.com>
References: <CAL-i0qF80jHGH_7Cwxik3HO86Ng3PZH18fxf0vABk4cMUY5OdQ@mail.gmail.com>
 <s5hwoubwar6.wl-tiwai@suse.de>
 <CAL-i0qFbukDczTtgnkbfpE=Giu6piv6dvcMi-D=QtnYy69Q5FQ@mail.gmail.com>
 <CAL-i0qERNjW-0kUE5xj8u2roCU0p0wVmscKiqUV7pxiFtO84mQ@mail.gmail.com>
 <s5hk1qbw37u.wl-tiwai@suse.de>
 <CAL-i0qHv-W0Qva1QW6FUUj04P=F41_Q4X1TWaYoZXCjHB7bXoA@mail.gmail.com>
 <s5hd0w3w132.wl-tiwai@suse.de>
 <CAL-i0qGLuuOCtSCOwUxFnHfPD9ub5Zvk-0L54+6SxHkZhAFP0w@mail.gmail.com>
 <CAL-i0qEuJda-YRFUn6EMg2eiBMRq4+nnju4r=T1dnUEZBuFA8Q@mail.gmail.com>
 <s5hy3eruj6l.wl-tiwai@suse.de>
 <CAL-i0qGoyDFOT10zX=bctO5_yty0C=W76XXikq-wuAfWHtBvcQ@mail.gmail.com>
 <CAL-i0qGsRX3ToRgox3KBExqF3e351r-ZH5auRPpx0xFdfX3FJg@mail.gmail.com>
 <s5hsh4zuh8d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id C5E622670D7
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 18:06:59 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id k81-v6so11606474oib.4
 for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2018 09:06:59 -0700 (PDT)
In-Reply-To: <s5hsh4zuh8d.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> But no other events are generated.
>
> It means that it's no system-wide XRUN handling.

Not sure what this means. Maybe something is misconfigured on my side?

> Which hardware?  If it's Intel LPE HDMI thing, -EPIPE report doesn't
> mean always an XRUN, but may imply just an unconnected device.

I've tested your patch on Audio over HDMI. Not sure if LPE thing, but
I can look into the details.

However the hardware i'm interested in is an Audio USB device, this
model to be more precise :
https://www.minidsp.com/products/usb-audio-interface/usbstreamer

For now I can't make sure that all the audio is correct on this latter
device, because I need to setup 4 I2S converters, I can only use my
oscilloscope for now. That's why I'm sometimes using HDMI, to check
the sound as I make changes.

Since I applied your patch, I only tried with HDMI, but I could give a
shot to the Audio USB Device just to make sure. What do you think?

Thanks,

Raphael
