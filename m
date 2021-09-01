Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A69FC4320E
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 17:03:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761F661058
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 17:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 761F661058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dnyon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0264176F;
	Wed,  1 Sep 2021 19:02:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0264176F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630515829;
	bh=/+spJHj+Ngr9m35GSnygXoafdYZCPeBa4DB05TovR0Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=At1TIBH9+5JjS0zCaqRbhDOLGpAhG9cTyD4D9kNRjonfphBZ6FOsV5GGTh6USknxu
	 okwe6aUpWUzoVR2NgBJDnMQ72EvPEPzdvJ/9RMB5biAA5y1tKysDTvAQn+p/NxoBRf
	 6XplrTUe8M3UbjJZiXgXPN754UROJBVzIQuTeG/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A05BF80227;
	Wed,  1 Sep 2021 19:02:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F8F3F80254; Wed,  1 Sep 2021 19:02:58 +0200 (CEST)
Received: from dnyon.com (dnyon.com [82.223.165.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3B58F80218
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 19:02:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3B58F80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=dnyon.com header.i=@dnyon.com
 header.b="2LGBrWEX"
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net
 [81.39.194.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by dnyon.com (Postfix) with ESMTPSA id 999AD40442;
 Wed,  1 Sep 2021 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
 t=1630515768; bh=/+spJHj+Ngr9m35GSnygXoafdYZCPeBa4DB05TovR0Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=2LGBrWEX0C3n8KEvZH5G11zEQYiiY3u9PCs5Ke7nb6gx6CDWkMC4J0ul9t9p3HCIm
 fpMJ2/Y1I+F2zSjR9+TGDYH9vfvaLd11Bpq2B5v4V02naa8KKjh8WugkYyh8x6xZpY
 WjO6DOX4daGBi9/ULAastYAk/azCphtYEW9Uz0eGoZNtkoL49QKKzd9RvXWML+2Zh3
 aSZ1BzYLK367fPJCFZKpTzUToe+FvmdvdiEYpfRF8KoqgAtXiAJNlueNZsHi5dQ7Mo
 eMhFRQckw9kulJARNQjW25I6C/9YxyMj7h7chHXRhYweNK2V3wyg33ltWMVhi75PMv
 fRvIaavKwVXZQ==
From: Alejandro Tafalla <atafalla@dnyon.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date: Wed, 01 Sep 2021 19:00:59 +0200
Message-ID: <4673573.GXAFRqVoOG@alexpc>
In-Reply-To: <CAHp75VfgbA0upoHyDLPCRGrN+7H5mZiDu-GbQPxHid++Z9UqQA@mail.gmail.com>
References: <20210830104426.487246-1-atafalla@dnyon.com>
 <20210830104426.487246-2-atafalla@dnyon.com>
 <CAHp75VfgbA0upoHyDLPCRGrN+7H5mZiDu-GbQPxHid++Z9UqQA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree <devicetree@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

On lunes, 30 de agosto de 2021 12:56:23 (CEST) Andy Shevchenko wrote:
> It simply as
> 
>                return dev_err_probe(&i2c->dev, PTR_ERR(reset_gpio),
>                        "failed to request GPIO reset pin");
> 
> > +       }
Alright, I'll make that change. Thank you.


