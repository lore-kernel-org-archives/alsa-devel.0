From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M
Date: Thu, 13 Dec 2018 09:55:11 +0800
Message-ID: <20181213015509.GA11997@dragon>
References: <1544647253-3806-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1544647253-3806-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-imx@nxp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 12, 2018 at 06:40:53PM -0200, Fabio Estevam wrote:
> eukrea-tlv320.c machine driver runs on non-DT platforms
> and include <asm/mach-types.h> header file in order to be able
> to use some machine_is_eukrea_xxx() macros.
> 
> Since commit 0e1532bfecf4 ("arm64: add basic Kconfig symbols for i.MX8")
> the ARCH_MXC symbol is visible on ARM64 too.
> 
> Building it for ARM64 causes the following build error:
> 
> sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory
> 
> Avoid this error by not allowing to build the SND_SOC_EUKREA_TLV320
> driver when ARM64 is selected.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Hi Mark,
> 
> Commit commit 0e1532bfecf4 ("arm64: add basic Kconfig symbols for i.MX8")
> is present in Shawn's tree, so maybe this should be taken by Shawn?

I would suggest you drop the mentioning of the commit from your commit
log, so that Mark can take the patch as a preparation for i.MX8 landing.

Shawn

> 
>  sound/soc/fsl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 6ec19fb..2e75b5b 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -221,7 +221,7 @@ config SND_SOC_PHYCORE_AC97
>  
>  config SND_SOC_EUKREA_TLV320
>  	tristate "Eukrea TLV320"
> -	depends on ARCH_MXC && I2C
> +	depends on ARCH_MXC && !ARM64 && I2C
>  	select SND_SOC_TLV320AIC23_I2C
>  	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_IMX_SSI
> -- 
> 2.7.4
> 
