Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BFEC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 05:56:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4941960F24
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 05:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4941960F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAB221607;
	Mon, 13 Sep 2021 07:55:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAB221607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631512607;
	bh=wuc/aR8/2QMOnzLBtThvqfbYAspQphQz2hm/GSVeYYA=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LN33mp6z3JqTHC0T0eVp1cAkphshjaylXPNJeX6FcLt/BAd7Y9DYG0G6o48paIMnJ
	 RI385iBBkYW6F6Axm3PlHe7xXOl01PuUyhy3KYQnhe9hDfZPrc3CZySW57LEcCr5bg
	 6J75rNaUjB+T4iYC5HroK1UXV/zwT1ffSSXFk5eE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B529F80128;
	Mon, 13 Sep 2021 07:55:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65F49F8027C; Mon, 13 Sep 2021 07:55:55 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B57B5F80132
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 07:55:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B57B5F80132
X-UUID: a04d09bb2c8a4bf0aef64581cadeaee6-20210913
X-UUID: a04d09bb2c8a4bf0aef64581cadeaee6-20210913
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1343577215; Mon, 13 Sep 2021 13:55:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Sep 2021 13:55:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Sep 2021 13:55:38 +0800
Message-ID: <5fa1e99f1b9097336a3e610dc383170f09036b14.camel@mediatek.com>
Subject: Re: [PATCH v2] ASoC: mediatek: common: handle NULL case in
 suspend/resume function
From: Trevor Wu <trevor.wu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Date: Mon, 13 Sep 2021 13:55:38 +0800
In-Reply-To: <20210910102358.GC4474@sirena.org.uk>
References: <20210910092613.30188-1-trevor.wu@mediatek.com>
 <20210910102358.GC4474@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, dan.carpenter@oracle.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
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

On Fri, 2021-09-10 at 11:23 +0100, Mark Brown wrote:
> On Fri, Sep 10, 2021 at 05:26:13PM +0800, Trevor Wu wrote:
> 
> > When memory allocation for afe->reg_back_up fails, reg_back_up
> > can't
> > be used.
> > Keep the suspend/resume flow but skip register backup when
> > afe->reg_back_up is NULL, in case illegal memory access happens.
> 
> It seems like it'd be better to just allocate the buffer at probe
> time
> and fail in case we can't get it, I'd be surprised if there's many
> platforms using this hardware that don't also end up suspending and
> resuming.

Hi Mark,

Thanks for your suggestion.
I agree it's better to allocate the memory at probe time.
I think we can still keep the implementation in the suspend/resume
function as a fallback solution if user doesn't allocate the memory in
probe function.

In the new mediatek SOCs, regcache has been used to handle register
backup.
Do I need to add the buffer allocation on probe function to the
platform in which mtk_afe_suspend and mtk_afe_resume are used?

Thanks,
Trevor

