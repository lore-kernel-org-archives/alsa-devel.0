From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: PXA: formatting
Date: Wed, 2 Feb 2011 10:54:12 +0000
Message-ID: <20110202105412.GB9810@sirena.org.uk>
References: <1296486650-6370-1-git-send-email-s.neumann@raumfeld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A10A61039B4
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 11:54:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296486650-6370-1-git-send-email-s.neumann@raumfeld.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sven Neumann <s.neumann@raumfeld.com>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 31, 2011 at 04:10:50PM +0100, Sven Neumann wrote:
> Signed-off-by: Sven Neumann <s.neumann@raumfeld.com>

Always CC maintainers on patch submissions as documented in
SubmittingPatches.  Adding Liam.

>  sound/soc/pxa/raumfeld.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
> index 0fd60f4..4a4b73e 100644
> --- a/sound/soc/pxa/raumfeld.c
> +++ b/sound/soc/pxa/raumfeld.c
> @@ -229,19 +229,19 @@ static struct snd_soc_dai_link raumfeld_dai[] = {
>  {
>  	.name		= "ak4104",
>  	.stream_name	= "Playback",
> -	.cpu_dai_name = "pxa-ssp-dai.1",
> -	.codec_dai_name = "ak4104-hifi",
> -	.platform_name = "pxa-pcm-audio",
> +	.cpu_dai_name	= "pxa-ssp-dai.1",
> +	.codec_dai_name	= "ak4104-hifi",
> +	.platform_name	= "pxa-pcm-audio",
>  	.ops		= &raumfeld_ak4104_ops,
> -	.codec_name = "ak4104-codec.0",
> +	.codec_name	= "ak4104-codec.0",
>  },
>  {
>  	.name		= "CS4270",
>  	.stream_name	= "CS4270",
> -	.cpu_dai_name = "pxa-ssp-dai.0",
> -	.platform_name = "pxa-pcm-audio",
> -	.codec_dai_name = "cs4270-hifi",
> -	.codec_name = "cs4270-codec.0-0048",
> +	.cpu_dai_name	= "pxa-ssp-dai.0",
> +	.platform_name	= "pxa-pcm-audio",
> +	.codec_dai_name	= "cs4270-hifi",
> +	.codec_name	= "cs4270-codec.0-0048",
>  	.ops		= &raumfeld_cs4270_ops,
>  },};
>  
> -- 
> 1.7.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
