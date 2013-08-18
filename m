From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 3/4] ARM: dts: Correct the /include entry on exynos5420
 dtsi file
Date: Mon, 19 Aug 2013 04:54:06 +0900
Message-ID: <5211265E.7030808@samsung.com>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com> <1373458313-18970-4-git-send-email-padma.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1373458313-18970-4-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Padmavathi Venna <padma.v@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, padma.kvr@gmail.com, sbkim73@samsung.com, broonie@kernel.org, kgene.kim@samsung.com, mturquette@linaro.org, dianders@chromium.org, abrestic@chromium.org
List-Id: alsa-devel@alsa-project.org

On 07/10/13 21:11, Padmavathi Venna wrote:
> This patch corrects the /include to #include on exynos5420
>
> Signed-off-by: Padmavathi Venna<padma.v@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5420.dtsi |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 8c54c4b..da55160 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -14,7 +14,7 @@
>    */
>
>   #include "exynos5.dtsi"
> -/include/ "exynos5420-pinctrl.dtsi"
> +#include "exynos5420-pinctrl.dtsi"
>   / {
>   	compatible = "samsung,exynos5420";
>
Applied, thanks.

- Kukjin
