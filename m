From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: add tavorevb3 machine driver for
	88pm860x
Date: Wed, 18 Aug 2010 22:08:22 +0800
Message-ID: <AANLkTi=j7383au6=J7eeY-axSKUXBvOGoPEVr=2NQTNe@mail.gmail.com>
References: <AANLkTi=o7+GtXz1ZxuLJiYkREpMB=RPckig95FQrSqLd@mail.gmail.com>
	<1282140419.3117.465.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A647244EC
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 16:08:23 +0200 (CEST)
Received: by gxk28 with SMTP id 28so230456gxk.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 07:08:22 -0700 (PDT)
In-Reply-To: <1282140419.3117.465.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <Mark.Brown@wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 18, 2010 at 10:06 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Wed, 2010-08-18 at 21:49 +0800, Haojian Zhuang wrote:
>> >From 114a6f2d4629b0bbff4c4ce9b4a633ddf7e25498 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Tue, 17 Aug 2010 13:24:35 +0800
>> Subject: [PATCH 2/3] ASoC: add tavorevb3 machine driver for 88pm860x
>>
>> 88PM860x codec is used in Marvell tavorevb3 development board. 88PM860x
>> codec is used as master mode of SSP communication. Only I2S format is
>> supported.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> =A0sound/soc/pxa/Kconfig =A0 =A0 =A0| =A0 =A09 +
>> =A0sound/soc/pxa/Makefile =A0 =A0 | =A0 =A02 +
>> =A0sound/soc/pxa/pxa2xx-ssp.c | =A0532 +++++++++++++++++++++++++++++++++=
+++++++++++
>> =A0sound/soc/pxa/pxa2xx-ssp.h | =A0 59 +++++
>> =A0sound/soc/pxa/ssp.c =A0 =A0 =A0 =A0| =A0298 +++++++++++++++++++++++++
>
> I dont think you meant to include the SSP driver.
>

I'm sorry that it's caused by mistake. I'll remove it and send it again.
> Thanks
>
> Liam
>
>
>
