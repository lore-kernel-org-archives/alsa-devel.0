Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C89CC47082
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 22:19:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889B9613DA
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 22:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889B9613DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jacquin.bzh
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45764170E;
	Fri,  4 Jun 2021 00:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45764170E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622758782;
	bh=jt6fW0lp64VOl0II5IDX3ZhKas82lzkBPi0CMQQSW8U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bFI8ZxOZAdODKzGpEVfrKJcScTQ8T67VNw2506/6mlYtz8RuWmFbKvTvz5/A2O/Oi
	 9lIWZaaBuiElpbNmxs2CPt/vYaPWNBnRUXlyTPDp5ZD1ztq6iQxDKWnpvY7d8qoip1
	 ZwW/M8bsdBoGoEVwwEmPPzg0/RTcYnaatWHXJllA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2E14F80253;
	Fri,  4 Jun 2021 00:18:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09791F8025B; Fri,  4 Jun 2021 00:18:38 +0200 (CEST)
Received: from toothrot.meleeweb.net (toothrot.meleeweb.net [62.210.131.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00103F80100
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 00:18:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00103F80100
Received: from [80.111.226.61] (port=51724 helo=lady-voodoo.scabb)
 by toothrot.meleeweb.net with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 id 1lovfW-0045zT-Sg; Fri, 04 Jun 2021 00:18:26 +0200
Date: Thu, 3 Jun 2021 23:18:25 +0100
From: Bertrand Jacquin <bertrand@jacquin.bzh>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: snd-soc-lpass requires REGMAP_MMIO
Message-ID: <YLlVMdJeqCjXJEAD@lady-voodoo.scabb>
References: <20210529184957.373232-1-bertrand@jacquin.bzh>
 <20210601125939.GA4322@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210601125939.GA4322@sirena.org.uk>
Jabber-ID: bertrand@jacquin.bzh
X-GPG-Key: 0xA3B5C016618D9AAA
X-GPG-Fingerprint: D71B FE62 F66F 3C8B 1A25  A461 A3B5 C016 618D 9AAA
X-GPG-URL: https://sks-keyservers.net/pks/lookup?op=get&search=0xA3B5C016618D9AAA
User-Agent: All mail clients suck. This one just sucks less.
Cc: alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, tiwai@suse.com
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


On Tuesday, June 01 2021 at 13:59:39 +0100, Mark Brown wrote:
> On Sat, May 29, 2021 at 07:49:57PM +0100, Bertrand Jacquin wrote:
> 
> > This does also apply to other Qualcomm Macro LPASS all making call to
> > devm_regmap_init_mmio()
> > ---
> >  sound/soc/codecs/Kconfig | 4 ++++
> 
> A Signed-off-by is required for patches, please see submitting-patches.rst 
> in the kernel tree for details on what this is and why it is important.

This sounds legit, I have submitted an updated version.

Cheers,

-- 
Bertrand
