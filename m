From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date: Thu, 22 Nov 2018 13:36:43 +0200
Message-ID: <CAHp75VddanEB-7qQutSWkbSZW4srRzGXkigCMxEP7zJ=KC6iKw@mail.gmail.com>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
 <20181108171701.4444-4-ayman.bagabas@gmail.com> <20181119235713.GB7367@amd>
 <s5hr2fgfcrm.wl-tiwai@suse.de> <20181120091039.GA16916@amd>
 <s5hbm6kf6gi.wl-tiwai@suse.de> <20181120093610.GF16916@amd>
 <s5h4lccf58f.wl-tiwai@suse.de> <20181120115159.GG16916@amd> <s5hzhu4c569.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzhu4c569.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, Ayman Bagabas <ayman.bagabas@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2018 at 2:19 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 20 Nov 2018 12:51:59 +0100,
> Pavel Machek wrote:
> >
> > Hi!
> >
> > > > You have general-purpose LED, yet you are treating it as "something
> > > > special". That means ugly code (quoted above) and lack of flexibility.
> > > >
> > > > For example, if my notebook lacks HDD LED, I can use scrollock LED for
> > > > that instead. Or, in reverse way, maybe "mic mute" LED is not useful
> > > > for me, and I'd like to use it for notifications instead.
> > >
> > > I'm not against adding the LEDs device implementation for any exotic
> > > usage.
> > >
> > > But for the audio mute LED features, you'll need really lots of other
> > > works if it were implemented via leds device.  That's the hardest
> > > part, and a few lines of hooks solves it easily in the kernel side.
> > > That's all about it.
> > >
> > > If you are ready for submitting the real solutions in user-space side
> > > (patching PulseAudio and whatever all existing sound daemons, and
> > > creating yet another daemon for non-PA systems (another footprint,
> > > lovely), and so on), we can happily delete such in-kernel hooks :)
> >
> > I'm not saying we should move it to the userspace.
> >
> > I'm saying this should be "normal" led. drivers/leds/led-huawei-acpi.c,
> > or something. Perhaps this acpi stuff is so similar you don't really
> > need .c code.
> >
> > And then there should be a "mic muted" trigger. Similar to
> > drivers/leds/trigger/ledtrig-disk.c.
>
> And who will trigger this, e.g. when the mixer is muted?

Is this settled? I'm encouraged to promote this series to our for-next branch.

-- 
With Best Regards,
Andy Shevchenko
