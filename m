From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: mid-x86: Fix dependency on intel_sst
	driver
Date: Sun, 06 Feb 2011 14:42:01 +0000
Message-ID: <1297003321.3315.163.camel@odin>
References: <1296986748-22614-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 28D5024449
	for <alsa-devel@alsa-project.org>; Sun,  6 Feb 2011 15:42:06 +0100 (CET)
Received: by wwe15 with SMTP id 15so3837332wwe.20
	for <alsa-devel@alsa-project.org>; Sun, 06 Feb 2011 06:42:05 -0800 (PST)
In-Reply-To: <1296986748-22614-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Harsha Priya <priya.harsha@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-02-06 at 15:35 +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> Enabling medfield asoc driver causes compliation error when intel_sst
> is not selected
> ERROR: "register_sst_card" [sound/soc/mid-x86/snd-soc-sst-platform.ko]
> undefined!
> 
> This patch puts proper dependency to elimate build error
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  sound/soc/mid-x86/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/mid-x86/Kconfig b/sound/soc/mid-x86/Kconfig
> index 1ad7538..2935042 100644
> --- a/sound/soc/mid-x86/Kconfig
> +++ b/sound/soc/mid-x86/Kconfig
> @@ -1,6 +1,7 @@
>  config SND_MFLD_MACHINE
>  	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
>  	depends on INTEL_SCU_IPC
> +	depends on SND_INTEL_SST
>  	select SND_SOC_SN95031
>  	select SND_SST_PLATFORM
>  	help
> @@ -11,4 +12,3 @@ config SND_MFLD_MACHINE
>  
>  config SND_SST_PLATFORM
>  	tristate
> -	depends on SND_INTEL_SST

Acked-by: liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
