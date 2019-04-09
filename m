From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [EXT] Re: [PATCH V1] ASoC: fsl_esai: replace
 fall-through with break
Date: Mon, 8 Apr 2019 20:54:52 -0700
Message-ID: <20190409035450.GA8476@Asurada>
References: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
 <38a6d36e-0f8e-fe3d-202b-30371042e248@embeddedor.com>
 <VE1PR04MB6479C16BB1C92E1AE291BB12E32D0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <eba6372b-618c-4633-f0a9-06c034cf2f9c@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23428F80765
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 05:55:03 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id k3so8492969pga.6
 for <alsa-devel@alsa-project.org>; Mon, 08 Apr 2019 20:55:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <eba6372b-618c-4633-f0a9-06c034cf2f9c@embeddedor.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Gustavo,

On Mon, Apr 08, 2019 at 10:20:25PM -0500, Gustavo A. R. Silva wrote:
> >>> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> >>> c7410bbfd2af..bad0dfed6b68 100644
> >>> --- a/sound/soc/fsl/fsl_esai.c
> >>> +++ b/sound/soc/fsl/fsl_esai.c
> >>> @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct
> >> snd_soc_dai *dai, int clk_id,
> >>>               break;
> >>>       case ESAI_HCKT_EXTAL:
> >>>               ecr |= ESAI_ECR_ETI;
> >>
> >> Also, you should use a simple assignment operator "=" instead of "|=" in
> >> both cases.
> > 
> > The result is same for "=" and "|=", because there is "ecr = 0" in beginning of
> > This function. 
> > 
> 
> Following that same logic, then why not use "+=" instead?
> 
> The point is: is "|=" or any other assignment operator other than "=" necessary?
> The answer in this case is: no, it is not.  So, go for the simple one and avoid
> any unnecessary confusion.

I would like to keep "|=" here, just in case that someday it'd be easier
to insert something to ecr before this chunk. So please get easy on this
one.

Thanks
Nicolin
