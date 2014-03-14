From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: codecs: Replace instances of
	rtd->codec with dai->codec
Date: Fri, 14 Mar 2014 12:15:20 +0200
Message-ID: <5322D6B8.2080604@ti.com>
References: <1394742294-14698-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 0215626518D
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 11:15:30 +0100 (CET)
In-Reply-To: <1394742294-14698-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, patches@opensource.wolfsonmicro.com, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/13/2014 10:24 PM, Lars-Peter Clausen wrote:
> With CODEC to CODEC links rtd->codec does not necessarily point to the driver's
> CODEC. CODEC drivers should always use dai->codec and never even look at the PCM
> runtime.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
[...]
> diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
> index d3517a9..cc1c9c2 100644
> --- a/sound/soc/codecs/tlv320aic31xx.c
> +++ b/sound/soc/codecs/tlv320aic31xx.c
> @@ -753,10 +753,9 @@ static int aic31xx_setup_pll(struct snd_soc_codec *codec,
>
>   static int aic31xx_hw_params(struct snd_pcm_substream *substream,
>   			     struct snd_pcm_hw_params *params,
> -			     struct snd_soc_dai *tmp)
> +			     struct snd_soc_dai *dai)
>   {
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_codec *codec = dai->codec;
>   	u8 data = 0;
>
>   	dev_dbg(codec->dev, "## %s: format %d width %d rate %d\n",
[...]

Concerning the part above.

Acked-by: Jyri Sarha <jsarha@ti.com>

Best regards,
Jyri
