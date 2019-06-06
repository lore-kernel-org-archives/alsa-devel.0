From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [alsa-devel] [RESEND PATCH v3 00/30] Update cros_ec_commands.h
Date: Thu, 6 Jun 2019 13:25:40 +0200
Message-ID: <CAFqH_51gMu81f=VFQaF4u9-tAWDMocGAwM_fOPT3Cctv6KWniw@mail.gmail.com>
References: <20190603183401.151408-1-gwendal@chromium.org> <20190604055908.GA4797@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604055908.GA4797@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, alsa-devel@alsa-project.org, linux-iio@vger.kernel.org, fabien.lahoudere@collabora.com, Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, Mark Brown <broonie@kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>, Jonathan Cameron <jic23@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

Missatge de Lee Jones <lee.jones@linaro.org> del dia dt., 4 de juny
2019 a les 8:00:
>
> On Mon, 03 Jun 2019, Gwendal Grignou wrote:
>
> > The interface between CrosEC embedded controller and the host,
> > described by cros_ec_commands.h, as diverged from what the embedded
> > controller really support.
> >
> > The source of thruth is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/inclu=
de/ec_commands.h
> >
> > That include file is converted to remove ACPI and Embedded only code.
> >
> > From now on, cros_ec_commands.h will be automatically generated from
> > the file above, do not modify directly.
> >
> > Fell free to squash the commits below.
> >
> > v3 resent: Add Fabien's ack.
>
> Thanks for doing that.
>
> In future, please ensure *-bys tags are in chronological order with
> the first one either being a Suggested-by or your SoB.  Reviews, tests
> etc usually come *after* first submission.
>
> I've changed this for you this time, yes in all 30 patches!  :)
>
> Anyway, all applied, thanks.
>

Could you do an immutable branch with those? I've few patches that
depends on those changes and probably I'll have more. Otherwise, I'll
wait for those to land.

Thanks,
 Enric

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
