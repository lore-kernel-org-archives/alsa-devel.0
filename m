From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Allow to describe
 master or slave mode
Date: Sun, 21 Sep 2014 23:10:30 -0700
Message-ID: <20140922061029.GA5124@Asurada>
References: <1411360854-16891-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 1648E265011
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 08:10:41 +0200 (CEST)
Received: by mail-pa0-f48.google.com with SMTP id ey11so4343319pad.35
 for <alsa-devel@alsa-project.org>; Sun, 21 Sep 2014 23:10:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411360854-16891-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On Mon, Sep 22, 2014 at 01:40:54AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Provide a mechanism to describe whether the system runs in master or slave mode.
> 
> In order to keep compatibilty with existing dtb's let slave mode be default one.
> 
> Tested on a imx6q-sabresd board in both modes.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt |  5 +++++
>  sound/soc/fsl/fsl-asoc-card.c                             | 15 ++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> index a96774c..1bbc828 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> @@ -59,6 +59,10 @@ Optional properties:
>    - audio-asrc		: The phandle of ASRC. It can be absent if there's no
>  			  need to add ASRC support via DPCM.
>  
> +  - audio-cpu-mode	: The operating mode for the audio cpu interface.
> +			  "slave" - audio clock comes from the external codec
> +			  "master" -audio clock is generated from the audio cpu
> +

This could be a good idea to move the 'hardcode' into the DT binding
while maintaining the compatibility toward imx-sgtl5000 and imx-wm8962.
But at least, it still needs to separate the bit clock and frame sync
clock. Otherwise, the CBS_CFM and CBM_CFS cases will be expelled, as
AUDMUX part in the driver takes care of them even if they are pretty
rare.

And another question I's wondering myself: If they are really worth
adding. Because we may then need I2S/LEFT_J parsing code too while
we can't eradicate all the hard code such as pll_id and mclk_id. So
since the further compatible of the driver still needs some specific
configurations, why not just leave DAI formats configurations in the
driver as well -- So I didn't expect this driver will be enhanced to
become a Freescale Simple Card.


What do you think about it after seeing my idea.

One more thing: we may figure out a better and more explicit name,
rather than 'cpu-mode', if we decide to add DAI formats information
into DT.

Thank you
Nicolin
