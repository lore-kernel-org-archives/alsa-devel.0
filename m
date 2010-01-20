From: "Chaithrika U S" <chaithrika@ti.com>
Subject: Re: [PATCH] ASoC: DaVinci: Fix stream restart error
Date: Wed, 20 Jan 2010 17:37:05 +0530
Message-ID: <008d01ca99c9$14f83ed0$3ee8bc70$@com>
References: <1263987285-29775-1-git-send-email-alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 328D7244FA
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 13:10:20 +0100 (CET)
In-Reply-To: <1263987285-29775-1-git-send-email-alsa-devel@alsa-project.org>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: khilman@deeprootsystems.com, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

All,

Please ignore this patch, missed the 'To' address in the mail.
I have re-submitted this patch.

Regards, 
Chaithrika

On Wed, Jan 20, 2010 at 17:04:45, alsa-devel@alsa-project.org wrote:
> From: Chaithrika U S <chaithrika@ti.com>
> 
> Sometimes after a suspend-resume cycle, the ALSA application
> restarts the stream when resume fails and McASP fails to work
> as the clock is not enabled. This patch corrects this bug.
> 
> Testes on TI DA850/OMAP-L138 EVM.
> 
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> ---
> Applies to ALSA GIT tree on branch topic/asoc at
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
> h=topic/asoc
> 
>  sound/soc/davinci/davinci-mcasp.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index a613bbb..ab6518d 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -768,13 +768,12 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
>  
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		if (!dev->clk_active) {
>  			clk_enable(dev->clk);
>  			dev->clk_active = 1;
>  		}
> -		/* Fall through */
> -	case SNDRV_PCM_TRIGGER_START:
> -	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		davinci_mcasp_start(dev, substream->stream);
>  		break;
>  
> -- 
> 1.5.6
> 
