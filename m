From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau1701: Add 44.1 KHz to supported
	sample rates
Date: Tue, 20 Oct 2015 11:10:57 +0200
Message-ID: <56260521.6080805@metafoo.de>
References: <1444907766-9892-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 7806126621A
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 11:10:58 +0200 (CEST)
In-Reply-To: <1444907766-9892-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pascal.huerst@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/15/2015 01:16 PM, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
> 
> According to the datasheet, this device does also support 44.1 KHz
> as sample rate. This adds the necessary changes to support this.
> 
> See Datasheet: Rev. B / page 39 / SR[1:0]
> 
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>

Hm, right. The sample rates that part can run at depend on the external
clock rate. It can run at ext_clk / 256, ext_clk / 128 or ext_clk / 64.
Maybe we should just implement it like that.

Do you have support for switching the external clock at runtime on your
platform?

> ---
>  sound/soc/codecs/adau1701.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index de53c0d..8b3ba51 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -459,6 +459,7 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
>  	case 96000:
>  		val = ADAU1701_DSPCTRL_SR_96;
>  		break;
> +	case 44100:
>  	case 48000:
>  		val = ADAU1701_DSPCTRL_SR_48;
>  		break;
> @@ -623,8 +624,8 @@ static int adau1701_startup(struct snd_pcm_substream *substream,
>  	return sigmadsp_restrict_params(adau1701->sigmadsp, substream);
>  }
>  
> -#define ADAU1701_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
> -	SNDRV_PCM_RATE_192000)
> +#define ADAU1701_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
> +	SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
>  
>  #define ADAU1701_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
>  	SNDRV_PCM_FMTBIT_S24_LE)
> 
