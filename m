From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 2/3] x86: add support for Huawei WMI hotkeys.
Date: Tue, 27 Nov 2018 17:52:02 +0200
Message-ID: <CAHp75Vd_k3Gu93hOUOLXD90O_eM3wy2K3QfMN0789PQEOixS=w@mail.gmail.com>
References: <20181127025752.6459-1-ayman.bagabas@gmail.com>
 <20181127025752.6459-3-ayman.bagabas@gmail.com> <s5hwooyye9c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwooyye9c.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ayman Bagabas <ayman.bagabas@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 27, 2018 at 1:02 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 27 Nov 2018 03:57:48 +0100,
> Ayman Bagabas wrote:

> > +     handle = ACPI_HANDLE(&inputdev->dev);
> > +     args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
> > +     args[1].integer.value = 0x04;
> > +
> > +     if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.SPIN")) {
>
> This looks ugly...  And checkpatch also complains.

Good point.
Actually another question is what handle do we get here? Can we check
method name by relative path, i.e. "SPIN" / "WPIN" instead?

> > +             args[0].integer.value = 0;
> > +             args[2].integer.value = on ? 1 : 0;
> > +     } else if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.WPIN")) {
> > +             args[0].integer.value = 1;
> > +             args[2].integer.value = on ? 0 : 1;
> > +     } else {
> > +             dev_err(&inputdev->dev, "Unable to find ACPI method\n");
> > +             return -ENOSYS;
> > +     }
>
> Can these checks be done at initialization phase?  It doesn't seem
> needed to be executed at each call.

Agree.

-- 
With Best Regards,
Andy Shevchenko
