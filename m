From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: avoid limiting
 params->msbits in hw_params()
Date: Fri, 1 Mar 2019 11:10:30 +0200
Message-ID: <07f53ffe-a1ba-59a7-986b-0fa384e96952@ti.com>
References: <E1gzNdw-00059M-54@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCAE1F896E0
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 10:10:38 +0100 (CET)
In-Reply-To: <E1gzNdw-00059M-54@rmk-PC.armlinux.org.uk>
Content-Language: en-GB
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Russell King <rmk+kernel@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 28/02/2019 17:30, Russell King wrote:
> Limiting the value of the passed in params->msbits in the hw_params()
> callback is redundant on three counts:
> 
> 1. We already specify in the DAI driver that we can only handle up to
>    24 bits.  This means msbits will be limited to 24 via the ALSA
>    constraints imposed by the ASoC core, unless we have multiple codecs
>    that can handle more bits.
> 
> 2. Nothing in our hw_params() implementation uses this value.
> 
> 3. The copy of the params that we are passed by the ASoC core never
>    reads back the msbits value.
> 
> Consequently, this code is unnecessary and does nothing useful.  Remove
> it.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Jyri Sarha <jsarha@ti.com>

> ---
>  sound/soc/codecs/hdmi-codec.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index d5f73c837281..35df73e42cbc 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -484,9 +484,6 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
>  		params_width(params), params_rate(params),
>  		params_channels(params));
>  
> -	if (params_width(params) > 24)
> -		params->msbits = 24;
> -
>  	ret = snd_pcm_create_iec958_consumer_hw_params(params, hp.iec.status,
>  						       sizeof(hp.iec.status));
>  	if (ret < 0) {
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
