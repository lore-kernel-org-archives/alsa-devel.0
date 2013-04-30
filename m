From: walter harms <wharms@bfs.de>
Subject: Re: [patch] ASoC: wm8994: missing break in
	wm8994_aif3_hw_params()
Date: Tue, 30 Apr 2013 09:49:34 +0200
Message-ID: <517F778E.3020700@bfs.de>
References: <20130430072441.GB7237@elgon.mountain>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx01.sz.bfs.de (mx01.sz.bfs.de [194.94.69.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 99413264F2D
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2013 09:50:07 +0200 (CEST)
In-Reply-To: <20130430072441.GB7237@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



Am 30.04.2013 09:24, schrieb Dan Carpenter:
> The missing break here means that we always return early and the
> function is a no-op.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 14094f5..1eb152c 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -2882,6 +2882,7 @@ static int wm8994_aif3_hw_params(struct snd_pcm_substream *substream,
>  		default:
>  			return 0;
>  		}
> +		break;
>  	default:
>  		return 0;
>  	}


the patch seems ok, but i would question the wisdom of a nested switch here,
obviously the readability suffers and since it is only one case it seems
better to be replaced it with

if (dai->id != 3) return 0;

Please can the maintainer comment on that ?

just my 2 cents,
 wh
