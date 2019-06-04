From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v3 00/30] Update cros_ec_commands.h
Date: Tue, 4 Jun 2019 06:59:08 +0100
Message-ID: <20190604055908.GA4797@dell>
References: <20190603183401.151408-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, jic23@kernel.org, broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com, fabien.lahoudere@collabora.com, linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 03 Jun 2019, Gwendal Grignou wrote:

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
> v3 resent: Add Fabien's ack.

Thanks for doing that.

In future, please ensure *-bys tags are in chronological order with
the first one either being a Suggested-by or your SoB.  Reviews, tests
etc usually come *after* first submission.

I've changed this for you this time, yes in all 30 patches!  :)

Anyway, all applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
