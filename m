From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] ASoC: Samsung: Fix build error
Date: Fri, 10 Aug 2012 15:03:16 +0900
Message-ID: <0dd201cd76bd$d57df270$8079d750$%kim@samsung.com>
References: <1344405883-27603-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1344405883-27603-1-git-send-email-sachin.kamat@linaro.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, patches@linaro.org, sbkim73@samsung.com
List-Id: alsa-devel@alsa-project.org

Sachin Kamat wrote:
>=20
> Fixes the following build error:
> In file included from arch/arm/mach-exynos/include/mach/dma.h:24:0,
> 		from arch/arm/plat-samsung/include/plat/dma-ops.h:17,
> 		from arch/arm/plat-samsung/include/plat/dma.h:128,
> 		from sound/soc/samsung/pcm.c:23:
> arch/arm/plat-samsung/include/plat/dma-pl330.h:106:8:
> 			error: redefinition of =E2=80=98struct s3c2410_dma_client=E2=80=99
> arch/arm/plat-samsung/include/plat/dma.h:40:8: note: originally defin=
ed
> here
> make[3]: *** [sound/soc/samsung/pcm.o] Error 1
>=20
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>

BTW, Sachin, do you _really_ need to keep above double signoff with dif=
ferent e-mail?

I think, last one should be removed? Because in the field of author, 'l=
inaro.org' e-mail is used?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
