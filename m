From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/2] ASoC: mxs-sgtl5000: add record function
Date: Mon, 22 Aug 2011 11:37:53 +0100
Message-ID: <4E523181.1020903@ti.com>
References: <1313942566-21433-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id D210B2454E
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:37:59 +0200 (CEST)
In-Reply-To: <1313942566-21433-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On 21/08/11 17:02, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  sound/soc/mxs/mxs-sgtl5000.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
> index a0d89c9..7fbeaec 100644
> --- a/sound/soc/mxs/mxs-sgtl5000.c
> +++ b/sound/soc/mxs/mxs-sgtl5000.c
> @@ -85,13 +85,21 @@ static struct snd_soc_ops mxs_sgtl5000_hifi_ops = {
>  
>  static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
>  	{
> -		.name		= "HiFi",
> +		.name		= "HiFi Tx",
>  		.stream_name	= "HiFi Playback",
>  		.codec_dai_name	= "sgtl5000",
>  		.codec_name	= "sgtl5000.0-000a",
>  		.cpu_dai_name	= "mxs-saif.0",
>  		.platform_name	= "mxs-pcm-audio.0",
>  		.ops		= &mxs_sgtl5000_hifi_ops,
> +	}, {
> +		.name		= "HiFi Rx",
> +		.stream_name	= "HiFi Capture",
> +		.codec_dai_name	= "sgtl5000",
> +		.codec_name	= "sgtl5000.0-000a",
> +		.cpu_dai_name	= "mxs-saif.1",
> +		.platform_name	= "mxs-pcm-audio.1",
> +		.ops		= &mxs_sgtl5000_hifi_ops,
>  	},
>  };
>  

Acked-by: Liam Girdwood <lrg@ti.com>
