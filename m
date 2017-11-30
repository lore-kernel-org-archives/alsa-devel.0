From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v8 07/13] slimbus: Add support for 'clock-pause' feature
Date: Thu, 30 Nov 2017 20:25:26 +0100
Message-ID: <CAOFm3uE+ehT+WGHO2tYz4W8h35wBgge+BO5fS=yuxemq28TERg@mail.gmail.com>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org> <20171130174200.6684-8-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171130174200.6684-8-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark <broonie@kernel.org>, ALSA <alsa-devel@alsa-project.org>, Sagar Dharia <sdharia@codeaurora.org>, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, Rob Herring <robh+dt@kernel.org>, pawel.moll@arm.com, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arn>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 30, 2017 at 6:41 PM,  <srinivas.kandagatla@linaro.org> wrote:
[]
> diff --git a/drivers/slimbus/sched.c b/drivers/slimbus/sched.c
> new file mode 100644
> index 000000000000..74300f1a6898
> --- /dev/null
> +++ b/drivers/slimbus/sched.c
> @@ -0,0 +1,128 @@
> +/* Copyright (c) 2011-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.

Could it make sense to use the new SPDX ids here? e.g.

> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2011-2016, The Linux Foundation

This neat and cleaner, is it?
See tglx doc posted as patches and Linus comments for a rationale on
the comment styles.
--
Cordially
Philippe Ombredanne
