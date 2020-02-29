Return-Path: <SRS0=/0g+=4R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20DDC3F2CD
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Feb 2020 23:43:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B4C20828
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Feb 2020 23:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RZ8cjSsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B4C20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8C6B1686;
	Sun,  1 Mar 2020 00:42:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8C6B1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583019785;
	bh=SE2jdqkxJ3Bp0cqn4tIuZ1+kwEXQYU5luWnRE4Pk5+A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RZ8cjSsldwpFxlIrNqXGZFxVda+lMhP0AwJihB17/+1DwnBtufUlkyY+UGJPjPVBp
	 i0Xq85ariqEFFe7AAI0JSgyg+MNueLbq/SSmRw5ViX5XpXXehtUgI51667cizDl5S6
	 bF7XI0z6J3UDAJvYf+PthEeSE3R8x1rtY/vbpqB8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38613F8013E;
	Sun,  1 Mar 2020 00:42:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD61BF8013E; Sun,  1 Mar 2020 00:42:12 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6392F80089
 for <alsa-devel@alsa-project.org>; Sun,  1 Mar 2020 00:42:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6392F80089
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1j8BkC-0004p9-60; Sun, 01 Mar 2020 00:42:04 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Describe RK3328 GPIO_MUTE
 users
Date: Sun, 01 Mar 2020 00:42:03 +0100
Message-ID: <2986513.xosFKxlJ7S@phil>
In-Reply-To: <59fe8a7d-22ab-6098-5266-4fdf4bf41adb@arm.com>
References: <cover.1581376744.git.robin.murphy@arm.com>
 <53637c0359ad9473dc1391a8428ba21017ec467e.1581376744.git.robin.murphy@arm.com>
 <59fe8a7d-22ab-6098-5266-4fdf4bf41adb@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, broonie@kernel.org,
 pgwipeout@gmail.com, linux-arm-kernel@lists.infradead.org
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Am Freitag, 28. Februar 2020, 13:48:50 CET schrieb Robin Murphy:
> Hi Heiko,
> 
> On 18/02/2020 9:32 pm, Robin Murphy wrote:
> > Add explicit properties to describe existing boards' GPIO_MUTE usage
> > for the analog codec.
> 
> Are you happy to pick this up now that the driver patches are queued?

very happy :-)
And applied for 5.7

Thanks
Heiko


