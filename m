From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: Return early with -EINVAL if invalid
 dai format is detected
Date: Wed, 5 Oct 2011 11:16:57 -0500
Message-ID: <4E8C82F9.1030306@freescale.com>
References: <1317779135.2595.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id C2DD424466
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 18:17:04 +0200 (CEST)
In-Reply-To: <1317779135.2595.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Cc: Timur Tabi <timur@freescale.com>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---
>  sound/soc/codecs/cs4270.c  |    2 +-
>  sound/soc/codecs/cs42l51.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
> index 5830c93..e645d67 100644
> --- a/sound/soc/codecs/cs4270.c
> +++ b/sound/soc/codecs/cs4270.c
> @@ -271,7 +271,7 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
>  		break;
>  	default:
>  		dev_err(codec->dev, "invalid dai format\n");
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
>  

If you're going to make a change like this, I say go all the way:

	/* set DAI format */
	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
	case SND_SOC_DAIFMT_I2S:
	case SND_SOC_DAIFMT_LEFT_J:
		cs4270->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
		break;
	default:
		dev_err(codec->dev, "invalid dai format\n");
		return -EINVAL;
	}

	/* set master/slave audio interface */
	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
	case SND_SOC_DAIFMT_CBS_CFS:
		cs4270->slave_mode = 1;
		break;
	case SND_SOC_DAIFMT_CBM_CFM:
		cs4270->slave_mode = 0;
		break;
	default:
		/* all other modes are unsupported by the hardware */
---> also add an error message here
		return -EINVAL;
	}

	return 0;

Then you can delete local variable 'ret' altogether.

-- 
Timur Tabi
Linux kernel developer at Freescale
