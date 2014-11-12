From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: rt5670: check if asrc is useable
Date: Wed, 12 Nov 2014 20:42:38 +0100
Message-ID: <5463B82E.7070303@metafoo.de>
References: <1415793273-7844-1-git-send-email-bardliao@realtek.com>
 <1415793273-7844-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-122.synserver.de (smtp-out-130.synserver.de
 [212.40.185.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B40A26592E
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 20:41:58 +0100 (CET)
In-Reply-To: <1415793273-7844-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, mengdong.lin@intel.com, lgirdwood@gmail.com, broonie@kernel.org, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 11/12/2014 12:54 PM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>
> To use ASRC, the sysclk should be faster than 384 times sample
> rate of I2S1.
>
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> ---
>   sound/soc/codecs/rt5670.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
> index 85dc210..898b17f 100644
> --- a/sound/soc/codecs/rt5670.c
> +++ b/sound/soc/codecs/rt5670.c
> @@ -575,6 +575,17 @@ static int is_using_asrc(struct snd_soc_dapm_widget *source,
>
>   }
>
> +static int can_use_asrc(struct snd_soc_dapm_widget *source,
> +			 struct snd_soc_dapm_widget *sink)
> +{
> +	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(source->codec);

Can you start using snd_soc_dapm_to_codec(source->dapm) instead of 
source->codec? The codec field will eventually be removed.

Bonus points for fixing up the existing w->codec users in rt drivers.

Thanks,
- Lars
