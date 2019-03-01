From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: add protection for the
 asrc of older version
Date: Fri, 1 Mar 2019 00:08:12 -0800
Message-ID: <20190301080812.GA5244@Asurada>
References: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
 <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA3AAF896C0
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 09:08:21 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id k2so11110143plt.3
 for <alsa-devel@alsa-project.org>; Fri, 01 Mar 2019 00:08:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 01, 2019 at 06:55:25AM +0000, S.j. Wang wrote:

> > Alternatively, I feel instead of error-out at here, should we add a HW
> > constraint or at least fence it off at the beginning of the hw_params()? This
> > is actually nothing specific to the pair-request function but a hardware
> > constraint.
> 
> How about add constraint in startup?
> static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
>                                struct snd_soc_dai *dai)
> {
>        struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);
> 
>        if (asrc_priv->channel_bits == 3) {
>                snd_pcm_hw_constraint_step(substream->runtime, 0,
>                                           SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>        }
> 
>        return 0;
> }

Yea, that looks good to me. Better to have a line of comments
to tell that "bits==3" means older version -- maybe we should
have something much more clear than using channel_bits but it
is fine for now since they only differ here.
