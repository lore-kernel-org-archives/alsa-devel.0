From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: samsung dma - Don't indicate support
 for pause/resume.
Date: Fri, 31 Aug 2012 10:41:36 -0700
Message-ID: <20120831174135.GF25575@opensource.wolfsonmicro.com>
References: <1346387854-22222-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5DA3A266488
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 19:41:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346387854-22222-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, ben-linux@fluff.org, padma.v@samsung.com, clemens@ladisch.de, alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 30, 2012 at 09:37:34PM -0700, Dylan Reid wrote:

> index f3ebc38..56a507a 100644
> --- a/sound/soc/samsung/dma.c
> +++ b/sound/soc/samsung/dma.c
> @@ -34,9 +34,7 @@ static const struct snd_pcm_hardware dma_hardware = {
>  	.info			= SNDRV_PCM_INFO_INTERLEAVED |
>  				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  				    SNDRV_PCM_INFO_MMAP |
> -				    SNDRV_PCM_INFO_MMAP_VALID |
> -				    SNDRV_PCM_INFO_PAUSE |
> -				    SNDRV_PCM_INFO_RESUME,
> +				    SNDRV_PCM_INFO_MMAP_VALID,

I'd expect to also see an update to the trigger function to not accept
the suspend and resume triggers?
