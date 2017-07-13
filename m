From: Viktor Radnai <viktor.radnai@gmail.com>
Subject: Re: Patch for Digidesign Mbox 2 (set sample rate)
Date: Fri, 14 Jul 2017 00:58:15 +0100
Message-ID: <CANx-tGhmxJ3b7B0ECF2fYoWh4sruvguQaG7exZF_zGV3WcR=tg@mail.gmail.com>
References: <CANx-tGgQ59u==FL-yAvR6QRZWZp7LNgU4Qaf6EQ45Ae8t-=VWw@mail.gmail.com>
 <s5h1ss6s0t9.wl-tiwai@suse.de>
 <8ff1733e-3ff5-0ba4-ebfa-866797ca35bf@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 22F642672A8
 for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2017 01:58:17 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id l130so8531488oib.2
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 16:58:17 -0700 (PDT)
In-Reply-To: <8ff1733e-3ff5-0ba4-ebfa-866797ca35bf@zamaudio.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien@zamaudio.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Damien,

Thanks for the test report.

I have now successfully recorded with both the Mbox 2 and Mbox 2 Mini,
however I had one occurrence where the Mbox 2 would not initialize even
when I repeatedly unplugged and plugged it back. I have added your "magic"
boot sequence back and since then I haven't seen this problem. I have been
using that version ever since, so I cannot tell if simply unloading and
reloading the driver would have fixed it. In any case I will re-submit the
patch with the magic boot sequence for inclusion.

Cheers,
Vik

On 9 July 2017 at 03:14, Damien Zammit <damien@zamaudio.com> wrote:

> Hi all,
>
> I have tested Viktor's patch on "Mbox 2" and it works very well.
> Looks like my 'magic' boot sequence was not needed.
> Rate switching works between 44.1 and 48k.
> Good job.
>
> Damien
>
> On 03/05/17 20:16, Takashi Iwai wrote:
> > On Fri, 28 Apr 2017 22:36:09 +0200,
> > Viktor Radnai wrote:
> >>
> >> Hi there,
> >>
> >> I have recently bought a Digidesign Mbox 2 Mini and found the lack of
> >> support for 44100Hz sample rate in the driver limiting (the sample rate
> was
> >> hard-set to 48000Hz by the original author even though the device
> supports
> >> it, because he couldn't get the frame rate switching to work reliably).
> >>
> >> I had a go at hacking the driver and came up with the following patch
> which
> >> appears to work on the MBox 2 Mini:
> >> https://pastebin.com/kzzTDj9T
> >>
> >> I have built and tested this with Linux 4.8.15 without any realtime
> >> patches. I am planning to pick up a "full size" Mbox 2 as well, in the
> >> meantime if anyone on the list owns one I would appreciate if you could
> >> test this and let me know the result. There is a possibility that it
> will
> >> not work without the "magic" init sequence that I have removed because
> it
> >> does not look like it's needed on the Mini. Although I would be a bit
> >> surprised because the two devices are apparently identical to the point
> >> that the Mini allows the use of it's physically nonexistent features.
> >>
> >> Once someone could confirm that this works, I would like to get it
> merged.
> >> This is my first attempt at submitting a patch for any Linux device
> driver
> >> so please let me know if I need to do anything else :)
> >
> > At least it'd be better to the original author in the loop.
> > Damien, could you take a look if you still have the device?
> >
> >
> > thanks,
> >
> > Takashi
> >
>



-- 
My other sig is hilarious
