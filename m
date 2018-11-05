From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda: add support for Huawei WMI MicMute LED
Date: Mon, 5 Nov 2018 16:46:59 +0200
Message-ID: <CAHp75VfFbv8Xu8TZ3O7QPxrNiBN6admdUSUzOG9KZXYYZJzjyA@mail.gmail.com>
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
 <20181102041120.7603-4-ayman.bagabas@gmail.com> <CAHp75VcA5M4XNVr94OALo3=AW3LbWU+Pz-KTRgodBtSP_K9-wA@mail.gmail.com>
 <33dce911f9544c53a7989430a1ce848444cf4e3b.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <33dce911f9544c53a7989430a1ce848444cf4e3b.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ayman Bagabas <ayman.bagabas@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 3, 2018 at 1:21 AM <ayman.bagabas@gmail.com> wrote:
> On Fri, 2018-11-02 at 20:12 +0200, Andy Shevchenko wrote:
> > On Fri, Nov 2, 2018 at 6:12 AM Ayman Bagabas <ayman.bagabas@gmail.com
> > > wrote:

Takashi explained me, that is the way sound driver are using the
external symbols, so, follow his suggestion.

> > > +static int (*huawei_wmi_micmute_led_set_func)(bool);
> >
> > Why is that?
>
> This is used with symbol_request and then in the update function to
> locate the function from the wmi device. But I guess you are right, we
> could use the function defined in the header file directly.

> > Takashi, is it a way how the rest sound drivers are written? B/c this
> > symbol_request(s) look to me a bit ugly.
> >
> > > +/* for alc_fixup_huawei_micmute_led */
> > > +#include "huawei_wmi_helper.c"
> >
> > Ditto.
> >
> > Include *.c?! Huh?
>
> Is that the wrong way? Should I define the functions directly into
> patch_realtek.c?


-- 
With Best Regards,
Andy Shevchenko
