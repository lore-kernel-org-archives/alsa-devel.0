From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] slimbus: stream: add stream support
Date: Mon, 25 Jun 2018 17:15:07 +0100
Message-ID: <990d582d-4cfb-f6f3-6ca5-a54daef8b88c@linaro.org>
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
 <152994313712.143105.4349052596355647972@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BB0D2673F5
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 18:15:09 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id b8-v6so8842596wro.6
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 09:15:09 -0700 (PDT)
In-Reply-To: <152994313712.143105.4349052596355647972@swboyd.mtv.corp.google.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Boyd <sboyd@kernel.org>, broonie@kernel.org, gregkh@linuxfoundation.org
Cc: alsa-devel@alsa-project.org, ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org

Thanks Stephen for review,

On 25/06/18 17:12, Stephen Boyd wrote:
> Quoting Srinivas Kandagatla (2018-06-21 06:40:08)
>> new file mode 100644
>> index 000000000000..f8af9474d286
>> --- /dev/null
>> +++ b/drivers/slimbus/stream.c
>> @@ -0,0 +1,493 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, Linaro Limited
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/slab.h>
>> +#include <linux/list.h>
>> +#include <linux/slimbus.h>
>> +#include "slimbus.h"
>> +
>> +/**
>> + * struct segdist_code - Segment Distributions code from
>> + *     Table 20 of SLIMbus Specs Version 2.0
>> + *
>> + * @ratem: Channel Rate Multipler(Segments per Superframe)
>> + * @seg_interval: Number of slots between the first Slot of Segment
>> + *             and the first slot of the next  consecutive Segment.
>> + * @segdist_code: Segment Distribution Code SD[11:0]
>> + * @seg_offset_mask: Segment offset mask in SD[11:0]
>> + * @segdist_codes: List of all possible Segmet Distribution codes.
>> + */
>> +static struct segdist_code {
> 
> const?
> 
Yep, Will fix this and presence rate in next version.!

>> +       int ratem;
>> +       int seg_interval;
>> +       int segdist_code;
>> +       u32 seg_offset_mask;
>> +
>> +} segdist_codes[] = {
>> +       {1,     1536,   0x200,   0xdff},
>> +       {2,     768,    0x100,   0xcff},
>> +       {4,     384,    0x080,   0xc7f},
>> +       {8,     192,    0x040,   0xc3f},
>> +       {16,    96,     0x020,   0xc1f},
>> +       {32,    48,     0x010,   0xc0f},
>> +       {64,    24,     0x008,   0xc07},
>> +       {128,   12,     0x004,   0xc03},
>> +       {256,   6,      0x002,   0xc01},
>> +       {512,   3,      0x001,   0xc00},
>> +       {3,     512,    0xe00,   0x1ff},
>> +       {6,     256,    0xd00,   0x0ff},
>> +       {12,    128,    0xc80,   0x07f},
>> +       {24,    64,     0xc40,   0x03f},
>> +       {48,    32,     0xc20,   0x01f},
>> +       {96,    16,     0xc10,   0x00f},
>> +       {192,   8,      0xc08,   0x007},
>> +       {364,   4,      0xc04,   0x003},
>> +       {768,   2,      0xc02,   0x001},
>> +};
>> +
>> +/**
>> + * struct slim_presence_rate - Presense Rate table for all Natural Frequencies
>> + *     The Presense rate of a constant bitrate stram is mean flow rate of the
>> + *     stream expressed in occupied Segments of that Data Channel per second.
>> + *     Table 66 from SLIMbus 2.0 Specs
>> + *
>> + * @rate: data rate
>> + * @pr_code: presence rate code PR[6:0]
>> + * @prate_table: All possible presence rate code for Natural Frequencies
>> + */
>> +static struct slim_presence_rate {
> 
> const?
> 
>> +       int rate;
>> +       int pr_code;
>> +} prate_table[] = {
