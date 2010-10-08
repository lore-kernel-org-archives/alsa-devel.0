From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 6/10] ARM: S5PV210: Add audio clocks as sysclk
Date: Fri, 08 Oct 2010 19:18:04 +0900
Message-ID: <001c01cb66d2$1ae0b350$50a219f0$%kim@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
 <1286193468-18510-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1286193468-18510-1-git-send-email-sw.youn@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Seungwhan Youn' <sw.youn@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org
Cc: ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com
List-Id: alsa-devel@alsa-project.org

Seungwhan Youn wrote:
> 
> This patch adds audio clocks(SCLK_AUDIO{0,1,2} and SCLK_AUDIO) to be
> initial as a sysclk on boot-time.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index 195a088..3f3b7ba 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -997,6 +997,10 @@ static struct clksrc_clk *sysclks[] = {
>  	&clk_sclk_dac,
>  	&clk_sclk_pixel,
>  	&clk_sclk_hdmi,
> +	&clk_sclk_audio0,
> +	&clk_sclk_audio1,
> +	&clk_sclk_audio2,
> +	&clk_sclk_spdif,
>  };
> 
>  void __init_or_cpufreq s5pv210_setup_clocks(void)
> --

Ok...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
