From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: ASoC: SAMSUNG: Change Kconfig to support all EXYNOSs
Date: Mon, 27 Aug 2012 11:06:47 -0700
Message-ID: <503BB737.7090004@samsung.com>
References: <003001cd8361$7016a110$5043e330$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <003001cd8361$7016a110$5043e330$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?EUC-KR?B?udq787z2?= <sangsu4u.park@samsung.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com, sbkim73@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com
List-Id: alsa-devel@alsa-project.org

On 08/26/12 01:04, =B9=DA=BB=F3=BC=F6 wrote:
> All EXYNOSs use SND_SOC_SAMSUNG configuration.
> This patch change Kconfig to support all EXYNOSs like EXYNOS4 and EXY=
NOS5.
>=20
> Signed-off-by: Sangsu Park<sangsu4u.park@samsung.com>
> ---
>   sound/soc/samsung/Kconfig |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index f17dd25..9e64ae6 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -1,6 +1,6 @@
>   config SND_SOC_SAMSUNG
>   	tristate "ASoC support for Samsung"
> -	depends on ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5P=
V210 || ARCH_S5P64X0 ||
> ARCH_EXYNOS4
> +	depends on ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5P=
V210 || ARCH_S5P64X0 ||
> ARCH_EXYNOS

Hmm, all of Samsung stuff is available...so how about?

+	depends on PLAT_SAMSUNG

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
