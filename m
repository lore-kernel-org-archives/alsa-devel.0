From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: fsl: Update set_tdm_slot()
	semantics
Date: Tue, 13 Jan 2015 01:58:34 -0800
Message-ID: <20150113095833.GA3189@Alpha>
References: <1421054841-19858-1-git-send-email-lars@metafoo.de>
 <1421054841-19858-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f46.google.com (mail-yh0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 46CD5260413
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 10:58:44 +0100 (CET)
Received: by mail-yh0-f46.google.com with SMTP id t59so985840yho.5
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 01:58:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421054841-19858-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Li.Xiubo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 12, 2015 at 10:27:18AM +0100, Lars-Peter Clausen wrote:
> The fsl-ssi and imx-ssi drivers use inverted semantics for the tx_mask and
> rx_mask parameter of the set_tdm_slot() callback compared to rest of ASoC.
> This patch updates the driver's semantics to be consistent with the rest of
> ASoC, i.e. a set bit means a active slot and a cleared bit means a inactive
> slot.  This will allow us to use the set_tdm_slot() API in a more generic
> way.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Changes since v1:
>  * Don't change the esai driver as it does not use the inverted semantics.
> ---
>  sound/soc/fsl/eukrea-tlv320.c | 2 +-
>  sound/soc/fsl/fsl_ssi.c       | 4 ++--
>  sound/soc/fsl/fsl_utils.c     | 6 +++---
>  sound/soc/fsl/imx-mc13783.c   | 2 +-
>  sound/soc/fsl/imx-ssi.c       | 4 ++--
>  sound/soc/fsl/wm1133-ev1.c    | 4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)

> diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
> index 9589452..9e6493d 100644
> --- a/sound/soc/fsl/imx-mc13783.c
> +++ b/sound/soc/fsl/imx-mc13783.c
> @@ -45,7 +45,7 @@ static int imx_mc13783_hifi_hw_params(struct snd_pcm_substream *substream,
>  	if (ret)
>  		return ret;
>  
> -	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x0, 0xfffffffc, 2, 16);
> +	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 16);

Hmm..I just notice the original configuration was 0x0 with 0xfffffffc.
It doesn't look making sense to me by using 0x0 here but not sure if
it was intentional.

However, I suppose it should be fine since the time slot number was 2.

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
