From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [alsa-devel] [PATCH V4 0/2]  refine esai for tdm support
Date: Fri, 8 Aug 2014 14:42:43 +0800
Message-ID: <20140808064243.GA6333@MrMyself>
References: <cover.1407480333.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1407480333.git.shengjiu.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, timur@tabi.org, perex@perex.cz, tiwai@suse.de, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, shc_work@mail.ru, fabio.estevam@freescale.com, arnd@arndb.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 08, 2014 at 02:47:20PM +0800, Shengjiu Wang wrote:
> These patchs is to refine esai for tdm support.
> 
> Changes for V4
> - update the comments for patch 2
> 
> Changes for V3
> - update the comments for patch 2
> 
> Changes for V2
> - update the comments according the reviewer's suggestion
> - add init value for slots and change pin to pins.
> 
> 
> Shengjiu Wang (2):
>   ASoC: fsl_esai: refine esai for TDM support
>   Revert "ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support."
> 
>  sound/soc/fsl/Kconfig    |    1 -
>  sound/soc/fsl/fsl_esai.c |   16 +++++++++++-----
>  sound/soc/fsl/fsl_esai.h |    8 ++++----
>  3 files changed, 15 insertions(+), 10 deletions(-)

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you

> 
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
