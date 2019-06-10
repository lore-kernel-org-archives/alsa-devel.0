From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and Cros due for the v5.3
 merge window
Date: Mon, 10 Jun 2019 10:45:15 +0200
Message-ID: <CAFqH_50J1wqdhWw5nW+D=crfg=JjUrSh2it=JORx5Wn8LfNTQg@mail.gmail.com>
References: <20190603183401.151408-1-gwendal@chromium.org> <20190604055908.GA4797@dell>
 <CAFqH_51gMu81f=VFQaF4u9-tAWDMocGAwM_fOPT3Cctv6KWniw@mail.gmail.com> <20190610082012.GK4797@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610082012.GK4797@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, alsa-devel@alsa-project.org, linux-iio@vger.kernel.org, fabien.lahoudere@collabora.com, Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, Mark Brown <broonie@kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>, Jonathan Cameron <jic23@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for the ib Lee.

Doing my Monday rebase I just noticed we will have a trivial conflict
for the merge window.

Missatge de Lee Jones <lee.jones@linaro.org> del dia dl., 10 de juny
2019 a les 10:20:
>
> As requested.
>
> Enjoy!
>
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0eb=
d9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-v=
5.3
>
> for you to fetch changes up to 3aa6be30da899619c44aa654313ba66eb44e7291:
>
>   mfd: cros_ec: Update I2S API (2019-06-10 09:15:08 +0100)
>
> ----------------------------------------------------------------
> Immutable branch between MFD and Cros due for the v5.3 merge window
>
> ----------------------------------------------------------------
> Gwendal Grignou (30):
>       mfd: cros_ec: Update license term

That's the commit will have problems due

commit 9c92ab61914157664a2fbdf926df0eb937838e45
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed May 29 07:17:56 2019 -0700

    treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 282

That was introduced in v5.2-rc4

Just to let you know.
 Enric

>       mfd: cros_ec: Zero BUILD_ macro
>       mfd: cros_ec: set comments properly
>       mfd: cros_ec: add ec_align macros
>       mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
>       mfd: cros_ec: use BIT macro
>       mfd: cros_ec: Update ACPI interface definition
>       mfd: cros_ec: move HDMI CEC API definition
>       mfd: cros_ec: Remove zero-size structs
>       mfd: cros_ec: Add Flash V2 commands API
>       mfd: cros_ec: Add PWM_SET_DUTY API
>       mfd: cros_ec: Add lightbar v2 API
>       mfd: cros_ec: Expand hash API
>       mfd: cros_ec: Add EC transport protocol v4
>       mfd: cros_ec: Complete MEMS sensor API
>       mfd: cros_ec: Fix event processing API
>       mfd: cros_ec: Add fingerprint API
>       mfd: cros_ec: Fix temperature API
>       mfd: cros_ec: Complete Power and USB PD API
>       mfd: cros_ec: Add API for keyboard testing
>       mfd: cros_ec: Add Hibernate API
>       mfd: cros_ec: Add Smart Battery Firmware update API
>       mfd: cros_ec: Add I2C passthru protection API
>       mfd: cros_ec: Add API for EC-EC communication
>       mfd: cros_ec: Add API for Touchpad support
>       mfd: cros_ec: Add API for Fingerprint support
>       mfd: cros_ec: Add API for rwsig
>       mfd: cros_ec: Add SKU ID and Secure storage API
>       mfd: cros_ec: Add Management API entry points
>       mfd: cros_ec: Update I2S API
>
>  include/linux/mfd/cros_ec_commands.h | 3658 +++++++++++++++++++++++++++-=
------
>  sound/soc/codecs/cros_ec_codec.c     |    8 +-
>  2 files changed, 2915 insertions(+), 751 deletions(-)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
