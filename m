From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH 00/30] Update cros_ec_commands.h
Date: Thu, 25 Apr 2019 09:38:09 -0700
Message-ID: <CAPUE2uu7npyi0jgHPLCD-3DWkiKuhRidBgyiVK6O1TesHLqkEg@mail.gmail.com>
References: <20190424232918.243308-1-gwendal@chromium.org> <20190425081232.GA14758@dell>
 <aa1c0ab7-6491-69a8-936c-26460b78d6c2@collabora.com> <CAPUE2ussoqWAP-1Hpa2mGq-23NuTh=Ai3dssiZYYiqLBDTCJwQ@mail.gmail.com>
 <0fad0c23-7939-606e-86e1-748dd1115b82@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0fad0c23-7939-606e-86e1-748dd1115b82@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 25, 2019 at 9:11 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> cc'ing some ASOC reviewers.
>
> On 25/4/19 18:00, Gwendal Grignou wrote:
> > On Thu, Apr 25, 2019 at 4:19 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Gwendal, Lee
> >>
> >> On 25/4/19 10:12, Lee Jones wrote:
> >>> On Wed, 24 Apr 2019, Gwendal Grignou wrote:
> >>>
> >>>> The interface between CrosEC embedded controller and the host,
> >>>> described by cros_ec_commands.h, as diverged from what the embedded
> >>>> controller really support.
> >>>>
> >>>> The source of thruth is at
> >>>> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> >>>>
> >>>> That include file is converted to remove ACPI and Embedded only code.
> >>>>
> >>>> From now on, cros_ec_commands.h will be automatically generated from
> >>>> the file above, do not modify directly.
> >>>>
> >>>> Fell free to squash the commits below.
> >>>
> >>> This is going to need a bunch of Chromium reviews (and testing
> >>> ideally) before I can take this set.
> >>>
> >>
> >> I tested this patchset in different ways. With the full series applied I checked
> >> that didn't break any cros-ec driver on Kevin, Samus and Veyron devices. I also
> >> checked via userspace tool that I don't see any problem sending commands and
> >> finally I checked that applying one-by-one the patches didn't break the build on
> >> x86 and arm64, there is though, a problem,
> >>
> >> [PATCH 24/30] mfd: cros_ec: Update I2S API
> >>
> >> introduces a build problem because removes a struct that is currently used by
> >> the cros_ec_codec driver. I think that at the same time we should update that
> >> driver with the new struct name.
> > Sorry, I did not structure this patchset right. The i2s patch is available at
> > https://patchwork.kernel.org/patch/10877645/
> >
>
> I think would be better squash both patches, otherwise things like bisection
> would be a pain. The patch then touches two subsystems but won't break
> compilation, and is pretty simple, so I think should not be a problem go through
> i.e. the mfd tree.
I squashed both patches in [PATCH v2 24/30] mfd: cros_ec: Update I2S API

Thanks for the feedback,

Gwendal.
>
> > Gwendal.
> >>
> >> Once this is fixed,
> >>
> >> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>
> >> for the full series.
> >>
> >> Thanks,
> >>  Enric
> >>
