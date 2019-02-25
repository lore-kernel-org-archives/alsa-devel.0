From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix channel swap issue
	when stream starts
Date: Mon, 25 Feb 2019 02:31:32 +0000
Message-ID: <VI1PR0402MB33920A616FCA34D15C502574E37A0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1550742787-3268-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5A-XCxtNmO5+JM+9R34oh-dYUD8ZHynCUE_p_Q-kjvR0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140054.outbound.protection.outlook.com [40.107.14.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1883F80721
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 03:32:35 +0100 (CET)
In-Reply-To: <CAOMZO5A-XCxtNmO5+JM+9R34oh-dYUD8ZHynCUE_p_Q-kjvR0w@mail.gmail.com>
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
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Thanks, will send v2.

Best regards
Wang shengjiu
> 
> Hi Shengjiu.
> 
> On Thu, Feb 21, 2019 at 6:53 AM S.j. Wang <shengjiu.wang@nxp.com>
> wrote:
> >
> > From: Shengjiu Wang <shengjiu.wang@freescale.com>
> 
> Better use your nxp.com address as the freescale.com domain is gone for a
> long time.
> 
> > There is very low possibility ( < 0.1% ) that channel swap happened in
> > beginning when multi output/input pin is enabled. The issue is that
> > hardware can't send data to correct pin in the begginning with
> 
> s/begginning/beginning
> 
> > the normal enable flow.
> >
> > This is hardware issue, the workaround flow is that: Each time
> 
> Is there an erratum reference for this issue? If so, please add it here.
> 
> > playback/recording, firstly clear the xSMA/xSMB, then enable TE/RE,
> > then enable xSMB and xSMA (xSMB must be enabled before xSMA).
> > Which is to use the xSMA as the trigger start register, previously the
> > xCR_TE or xCR_RE is the bit for starting
> 
> Please add a Fixes tag and Cc stable.
> 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> Thanks
