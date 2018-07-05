From: =?UTF-8?B?UmFwaGHDq2wgRGluZ8Op?= <raphael.dinge@ohmforce.com>
Subject: Re: Can't detect "XRUNs"
Date: Thu, 5 Jul 2018 14:34:02 +0200
Message-ID: <CAL-i0qESvno6PepeEUT1hp6os9_tmE-sEMnLFcTFnKkPciVB5g@mail.gmail.com>
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
 <CAL-i0qF=V5cgTEGa8E-e_Ww8zCWkCGN_5qwxvCrwavGQ+AP1bQ@mail.gmail.com>
 <s5hefgiuhdv.wl-tiwai@suse.de>
 <CAL-i0qHWbJmrk5vhqwimDPVT5toB6Cud5=PtsOwMCOL3Bi_n+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 289AB266E76
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 14:34:04 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id s198-v6so16477872oih.11
 for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2018 05:34:04 -0700 (PDT)
In-Reply-To: <CAL-i0qHWbJmrk5vhqwimDPVT5toB6Cud5=PtsOwMCOL3Bi_n+Q@mail.gmail.com>
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

Hi,

Looking more in depth into the code I understood my problem was
between the chair and the computer screen *sigh*.

So the code was calling snd_pcm_sw_params_set_stop_threshold which
apart from stopping the stream on underruns apparently "eats" the xrun
from the kernel tracing perspective.

If I comment out this portion of code, I get the EPIPE in
snd_pcm_avail_update as well as the xrun events in
/sys/kernel/tracing/trace.

Thanks a million again to put me on the right track. I've learnt a lot
from this exchange.

Have a good day,

Raphael
