From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: sam9x5_wm8731: change to work in
	DSP A mode
Date: Wed, 04 Dec 2013 12:38:12 +0100
Message-ID: <529F1424.7040501@gmail.com>
References: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
 <1386124624-22414-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
 [74.125.82.182])
 by alsa0.perex.cz (Postfix) with ESMTP id D849226537B
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 12:38:29 +0100 (CET)
Received: by mail-we0-f182.google.com with SMTP id q59so15173521wes.27
 for <alsa-devel@alsa-project.org>; Wed, 04 Dec 2013 03:38:29 -0800 (PST)
In-Reply-To: <1386124624-22414-3-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: zql@glomationinc.com, nicolas.ferre@atmel.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 04/12/2013 03:37, Bo Shen wrote:
> Change sam9x5 with wm8731 work in DSP A mode, this will fix the
> left/right channel swap issue.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>  sound/soc/atmel/sam9x5_wm8731.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
> index 992ae38..06c1811 100644
> --- a/sound/soc/atmel/sam9x5_wm8731.c
> +++ b/sound/soc/atmel/sam9x5_wm8731.c
> @@ -107,7 +107,7 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
>  	dai->stream_name = "WM8731 PCM";
>  	dai->codec_dai_name = "wm8731-hifi";
>  	dai->init = sam9x5_wm8731_init;
> -	dai->dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> +	dai->dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF
>  		| SND_SOC_DAIFMT_CBM_CFM;
>  
>  	ret = snd_soc_of_parse_card_name(card, "atmel,model");
> 
Tested-by: Richard Genoud <richard.genoud@gmail.com>
on at91sam9g35-ek with 3.12-rc2 + "ASoC: wm8731: fix dsp mode configuration"


Thanks !
