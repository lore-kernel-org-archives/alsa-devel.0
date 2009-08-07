From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Fixed module builds of soc/fsl/*.c
Date: Fri, 7 Aug 2009 15:45:41 +0100
Message-ID: <20090807144540.GH639@sirena.org.uk>
References: <s5heirny98v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FB96103870
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 16:45:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5heirny98v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 07, 2009 at 04:44:00PM +0200, Takashi Iwai wrote:
> JFYI, I merged the patch below now.

Thanks.  CCing in Jon, who wrote the drivers, for info.

> From afc5e65245255a268ab22a20477ed2c9f2cdfcd3 Mon Sep 17 00:00:00 2001
> From: Takashi Iwai <tiwai@suse.de>
> Date: Fri, 7 Aug 2009 16:33:53 +0200
> Subject: ASoC: Add missing DRV_NAME definitions for fsl/* drivers
> 
> Module builds are broken due to missing DRV_NAME for
> efika-audio-fabric and pcm030-audio-fabric.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/fsl/efika-audio-fabric.c  |    2 ++
>  sound/soc/fsl/pcm030-audio-fabric.c |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
> index 85b0e75..3326e2a 100644
> --- a/sound/soc/fsl/efika-audio-fabric.c
> +++ b/sound/soc/fsl/efika-audio-fabric.c
> @@ -30,6 +30,8 @@
>  #include "mpc5200_psc_ac97.h"
>  #include "../codecs/stac9766.h"
>  
> +#define DRV_NAME "efika-audio-fabric"
> +
>  static struct snd_soc_device device;
>  static struct snd_soc_card card;
>  
> diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
> index 8766f7a..b928ef7 100644
> --- a/sound/soc/fsl/pcm030-audio-fabric.c
> +++ b/sound/soc/fsl/pcm030-audio-fabric.c
> @@ -30,6 +30,8 @@
>  #include "mpc5200_psc_ac97.h"
>  #include "../codecs/wm9712.h"
>  
> +#define DRV_NAME "pcm030-audio-fabric"
> +
>  static struct snd_soc_device device;
>  static struct snd_soc_card card;
>  
> -- 
> 1.6.3.3
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
