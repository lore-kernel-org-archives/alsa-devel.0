From: ayman.bagabas@gmail.com
Subject: Re: [PATCH v7 2/3] x86: add support for Huawei WMI hotkeys.
Date: Tue, 27 Nov 2018 19:49:48 -0500
Message-ID: <789965489e73fd543f0552090063fdff69363497.camel@gmail.com>
References: <20181127025752.6459-1-ayman.bagabas@gmail.com>
         <20181127025752.6459-3-ayman.bagabas@gmail.com>
         <s5hwooyye9c.wl-tiwai@suse.de>
         <CAHp75Vd_k3Gu93hOUOLXD90O_eM3wy2K3QfMN0789PQEOixS=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd_k3Gu93hOUOLXD90O_eM3wy2K3QfMN0789PQEOixS=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-11-27 at 17:52 +0200, Andy Shevchenko wrote:
> On Tue, Nov 27, 2018 at 1:02 PM Takashi Iwai <tiwai@suse.de> wrote:
> > On Tue, 27 Nov 2018 03:57:48 +0100,
> > Ayman Bagabas wrote:
> > > +     handle = ACPI_HANDLE(&inputdev->dev);
> > > +     args[0].type = args[1].type = args[2].type =
> > > ACPI_TYPE_INTEGER;
> > > +     args[1].integer.value = 0x04;
> > > +
> > > +     if (acpi_has_method(handle, method =
> > > "\\_SB.PCI0.LPCB.EC0.SPIN")) {
> > 
> > This looks ugly...  And checkpatch also complains.
> 
> Good point.
> Actually another question is what handle do we get here? Can we check
> method name by relative path, i.e. "SPIN" / "WPIN" instead?

The handle is a NULL handle at "\". Should I use acpi_get_handle(NULL,
"\\_SB.PCI0.LPCB.EC0", &handle)?  EC0 is a acpi device HID:PNP0C09.

> 
> > > +             args[0].integer.value = 0;
> > > +             args[2].integer.value = on ? 1 : 0;
> > > +     } else if (acpi_has_method(handle, method =
> > > "\\_SB.PCI0.LPCB.EC0.WPIN")) {
> > > +             args[0].integer.value = 1;
> > > +             args[2].integer.value = on ? 0 : 1;
> > > +     } else {
> > > +             dev_err(&inputdev->dev, "Unable to find ACPI
> > > method\n");
> > > +             return -ENOSYS;
> > > +     }
> > 
> > Can these checks be done at initialization phase?  It doesn't seem
> > needed to be executed at each call.
> 
> Agree.
> 

Even if it was done in init phase, we still need to check what acpi
method should be used and based on that and micmute status we set the
arguments args[0] and args[2], args[1] is the pin value. We could check
these using event_guid, but that would assume the methods exist for
each guid.
For example, if event_guid == MBX_EVENT_GUID, then method SPIN should
be used.
