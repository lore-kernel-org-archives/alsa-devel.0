Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4B4C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jan 2022 20:00:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D64C1174A;
	Mon,  3 Jan 2022 20:59:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D64C1174A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641240009;
	bh=ygk9vpP3wQIwP3TpLe+oxTCCaE18Xsq2EiXMl4DpFk4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MEErzHje6KYK3aT0xd+Sr/9B2EETzMtYBi7ETIrdF4NSQ8Piq6V4EGMLb3iFrEslC
	 xH26+UgDC3+MvceLaDUh1H8CAP4qZMo0EgFvBToebHT0MQ7ixjq06rOvsK4ZKgFew5
	 JEAgyh0unFMisyhqKUSKZth8vnOdT09ioCPyQNlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9F3FF800FF;
	Mon,  3 Jan 2022 20:58:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05653F800FF; Mon,  3 Jan 2022 20:58:44 +0100 (CET)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by alsa1.perex.cz (Postfix) with ESMTP id 07C97F800FF
 for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2022 20:58:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07C97F800FF
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1n4TTQ-0004X1-01; Mon, 03 Jan 2022 20:58:28 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 2AA2BC0AA0; Mon,  3 Jan 2022 20:51:46 +0100 (CET)
Date: Mon, 3 Jan 2022 20:51:46 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] mips: bcm63xx: add support for clk_set_parent()
Message-ID: <20220103195146.GB10983@alpha.franken.de>
References: <20211229000553.32240-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229000553.32240-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Florian Fainelli <f.fainelli@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Paul Cercueil <paul@crapouillou.net>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, bcm-kernel-feedback-list@broadcom.com,
 Russell King <linux@armlinux.org.uk>, Jonathan Cameron <jic23@kernel.org>
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

On Tue, Dec 28, 2021 at 04:05:53PM -0800, Randy Dunlap wrote:
> The MIPS BMC63XX subarch does not provide/support clk_set_parent().
> This causes build errors in a few drivers, so add a simple implementation
> of that function so that callers of it will build without errors.
> 
> Fixes these build errors:
> 
> ERROR: modpost: "clk_set_parent" [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
> ERROR: modpost: "clk_set_parent" [sound/soc/atmel/snd-soc-atmel-i2s.ko] undefined!
> 
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs." )
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  arch/mips/bcm63xx/clk.c |    6 ++++++
>  1 file changed, 6 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
