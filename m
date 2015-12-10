From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 05/13] ASoC: wm_adsp: Select
	SND_SOC_COMPRESS
Date: Thu, 10 Dec 2015 13:39:47 +0530
Message-ID: <20151210080947.GS1854@localhost>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1449590917-21170-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 09F85261721
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 09:06:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1449590917-21170-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 08, 2015 at 04:08:29PM +0000, Charles Keepax wrote:
> Additions to the DSP mean we will need to include support for the
> compressed framework. This patch selects SND_SOC_COMPRESS.

probably this should be sqashed to the 6th one where you add the compress DAI

> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index c0c5c8e..2b51aff 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -218,6 +218,7 @@ config SND_SOC_WM_HUBS
>  
>  config SND_SOC_WM_ADSP
>  	tristate
> +	select SND_SOC_COMPRESS
>  	default y if SND_SOC_CS47L24=y
>  	default y if SND_SOC_WM5102=y
>  	default y if SND_SOC_WM5110=y
> -- 
> 2.1.4
> 

-- 
~Vinod
