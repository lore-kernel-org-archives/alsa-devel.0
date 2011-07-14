From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: RE: [alsa-devel] [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
	machine driver
Date: Thu, 14 Jul 2011 03:04:11 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CE3AB@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713155821.GL1928@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110713155821.GL1928@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Wolfram Sang
> Sent: Wednesday, July 13, 2011 11:58 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> broonie@opensource.wolfsonmicro.com; u.kleine-koenig@pengutronix.de;
> lrg@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [alsa-devel] [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
> machine driver
> 
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> 
> No parameters here, drop it.
> 
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/fsl_devices.h>
> > +#include <linux/gpio.h>
> 
> The last three, too.
>
> > +	/* sgtl5000 does not support 512*rate when in 96000 fs */
> > +	rate = params_rate(params);
> 
> ...so this line can go.
> 
Updated.
Thanks.

Regards
Dong Aisheng
