From: =?UTF-8?B?UmFwaGHDq2wgRGluZ8Op?= <raphael.dinge@ohmforce.com>
Subject: Re: Can't detect "XRUNs"
Date: Thu, 5 Jul 2018 12:59:55 +0200
Message-ID: <CAL-i0qHWbJmrk5vhqwimDPVT5toB6Cud5=PtsOwMCOL3Bi_n+Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 99EB2266E76
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 12:59:58 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id b15-v6so15988055oib.10
 for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2018 03:59:57 -0700 (PDT)
In-Reply-To: <s5hefgiuhdv.wl-tiwai@suse.de>
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

>> So I've run with the Audio USB card with your patch, and the behaviour
>> is the same as with HDMI, meaning that echo 1 > xrun_injection outputs
>> a xrun in /sys/kernel/tracing/trace, but apart from that, I never have
>> an xrun.
>
> It means that there is no XRUN error, handled neither in PCM core nor
> USB-audio driver.

It seems I have a total misconception of what is an XRUN then.

What I understand from your reply is that the program I launch doesn't
create XRUNs anyway (but my interpretation might be mistaken).

I changed the code of my test to the following in the write loop :

    snd_pcm_wait(pcm, 1000 /* milliseconds */);
    snd_pcm_sframes_t avail = snd_pcm_avail_update(pcm);
    if (avail < 0)
    {
      std::cout << "snd_pcm_avail_update failed\n";
      snd_pcm_recover (pcm, avail, 1);
   }

    snd_pcm_sframes_t nb_written = snd_pcm_writei(pcm, &buffer[0],
frames_per_buffer);
    if (nb_written < 0) {
      std::cout << "snd_pcm_writei failed\n";
      snd_pcm_recover(pcm, nb_written, 1 /* silent */);
      xrun_count++;
    }

    usleep (100000);  // 100 msec

So basically I introduced a large sleep to force an audio drop (my
buffers are 3 x 64).

But this doesn't trigger an XRUN anyway.

What is unclear for me is if the code above shall trigger an XRUN or not?

Thanks,

Raphael
