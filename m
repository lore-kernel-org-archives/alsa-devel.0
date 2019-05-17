From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Date: Fri, 17 May 2019 15:48:47 -0700
Message-ID: <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
References: <20190509211353.213194-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Mark Brown <broonie@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Takashi Iwai <tiwai@suse.com>
Cc: linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Lee,

I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
used on chromebook using a squashed version of these patches.
(crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
respectively)
Please let me know if you have any questions.

Thanks,

Gwendal.

On Thu, May 9, 2019 at 2:14 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.
>
> The source of thruth is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
>
> That include file is converted to remove ACPI and Embedded only code.
>
> From now on, cros_ec_commands.h will be automatically generated from
> the file above, do not modify directly.
>
> Fell free to squash the commits below.
>
> Changes in v3:
> - Rebase after commit 81888d8ab1532 ("mfd: cros_ec: Update the EC feature codes")
> - Add Acked-by: Benson Leung <bleung@chromium.org>
>
> Changes in v2:
> - Move I2S changes at the end of the patchset, squashed with change in
>   sound/soc/codecs/cros_ec_codec.c to match new interface.
> - Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Gwendal Grignou (30):
>   mfd: cros_ec: Update license term
>   mfd: cros_ec: Zero BUILD_ macro
>   mfd: cros_ec: set comments properly
>   mfd: cros_ec: add ec_align macros
>   mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
>   mfd: cros_ec: use BIT macro
>   mfd: cros_ec: Update ACPI interface definition
>   mfd: cros_ec: move HDMI CEC API definition
>   mfd: cros_ec: Remove zero-size structs
>   mfd: cros_ec: Add Flash V2 commands API
>   mfd: cros_ec: Add PWM_SET_DUTY API
>   mfd: cros_ec: Add lightbar v2 API
>   mfd: cros_ec: Expand hash API
>   mfd: cros_ec: Add EC transport protocol v4
>   mfd: cros_ec: Complete MEMS sensor API
>   mfd: cros_ec: Fix event processing API
>   mfd: cros_ec: Add fingerprint API
>   mfd: cros_ec: Fix temperature API
>   mfd: cros_ec: Complete Power and USB PD API
>   mfd: cros_ec: Add API for keyboard testing
>   mfd: cros_ec: Add Hibernate API
>   mfd: cros_ec: Add Smart Battery Firmware update API
>   mfd: cros_ec: Add I2C passthru protection API
>   mfd: cros_ec: Add API for EC-EC communication
>   mfd: cros_ec: Add API for Touchpad support
>   mfd: cros_ec: Add API for Fingerprint support
>   mfd: cros_ec: Add API for rwsig
>   mfd: cros_ec: Add SKU ID and Secure storage API
>   mfd: cros_ec: Add Management API entry points
>   mfd: cros_ec: Update I2S API
>
>  include/linux/mfd/cros_ec_commands.h | 3658 ++++++++++++++++++++------
>  sound/soc/codecs/cros_ec_codec.c     |    8 +-
>  2 files changed, 2915 insertions(+), 751 deletions(-)
>
> --
> 2.21.0.1020.gf2820cf01a-goog
>
