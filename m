From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ASoC: DaVinci: Update suspend/resume
 support for McASP driver
Date: Thu, 03 Dec 2009 16:00:19 +0300
Message-ID: <4B17B663.70206@ru.mvista.com>
References: <1259737740-27324-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap.sh.mvista.com (gateway-1237.mvista.com [206.112.117.35])
	by alsa0.perex.cz (Postfix) with SMTP id 40F2E24444
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 13:59:16 +0100 (CET)
In-Reply-To: <1259737740-27324-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Hello.

Chaithrika U S wrote:

> Add clock enable and disable calls to resume and suspend respectively.
> Also add a member to the audio device data structure which tracks the clock
> status.

> Tested on DA850/OMAP-L138 EVM. For the purpose of testing, the patches[1] which 
> add suspend-to-RAM support to DA850/OMAP-L138 SoC were applied.

> [1] http://linux.davincidsp.com/pipermail/davinci-linux-open-source/
> 2009-November/016958.html

> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> ---

[...]

> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 0a302e1..0d263f1 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -767,14 +767,27 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
>  	int ret = 0;
>  
>  	switch (cmd) {
> -	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
> +		if (!dev->clk_active) {
> +			clk_enable(dev->clk);
> +			dev->clk_active = 1;
> +		}

   You should add a comment in the cases where *break* is ommitted 
deliberately (if it indeed is), like:

		/* FALL THRU */

> +
> +	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		davinci_mcasp_start(dev, substream->stream);
>  		break;
>  

WBR, Sergei
