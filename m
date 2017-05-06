From: Viktor Radnai <viktor.radnai@gmail.com>
Subject: Re: Patch for Digidesign Mbox 2 (set sample rate)
Date: Sat, 6 May 2017 09:03:09 +0100
Message-ID: <CANx-tGi4TaZUzgnuLN_CGe9SFAnfok=z1Pd1x-RYAePWzzX6mQ@mail.gmail.com>
References: <CANx-tGgQ59u==FL-yAvR6QRZWZp7LNgU4Qaf6EQ45Ae8t-=VWw@mail.gmail.com>
 <s5h1ss6s0t9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id E251B26664F
 for <alsa-devel@alsa-project.org>; Sat,  6 May 2017 10:03:11 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id w10so1603127oif.1
 for <alsa-devel@alsa-project.org>; Sat, 06 May 2017 01:03:11 -0700 (PDT)
In-Reply-To: <s5h1ss6s0t9.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Damien Zammit <damien@zamaudio.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks, I have also reached out to Damien and he just got back to me.
Unfortunately he no longer has the device and is quite busy with other
things.

I am going to buy an Mbox 2 and test this myself. You can expect results
within two weeks, hopefully sooner.

In the meantime if anyone on the list has this device I would really
appreciate if you could test it.

Cheers,
Vik

On 3 May 2017 at 11:16, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 28 Apr 2017 22:36:09 +0200,
> Viktor Radnai wrote:
> >
> > Hi there,
> >
> > I have recently bought a Digidesign Mbox 2 Mini and found the lack of
> > support for 44100Hz sample rate in the driver limiting (the sample rate
> was
> > hard-set to 48000Hz by the original author even though the device
> supports
> > it, because he couldn't get the frame rate switching to work reliably).
> >
> > I had a go at hacking the driver and came up with the following patch
> which
> > appears to work on the MBox 2 Mini:
> > https://pastebin.com/kzzTDj9T
> >
> > I have built and tested this with Linux 4.8.15 without any realtime
> > patches. I am planning to pick up a "full size" Mbox 2 as well, in the
> > meantime if anyone on the list owns one I would appreciate if you could
> > test this and let me know the result. There is a possibility that it will
> > not work without the "magic" init sequence that I have removed because it
> > does not look like it's needed on the Mini. Although I would be a bit
> > surprised because the two devices are apparently identical to the point
> > that the Mini allows the use of it's physically nonexistent features.
> >
> > Once someone could confirm that this works, I would like to get it
> merged.
> > This is my first attempt at submitting a patch for any Linux device
> driver
> > so please let me know if I need to do anything else :)
>
> At least it'd be better to the original author in the loop.
> Damien, could you take a look if you still have the device?
>
>
> thanks,
>
> Takashi
>



-- 
My other sig is hilarious
