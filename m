From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/7] ASoC: Samsung: Fix build regressions
	due to gpio re-org
Date: Wed, 22 Jan 2014 08:56:56 +0100
Message-ID: <CACRpkdZ05LPRB_MdM4ZaJtSYRVM294aW4h9DC04wc__8rSyxjA@mail.gmail.com>
References: <1390371213-21643-1-git-send-email-sachin.kamat@linaro.org>
 <1390371213-21643-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f44.google.com (mail-oa0-f44.google.com
 [209.85.219.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C760F2610A0
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 08:56:57 +0100 (CET)
Received: by mail-oa0-f44.google.com with SMTP id g12so40292oah.31
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 23:56:56 -0800 (PST)
In-Reply-To: <1390371213-21643-2-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Patch Tracking <patches@linaro.org>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 22, 2014 at 7:13 AM, Sachin Kamat <sachin.kamat@linaro.org> wro=
te:

> Recent changes through commits c67d0f29262b ("ARM: s3c24xx: get rid
> of custom <mach/gpio.h>"), b0161caa72b6 ("ARM: S3C[24|64]xx: move includes
> back under <mach/> scope"), 364374121b78 ("ARM: s3c24xx: explicit
> dependency on <plat/gpio-cfg.h>") and 41c3548e6da6 ("ARM: s3c64xx: get rid
> of custom <mach/gpio.h>") caused build regressions due to broken
> dependencies. Fix the following errors by including the necessary header
> files explicitly:
>
> sound/soc/samsung/h1940_uda1380.c:56:3: error: implicit declaration of fu=
nction =91S3C2410_GPG=92
> sound/soc/samsung/h1940_uda1380.c:149:18: error: =91S3C_GPIO_END=92 undec=
lared (first use in this function)
> sound/soc/samsung/h1940_uda1380.c:234:21: error: =91S3C_GPIO_END=92 undec=
lared (first use in this function)
> sound/soc/samsung/h1940_uda1380.c:270:12: error: =91S3C_GPIO_END=92 undec=
lared (first use in this function)
> sound/soc/samsung/neo1973_wm8753.c:239:2: error: implicit declaration of =
function =91S3C2410_GPJ=92
> sound/soc/samsung/rx1950_uda1380.c:67:3: error: implicit declaration of f=
unction =91S3C2410_GPG=92
> sound/soc/samsung/s3c2412-i2s.c:86:2: error: implicit declaration of func=
tion =91s3c_gpio_cfgall_range=92
> sound/soc/samsung/s3c2412-i2s.c:86:2: error: implicit declaration of func=
tion =91S3C2410_GPE=92
> sound/soc/samsung/s3c2412-i2s.c:86:2: error: implicit declaration of func=
tion =91S3C_GPIO_SFN=92
> sound/soc/samsung/s3c2412-i2s.c:87:10: error: =91S3C_GPIO_PULL_NONE=92 un=
declared
> sound/soc/samsung/s3c24xx-i2s.c:394:2: error: implicit declaration of fun=
ction =91s3c_gpio_cfgall_range=92
> sound/soc/samsung/s3c24xx-i2s.c:394:2: error: implicit declaration of fun=
ction =91S3C2410_GPE=92
> sound/soc/samsung/s3c24xx-i2s.c:394:2: error: implicit declaration of fun=
ction =91S3C_GPIO_SFN=92
> sound/soc/samsung/s3c24xx-i2s.c:395:10: error: =91S3C_GPIO_PULL_NONE=92 u=
ndeclared
> sound/soc/samsung/smartq_wm8987.c:112:3: error: implicit declaration of f=
unction =91S3C64XX_GPL=92
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

And I *really* tried to catch all these, could we make this driver
part of the defconfig
if it isn't?

Yours,
Linus Walleij
