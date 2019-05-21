From: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: Re: [alsa-devel] [PATCH v3 00/30] Update cros_ec_commands.h
Date: Tue, 21 May 2019 15:45:41 +0200
Message-ID: <2741579da03893d2d4e7ad7f5fc42a506a82f380.camel@collabora.com>
References: <20190509211353.213194-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>, enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org, broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc: linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Le jeudi 09 mai 2019 à 14:13 -0700, Gwendal Grignou a écrit :
> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.
> 
> The source of thruth is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> 
> That include file is converted to remove ACPI and Embedded only code.

Hi, 

I reviewed patches of the series and they looks good to me.

Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
