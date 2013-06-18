From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 1/2] ASoC: spear: Remove nonexistant EVM
	options
Date: Tue, 18 Jun 2013 09:48:56 +0530
Message-ID: <51BFDFB0.5000006@st.com>
References: <1371456427-31648-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
 [207.126.144.137])
 by alsa0.perex.cz (Postfix) with ESMTP id D3ED9261A5F
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2013 06:19:01 +0200 (CEST)
In-Reply-To: <1371456427-31648-1-git-send-email-broonie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 6/17/2013 1:37 PM, Mark Brown wrote:
> The source wasn't added.
>
> Stephen Rothwell<sfr@canb.auug.org.au>
> Signed-off-by: Mark Brown<broonie@linaro.org>
> ---
>   sound/soc/spear/Kconfig  |   21 ---------------------
>   sound/soc/spear/Makefile |    3 ---
>   2 files changed, 24 deletions(-)
>
> diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
> index e3851d6..3567d73 100644
> --- a/sound/soc/spear/Kconfig
> +++ b/sound/soc/spear/Kconfig
> @@ -1,24 +1,3 @@
> -config SND_SPEAR_EVM
> -	tristate "SoC Audio support for SPEAr EVM"
> -	select SND_DESIGNWARE_I2S
> -	select SND_SOC_STA529
> -	select SND_SPEAR_SOC
> -	help
> -	 Say Y if you want to add support for SoC audio on SPEAr
> -	 platform
> -
> -config SND_SPEAR1340_EVM
> -	tristate "SoC Audio support for SPEAr1340 EVM"
> -	select SND_DESIGNWARE_I2S
> -	select SND_SOC_STA529
> -	select SND_SPEAR_SPDIF_OUT
> -	select SND_SPEAR_SPDIF_IN
> -	select SND_SOC_SPDIF
> -	select SND_SPEAR_SOC
> -	help
> -	 Say Y if you want to add support for SoC audio on SPEAr1340
> -	 platform
> -
>   config SND_SPEAR_SOC
>   	tristate
>   	select SND_SOC_DMAENGINE_PCM
> diff --git a/sound/soc/spear/Makefile b/sound/soc/spear/Makefile
> index b365126..9f47bb4 100644
> --- a/sound/soc/spear/Makefile
> +++ b/sound/soc/spear/Makefile
> @@ -2,6 +2,3 @@
>   obj-$(CONFIG_SND_SPEAR_SOC) += spear_pcm.o
>   obj-$(CONFIG_SND_SPEAR_SPDIF_IN) += spdif_in.o
>   obj-$(CONFIG_SND_SPEAR_SPDIF_OUT) += spdif_out.o
> -
> -# SPEAR Machine Support
> -obj-$(CONFIG_SND_SPEAR_EVM) += spear_evb.o


Acked-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
