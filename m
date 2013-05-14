From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH RFT] ASoC: da7213: Fix setting
 dmic_samplephase and dmic_clk_rate
Date: Tue, 14 May 2013 11:05:52 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03374D655D56@SW-EX-MBX02.diasemi.com>
References: <1368105260.10534.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay1.diasemi.com (mailrelay1.diasemi.com [82.210.246.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EB3A2619DA
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 13:05:59 +0200 (CEST)
In-Reply-To: <1368105260.10534.0.camel@phoenix>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Apologies. Completely missed this e-mail.

Good spot. Thanks for the update.

> -----Original Message-----
> From: Axel Lin [mailto:axel.lin@ingics.com]
> Sent: 09 May 2013 14:14
> To: Mark Brown
> Cc: Liam Girdwood; Opensource [Adam Thomson]; alsa-devel@alsa-project.org
> Subject: [PATCH RFT] ASoC: da7213: Fix setting dmic_samplephase and dmic_clk_rate
> 
> When set dmic_samplephase and dmic_clk_rate bits for dmic_cfg,
> current code checks pdata->dmic_data_sel which is wrong.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> This looks like a copy-paste bug.
> 
>  sound/soc/codecs/da7213.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index 41230ad..4a6f1da 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -1488,17 +1488,17 @@ static int da7213_probe(struct snd_soc_codec *codec)
>  				     DA7213_DMIC_DATA_SEL_SHIFT);
>  			break;
>  		}
> -		switch (pdata->dmic_data_sel) {
> +		switch (pdata->dmic_samplephase) {
>  		case DA7213_DMIC_SAMPLE_ON_CLKEDGE:
>  		case DA7213_DMIC_SAMPLE_BETWEEN_CLKEDGE:
> -			dmic_cfg |= (pdata->dmic_data_sel <<
> +			dmic_cfg |= (pdata->dmic_samplephase <<
>  				     DA7213_DMIC_SAMPLEPHASE_SHIFT);
>  			break;
>  		}
> -		switch (pdata->dmic_data_sel) {
> +		switch (pdata->dmic_clk_rate) {
>  		case DA7213_DMIC_CLK_3_0MHZ:
>  		case DA7213_DMIC_CLK_1_5MHZ:
> -			dmic_cfg |= (pdata->dmic_data_sel <<
> +			dmic_cfg |= (pdata->dmic_clk_rate <<
>  				     DA7213_DMIC_CLK_RATE_SHIFT);
>  			break;
>  		}
> --
> 1.8.1.2
> 
> 
