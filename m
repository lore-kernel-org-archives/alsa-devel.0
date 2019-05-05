From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 01/30] mfd: cros_ec: Update license term
Date: Sun, 5 May 2019 16:46:37 +0100
Message-ID: <20190505164637.579ffb11@archlinux>
References: <20190503220233.64546-1-gwendal@chromium.org>
 <20190503220233.64546-2-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62615F80C0B
 for <alsa-devel@alsa-project.org>; Sun,  5 May 2019 17:46:45 +0200 (CEST)
In-Reply-To: <20190503220233.64546-2-gwendal@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: alsa-devel@alsa-project.org, linux-iio@vger.kernel.org, bleung@chromium.org, tiwai@suse.com, groeck@chromium.org, broonie@kernel.org, enric.balletbo@collabora.com, lee.jones@linaro.org, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

On Fri,  3 May 2019 15:02:04 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Update to SPDX-License-Identifier, GPL-2.0
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Nitpick. There are a few other trivial changes in here, that the description
should probably mention.  I doubt anyone really cares though given
how trivial the other comment changes are.

Jonathan

> ---
>  include/linux/mfd/cros_ec_commands.h | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 43bee4f7d137..6fa508643da3 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -1,25 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Host communication command constants for ChromeOS EC
>   *
>   * Copyright (C) 2012 Google, Inc
>   *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * The ChromeOS EC multi function device is used to mux all the requests
> - * to the EC device for its multiple features: keyboard controller,
> - * battery charging and regulator control, firmware update.
> - *
> - * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
> - * project in an attempt to make future updates easy to make.
> + * NOTE: This file is auto-generated from ChromeOS EC Open Source code from
> + * https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
>   */
>  
> +/* Host communication command constants for Chrome EC */
> +
>  #ifndef __CROS_EC_COMMANDS_H
>  #define __CROS_EC_COMMANDS_H
>  
