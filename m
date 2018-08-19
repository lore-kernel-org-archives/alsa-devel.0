From: Joseph Spencer <joespenceris@gmail.com>
Subject: Re: snd_usb_usx2y holding onto a lock?
Date: Sun, 19 Aug 2018 13:27:19 -0700
Message-ID: <CAMvaF72rLr85Tui_DAbemRB2LhV+5=h420f=OVLYX5L9bFQ9BQ@mail.gmail.com>
References: <CAMvaF70On5Jz3wMDUj1QU5hD+L=JTxGGuKtg9ZzL2hz=_XoU4g@mail.gmail.com>
 <s5hh8jqixrw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 73D1726766E
 for <alsa-devel@alsa-project.org>; Sun, 19 Aug 2018 22:27:31 +0200 (CEST)
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so2350458lff.12
 for <alsa-devel@alsa-project.org>; Sun, 19 Aug 2018 13:27:31 -0700 (PDT)
In-Reply-To: <s5hh8jqixrw.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the reply!  I've been pouring over the source.  Looks like it
really hasn't been actively maintained since around 2005, mostly minor
refactoring since then.

If I have questions that the docs available online can't answer, would this
be a good place to ask?

I appreciate all the work you guys do!
Joe Spencer
602.777.2307


On Sun, Aug 19, 2018 at 1:08 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 17 Aug 2018 09:23:35 +0200,
> Joseph Spencer wrote:
> >
> > When plugging an audio interface in with nomodeset I see the following in
> > the logs:
> >
> > Aug 08 23:19:23 localhost.localdomain kernel: INFO: task pulseaudio:1750
> > blocked for more than 120 seconds.
> > Aug 08 23:19:23 localhost.localdomain kernel:       Tainted: G
> >  OE     4.17.11-200.fc28.x86_64+debug #1
> > Aug 08 23:19:23 localhost.localdomain kernel: "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > Aug 08 23:19:23 localhost.localdomain kernel: pulseaudio      D12408
> 1750
> >  1268 0x00000000
> > Aug 08 23:19:23 localhost.localdomain kernel: Call Trace:
> >
> > Aug 08 23:19:23 localhost.localdomain kernel:  ? __schedule+0x2ba/0xaf0
> >
> > Aug 08 23:19:23 localhost.localdomain kernel:  ?
> > prepare_to_wait_event+0xd2/0x180
> > Aug 08 23:19:23 localhost.localdomain kernel:  schedule+0x2f/0x90
> >
> > Aug 08 23:19:23 localhost.localdomain kernel:
> usX2Y_urbs_start+0x208/0x470
> > [snd_usb_usx2y]
> > Aug 08 23:19:23 localhost.localdomain kernel:  ? finish_wait+0x80/0x80
> (snip)
>
> So this is waiting for the event to be triggered by the urb
> completion, but it didn't happen by some reason on your machine.
>
> > The audio interface doesn't work and without nomodeset X freezes.
> >
> > Any help pointing me in the right direction would be greatly appreciated.
> > It looks like an issue with the snd_usb_usx2y driver to me, but I'm not
> > sure.
>
> Unfortunately the driver is very special and does somewhat magical way
> only the author knows of well.
> You need to follow the code, and at least check whether the urb
> submission at the playback start worked properly as expected.
>
>
> Takashi
>
