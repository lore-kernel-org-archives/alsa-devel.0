Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3F3C83F1A
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jul 2025 07:08:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82A5D601FE;
	Thu, 10 Jul 2025 09:08:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82A5D601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1752131319;
	bh=Fa8cNJqXyqhTY+lay0tanZOJxMosTm8d38KlOTsaTVM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m13Ctm7A9A1LK/aNNPiFSay+4djklDjuwA+oLoPs4A2cjWn6TroKjgZgKdyn2zUU0
	 kUtJNF4vDSkRWF3kbOrlQLSx84h11/6cH0BYOOjKztf2Nzpk1nGQWskLGYOEW0SquC
	 TYm3GjH/J4O8cKykOMcjCrmrwDoxM2CGpZmwyVLo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 331F1F805D4; Thu, 10 Jul 2025 09:08:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2F0FF805D2;
	Thu, 10 Jul 2025 09:08:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4685CF80526; Thu, 10 Jul 2025 09:07:46 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 68F39F804B2
	for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2025 09:07:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68F39F804B2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256
 header.s=mail20170921 header.b=m6uLqEfr
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250710070735epoutp04dc926a8c533b5c55617f6e02bb4ebac7~Q0hfuWH3g0570205702epoutp049
	for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2025 07:07:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250710070735epoutp04dc926a8c533b5c55617f6e02bb4ebac7~Q0hfuWH3g0570205702epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752131255;
	bh=ocJtS6jXeU938kHSDICEvHMlpPd1ymK+OTM7LO9g54I=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=m6uLqEfr/gRB3eWvwZ7i7m721EbN+D/FA5rp8N0lfd1Ya2jYLn/Eh5ck7zzPmu2g0
	 DWsGYQ5FKMCTeqMlciF0ro8Q5rGaTPfCSoei8jp4iPGvziYcEqL8AKLSVx88LhV9jA
	 as8DmFfLHcSM0XgCqiwPIQF6lU4bSMGa/Gs77jUk=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20250710070734epcas2p403d8929c9d056f22eb961ef63e1d3703~Q0hfCFwFu1887718877epcas2p40;
	Thu, 10 Jul 2025 07:07:34 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.98]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bd5Wn4TQBz6B9mL; Thu, 10 Jul
	2025 07:07:33 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250710070732epcas2p4e181084f4733cc0514c2257e468cccf2~Q0hdkQnfD1887318873epcas2p4P;
	Thu, 10 Jul 2025 07:07:32 +0000 (GMT)
Received: from KORCO193562 (unknown [12.36.160.57]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250710070732epsmtip185e7fbac963c7ffe1a1942119a27b49c~Q0hdhicsW2331023310epsmtip1R;
	Thu, 10 Jul 2025 07:07:32 +0000 (GMT)
From: =?ks_c_5601-1987?B?sejAur/s?= <ew.kim@samsung.com>
To: "'Mark Brown'" <broonie@kernel.org>
Cc: <s.nawrocki@samsung.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <aG4sb7UcqvHz_Z5r@finisterre.sirena.org.uk>
Subject: RE: [PATCH] ASoC: samsung: Implement abox generic structure
Date: Thu, 10 Jul 2025 16:07:32 +0900
Message-ID: <01a301dbf169$4e7656c0$eb630440$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGD3td0XDcdc/GKkWKGNfQw8ZJQZQD9NwnZAhfWmTW0wmquUA==
Content-Language: ko
X-CMS-MailID: 20250710070732epcas2p4e181084f4733cc0514c2257e468cccf2
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250709002150epcas2p467416bdbc16754726599a0cacb1feecc
References: 
 <CGME20250709002150epcas2p467416bdbc16754726599a0cacb1feecc@epcas2p4.samsung.com>
	<20250709001002.378246-1-ew.kim@samsung.com>
	<aG4sb7UcqvHz_Z5r@finisterre.sirena.org.uk>
Message-ID-Hash: NPQPKXYW4INTTRJWJ4YMF6RNIJV2BCAC
X-Message-ID-Hash: NPQPKXYW4INTTRJWJ4YMF6RNIJV2BCAC
X-MailFrom: ew.kim@samsung.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NPQPKXYW4INTTRJWJ4YMF6RNIJV2BCAC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thank you for your detailed review.
We will proceed to remove unnecessary logs and code, as well as make
changes to some APIs accordingly.

Based on the feedback provided during your review, we will revise our work
and submit it again upon completion.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, July 9, 2025 5:47 PM
> To: ew.kim@samsung.com
> Cc: s.nawrocki@samsung.com; lgirdwood@gmail.com; perex@perex.cz;
> tiwai@suse.com; linux-sound@vger.kernel.org; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: samsung: Implement abox generic structure
> 
> On Wed, Jul 09, 2025 at 09:10:02AM +0900, ew.kim@samsung.com wrote:
> > From: ew kim <ew.kim@samsung.com>
> >
> > Implemet basic abox generic drivers.
> > This driver is a management driver for the generic drivers used in
> > Automotive Abox, connecting them to SOC drivers.
> > It supports various Exynos Automotive SOCs.
> 
> I can't really tell what the driver is supposed to do from this - what is
> abox?  Looking at the code I'm not really much clearer, to a large extent
> because it doesn't seem to integrate with the subsystem (or other kernel
> subsystems) at all.  It looks like this might be intended to control a DSP
> offload system, but it's not 100% clear, and it seems like there's an
> ioctl() interface which it looks like it's exposing internal abstractions
> to userspace.  This needs to be some combination of much more clearly
> explained and better integrated with the existing kernel subsystems, right
> now I can't really review it effectively because it's hard for me to tell
> what the code is trying to do.
> 
> I've got a few very supreficial comments below but really there's a
> structural problem that needs to be addressed first.
> 
> > +++ b/sound/soc/samsung/auto_abox/generic/abox_generic.c
> > @@ -0,0 +1,568 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> > + *        http://www.samsung.com/
> 
> It's now 2025...
> 
> Please also make the entire comment a C++ one so things look more
> intentional.
> 
> > +//#define DEBUG
> 
> Just delete this, it can be added if needed.
> 
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/delay.h>
> > +#include <linux/suspend.h>
> > +#include <sound/soc.h>
> > +#include <sound/soc-dapm.h>
> > +#include <sound/pcm_params.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/types.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/sched/clock.h>
> > +#include <linux/ktime.h>
> > +#include <linux/iommu.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/kmod.h>
> > +#include <linux/umh.h>
> > +#include <linux/string.h>
> 
> Do you really need all these headers?
> 
> > +static struct abox_generic_data *g_abox_generic_data;
> 
> This isn't really the kernel style - neither the g_ naming, nor the
> concept of having a global for a driver.
> 
> > +/**
> > + * @cnotice
> > + * @prdcode
> > + * @Sub_SW_Component{abox_generic}
> > + * @ALM_Link {work item url}
> > + * @purpose "get value from virtual address"
> > + * @logic "return global abox_generic_data"
> > + * \image html
> > + * @params
> > + * @param{in, -, -, -}
> > + * @endparam
> > + * @retval {-, struct *abox_generic_data, !NULL, NULL}  */
> 
> This is not the style for kernel comments, and doesn't seem to make
> terribly much sense.

