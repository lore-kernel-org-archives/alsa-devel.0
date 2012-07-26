From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 16/21] ASoC: Ux500: Enable MOP500 driver for Device Tree
Date: Thu, 26 Jul 2012 14:51:09 +0100
Message-ID: <50114B4D.3030305@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org> <1343298534-13611-17-git-send-email-lee.jones@linaro.org> <20120726113734.GZ3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120726113734.GZ3099@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, sameo@linux.intel.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 26/07/12 12:37, Mark Brown wrote:> On Thu, Jul 26, 2012 at 11:28:49A=
M +0100, Lee Jones wrote:
>=20
>>   arch/arm/mach-ux500/board-mop500-msp.c |    3 ---
>>   sound/soc/ux500/mop500.c               |   41 ++++++++++++++++++++=
++++++++++++
>=20
> There is no binding documentation here.  All bindings should be
> documented.

Yes I know. This is more of an RFC _before_ I waste my time writing doc=
umentation (again).

>> -	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func_=
_);
>> -	platform_device_register(&snd_soc_mop500);
>> -
>=20
> This should be done separately - if it's going to be merged with
> something it should be the patch that adds the relevant DT fragments.

Yes, I can do that.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
