From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 5/5] ASoc: add machine driver for 88pm860x
Date: Fri, 13 Aug 2010 23:01:36 +0800
Message-ID: <AANLkTimWSCwUjE3Xw304DFGyP9VXXi_YT3R4fM_tvdm1@mail.gmail.com>
References: <AANLkTikpcA0RTxdGne2L5n06d0AjfnWEMsh0GP8nvyO6@mail.gmail.com>
	<20100813142646.GE6449@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 31A1624156
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 17:01:42 +0200 (CEST)
Received: by gwb17 with SMTP id 17so803386gwb.38
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2010 08:01:41 -0700 (PDT)
In-Reply-To: <20100813142646.GE6449@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 13, 2010 at 10:26 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 13, 2010 at 09:55:53PM +0800, Haojian Zhuang wrote:
>> From cd2063f68b233a86b24efa3f4dc3ca3c438b1576 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Thu, 12 Aug 2010 12:04:23 +0800
>
> Please fix your configuration for sending patches - none of this header
> stuff should be in the body of the mail.
>
Oh. It seems wrong date. Do you know how to resolve this?

>> Subject: [PATCH 5/5] ASoc: add machine driver for 88pm860x
>
> It's not a machine driver for this CODEC, it appears to be two machine
> drivers for...
>
>> 88PM860x codec is used in Marvell development board (Saarb and tavorevb3=
).
>> Codec is used as master mode in both of these two boards.
>
> ...these two boards. =A0I'd suggest supplying one board per patch.
>
OK
>> +#include "../../arm/pxa2xx-pcm.h"
>
> Why?
>
should remove
>> + =A0 =A0 SND_SOC_DAPM_SPK("Board Speaker", NULL),
>> + =A0 =A0 SND_SOC_DAPM_MIC("Board Mic 1", NULL),
>> + =A0 =A0 SND_SOC_DAPM_MIC("Board Mic 3", NULL),
>
> What happened to Mic 2?
>
Mic 2 is in headset. I declared it with "Mic Jack" in DAPM.
