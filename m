Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200FDC63793
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:18:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272E861353
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272E861353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5ECA016E4;
	Thu, 22 Jul 2021 16:18:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5ECA016E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626963536;
	bh=b1644+lt/CLt2y1BrUgtSKpye3yq+XLJ88kLrk3Z5sQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d/5cV8KkyrzHCNXEnDQjaiv6Ga+fpX3kL+Lx7Yx/FyUUqH1JPNCojoLb0lGSE6Gzm
	 nO8yEqf68qa2jm+3DflfUhRr10hGB6xh/shKBxjLcoYknte4ZTtdOb3niDJ4xFXTan
	 0z3w8/KqKpx9boi1WpgAZO/Yz2g4+eBypnb24Qt0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9952F802E0;
	Thu, 22 Jul 2021 16:17:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 994ACF8032B; Thu, 22 Jul 2021 16:17:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B353F80114
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 16:17:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B353F80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="m0TehVqA"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C12886128D;
 Thu, 22 Jul 2021 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626963466;
 bh=b1644+lt/CLt2y1BrUgtSKpye3yq+XLJ88kLrk3Z5sQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m0TehVqAPaV+xHqi7bCZDUIYUvLDFrpkWOYonPSMmu9m6pDE125bXXA3wPwsBY7xS
 tMTkQbN3qxPx6jI7S9/CmG105hZpF25mPYd1YBuHIxXAt2ioPKce8KgOXNhvMdZl5K
 Cn8tNIGaKvhq5/C7gxog5df2V630JaYUM2UOctlYCGyda7IPlVZ/pODJhy3l7/ia5A
 9rWgHoL2QHULqXWV7aO2Xu6Q37zFXNL80QKbZTv/+5I9WZ/X6Hj46DZibOILU2KQYZ
 x3u6S/3olVAANAa8fsQXQoqqKAS4dP7sr0XBmWoOkhsLNp5AqqhPKyubEkh6wYO6nN
 I6iargh1gwXOg==
Date: Thu, 22 Jul 2021 19:47:42 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: cadence: Remove ret variable from
 sdw_cdns_irq()
Message-ID: <YPl+BrBL85aX1/uT@matsya>
References: <20210714015555.17685-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714015555.17685-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On 14-07-21, 09:55, Bard Liao wrote:
> From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> 
> The ret is not used in the interrupt handler, it is just returned without
> any condition or change.
> We can return the IRQ_HANDLED directly.

Applied, thanks

-- 
~Vinod
