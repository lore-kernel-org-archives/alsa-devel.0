From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] slimbus: stream: add stream support
Date: Mon, 25 Jun 2018 09:12:17 -0700
Message-ID: <152994313712.143105.4349052596355647972@swboyd.mtv.corp.google.com>
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, gregkh@linuxfoundation.org
Cc: sdharia@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, ctatlor97@gmail.com, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Quoting Srinivas Kandagatla (2018-06-21 06:40:08)
> new file mode 100644
> index 000000000000..f8af9474d286
> --- /dev/null
> +++ b/drivers/slimbus/stream.c
> @@ -0,0 +1,493 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>
> +#include <linux/slimbus.h>
> +#include "slimbus.h"
> +
> +/**
> + * struct segdist_code - Segment Distributions code from
> + *     Table 20 of SLIMbus Specs Version 2.0
> + *
> + * @ratem: Channel Rate Multipler(Segments per Superframe)
> + * @seg_interval: Number of slots between the first Slot of Segment
> + *             and the first slot of the next  consecutive Segment.
> + * @segdist_code: Segment Distribution Code SD[11:0]
> + * @seg_offset_mask: Segment offset mask in SD[11:0]
> + * @segdist_codes: List of all possible Segmet Distribution codes.
> + */
> +static struct segdist_code {

const?

> +       int ratem;
> +       int seg_interval;
> +       int segdist_code;
> +       u32 seg_offset_mask;
> +
> +} segdist_codes[] =3D {
> +       {1,     1536,   0x200,   0xdff},
> +       {2,     768,    0x100,   0xcff},
> +       {4,     384,    0x080,   0xc7f},
> +       {8,     192,    0x040,   0xc3f},
> +       {16,    96,     0x020,   0xc1f},
> +       {32,    48,     0x010,   0xc0f},
> +       {64,    24,     0x008,   0xc07},
> +       {128,   12,     0x004,   0xc03},
> +       {256,   6,      0x002,   0xc01},
> +       {512,   3,      0x001,   0xc00},
> +       {3,     512,    0xe00,   0x1ff},
> +       {6,     256,    0xd00,   0x0ff},
> +       {12,    128,    0xc80,   0x07f},
> +       {24,    64,     0xc40,   0x03f},
> +       {48,    32,     0xc20,   0x01f},
> +       {96,    16,     0xc10,   0x00f},
> +       {192,   8,      0xc08,   0x007},
> +       {364,   4,      0xc04,   0x003},
> +       {768,   2,      0xc02,   0x001},
> +};
> +
> +/**
> + * struct slim_presence_rate - Presense Rate table for all Natural Frequ=
encies
> + *     The Presense rate of a constant bitrate stram is mean flow rate o=
f the
> + *     stream expressed in occupied Segments of that Data Channel per se=
cond.
> + *     Table 66 from SLIMbus 2.0 Specs
> + *
> + * @rate: data rate
> + * @pr_code: presence rate code PR[6:0]
> + * @prate_table: All possible presence rate code for Natural Frequencies
> + */
> +static struct slim_presence_rate {

const?

> +       int rate;
> +       int pr_code;
> +} prate_table[] =3D {
