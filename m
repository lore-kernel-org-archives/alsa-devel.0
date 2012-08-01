From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
Date: Wed, 01 Aug 2012 14:50:32 +0100
Message-ID: <50193428.5000708@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org> <1343741493-17671-3-git-send-email-lee.jones@linaro.org> <20120731134214.GK4468@opensource.wolfsonmicro.com> <5017EAC3.3080504@linaro.org> <20120731142820.GW4468@opensource.wolfsonmicro.com> <5017EDCA.4020601@linaro.org> <20120731145443.GY4468@opensource.wolfsonmicro.com> <5017F68B.3060400@linaro.org> <20120731151819.GC4468@opensource.wolfsonmicro.com> <5018D880.5090306@linaro.org> <20120801132022.GS11892@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120801132022.GS11892@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 01/08/12 14:20, Mark Brown wrote:
> On Wed, Aug 01, 2012 at 08:19:28AM +0100, Lee Jones wrote:
>> On 31/07/12 16:18, Mark Brown wrote:
>
>>> I'm not going to apply this patch.  This isn't a vendor BSP, we
>>> shouldn't be putting random hacks like this in core code.
>
>> BSP kernel or otherwise, it still seems wrong to me to fail and
>> entire audio driver just because of a broken link.
>
> No, really.  Random disconnections in the DAPM graph are just endless
> pain from a support and debug point of view.  This isn't something th=
at
> randomly breaks on specific hardware where we'd expect random errors =
at
> runtime, it's something that will never have worked - it seems clear
> nobody tested the mainline submission.

I am under the impression that it was tested. Perhaps before it was=20
rebased, but tests were completed. Ola was very surprised when I told=20
him there were link failures. The only issue is that I only found out=20
and told him a day before he was due to take his Summer leave.

> It's very disappointing to see such an error exist, and even more
> disappointing that there's no interest in fixing the driver.

This is incorrect. I'm sure the driver will be fixed post-haste when Ol=
a=20
returns back from vacation. If I can find some time I might dabble in=20
the mean-time also.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
