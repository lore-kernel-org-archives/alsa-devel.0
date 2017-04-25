From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tas2552: Propagate the error code in
	suspend/resume
Date: Tue, 25 Apr 2017 07:12:08 -0500
Message-ID: <b04cd27d-c88c-f0ae-27bc-df5124d04c02@ti.com>
References: <1493081029-23975-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 41DEA2667E7
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 14:12:16 +0200 (CEST)
In-Reply-To: <1493081029-23975-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/24/2017 07:43 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> tas2552_suspend() and tas2552_resume() currently always return success,
> even though they may fail.
> 
> Fix this behaviour by always propagating the error code.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Dan Murphy <dmurphy@ti.com>

> ---
>  sound/soc/codecs/tas2552.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
> index fd5251e..8840f72 100644
> --- a/sound/soc/codecs/tas2552.c
> +++ b/sound/soc/codecs/tas2552.c
> @@ -637,7 +637,7 @@ static int tas2552_suspend(struct snd_soc_codec *codec)
>  	if (ret != 0)
>  		dev_err(codec->dev, "Failed to disable supplies: %d\n",
>  			ret);
> -	return 0;
> +	return ret;
>  }
>  
>  static int tas2552_resume(struct snd_soc_codec *codec)
> @@ -653,7 +653,7 @@ static int tas2552_resume(struct snd_soc_codec *codec)
>  			ret);
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  #else
>  #define tas2552_suspend NULL
> 


-- 
------------------
Dan Murphy
