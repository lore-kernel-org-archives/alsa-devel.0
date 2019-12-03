Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7BEC432C0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:04:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2ACE206E0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hy8Kpe4x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M9RMVVU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2ACE206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 915091612;
	Tue,  3 Dec 2019 04:03:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 915091612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575342241;
	bh=SAisoeB/Mstidk/LsGSWZq0QEr6qMZ6Hsoy41DEZPCc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hy8Kpe4xUMoowwiAUyvW81g5HNC1wsBYVl5U9M1eyutF3P+KosaHxb9UFIQsjGipw
	 Sg5V5x72PINHRU5pB416pPnzIHuv1zx+NYLnTu74LJYuRTSb/a+g7FbDNIhXQjB81h
	 rpEmujSuw3+FZMMNz8UnBO6UvUsc7wJ/faV8CxfY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12045F8015A;
	Tue,  3 Dec 2019 04:03:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8467CF80227; Tue,  3 Dec 2019 04:03:09 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by alsa1.perex.cz (Postfix) with ESMTP id A455DF800ED
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 04:02:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A455DF800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="M9RMVVU3"
X-UUID: 1c01cec76ebd41b3b518e551b253bcde-20191203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=pmVMm5SOfCFhpHw4vOj3FTnsiDgBoQKAvwJKCKcst2Q=; 
 b=M9RMVVU3ClZgl7kr+w58TYfLI85oC+ADmSf2PhCOeLhnpnaMqU8do2YuHeNhK49abHcPrIa3AHGKqOjPRnJqNzpLTYiu7jkwRAejXqsLCmz7Db+aQdphG/QjNj29q1Rw8s86iMmLQ+pARe6nxQHVTz8RxYmFV9Q5z3tsMGBhRuo=;
X-UUID: 1c01cec76ebd41b3b518e551b253bcde-20191203
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.liang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 678663031; Tue, 03 Dec 2019 11:02:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 3 Dec 2019 11:02:01 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Dec 2019 11:01:56 +0800
Message-ID: <1575342124.7013.13.camel@mhfsdcap03>
From: Yong Liang <yong.liang@mediatek.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 3 Dec 2019 11:02:04 +0800
In-Reply-To: <88994e7445df8b2d98f3548e2043eb29bf5fa95f.camel@pengutronix.de>
References: <20191125061627.GA7313@roeck-us.net>
 <e138b69efad563822da1db8e160d43458c21eae1.camel@pengutronix.de>
 <1575016588.7013.8.camel@mhfsdcap03>
 <88994e7445df8b2d98f3548e2043eb29bf5fa95f.camel@pengutronix.de>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 82EBD1AB543FDABB01B85E3B0278C45DF1646569865AE3A902AE5107D2AF64112000:8
X-MTK: N
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Jiaxin Yu =?UTF-8?Q?=28=E4=BF=9E=E5=AE=B6=E9=91=AB=29?=
 <Jiaxin.Yu@mediatek.com>, "tzungbi@google.com" <tzungbi@google.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Eason Yen =?UTF-8?Q?=28=E9=A1=8F=E5=BB=B7=E4=BB=BB=29?=
 <Eason.Yen@mediatek.com>,
 Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?=
 <Yingjoe.Chen@mediatek.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Mon, 2019-12-02 at 21:02 +0800, Philipp Zabel wrote:
> On Fri, 2019-11-29 at 16:36 +0800, Yong Liang wrote:
> > On Mon, 2019-11-25 at 17:51 +0800, Philipp Zabel wrote:
> > > On Sun, 2019-11-24 at 22:16 -0800, Guenter Roeck wrote:
> > > > On Mon, Nov 25, 2019 at 11:03:50AM +0800, Jiaxin Yu wrote:
> > > > > From: "yong.liang" <yong.liang@mediatek.com>
> > > > > 
> > > > > Add reset controller API in watchdog driver.
> > > > > Besides watchdog, MTK toprgu module also provide sub-system (eg, audio,
> > > > > camera, codec and connectivity) software reset functionality.
> > > > > 
> > > > > Signed-off-by: yong.liang <yong.liang@mediatek.com>
> > > > > Signed-off-by: jiaxin.yu <jiaxin.yu@mediatek.com>
> > > > > Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > > > > ---
> > > > >  drivers/watchdog/Kconfig   |   1 +
> > > > >  drivers/watchdog/mtk_wdt.c | 111 ++++++++++++++++++++++++++++++++++++-
> > > > >  2 files changed, 111 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > > > index 2e07caab9db2..629249fe5305 100644
> > > > > --- a/drivers/watchdog/Kconfig
> > > > > +++ b/drivers/watchdog/Kconfig
> > > > > @@ -717,6 +717,7 @@ config MEDIATEK_WATCHDOG
> > > > >  	tristate "Mediatek SoCs watchdog support"
> > > > >  	depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > >  	select WATCHDOG_CORE
> > > > > +	select RESET_CONTROLLER
> > > > >  	help
> > > > >  	  Say Y here to include support for the watchdog timer
> > > > >  	  in Mediatek SoCs.
> > > > > diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> > > > > index 9c3d0033260d..d29484c7940a 100644
> > > > > --- a/drivers/watchdog/mtk_wdt.c
> > > > > +++ b/drivers/watchdog/mtk_wdt.c
> > > > > @@ -9,6 +9,9 @@
> > > > >   * Based on sunxi_wdt.c
> > > > >   */
> > > > >  
> > > > > +#include <dt-bindings/reset-controller/mt2712-resets.h>
> > > > > +#include <dt-bindings/reset-controller/mt8183-resets.h>
> > > > > +#include <linux/delay.h>
> > > > >  #include <linux/err.h>
> > > > >  #include <linux/init.h>
> > > > >  #include <linux/io.h>
> > > > > @@ -16,10 +19,12 @@
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/moduleparam.h>
> > > > >  #include <linux/of.h>
> > > > > +#include <linux/of_device.h>
> > > > >  #include <linux/platform_device.h>
> > > > > +#include <linux/reset-controller.h>
> > > > > +#include <linux/slab.h>
> > > > >  #include <linux/types.h>
> > > > >  #include <linux/watchdog.h>
> > > > > -#include <linux/delay.h>
> > > > >  
> > > > >  #define WDT_MAX_TIMEOUT		31
> > > > >  #define WDT_MIN_TIMEOUT		1
> > > > > @@ -44,6 +49,9 @@
> > > > >  #define WDT_SWRST		0x14
> > > > >  #define WDT_SWRST_KEY		0x1209
> > > > >  
> > > > > +#define WDT_SWSYSRST		0x18U
> > > > > +#define WDT_SWSYS_RST_KEY	0x88000000
> > > > > +
> > > > >  #define DRV_NAME		"mtk-wdt"
> > > > >  #define DRV_VERSION		"1.0"
> > > > >  
> > > > > @@ -53,8 +61,99 @@ static unsigned int timeout;
> > > > >  struct mtk_wdt_dev {
> > > > >  	struct watchdog_device wdt_dev;
> > > > >  	void __iomem *wdt_base;
> > > > > +	spinlock_t lock; /* protects WDT_SWSYSRST reg */
> > > > > +	struct reset_controller_dev rcdev;
> > > > > +};
> > > > > +
> > > > > +struct mtk_wdt_data {
> > > > > +	int sw_rst_num;
> > > > >  };
> > > > >  
> > > > > +static const struct mtk_wdt_data mt2712_data = {
> > > > > +	.sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
> > > > > +};
> > > > > +
> > > > > +static const struct mtk_wdt_data mt8183_data = {
> > > > > +	.sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
> > > > > +};
> > > > 
> > > > The number of resets can be set in .data directly; there is no need
> > > > for the structures.
> > 
> >     We want to put all properities in mtxxxx-resets.h and it easy to
> > manager. If there are new properity in the feture, we can put it in
> > mtk_wdt_data mtxxxx_data
> 
> Do you expect there will be more properties in the future?

  Yes, We may put some infra reset bit and max number in mtxxxx-resets.h
> 
> > > > > +static int toprgu_reset_deassert(struct reset_controller_dev *rcdev,
> > > > > +				 unsigned long id)
> > > > > +{
> > > > > +	unsigned int tmp;
> > > > > +	unsigned long flags;
> > > > > +	struct mtk_wdt_dev *data =
> > > > > +		 container_of(rcdev, struct mtk_wdt_dev, rcdev);
> > > > > +
> > > > > +	spin_lock_irqsave(&data->lock, flags);
> > > > > +
> > > > > +	tmp = __raw_readl(data->wdt_base + WDT_SWSYSRST);
> > > > > +	tmp &= ~BIT(id);
> > > > > +	tmp |= WDT_SWSYS_RST_KEY;
> > > > > +	writel(tmp, data->wdt_base + WDT_SWSYSRST);
> > > > > +
> > > > > +	spin_unlock_irqrestore(&data->lock, flags);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > 
> > > > There is a lot of duplication in those functions. Only one line
> > > > is different. I think this is a good example where a helper function
> > > > with an additional argument indicating set or reset would be helpful.
> > > > 
> >     .assert and .dessert are two numbers of struct reset_control_ops.
> >      I think it's better to define both of them.
> 
> The suggestion was to have two very short _assert and _deassert
> functions that only contain a single call to a common helper function.
> See the reset-a10sr.c driver for an example.

  OK. I will modify it as reset-a10sr.c do.
> 
> regards
> Philipp
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
