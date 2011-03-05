From: Zeng Zhaoming <zengzm.kernel@gmail.com>
Subject: Re: [PATCH -next] soc: sgtl5000 uses regulator interfaces
Date: Sat, 5 Mar 2011 20:41:38 +0800
Message-ID: <AANLkTikivW3+V4QYh9Nt9FGXTefZiN9WbpAvGVeBJHNN@mail.gmail.com>
References: <20110304180027.20deb6c4.sfr@canb.auug.org.au>
	<20110304173357.23d36116.randy.dunlap@oracle.com>
	<20110305112936.GA30187@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110305112936.GA30187@opensource.wolfsonmicro.com>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Zeng Zhaoming <zhaoming.zeng@freescale.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 5, 2011 at 7:29 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Mar 04, 2011 at 05:33:57PM -0800, Randy Dunlap wrote:
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> sgtl5000 uses regulator interfaces, so make selecting it depend
>> on REGULATOR.
>>
>> sgtl5000.c:(.text+0x4ae33): undefined reference to `regulator_unregi=
ster'
>> sgtl5000.c:(.text+0x4af41): undefined reference to `rdev_get_drvdata=
'
>> sgtl5000.c:(.text+0x4b191): undefined reference to `regulator_regist=
er'
>

hi=EF=BC=8C Thanks for the report.

> Since the regulator on the device is optional this isn't the best fix=
,
> the code should be updated to support building without regulator.

I will fix the code. If regulator not enabled, and the optional
regulator not provided externally,
a warning message will print out, and internal regulator will set
directly by write register.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Best Regards
=C2=A0 =C2=A0 Zeng Zhaoming
