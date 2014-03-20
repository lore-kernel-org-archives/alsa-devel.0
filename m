From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
Date: Thu, 20 Mar 2014 10:10:09 -0500
Message-ID: <532B04D1.9000405@tabi.org>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
 <1394894616.578942243@f331.i.mail.ru> <20140318081019.GJ11360@pengutronix.de>
 <5b62326226b54b1da0addf839cbcd104@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id E9BB9265278
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 16:10:11 +0100 (CET)
In-Reply-To: <5b62326226b54b1da0addf839cbcd104@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexander Shiyan <shc_work@mail.ru>, Mark Brown <broonie@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 03/20/2014 01:07 AM, Li.Xiubo@freescale.com wrote:
> While for the scenario like our LS1(ARM) platform.
> CPU		SSI
> LE		BE	then should we set the .val_format_endian to
> 			REGMAP_ENDIAN_BIG
>
>
> And so not only for PowerPC, but also maybe for ARM platforms.
> So here how about just adding one Boolean property like 'big-endian' in DT node
> to learn the endianness of the devices dynamically ?

That's not a bad idea.  The property should be something like, 
"fsl,ssi-endian" and is should be set to "big", "little", or "native". 
In the absence of the property, it should default to native endian.
