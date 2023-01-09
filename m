Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59797C54EBD
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Jan 2023 16:11:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8966AA75;
	Mon,  9 Jan 2023 17:10:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8966AA75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673280695;
	bh=HLgtPdA65+mQfQm5WkzovBOu6BONQCqDIp6Ib66Dv/U=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ropgoYckM92lQ0akt/nHc2tzjB6nU7ZVnJX/R7JGsNoUO05NgzAC3AX5MFkW7idj2
	 Opwxq4wqMWhP7gYjdzJ2uLcMSNjt0stK96VeIzmCRaGg8EhaL1gd10L7jGgWL9iITP
	 378J7MgvCrO3FDEK4tPGtOiho4ZkLObxhCmiMDLI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D54AF80425;
	Mon,  9 Jan 2023 17:10:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEF2DF8030F; Mon,  9 Jan 2023 17:10:42 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D2D1F8026A
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2023 17:10:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D2D1F8026A
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KjojKt1j
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 41C85611B6;
 Mon,  9 Jan 2023 16:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DF1C433EF;
 Mon,  9 Jan 2023 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673280638;
 bh=HLgtPdA65+mQfQm5WkzovBOu6BONQCqDIp6Ib66Dv/U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KjojKt1ju8VC0jtrC5l8DbSKl5Yo3fgDHQsWNRlBDmH/BsWvEpJReFHNnjLIQTRbQ
 Z/YZe0YSran0mYD9pvwbIOCCr1uzwB6BqSqI5zduRqdH/5EQ74FMeL6NkuVjkoK+s1
 67B+NYnIXANnvSq0ZLAdpzvyJ6iN9c6TmPJ2sCh1JXQu98BY8EfkGhzaktjdHC5J84
 Ai5Pc5FgNYoXsTkMcjskHt6CTNgteQ9uXAWplyukiVs0zydnE+N280hdf+dgx/FXaw
 Hlpsb42WRr8B6owVWVK2UBtYzZQRCWFqrJBMMLBRvVnDJCb9LIFPLZ31JWd5UXQOEQ
 586mnkAJaAjfw==
Date: Mon, 9 Jan 2023 21:40:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: Re: [PATCH] soundwire: cadence: remove unused sdw_cdns_master_ops
 declaration
Message-ID: <Y7w8e/W3ckrOFFjT@matsya>
References: <20220911093442.3221637-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911093442.3221637-1-cuigaosheng1@huawei.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 shreyas.nc@intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 11-09-22, 17:34, Gaosheng Cui wrote:
> sdw_cdns_master_ops has been removed since
> commit c91605f48938 ("soundwire: Remove cdns_master_ops"),
> so remove it.

Applied, thanks

-- 
~Vinod
