From: =?UTF-8?B?UmFwaGHDq2wgRGluZ8Op?= <raphael.dinge@ohmforce.com>
Subject: Re: Can't detect "XRUNs"
Date: Thu, 5 Jul 2018 11:10:28 +0200
Message-ID: <CAL-i0qF=V5cgTEGa8E-e_Ww8zCWkCGN_5qwxvCrwavGQ+AP1bQ@mail.gmail.com>
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
 <CAL-i0qGf1ASYDc0BT7X=O6B94xzKusnpLWVwvH91C+h=zM2bnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 088BE266E76
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 11:10:30 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so15468746oiw.8
 for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2018 02:10:30 -0700 (PDT)
In-Reply-To: <CAL-i0qGf1ASYDc0BT7X=O6B94xzKusnpLWVwvH91C+h=zM2bnA@mail.gmail.com>
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

Hi Takashi,


>> Which hardware?  If it's Intel LPE HDMI thing, -EPIPE report doesn't
>> mean always an XRUN, but may imply just an unconnected device.
>
> I've tested your patch on Audio over HDMI. Not sure if LPE thing, but
> I can look into the details.

My kernel is configured with :
# CONFIG_HDMI_LPE_AUDIO is not set

So I guess it's fine to assume it's not the LPE HDMI thing.
Additionally, description in /proc/asound/card0 never mention that.

> However the hardware i'm interested in is an Audio USB device, this
> model to be more precise :
> https://www.minidsp.com/products/usb-audio-interface/usbstreamer
> [...]
> Since I applied your patch, I only tried with HDMI, but I could give a
> shot to the Audio USB Device just to make sure. What do you think?

So I've run with the Audio USB card with your patch, and the behaviour
is the same as with HDMI, meaning that echo 1 > xrun_injection outputs
a xrun in /sys/kernel/tracing/trace, but apart from that, I never have
an xrun.

Thanks,

Raphael
