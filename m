Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06741C2BA83
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:22:08 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC3221569
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC3221569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFE5E1665;
	Wed, 12 Feb 2020 17:20:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFE5E1665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581524505;
	bh=ZYMuSMHQuYw/SXBQXmRkba3AhZwaU26DYS25jzNyRPQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gAmHV4o9x2UCqCiS/lmQieOqIjurw/uO6qUbzh3K3g1C8Mqf56uI1VyAJ36px9ZsM
	 PRXUn6puMcUH87HjoDTbJqafyV0jFJ+yRQI8oLBmxqnz2FbnHKQ05lPfAWKkKPm8s8
	 JY+6SVw7gP13EZ5ZUoUt5ELw31aENkXcit+iRKvU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CEFAF8014F;
	Wed, 12 Feb 2020 17:20:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83146F80157; Wed, 12 Feb 2020 17:20:53 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C429CF80125
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 17:20:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C429CF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="olbpfkI4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=+UKmHxiuZF1shyZt5oca8fTPDu1pZzR6zzY6ICKT86M=; b=olbpfkI4hWORuzwrfVqSmdX12v
 4GgVopStHyZZAtAuXxWOKGr4+I+xfs7Xi35KHn2imuxJzCSDloJUjXlJ9wnF/RKvrOi0vo6BOQ7w9
 R3Em34rcq1/DtrWFt86iXuM47N6ZZpkfv54V/B0cWv3lwcAxk+Y3D7ZfMe5KWJG92MSNx+czhrqU3
 eXna46aLU0ZvuTQfdxEswxUcaP/3xRWnXq8RXvYsnznVprHK8RrQ7aNrykYkLEFyflxpSSTXd96Fa
 JBCA1QFY2SNReCR0BnqzgxAjuZaoGcX4cwBvGdxJkzEyJVKF8j8HiTopT72KlLp/0H3xCqB/pbUtm
 F7B6qsBQ==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1uko-0004pe-6K; Wed, 12 Feb 2020 16:20:46 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20200212145650.4602-1-geert@linux-m68k.org>
 <20200212145650.4602-2-geert@linux-m68k.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4cd8ffb2-0d3c-dd04-5cf7-bd4d6ccb9d43@infradead.org>
Date: Wed, 12 Feb 2020 08:20:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212145650.4602-2-geert@linux-m68k.org>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: Fix SND_SOC_ALL_CODECS imply SPI
	fallout
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2/12/20 6:56 AM, Geert Uytterhoeven wrote:
> Fixes for CONFIG_SPI=n:
> 
>     WARNING: unmet direct dependencies detected for REGMAP_SPI
>       Depends on [n]: SPI [=n]
>       Selected by [m]:
>       - SND_SOC_ADAU1781_SPI [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
>       - SND_SOC_ADAU1977_SPI [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
> 
>     ERROR: "spi_async" [...] undefined!
>     ERROR: "spi_get_device_id" [...] undefined!
>     ERROR: "__spi_register_driver" [...] undefined!
>     ERROR: "spi_setup" [...] undefined!
>     ERROR: "spi_sync" [...] undefined!
>     ERROR: "spi_write_then_read" [...] undefined!
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


thanks.
-- 
~Randy

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
