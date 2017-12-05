From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4/8] ASoC: uniphier: add support for UniPhier EVEA codec
Date: Tue, 5 Dec 2017 09:58:54 +0900
Message-ID: <CAK7LNAR=-vHN5k6irpaDcAUYcH2kjCXLJpf10RMuq=GZB3huog@mail.gmail.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-5-suzuki.katsuhiro@socionext.com> <20171204182027.2k5uw5og65h6ac7w@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204182027.2k5uw5og65h6ac7w@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

+CC Greg-KH
+CC Thomas Gleixner

2017-12-05 3:20 GMT+09:00 Mark Brown <broonie@kernel.org>:
> On Wed, Nov 22, 2017 at 08:43:17PM +0900, Katsuhiro Suzuki wrote:
>
>> +++ b/sound/soc/uniphier/evea.c
>> @@ -0,0 +1,567 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Socionext UniPhier EVEA ADC/DAC codec driver.
>> + *
>> + * Copyright (c) 2016-2017 Socionext Inc.
>
> Make the entire comment a C++ comment, don't mix and match like this -
> it's ugly.  Otherwise this looks good so I'll apply it, please send a
> followup patch fixing this (and I guess the same thing will apply to
> other files).


Indeed ugly,
but I think this is intentional to make the SPDX line stand out.


Linus suggested this as far as I understood from the following:
https://patchwork.kernel.org/patch/10016201/


If you use C++ comment style for the entire block,
it will not stand out.




-- 
Best Regards
Masahiro Yamada
