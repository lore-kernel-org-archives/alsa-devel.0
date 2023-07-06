Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61C3EB64D9
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jul 2023 15:31:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3D5C84A;
	Mon, 10 Jul 2023 17:30:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3D5C84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689003096;
	bh=MG5u7orRY+S775CcR6Jjg0XM98vTZ+cG+jXAIDN98J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=o7g6BeKmc3LgnG58XNM1Nc36Ggha7xowBje9IQeZDh2GWUPLXF6VC1fDC693lRJ1A
	 qe8ywuiL2ha6GERRpGMaHu++iZUT2vt2EcVvNkoaAL6yI6KvhEA2ikVlUf2nJvftDc
	 sZScYZCVaAEmEOWC1WWGx/JyJ+G65RWRXOyP6c3c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C9D3F80549; Mon, 10 Jul 2023 17:29:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A5CD2F80552;
	Mon, 10 Jul 2023 17:29:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1328F80549; Thu,  6 Jul 2023 14:34:08 +0200 (CEST)
Received: from pi.fatal.se (94-255-170-6.cust.bredband2.com [94.255.170.6])
	by alsa1.perex.cz (Postfix) with ESMTP id 04540F80093
	for <alsa-devel@alsa-project.org>; Thu,  6 Jul 2023 14:34:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04540F80093
Received: by pi.fatal.se (Postfix, from userid 1000)
	id E76412A8E0; Thu,  6 Jul 2023 14:34:01 +0200 (CEST)
Date: Thu, 6 Jul 2023 14:34:01 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Fabio Estevam <festevam@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Linux-ALSA <alsa-devel@alsa-project.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Hans =?iso-8859-1?Q?S=F6derlund?= <hans.soderlund@realbit.se>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode
Message-ID: <20230706123401.kctossjho26bry7e@fatal.se>
References: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DtpoH0dLDX3=Sv4UUpX_=66VEZPsJUWQNnYviApfMLKQ@mail.gmail.com>
 <20230706084706.bzwsbi3zisx5m5rl@fatal.se>
 <CAOMZO5CCdaodWQrHUQgMizoES=jfEtw-sNJZG-DJMpRD8tZW9g@mail.gmail.com>
 <CAA+D8ANAg7bs0A35c7Af3_-5sLaqvT1RoKfCbzYi=z=t_q9LUw@mail.gmail.com>
 <CAOMZO5BtrKwrMwrjVDbYn3ivt2uV9rzbSDxd8qfiYjOBMvKBgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: 
 <CAOMZO5BtrKwrMwrjVDbYn3ivt2uV9rzbSDxd8qfiYjOBMvKBgg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-MailFrom: ah@fatal.se
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 3TEBS3OHQ7EVJ3K53BLFDPNCPUUL5SEN
X-Message-ID-Hash: 3TEBS3OHQ7EVJ3K53BLFDPNCPUUL5SEN
X-Mailman-Approved-At: Mon, 10 Jul 2023 15:29:54 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3TEBS3OHQ7EVJ3K53BLFDPNCPUUL5SEN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello Fabio,

Maybe I shouldn't comment as I'm already on deep water, but...

On Thu, Jul 06, 2023 at 08:32:57AM -0300, Fabio Estevam wrote:
> On Thu, Jul 6, 2023 at 8:19 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
> 
> > No, this is the code in probe().
> > The code with the issue is in fsl_sai_set_bclk().
> 
> Yes, I put it in the wrong place.
> 
> > The clean way for fixing is to remove the code in fsl_sai_set_bclk()
> > and add "fsl,sai-mclk-direction-output;" property in dts for some
> > node.
> 
> Yes, what about this?
> 
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -507,7 +507,7 @@ static int fsl_sai_set_bclk(struct snd_soc_dai
> *dai, bool tx, u32 freq)
>                                    savediv / 2 - 1);
>         }
> 
> -       if (sai->soc_data->max_register >= FSL_SAI_MCTL) {
> +       if (sai->soc_data->max_register >= FSL_SAI_MCTL  &&
> sai->mclk_direction_output) {
>                 /* SAI is in master mode at this point, so enable MCLK */
>                 regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
>                                    FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);

This is exactly the same as and thus redundant to the code already in
the probe function?!

If I understood it correctly, the problem Shengjiu was trying to adress
was that apparently on i.MX8MM (and only imx8mm?!), even when using MCLK
in *input*, you still need to enable it because otherwise BCLK will not
be generated. (I personally don't know anything about this or the imx8mm
variant though.)

The problem could probably equally well be worked around by always setting the
fsl,sai-mclk-direction-output; devicetree property on imx8mm, even when
using MCLK in input..... But I'm just guessing here to be honest. This
is just as I understood what purpose the initial patch that was merged
had.

The current state affects more devices than imx8mm though, making MCLK
in input mode not possible.

I think your initial review comment was spot on Fabio. There probably
needs to be a(n imx8mm) specific flag that says when this workaround
should be applied and gate the code in bclk function on that.
Atleast that's the only thing I can think of if my interpretation of the
problem for imx8mm is correct.

Regards,
Andreas Henriksson

