From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: Tegra and i.MX are mutually exclusive
Date: Mon, 24 Jun 2013 09:28:08 -0600
Message-ID: <51C86588.5020606@wwwdotorg.org>
References: <5967649.DUvDfofhX4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id CC91C2650C6
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 17:28:12 +0200 (CEST)
In-Reply-To: <5967649.DUvDfofhX4@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On 06/24/2013 09:04 AM, Arnd Bergmann wrote:
> Both Tegra and i.MX provide ac97 operations, which can only
> exist once in the kernel. They can both be built as loadable
> modules (only one of them needs to be loaded anyway), but we
> have to disallow enabling them both as built-in.

> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig

>  menuconfig SND_IMX_SOC
>  	tristate "SoC Audio for Freescale i.MX CPUs"
>  	depends on ARCH_MXC
> +	depends on SND_SOC_TEGRA=n || (SND_SOC_TEGRA=m && m)

I can easily see how this prevents adding SND_IMX_SOC to a config if
SND_SOC_TEGRA is enabled, but I'm not sure about the other way around;
does Kconfig check that adding a new SND_SOC_TEGRA wouldn't invalidate
any of the depends of any already-selected options?

In other words, do you need to make the "same" change to Tegra?
