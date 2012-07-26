From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
Date: Thu, 26 Jul 2012 16:17:08 +0100
Message-ID: <50115F74.2040706@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org> <1343298534-13611-21-git-send-email-lee.jones@linaro.org> <20120726115055.GD3099@opensource.wolfsonmicro.com> <50114D71.9060700@linaro.org> <20120726142825.GK3099@opensource.wolfsonmicro.com> <50115BBA.2020400@linaro.org> <20120726151404.GP3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120726151404.GP3099@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, sameo@linux.intel.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 26/07/12 16:14, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 04:01:14PM +0100, Lee Jones wrote:
>
>> This is the only value which the user can pick an obscure value,
>> such as 913, thinking they can pick 913mV. I'm happy to fall-back,
>> as long as Ola is too.
>
> Erroring out if they pick an invalid value is fine, I'm more concerne=
d
> with the case where no property is supplied at all.

Hmmm... I'll have a think.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
