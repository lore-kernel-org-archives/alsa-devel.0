From: AC30 CTLin0 <ctlin0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8822: new codec driver
Date: Fri, 19 Oct 2018 12:56:53 +0800
Message-ID: <27474a3d-515a-661f-26c2-108abcc69608@nuvoton.com>
References: <20180928031002.16112-1-CTLIN0@nuvoton.com>
 <20181017185423.GG24097@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9655926752C
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 06:56:58 +0200 (CEST)
In-Reply-To: <20181017185423.GG24097@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: wtli@nuvoton.com, yhchuang@nuvoton.com, alsa-devel@alsa-project.org, kchsu0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/18/2018 2:54 AM, Mark Brown wrote:
> On Fri, Sep 28, 2018 at 11:10:04AM +0800, David Lin wrote:
>
> This looks mostly good so I'm going to apply it, I do have a couple of
> comments below but they are quite small and I think they can be
> addressed with followup patches.
>
>> +++ b/sound/soc/codecs/nau8822.c
>> @@ -0,0 +1,1136 @@
>> +/*
>> + * nau8822.c  --  NAU8822 ALSA Soc Audio Codec driver
>> + *
>> + * Copyright 2017 Nuvoton Technology Corp.
>> + *
>> + * Author: David Lin <ctlin0@nuvoton.com>
>> + * Co-author: John Hsu <kchsu0@nuvoton.com>
>> + * Co-author: Seven Li <wtli@nuvoton.com>
>> + *
>> + * Based on WM8974.c
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
> This should be converted to use a SPDX license header
>
>       // SPDX-License-Identifier: GPL-2.0.
OK, I will convert it on next patch.
>> +static int nau8822_config_clkdiv(struct snd_soc_dai *dai, int div, int rate)
>> +{
>> +    struct snd_soc_component *component = dai->component;
>> +    struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
>> +    struct nau8822_pll *pll = &nau8822->pll;
>> +    int i, sclk, imclk;
> We're trying to get away from using set_clkdiv() as it makes it much
> harder to use generic card drivers without specific knowledge of the
> card.  However in this case it seems like it's mainly choosing if we
> should use the MCLK directly or the PLL and you should be able to do
> everything in the set_sysclk() operation - is there a reason not to do
> that?  If not then moving to set_sysclk() would avoid problems.

The nau8822_config_clkdiv() will be called internally by
nau8822_hw_params(), not link to the function point (*set_clkdiv) from
the structure "snd_soc_dai_ops".

If nau8822_config_clkdiv() need to simplify, I will remove case
NAU8822_CLK_PLL. The reason is using set_pll() operation can also finish
clk configure from machine driver.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
