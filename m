From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 2/3] x86: add support for Huawei WMI hotkeys.
Date: Mon, 3 Dec 2018 21:17:49 +0200
Message-ID: <CAHp75VcqiKaWYwMGJcehE9RAC56GExdK5skky2S-eUPs+ekgaA@mail.gmail.com>
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
 <20181203185344.3521-3-ayman.bagabas@gmail.com> <s5h8t16jut7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h8t16jut7.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ayman Bagabas <ayman.bagabas@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 3, 2018 at 9:04 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 03 Dec 2018 19:53:39 +0100,
> Ayman Bagabas wrote:
> > +     if (code == 0x80) {
> > +             acpi_status status;
> > +             acpi_handle handle;
> > +             unsigned long long result;
> > +             union acpi_object args[1];
> > +             struct acpi_object_list arg_list = {
> > +                     .pointer = args,
> > +                     .count = ARRAY_SIZE(args),
> > +             };
> > +
> > +             args[0].type = ACPI_TYPE_INTEGER;
> > +             args[0].integer.value = 0;
> > +
> > +             status = acpi_get_handle(NULL, "\\WMI0", &handle);
> > +             if (ACPI_FAILURE(status)) {
> > +                     dev_err(&wdev->dev, "Unable to get ACPI handle\n");
> > +                     return;
> > +             }
> > +
> > +             status = acpi_evaluate_integer(NULL, "WQ00", &arg_list, &result);
>
> I guess you need to pass handle here?  In the earlier version, you
> passed \\WMI0.WQ00, so it worked with NULL handle.  But now it's no
> longer so...

I think in this case we don't need to have a separate call to get
handle and try to get integer directly. In either we will have an
error case if method  / namespace / etc is not found.

> Other than that, it looks OK to me.
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>
>
> But, you don't need to rush too much.  Instead, better to test your
> own patches and make sure that they really work before submitting the
> final version.

Yes, I will wait couple of days for v10 in hope it will be tested carefully.

-- 
With Best Regards,
Andy Shevchenko
