From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: gta02: fix includes
Date: Tue, 13 Oct 2009 01:22:15 +0200
Message-ID: <4AD3BA27.5000905@metafoo.de>
References: <20091012201700.042515646@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 98F542438E
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 01:22:06 +0200 (CEST)
In-Reply-To: <20091012201700.042515646@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Simtec Linux Team <linux@simtec.co.uk>
List-Id: alsa-devel@alsa-project.org

>Ben Dooks wrote:
>The gta02 build is missing <mach/regs-gpio.h> and is also using the
>incorrect <asm/io.h> header (it should be <linux/io.h>). Fix these
>two problems.
>
>Signed-off-by: Ben Dooks <ben@simtec.co.uk>
>Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>
>
>---
> sound/soc/s3c24xx/neo1973_gta02_wm8753.c |    4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

>Index: b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
>===================================================================
>--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c    2009-10-10
22:55:53.000000000 +0100
>+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c    2009-10-10
22:58:31.000000000 +0100
>@@ -19,6 +19,8 @@
> #include <linux/interrupt.h>
> #include <linux/platform_device.h>
> #include <linux/gpio.h>
>+#include <linux/io.h>
>+
> #include <sound/core.h>
> #include <sound/pcm.h>
> #include <sound/soc.h>
>@@ -29,7 +31,7 @@
> #include <plat/regs-iis.h>
 
> #include <mach/regs-clock.h>
>-#include <asm/io.h>
>+#include <mach/regs-gpioj.h>

This file is not using any of the symbols from regs-gpioh.h directly.
It only uses GTA02_GPIO_{HP_IN,AMP_SHUT} from gta02.h which are
defined as S3C2440_GPJX.
So the include of regs-gpioj.h should rather go into gta02.h than here.

- Lars
