From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [EXT] Re: [PATCH V2] ASoC: fsl_esai: replace
 fall-through with break
Date: Thu, 11 Apr 2019 03:09:41 +0000
Message-ID: <VE1PR04MB6479BBD94E90632DB3374555E32F0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
 <20190410112813.GL6106@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBB46F89616
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 05:09:43 +0200 (CEST)
In-Reply-To: <20190410112813.GL6106@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark

> 
> On Wed, Apr 10, 2019 at 02:42:45AM +0000, S.j. Wang wrote:
> > case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent
> of
> > each other, so replace fall-through with break.
> 
> This doesn't apply against current code, please check and resend.

Thanks, have sent v4 for update subject according to Gustavo's comments.

[PATCH V4] ASoC: fsl_esai: Fix missing break in switch statement

Best regards
Wang shengjiu
