From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Fix for master playback/capture
	volume range for TWL4030 codec
Date: Fri, 14 Nov 2008 10:11:22 +0000
Message-ID: <20081114101120.GB21573@sirena.org.uk>
References: <1226645848-32080-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BC7A710380E
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 11:11:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226645848-32080-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 14, 2008 at 08:57:28AM +0200, Peter Ujfalusi wrote:
> FGAIN for playback is in range of 0-0x3f, while for capture GAIN it
> is in the range of 0-0x1f.
> The original value of 128 (0x7f) would modify the CGAIN also for
> playback.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

CCing in Steve Sakoman who wrote the driver.

> ---
>  sound/soc/codecs/twl4030.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 90f3b4d..65aeabe 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -192,10 +192,10 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
>  static const struct snd_kcontrol_new twl4030_snd_controls[] = {
>  	SOC_DOUBLE_R("Master Playback Volume",
>  		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> -		0, 127, 0),
> +		0, 0x3f, 0),
>  	SOC_DOUBLE_R("Capture Volume",
>  		 TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
> -		0, 127, 0),
> +		0, 0x1f, 0),
>  };
>  
>  /* add non dapm controls */
> -- 
> 1.6.0.3
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
