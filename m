From: ayman.bagabas@gmail.com
Subject: Re: [PATCH v9 2/3] x86: add support for Huawei WMI hotkeys.
Date: Tue, 04 Dec 2018 10:41:26 -0500
Message-ID: <c1345856d250351a5d8e81bb723ce5ac26ff8dd5.camel@gmail.com>
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
         <20181203185344.3521-3-ayman.bagabas@gmail.com>
         <s5h8t16jut7.wl-tiwai@suse.de>
         <CAHp75VcqiKaWYwMGJcehE9RAC56GExdK5skky2S-eUPs+ekgaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcqiKaWYwMGJcehE9RAC56GExdK5skky2S-eUPs+ekgaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <hui.wang@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-12-03 at 21:17 +0200, Andy Shevchenko wrote:
> On Mon, Dec 3, 2018 at 9:04 PM Takashi Iwai <tiwai@suse.de> wrote:
> > On Mon, 03 Dec 2018 19:53:39 +0100,
> > Ayman Bagabas wrote:
> > > +     if (code == 0x80) {
> > > +             acpi_status status;
> > > +             acpi_handle handle;
> > > +             unsigned long long result;
> > > +             union acpi_object args[1];
> > > +             struct acpi_object_list arg_list = {
> > > +                     .pointer = args,
> > > +                     .count = ARRAY_SIZE(args),
> > > +             };
> > > +
> > > +             args[0].type = ACPI_TYPE_INTEGER;
> > > +             args[0].integer.value = 0;
> > > +
> > > +             status = acpi_get_handle(NULL, "\\WMI0", &handle);
> > > +             if (ACPI_FAILURE(status)) {
> > > +                     dev_err(&wdev->dev, "Unable to get ACPI
> > > handle\n");
> > > +                     return;
> > > +             }
> > > +
> > > +             status = acpi_evaluate_integer(NULL, "WQ00",
> > > &arg_list, &result);
> > 
> > I guess you need to pass handle here?  In the earlier version, you
> > passed \\WMI0.WQ00, so it worked with NULL handle.  But now it's no
> > longer so...
> 
> I think in this case we don't need to have a separate call to get
> handle and try to get integer directly. In either we will have an
> error case if method  / namespace / etc is not found.

Agree.

> 
> > Other than that, it looks OK to me.
> >   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks.

> > 
> > But, you don't need to rush too much.  Instead, better to test your
> > own patches and make sure that they really work before submitting
> > the
> > final version.
> 
> Yes, I will wait couple of days for v10 in hope it will be tested
> carefully.

You're right, I will test it more and make sure everything work as
expected.

> 
