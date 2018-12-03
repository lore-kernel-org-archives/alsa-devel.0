From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v8 2/3] x86: add support for Huawei WMI hotkeys.
Date: Mon, 3 Dec 2018 16:23:46 +0200
Message-ID: <CAHp75Vfg7K=7U1P2+N+wsxHV4rwQ4z3rvFuaUXz+znpgiN19YA@mail.gmail.com>
References: <20181129235742.14332-1-ayman.bagabas@gmail.com>
 <20181129235742.14332-3-ayman.bagabas@gmail.com> <s5hftvezupj.wl-tiwai@suse.de>
 <CAHp75Vf7WW8ezL_H_iw_=nSVARuvhugUY5sTkQ=usU96Wj2YSA@mail.gmail.com> <s5hlg56y9k3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hlg56y9k3.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ayman Bagabas <ayman.bagabas@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 3, 2018 at 4:22 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 03 Dec 2018 15:18:54 +0100,
> Andy Shevchenko wrote:
> >
> > On Mon, Dec 3, 2018 at 2:00 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > On Fri, 30 Nov 2018 00:57:37 +0100,
> > > Ayman Bagabas wrote:
> >
> > > > +struct huawei_wmi_priv {
> > > > +     struct input_dev *idev;
> > > > +     struct led_classdev cdev;
> > > > +     acpi_handle handle;
> > >
> > > Is this handle set in anywhere?  I couldn't see it in your patch.
> > > If it's supposed to be NULL, passing NULL explicitly makes your
> > > intention clearer.
> >
> > Isn't below an answer?
> >
> > > > +     // Skip registering LED subsystem if no ACPI method was found.
> > > > +     status = acpi_get_handle(priv->handle, "\\_SB.PCI0.LPCB.EC0", &priv->handle);
>
> Oh indeed, but why it passes priv->handle at the first argument...?

Yes, since it's an absolute, I guess NULL in this case will be OK.

-- 
With Best Regards,
Andy Shevchenko
