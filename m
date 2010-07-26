From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Modify the
	name of I2S driver
Date: Mon, 26 Jul 2010 16:37:13 +0900
Message-ID: <AANLkTimV+mJF_Qz2JvDcAUc+pApVApFQMHkLK32w+MWp@mail.gmail.com>
References: <4C4CEDE1.5010605@samsung.com>
	<B9F57799-417E-4006-80D4-7768EE347BF5@opensource.wolfsonmicro.com>
	<AANLkTi=20B0K+87HeRjdKAONVjwEhar09QRmj-SB2zbO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id DAE8924698
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 09:37:14 +0200 (CEST)
Received: by vws20 with SMTP id 20so2487307vws.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 00:37:14 -0700 (PDT)
In-Reply-To: <AANLkTi=20B0K+87HeRjdKAONVjwEhar09QRmj-SB2zbO@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Chanwoo Choi <cw00.choi@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 26, 2010 at 4:22 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Mon, Jul 26, 2010 at 3:57 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On 25 Jul 2010, at 19:07, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>>> This patch modify the name of I2S driver(S3C64XX/S3C24xx
>>> /S3C2412) from "*-iis-*" to "*-i2s-*". The mismatch of I2S name
>>> exist in the following sound driver. These files write the
>>> "cpu_dai_name" of I2S as "*-i2s-*".
>>>
>>> - sound/soc/s3c24xx/aquila_wm8994.c : "s3c64xx-i2s-v4-dai"
>>> - sound/soc/s3c24xx/goni_wm8994.c : "s3c64xx-i2s-v4-dai"
>>> - sound/soc/s3c24xx/smdk64xx_wm8580.c "s3c64xx-i2s-v4-dai"
>>> - sound/soc/s3c24xx/jive_wm8750.c : "s3c2412-i2s-dai"
>>> - sound/soc/s3c24xx/neo1973_wm8753.c : "s3c24xx-i2s-dai"
>>> - sound/soc/s3c24xx/neo1973_gta02_wm8753.c : "s3c24xx-i2s-dai"
>>> - sound/soc/s3c24xx/s3c24xx_simtec_hermes.c : "s3c24xx-i2s-dai"
>>> - sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c : "s3c24xx-i2s-dai"
>>> - sound/soc/s3c24xx/s3c24xx_uda134x.c : "s3c24xx-i2s-dai"
>>> - sound/soc/s3c24xx/smartq_wm8987.c : "s3c64xx-i2s-dai.0"
>>>
>>> or, It is should modify "cpu_dai_name" of sound drvier files
>>> instead of modifying the name of I2S driver.
>>
>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>>
>> but Jassi really should also comment here.
> I already talked to Ben about renaming drivers but he doesn't like the idea
> of breaking loadable drivers in distributions and I buy his opinion.
> So, Ben really has the say on the matter.

Plus how to change the directory name to "samsung'?

Thank you,
Kyungmin Park
