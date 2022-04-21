Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F940C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 13:33:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E081016F8;
	Fri, 22 Apr 2022 15:32:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E081016F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650634413;
	bh=1ZrYRyDHAKh247fQDUgXrlOMZtr/U466EC2/ch5CNwQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d7TXXhKDrF6A5VAROo6FyjV5o8W4O5YV0wM34cxvuNgZE2pcw4+59TD+JTzInvF6M
	 CBQUpWndwkMrkSjHnVTufZh2eyxixJAuL4e+294ya2VbFebwnvPDze5N5Zv9wsi01C
	 8fNz0btq1IahaxyLOmRoRL+TZ9ajdV0yJ10xZhz0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08B7CF80508;
	Fri, 22 Apr 2022 15:31:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0085F80279; Thu, 21 Apr 2022 08:17:48 +0200 (CEST)
Received: from muru.com (muru.com [72.249.23.125])
 by alsa1.perex.cz (Postfix) with ESMTP id 8139AF800F4
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 08:17:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8139AF800F4
Received: from localhost (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id D7D83811B;
 Thu, 21 Apr 2022 06:14:47 +0000 (UTC)
Date: Thu, 21 Apr 2022 09:17:37 +0300
From: Tony Lindgren <tony@atomide.com>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 17/41] ARM: omap1: move 32k counter from plat-omap to
 mach-omap1
Message-ID: <YmD3ATc4CBESln6j@atomide.com>
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-18-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419133723.1394715-18-arnd@kernel.org>
X-Mailman-Approved-At: Fri, 22 Apr 2022 15:31:40 +0200
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-usb@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>,
 aaro.koskinen@iki.fi, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Helge Deller <deller@gmx.de>, jmkrzyszt@gmail.com,
 Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, linux-serial@vger.kernel.org,
 linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Felipe Balbi <balbi@kernel.org>, Paul Walmsley <paul@pwsan.com>,
 Jingoo Han <jingoohan1@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Hilman <khilman@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, alsa-devel@alsa-project.org
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

* Arnd Bergmann <arnd@kernel.org> [220419 13:36]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> omap2 stopped using this code with commit 8d39ff3d1696 ("ARM: OMAP2+:
> Remove unused legacy code for timer"), so just move it to mach-omap1 now,
> along with the other half of that driver.

BTW, if omap1 gains devicetree support, chances are that the
drivers/clocksource/timer-ti-32k.c will be usable with minor
modifications.

Regards,

Tony
