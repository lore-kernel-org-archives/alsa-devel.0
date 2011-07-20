From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v4 02/10] ASoc: mxs: add mxs-saif driver
Date: Thu, 21 Jul 2011 00:43:18 +0800
Message-ID: <CAA+hA=SRbRr2m43UTf4hp3iwmt2xVxn6-1p0R1wkwQ+gKaAXVw@mail.gmail.com>
References: <1311133306-9496-1-git-send-email-b29396@freescale.com>
	<1311133306-9496-3-git-send-email-b29396@freescale.com>
	<4E27007C.6090805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 76CBC245A4
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 18:43:22 +0200 (CEST)
Received: by yxm34 with SMTP id 34so191619yxm.38
	for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2011 09:43:18 -0700 (PDT)
In-Reply-To: <4E27007C.6090805@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Dong Aisheng <b29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

2011/7/21 Liam Girdwood <lrg@ti.com>:
> On 20/07/11 04:41, Dong Aisheng wrote:
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Liam Girdwood <lrg@ti.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
>> ---
>> =A0sound/soc/mxs/mxs-saif.c | =A0677 +++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A0sound/soc/mxs/mxs-saif.h | =A0130 +++++++++
>> =A02 files changed, 807 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
>> new file mode 100644
>> index 0000000..0b3adae
>> --- /dev/null
>> +++ b/sound/soc/mxs/mxs-saif.c
>> @@ -0,0 +1,677 @@
>> +/*
>> + * Copyright 2011 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License al=
ong
>> + * with this program; if not, write to the Free Software Foundation, In=
c.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <sound/core.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +#include <mach/dma.h>
>> +#include <asm/mach-types.h>
>> +#include <mach/hardware.h>
>> +#include <mach/mxs.h>
>> +
>> +#include "mxs-saif.h"
>> +
>> +static struct mxs_saif *mxs_saif[2];
>> +
>
> Is there any reason why this struct cant be part of your DAI private data=
 ?

Yes, it is because we provide a interface mxs_saif_get_mclk for
machine driver to get the mclk if needed in a very early stage such as
probe.
And during that time, the machine driver will not be able to provide a
DAI as parameter
(card is still not registered).

+ * Get MCLK and set clock rate, then enable it
+ *
+ * This interface is used for codecs who are using MCLK provided
+ * by saif.
+ */
+int mxs_saif_get_mclk(unsigned int saif_id, unsigned int mclk,
+                                       unsigned int rate)

Regards
Dong Aisheng
