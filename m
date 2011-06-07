From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH v2] wm8940: remove unnecessary if statements
Date: Tue, 07 Jun 2011 09:01:14 +0100
Message-ID: <4DEDDACA.6040403@cam.ac.uk>
References: <4DECA33E.5040306@ti.com>
	<1307393581-25202-1-git-send-email-Gregory.Dietsche@cuw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-51.csi.cam.ac.uk (ppsw-51.csi.cam.ac.uk [131.111.8.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 0215624383
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 09:53:13 +0200 (CEST)
In-Reply-To: <1307393581-25202-1-git-send-email-Gregory.Dietsche@cuw.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg Dietsche <Gregory.Dietsche@cuw.edu>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 06/06/11 21:53, Greg Dietsche wrote:
> removing unnecessary if(ret) checks
> 
> This updated patch corrects a minor spelling problem in the commit message
> and resolves two other (similar) issues found in wm8940.c by Jonathan Cameron.
> 
Thanks
> Signed-off-by: Greg Dietsche <Gregory.Dietsche@cuw.edu>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  sound/soc/codecs/wm8940.c |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
> index 25580e3..056daa0 100644
> --- a/sound/soc/codecs/wm8940.c
> +++ b/sound/soc/codecs/wm8940.c
> @@ -297,8 +297,6 @@ static int wm8940_add_widgets(struct snd_soc_codec *codec)
>  	if (ret)
>  		goto error_ret;
>  	ret = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
> -	if (ret)
> -		goto error_ret;
>  
>  error_ret:
>  	return ret;
> @@ -683,8 +681,6 @@ static int wm8940_resume(struct snd_soc_codec *codec)
>  		}
>  	}
>  	ret = wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> -	if (ret)
> -		goto error_ret;
>  
>  error_ret:
>  	return ret;
> @@ -730,9 +726,6 @@ static int wm8940_probe(struct snd_soc_codec *codec)
>  	if (ret)
>  		return ret;
>  	ret = wm8940_add_widgets(codec);
> -	if (ret)
> -		return ret;
> -
>  	return ret;
>  }
>  
