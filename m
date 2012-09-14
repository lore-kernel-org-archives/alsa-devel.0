From: agust@denx.de
Subject: Re: [PATCH 1/7] powerpc/52xx: define FSL_SOC
Date: Fri, 14 Sep 2012 11:31:00 +0200
Message-ID: <20120914113100.119048xeot7zcym8@webmail.mnet-online.de>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-2-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1347572596-37540-2-git-send-email-emillbrandt@dekaresearch.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Eric Millbrandt <emillbrandt@dekaresearch.com> wrote:

> mpc52xx socs need to have FSL_SOC defined to build their drivers  
> (i2c-mpc, ASoC)

No, i2c-mpc depends on PPC only. And FSL_SOC enables code we do not
use on mpc52xx. For ASoC please see comment below.

> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
>
> diff --git a/arch/powerpc/platforms/52xx/Kconfig  
> b/arch/powerpc/platforms/52xx/Kconfig
> index 90f4496..fb35944 100644
> --- a/arch/powerpc/platforms/52xx/Kconfig
> +++ b/arch/powerpc/platforms/52xx/Kconfig
> @@ -1,6 +1,7 @@
>  config PPC_MPC52xx
>  	bool "52xx-based boards"
>  	depends on 6xx
> +	select FSL_SOC

Better use:

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d701330..4563b28 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -6,7 +6,7 @@ config SND_SOC_FSL_UTILS

  menuconfig SND_POWERPC_SOC
         tristate "SoC Audio for Freescale PowerPC CPUs"
-       depends on FSL_SOC
+       depends on FSL_SOC || PPC_MPC52xx
         help
           Say Y or M if you want to add support for codecs attached to
           the PowerPC CPUs.

Thanks,

Anatolij
