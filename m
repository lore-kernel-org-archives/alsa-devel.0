Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F70C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 23:35:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FC22312F
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 23:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FC22312F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E551B1685;
	Wed, 13 Jan 2021 00:34:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E551B1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610494499;
	bh=jK6xhsvTFBXbJFMHuE82FMHQLf3jl+2+jInTJl+Nuic=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NtThyGQh1z7JbVsQKO/3zAqS7Q0RsH6nkmeSqPBAB/sA2KrDS6yYrOVVm3zblIvuA
	 xy9MYDPmhzc8NeYCSy0lDCjySvXMY4tn4DiIlWJcMeYhx70HhLWdYYuWTw+Fm/b07P
	 WK22lAnu2V3WhjslpMzgy0xvg9VpfB4+aKZKMSMI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B561EF80249;
	Wed, 13 Jan 2021 00:34:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA565F8025E; Wed, 13 Jan 2021 00:34:04 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21C21F80113
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 00:33:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21C21F80113
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr
 [86.202.109.140])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A8AE81BF20B;
 Tue, 12 Jan 2021 23:33:41 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jaroslav Kysela <perex@perex.cz>, Matt Mackall <mpm@selenic.com>,
 linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Richard Weinberger <richard@nod.at>,
 Alessandro Zummo <a.zummo@towertech.it>,
 "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-crypto@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-watchdog@vger.kernel.org,
 alsa-devel@alsa-project.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-ide@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: (subset) [PATCH 00/10] Remove support for TX49xx
Date: Wed, 13 Jan 2021 00:33:30 +0100
Message-Id: <161049432258.352381.2804715824942772218.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210105140305.141401-1-tsbogend@alpha.franken.de>
References: <20210105140305.141401-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
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

On Tue, 5 Jan 2021 15:02:45 +0100, Thomas Bogendoerfer wrote:
> I couldn't find any buyable product other than reference boards using
> TX49xx CPUs. And since nobody showed interest in keeping support for
> it, it's time to remove it.
> 
> I've split up the removal into seperate parts for different maintainers.
> So if the patch fits your needs, please take it via your tree or
> give me an ack so I can apply them  the mips-next tree.
> 
> [...]

Applied, thanks!

[08/10] rtc: tx4939: Remove driver
        commit: 446667df283002fdda0530523347ffd1cf053373

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
