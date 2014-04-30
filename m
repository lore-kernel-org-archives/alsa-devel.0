From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH v3 00/18] ASoC: fsl-ssi: Driver cleanup
Date: Wed, 30 Apr 2014 02:01:23 +0000
Message-ID: <56674acdcf9f4c19916f349286c883f7@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <20140424114403.GN12304@sirena.org.uk>
 <20140428085453.GC15179@pengutronix.de>
 <20140429162229.GA16981@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A3EE26516D
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 04:01:39 +0200 (CEST)
In-Reply-To: <20140429162229.GA16981@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexander Shiyan <shc_work@mail.ru>, Timur Tabi <timur@tabi.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org




> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, April 30, 2014 12:22 AM
> To: Markus Pargmann
> Cc: Timur Tabi; Chen Guangyu-B42378; Estevam Fabio-R49496; Alexander Shiyan;
> Xiubo Li-B47053; alsa-devel@alsa-project.org; linux-arm-
> kernel@lists.infradead.org; kernel@pengutronix.de
> Subject: Re: [PATCH v3 00/18] ASoC: fsl-ssi: Driver cleanup
> 
> On Mon, Apr 28, 2014 at 10:54:53AM +0200, Markus Pargmann wrote:
> 
> > What do you think of some framework function like
> > of_regmap_parse_endianess()? This would offer a common devicetree
> > binding and the driver would still be involved.
> 
> Something like that should be fine, Xiubo has been working on it.

Yes, the patch is still discussing.

Thanks,

BRs
Xiubo
