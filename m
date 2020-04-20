Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83F2C3815B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:28:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F18206CD
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z5azrLrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F18206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A627B166F;
	Mon, 20 Apr 2020 09:27:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A627B166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587367713;
	bh=iGwhJpZljJ5HD/xTogQHJipG1I1P5qZhQcIlq9rRLKM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z5azrLrRvz9mFEa3cajjUJoptjhNnMABbJadAcM1v88DYSnphhemIVLgSZvIQFE+q
	 eRqBRwCAfqSyCS49+I3hpqih6RnUzoDuzZIkKYuL+NRprg3tdoNnH5mDEskY7d6GF1
	 r6UMoQgZ1QCTcM0S9djgO/o7rrZMboYsdOS8GLJE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D6C8F8013E;
	Mon, 20 Apr 2020 09:27:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90937F8021C; Mon, 20 Apr 2020 09:27:42 +0200 (CEST)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by alsa1.perex.cz (Postfix) with ESMTP id 2357CF8012F
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 09:27:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2357CF8012F
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1jQQqA-00070o-01; Mon, 20 Apr 2020 09:27:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id C3D0DC0181; Mon, 20 Apr 2020 09:02:40 +0200 (CEST)
Date: Mon, 20 Apr 2020 09:02:40 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: MIPS ioremap cleanups v2
Message-ID: <20200420070240.GB4627@alpha.franken.de>
References: <20200416150011.820984-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416150011.820984-1-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-mips@vger.kernel.org
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

On Thu, Apr 16, 2020 at 05:00:04PM +0200, Christoph Hellwig wrote:
> Hi Thomas,
> 
> below is a bunch of cleanups for the MIPS ioremap code.  Compile tested
> only.
> 
> Changes since v1:
>  - don't remove cpu_has_64bit_gp_regs
>  - add a new prep patch to stop txx9aclc-ac97 from poking into ioremap
>    internals

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
