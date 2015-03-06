From: Chih-Chiang Chang <ccchang12@nuvoton.com>
Subject: Re: [PATCH v2] ASoC: Add support for NAU8824 codec to ASoC
Date: Fri, 6 Mar 2015 15:38:58 +0800
Message-ID: <54F95992.9080309@nuvoton.com>
References: <54F70052.1070109@nuvoton.com> <1425508332.2090.48.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425508332.2090.48.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Mark Brown <broonie@kernel.org>, "mcuos.com@gmail.com" <mcuos.com@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



On 2015/3/5 =E4=B8=8A=E5=8D=88 06:32, Paul Bolle wrote:
> Chih-Chiang Chang schreef op wo 04-03-2015 om 20:53 [+0800]:
>> From fe37688e226f83ba477a3c2fbc1e64946cd4ec4e Mon Sep 17 00:00:00 20=
01
>> From: Chih-Chiang Chang <ccchang12@nuvoton.com>
>> Date: Wed, 4 Mar 2015 20:03:21 +0800
>> Subject: [PATCH v2] ASoC: Add support for NAU8824 codec to ASoC
>=20
> It seems that none of those lines were needed.
Sorry for the wrong patch format, will remove these lines in next submi=
t.
>=20
>> --- /dev/null
>> +++ b/include/sound/nau8824.h
>> @@ -0,0 +1,22 @@
>> +/*
>> + * linux/sound/nau8824.h -- Platform data for NAU8824
>> + *
>> + * Copyright 2015 Nuvoton Technology Corp.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __LINUX_SND_NAU8824_H
>> +#define __LINUX_SND_NAU8824_H
>> +
>> +struct nau8824_platform_data {
>> +       unsigned int audio_mclk1;
>> +       unsigned int gpio_irq;
>> +       int naudint_irq;
>> +       int headset_detect;
>> +       int button_press_detect;
>> +};
>> +
>> +#endif
>=20
> In the future something other than just sound/soc/codecs/nau8824.h is
> going to include this header, right?
>=20
>> --- /dev/null
>> +++ b/sound/soc/codecs/nau8824.c
>> @@ -0,0 +1,807 @@
>> +/*
>> + * linux/sound/soc/codecs/nau8824.c
>> + *
>> + * Copyright 2015 Nuvoton Technology Corp.
>> + * Author: Meng-Huang Kuo <mhkuo@nuvoton.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>=20
> This states the license is GPL v2. (So do the two headers this patch
> adds.)
>=20
>> +MODULE_LICENSE("GPL");
>=20
> So that should probably be
>     MODULE_LICENSE("GPL v2");
We will modify the code to be GPL v2.
>=20
>=20
> Paul Bolle
>=20
