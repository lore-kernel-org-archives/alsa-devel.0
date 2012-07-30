From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 10/18] ARM: ux500: Enable HIGHMEM on all mop500 platforms
Date: Mon, 30 Jul 2012 07:54:26 +0100
Message-ID: <50162FA2.4010009@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org> <1343393162-11938-11-git-send-email-lee.jones@linaro.org> <20120729204516.GJ4384@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120729204516.GJ4384@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 29/07/12 21:45, Mark Brown wrote:
> On Fri, Jul 27, 2012 at 01:45:54PM +0100, Lee Jones wrote:
>> The current kernel commandline for ux500 based devices includes
>> hard-coded allocations for things like mali and hwmem, which
>> actually run over lowmem. Here we enable highmem in order to
>> avoid memory corruption errors.
>
> This appears to be at best tangentially related to the rest of the
> series, are you sure it shouldn't be being sent separately as a bugfi=
x?

Yes, it should. I'll shift it.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
