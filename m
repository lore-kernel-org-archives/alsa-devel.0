From: =?UTF-8?B?UmFwaGHDq2wgRGluZ8Op?= <raphael.dinge@ohmforce.com>
Subject: Re: Can't detect "XRUNs"
Date: Wed, 4 Jul 2018 17:11:17 +0200
Message-ID: <CAL-i0qEuJda-YRFUn6EMg2eiBMRq4+nnju4r=T1dnUEZBuFA8Q@mail.gmail.com>
References: <CAL-i0qF80jHGH_7Cwxik3HO86Ng3PZH18fxf0vABk4cMUY5OdQ@mail.gmail.com>
 <s5hwoubwar6.wl-tiwai@suse.de>
 <CAL-i0qFbukDczTtgnkbfpE=Giu6piv6dvcMi-D=QtnYy69Q5FQ@mail.gmail.com>
 <CAL-i0qERNjW-0kUE5xj8u2roCU0p0wVmscKiqUV7pxiFtO84mQ@mail.gmail.com>
 <s5hk1qbw37u.wl-tiwai@suse.de>
 <CAL-i0qHv-W0Qva1QW6FUUj04P=F41_Q4X1TWaYoZXCjHB7bXoA@mail.gmail.com>
 <s5hd0w3w132.wl-tiwai@suse.de>
 <CAL-i0qGLuuOCtSCOwUxFnHfPD9ub5Zvk-0L54+6SxHkZhAFP0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FFFC2670D7
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 17:11:18 +0200 (CEST)
Received: by mail-oi0-f47.google.com with SMTP id n84-v6so11305538oib.9
 for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2018 08:11:18 -0700 (PDT)
In-Reply-To: <CAL-i0qGLuuOCtSCOwUxFnHfPD9ub5Zvk-0L54+6SxHkZhAFP0w@mail.gmail.com>
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

> I'm going back to the program to see if there is anything suspect.

So I got back to the program and put a bit more logging. I have new
results, but they are even more confusing.

Here is the part that writes to the buffer :

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

Not sure if this is the proper way, didn't write it myself, but looks
more or less legit.

When I launch the program, nothing is output to the console.

But! If I echo 1 > xrun_injection, then I have "snd_pcm_avail_update
failed" systematically.

However at the same time, no events are traces in
/sys/kernel/debug/tracing/trace

Then the program itself is always dropping audio. In /proc/kmsg I see
messages about lost interrupts and callback suppression.

Does it ring a bell?

I'm using kernel 4.17.2
http://kernel.org/pub/linux/kernel/v4.x/linux-4.17.2.tar.xz

With glibc 2.27
http://ftp.gnu.org/gnu/glibc/glibc-2.27.tar.bz2

With Alsa 1.1.6
http://www.mirrorservice.org/sites/ftp.alsa-project.org/pub/lib/alsa-lib-1.1.6.tar.bz2

Thanks,

Raphael
