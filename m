From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/6] ASoC: sn95031: Use table based control
	setup
Date: Wed, 5 Nov 2014 17:42:38 +0530
Message-ID: <20141105121238.GM1870@intel.com>
References: <1415180796-31129-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 261942606A5
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 13:12:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1415180796-31129-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dan Murphy <dmurphy@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 05, 2014 at 10:46:31AM +0100, Lars-Peter Clausen wrote:
> Makes the code a bit cleaner.
Looks good to me,

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/codecs/sn95031.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
> index cf8fa40..6167c59 100644
> --- a/sound/soc/codecs/sn95031.c
> +++ b/sound/soc/codecs/sn95031.c
> @@ -867,9 +867,6 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
>  	snd_soc_write(codec, SN95031_SSR2, 0x10);
>  	snd_soc_write(codec, SN95031_SSR3, 0x40);
>  
> -	snd_soc_add_codec_controls(codec, sn95031_snd_controls,
> -			     ARRAY_SIZE(sn95031_snd_controls));
> -
>  	return 0;
>  }
>  
> @@ -886,6 +883,9 @@ static struct snd_soc_codec_driver sn95031_codec = {
>  	.remove		= sn95031_codec_remove,
>  	.set_bias_level	= sn95031_set_vaud_bias,
>  	.idle_bias_off	= true,
> +
> +	.controls	= sn95031_snd_controls,
> +	.num_controls	= ARRAY_SIZE(sn95031_snd_controls),
>  	.dapm_widgets	= sn95031_dapm_widgets,
>  	.num_dapm_widgets	= ARRAY_SIZE(sn95031_dapm_widgets),
>  	.dapm_routes	= sn95031_audio_map,
> -- 
> 1.8.0
> 

-- 
