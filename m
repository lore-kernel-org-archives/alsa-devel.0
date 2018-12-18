From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: eukrea-tlv320: Do not enable on ARM64
Date: Tue, 18 Dec 2018 21:02:21 -0200
Message-ID: <CAOMZO5DxThsRyT0Bnn8zDSw-yiHT-Bokcf0DcU0mx6gu+VgzJA@mail.gmail.com>
References: <20181218225824.20974-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218225824.20974-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Andrey,

On Tue, Dec 18, 2018 at 8:58 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> ARCH_MXC is also used by i.MX8/AArch64 SoC, building the driver for
> that platform results in:
>
> sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory
>  #include <asm/mach-types.h>
>           ^~~~~~~~~~~~~~~~~~
> compilation terminated.
>
> Since the code in question doesn't seem to have any use on i.MX8,
> disable it by adding a !ARM64 as a dependecy.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Sorry for the noise if this is fixed already.

Yes, I sent a fix for this and it is linux-next already:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/sound/soc/fsl/Kconfig?h=next-20181218&id=add6883619a9e3bf9658eaff1a547354131bbcd9
