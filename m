From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Add ASRC support
Date: Sat, 08 Nov 2014 09:18:04 +0100
Message-ID: <545DD1BC.9000208@metafoo.de>
References: <1414741076-26685-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-036.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C5C8260453
 for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2014 09:18:00 +0100 (CET)
In-Reply-To: <1414741076-26685-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 10/31/2014 08:37 AM, bardliao@realtek.com wrote:
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index bc442f4..3131e91 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -443,6 +443,65 @@ static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_sel_enum,
>   				RT5645_TDM_CTRL_1, 8,
>   				rt5645_tdm_adc_data_select);
>
> +static int rt5645_clk_sel_put(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> [...]
 > +}

This function seems to be completely unused.
