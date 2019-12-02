Return-Path: <SRS0=OACP=ZY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4162C432C3
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:03:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93B5215E5
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jGEwcVOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93B5215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B338B84A;
	Mon,  2 Dec 2019 14:02:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B338B84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575291801;
	bh=QSV4oo9hI7gEcw9Q/Jy8m2mGkUlZOp7CrAt1WMDBD0c=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jGEwcVOeD7AQzDHPi6PFdb87ryYAs2pi6TqLIcmbPup7gOGdK8U9FMNwUu/UgSW6i
	 KM8hyDGuB//P9Eon+ygVWfpz/WZ+ZCvEUu9nweo6p2Qqah5Qk4C7Hm0hCdvMSxBq5Y
	 vBPwgDV+T8bHEsNDfNGGY7QK7C0UxDoRdJN6Q8zA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F796F801D9;
	Mon,  2 Dec 2019 14:02:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6A1BF80214; Mon,  2 Dec 2019 14:02:29 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9695F800B4
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 14:02:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9695F800B4
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1iblLB-0005vk-3o; Mon, 02 Dec 2019 14:02:13 +0100
Message-ID: <88994e7445df8b2d98f3548e2043eb29bf5fa95f.camel@pengutronix.de>
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yong Liang <yong.liang@mediatek.com>
Date: Mon, 02 Dec 2019 14:02:11 +0100
In-Reply-To: <1575016588.7013.8.camel@mhfsdcap03>
References: <20191125061627.GA7313@roeck-us.net>
 <e138b69efad563822da1db8e160d43458c21eae1.camel@pengutronix.de>
 <1575016588.7013.8.camel@mhfsdcap03>
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Jiaxin Yu =?UTF-8?Q?=28=E4=BF=9E=E5=AE=B6=E9=91=AB=29?=
 <Jiaxin.Yu@mediatek.com>, "tzungbi@google.com" <tzungbi@google.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Eason Yen =?UTF-8?Q?=28=E9=A1=8F=E5=BB=B7=E4=BB=BB=29?=
 <Eason.Yen@mediatek.com>,
 Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?=
 <Yingjoe.Chen@mediatek.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [alsa-devel] [PATCH v5 2/2] watchdog: mtk_wdt: mt8183: Add
	reset controller
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, 2019-11-29 at 16:36 +0800, Yong Liang wrote:
> On Mon, 2019-11-25 at 17:51 +0800, Philipp Zabel wrote:
> > On Sun, 2019-11-24 at 22:16 -0800, Guenter Roeck wrote:
> > > On Mon, Nov 25, 2019 at 11:03:50AM +0800, Jiaxin Yu wrote:
> > > > From: "yong.liang" <yong.liang@mediatek.com>
> > > > 
> > > > Add reset controller API in watchdog driver.
> > > > Besides watchdog, MTK toprgu module also provide sub-system (eg, audio,
> > > > camera, codec and connectivity) software reset functionality.
> > > > 
> > > > Signed-off-by: yong.liang <yong.liang@mediatek.com>
> > > > Signed-off-by: jiaxin.yu <jiaxin.yu@mediatek.com>
> > > > Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > > > ---
> > > >  drivers/watchdog/Kconfig   |   1 +
> > > >  drivers/watchdog/mtk_wdt.c | 111 ++++++++++++++++++++++++++++++++++++-
> > > >  2 files changed, 111 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > > index 2e07caab9db2..629249fe5305 100644
> > > > --- a/drivers/watchdog/Kconfig
> > > > +++ b/drivers/watchdog/Kconfig
> > > > @@ -717,6 +717,7 @@ config MEDIATEK_WATCHDOG
> > > >  	tristate "Mediatek SoCs watchdog support"
> > > >  	depends on ARCH_MEDIATEK || COMPILE_TEST
> > > >  	select WATCHDOG_CORE
> > > > +	select RESET_CONTROLLER
> > > >  	help
> > > >  	  Say Y here to include support for the watchdog timer
> > > >  	  in Mediatek SoCs.
> > > > diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> > > > index 9c3d0033260d..d29484c7940a 100644
> > > > --- a/drivers/watchdog/mtk_wdt.c
> > > > +++ b/drivers/watchdog/mtk_wdt.c
> > > > @@ -9,6 +9,9 @@
> > > >   * Based on sunxi_wdt.c
> > > >   */
> > > >  
> > > > +#include <dt-bindings/reset-controller/mt2712-resets.h>
> > > > +#include <dt-bindings/reset-controller/mt8183-resets.h>
> > > > +#include <linux/delay.h>
> > > >  #include <linux/err.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/io.h>
> > > > @@ -16,10 +19,12 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/moduleparam.h>
> > > >  #include <linux/of.h>
> > > > +#include <linux/of_device.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/reset-controller.h>
> > > > +#include <linux/slab.h>
> > > >  #include <linux/types.h>
> > > >  #include <linux/watchdog.h>
> > > > -#include <linux/delay.h>
> > > >  
> > > >  #define WDT_MAX_TIMEOUT		31
> > > >  #define WDT_MIN_TIMEOUT		1
> > > > @@ -44,6 +49,9 @@
> > > >  #define WDT_SWRST		0x14
> > > >  #define WDT_SWRST_KEY		0x1209
> > > >  
> > > > +#define WDT_SWSYSRST		0x18U
> > > > +#define WDT_SWSYS_RST_KEY	0x88000000
> > > > +
> > > >  #define DRV_NAME		"mtk-wdt"
> > > >  #define DRV_VERSION		"1.0"
> > > >  
> > > > @@ -53,8 +61,99 @@ static unsigned int timeout;
> > > >  struct mtk_wdt_dev {
> > > >  	struct watchdog_device wdt_dev;
> > > >  	void __iomem *wdt_base;
> > > > +	spinlock_t lock; /* protects WDT_SWSYSRST reg */
> > > > +	struct reset_controller_dev rcdev;
> > > > +};
> > > > +
> > > > +struct mtk_wdt_data {
> > > > +	int sw_rst_num;
> > > >  };
> > > >  
> > > > +static const struct mtk_wdt_data mt2712_data = {
> > > > +	.sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
> > > > +};
> > > > +
> > > > +static const struct mtk_wdt_data mt8183_data = {
> > > > +	.sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
> > > > +};
> > > 
> > > The number of resets can be set in .data directly; there is no need
> > > for the structures.
> 
>     We want to put all properities in mtxxxx-resets.h and it easy to
> manager. If there are new properity in the feture, we can put it in
> mtk_wdt_data mtxxxx_data

Do you expect there will be more properties in the future?

> > > > +static int toprgu_reset_deassert(struct reset_controller_dev *rcdev,
> > > > +				 unsigned long id)
> > > > +{
> > > > +	unsigned int tmp;
> > > > +	unsigned long flags;
> > > > +	struct mtk_wdt_dev *data =
> > > > +		 container_of(rcdev, struct mtk_wdt_dev, rcdev);
> > > > +
> > > > +	spin_lock_irqsave(&data->lock, flags);
> > > > +
> > > > +	tmp = __raw_readl(data->wdt_base + WDT_SWSYSRST);
> > > > +	tmp &= ~BIT(id);
> > > > +	tmp |= WDT_SWSYS_RST_KEY;
> > > > +	writel(tmp, data->wdt_base + WDT_SWSYSRST);
> > > > +
> > > > +	spin_unlock_irqrestore(&data->lock, flags);
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > There is a lot of duplication in those functions. Only one line
> > > is different. I think this is a good example where a helper function
> > > with an additional argument indicating set or reset would be helpful.
> > > 
>     .assert and .dessert are two numbers of struct reset_control_ops.
>      I think it's better to define both of them.

The suggestion was to have two very short _assert and _deassert
functions that only contain a single call to a common helper function.
See the reset-a10sr.c driver for an example.

regards
Philipp

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
