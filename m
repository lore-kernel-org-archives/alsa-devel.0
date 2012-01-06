From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: Fix build dependency for
	SND_ATMEL_SOC_SSC
Date: Fri, 6 Jan 2012 15:36:06 +0800
Message-ID: <CAF+7xW=Kztc+q8TqQvzR-k666yj2BLew_v4GDig=uQtnh23a4A@mail.gmail.com>
References: <1325832864.31496.1.camel@phoenix>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 88C1B24133
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 08:36:29 +0100 (CET)
Received: by lago2 with SMTP id o2so405945lag.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Jan 2012 23:36:27 -0800 (PST)
In-Reply-To: <1325832864.31496.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Paul Bolle <pebolle@tiscali.nl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2012/1/6 Axel Lin <axel.lin@gmail.com>:
> Make SND_ATMEL_SOC_SSC select ATMEL_SSC to fix below build errors:
>
> =A0LD =A0 =A0 =A0.tmp_vmlinux1
> sound/built-in.o: In function `atmel_ssc_remove':
> sound/soc/atmel/atmel_ssc_dai.c:713: undefined reference to `ssc_free'
> sound/built-in.o: In function `atmel_ssc_probe':
> sound/soc/atmel/atmel_ssc_dai.c:700: undefined reference to `ssc_request'
> sound/built-in.o: In function `atmel_ssc_set_audio':
> sound/soc/atmel/atmel_ssc_dai.c:845: undefined reference to `ssc_request'
> sound/soc/atmel/atmel_ssc_dai.c:851: undefined reference to `ssc_free'
> make: *** [.tmp_vmlinux1] Error 1
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> This patch is against linux-next 20120103.
> =A0sound/soc/atmel/Kconfig | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index d1fcc81..a4d6742 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -9,6 +9,7 @@ config SND_ATMEL_SOC
> =A0config SND_ATMEL_SOC_SSC
> =A0 =A0 =A0 =A0tristate
> =A0 =A0 =A0 =A0depends on SND_ATMEL_SOC
> + =A0 =A0 =A0 select ATMEL_SSC

With this patch I got  recursive dependency detected with the patch
because SND_AT91_SOC_SAM9G20_WM8731 depends on ATMEL_SSC.

scripts/kconfig/mconf Kconfig
drivers/misc/Kconfig:212:error: recursive dependency detected!
drivers/misc/Kconfig:212:       symbol ATMEL_SSC is selected by
SND_ATMEL_SOC_SSC
sound/soc/atmel/Kconfig:9:      symbol SND_ATMEL_SOC_SSC is selected
by SND_AT91_SOC_SAM9G20_WM8731
sound/soc/atmel/Kconfig:18:     symbol SND_AT91_SOC_SAM9G20_WM8731
depends on ATMEL_SSC

And if I removed ATMEL_SSC dependency from SND_AT91_SOC_SAM9G20_WM8731,
I still got below build warning:

warning: (SND_ATMEL_SOC_SSC) selects ATMEL_SSC which has unmet direct
dependencies (MISC_DEVICES && (AVR32 || ARCH_AT91))
warning: (SND_ATMEL_SOC_SSC) selects ATMEL_SSC which has unmet direct
dependencies (MISC_DEVICES && (AVR32 || ARCH_AT91))

So how about make SND_AT91_SOC_AFEB9260 depend on ATMEL_SSC
instead of making SND_ATMEL_SOC_SSC select ATMEL_SSC? Comment?

Regards,
Axek
