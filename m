From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: add protection for the
 asrc of older version
Date: Fri, 1 Mar 2019 06:55:25 +0000
Message-ID: <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50065.outbound.protection.outlook.com [40.107.5.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54F3CF896B8
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 07:55:27 +0100 (CET)
In-Reply-To: <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi
> 
> Hi Shengjiu,
> 
> On Fri, Mar 01, 2019 at 02:32:38AM +0000, S.j. Wang wrote:
> > There is a constraint for the channel number setting on the asrc of
> > older version (e.g. imx35), the channel number should be even, odd
> > number isn't valid.
> >
> > So add protection when the asrc of older version is used.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_asrc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c index
> > 528e8b108422..b3b3c5e15ef1 100644
> > --- a/sound/soc/fsl/fsl_asrc.c
> > +++ b/sound/soc/fsl/fsl_asrc.c
> > @@ -109,7 +109,8 @@ static int fsl_asrc_request_pair(int channels, struct
> fsl_asrc_pair *pair)
> >  	if (index == ASRC_INVALID_PAIR) {
> >  		dev_err(dev, "all pairs are busy now\n");
> >  		ret = -EBUSY;
> > -	} else if (asrc_priv->channel_avail < channels) {
> > +	} else if (asrc_priv->channel_avail < channels ||
> > +		(asrc_priv->channel_bits < 4 && channels % 2 != 0)) {
> >  		dev_err(dev, "can't afford required channels: %d\n",
> channels);
> 
> I feel it'd be better to have another else-if, since the existing error message
> is against something else.
> 
> +	} else if (asrc_priv->channel_bits < 4 && channels & 1) {
> +		/* old version of ASRC has channel_bits = 3 */
> +  		dev_err(dev, "does not support odd channel number\n");
> +  		ret = -EINVAL;
> 
> Alternatively, I feel instead of error-out at here, should we add a HW
> constraint or at least fence it off at the beginning of the hw_params()? This
> is actually nothing specific to the pair-request function but a hardware
> constraint.

How about add constraint in startup?
static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
                               struct snd_soc_dai *dai)
{
       struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);

       if (asrc_priv->channel_bits == 3) {
               snd_pcm_hw_constraint_step(substream->runtime, 0,
                                          SNDRV_PCM_HW_PARAM_CHANNELS, 2);
       }

       return 0;
}

Best regards
Wang shengjiu
