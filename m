From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix S24_LE and U24_LE
 support
Date: Thu, 26 Jun 2014 09:29:42 +0200
Message-ID: <53ABCBE6.7040906@zonque.org>
References: <1403759364-14524-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ED6E264F23
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 09:29:44 +0200 (CEST)
In-Reply-To: <1403759364-14524-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/26/2014 07:09 AM, Peter Ujfalusi wrote:
> In case of S24_LE/U24_LE modes we expect 24bits on the bus while the samples
> are stored and transferred in memory on 32bits (lower 3 bytes of the 4
> bytes).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Tested-by: Daniel Mack <daniel@zonque.org>


Thanks!
Daniel

> ---
>  sound/soc/davinci/davinci-mcasp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 9afb14629a17..6d5de26eae2f 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -720,6 +720,10 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
>  
>  	case SNDRV_PCM_FORMAT_U24_LE:
>  	case SNDRV_PCM_FORMAT_S24_LE:
> +		dma_params->data_type = 4;
> +		word_length = 24;
> +		break;
> +
>  	case SNDRV_PCM_FORMAT_U32_LE:
>  	case SNDRV_PCM_FORMAT_S32_LE:
>  		dma_params->data_type = 4;
> 
