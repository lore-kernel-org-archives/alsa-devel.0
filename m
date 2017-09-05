From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: wm8741: Set SR mode in
	hw_params()
Date: Tue, 5 Sep 2017 17:23:00 +0100
Message-ID: <20170905162300.zrmwyz3niarqzcr4@localhost.localdomain>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-4-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 71432266C6D
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 18:23:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1504553653-8144-4-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 04, 2017 at 09:34:13PM +0200, Sergej Sawazki wrote:
> Set the ratio of MCLK/LRCLK in hw_params() instead of relying on the
> auto-detection.
> 
> The ratio of MCLK/LRCLK is known to the driver, there is no need to let
> the device to detect it.
> 

But also no reason to not let it do so, are there some problems
with the auto-detect?

> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
> ---
>  sound/soc/codecs/wm8741.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
> index 7e8a7fe..534741b 100644
> --- a/sound/soc/codecs/wm8741.c
> +++ b/sound/soc/codecs/wm8741.c
> @@ -198,7 +198,6 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
>  	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
>  	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1FC;
>  	u16 mode = snd_soc_read(codec, WM8741_MODE_CONTROL_1) & 0x183;
> -	int i;
>  
>  	/* The set of sample rates that can be supported depends on the
>  	 * MCLK supplied to the CODEC - enforce this.
> @@ -209,13 +208,27 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
>  
> -	/* Find a supported LRCLK rate */
> -	for (i = 0; i < wm8741->sysclk_constraints->count; i++) {
> -		if (wm8741->sysclk_constraints->list[i] == params_rate(params))
> -			break;
> -	}

This looks like it should be in a separate patch, is removing
this part of this patch? It feels like the constraints should
have already been applied by startup so we should never be able
to fail here in hw_params, is that why you are removing it?

Thanks,
Charles
