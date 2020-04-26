Return-Path: <SRS0=mTWV=6K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADEFC55199
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 08:56:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A17920700
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 08:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UPeCjgbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A17920700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D40961669;
	Sun, 26 Apr 2020 10:55:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D40961669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587891403;
	bh=BS1fN1DNCOOGWEVK8AV8fRFLvuOb44Ub1tmQZyFB6zA=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UPeCjgbY5dLpaMfgnclwoJhEsWj6LqzFUwgm9ijewaT0fAUZtiXB6qaGSU1cQaloB
	 rLJeUO0zRz9wtVEZbP/muM7/Ot0qLpcgveNqYgGFmnEDSJCaKZGJZGYaUC5BJyeM6p
	 EQ1whD7uq6xQY2G4fEtKPP2YHUZmoKO/QmslxFc8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6458EF80136;
	Sun, 26 Apr 2020 10:55:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D172F801DB; Sun, 26 Apr 2020 10:55:51 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81A1FF8010A
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 10:55:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81A1FF8010A
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 12049A1F2C731;
 Sun, 26 Apr 2020 10:55:43 +0200 (CEST)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OmA7wK9_Nxo0; Sun, 26 Apr 2020 10:55:37 +0200 (CEST)
Received: from [192.168.105.191] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id E0589A1F2BCF8;
 Sun, 26 Apr 2020 10:55:36 +0200 (CEST)
Subject: Re: High-bandwidth/multiple transactions per microframe in usb audio?
To: Alexander Tsoy <alexander@tsoy.me>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <ee53ad0d-2d61-545b-7afd-64a5ed37c702@ivitera.com>
 <548c8312bd8ad65993c3169faf30054fdfa83558.camel@tsoy.me>
 <3a44ca23-f0ed-af54-3e63-8bf77d833c8f@ivitera.com>
 <253259a4ef8a2bcfa0568982b8fd23d5e2d0937a.camel@tsoy.me>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <dbaba3f0-88b8-21f2-b7dc-5e1c5fadc675@ivitera.com>
Date: Sun, 26 Apr 2020 10:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <253259a4ef8a2bcfa0568982b8fd23d5e2d0937a.camel@tsoy.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Dne 25. 04. 20 v 21:50 Alexander Tsoy napsal(a):
> В Сб, 25/04/2020 в 20:06 +0200, Pavel Hofman пишет:
> 
> And I just noticed that USB-audio driver can't properly parse max
> packet size for SuperSpeed and SuperSpeed+ devices yet. See
> audio_format_alloc_init().

Very good catch. IIUC there are two basically equivalent calculations
for HighSpeed -

https://elixir.bootlin.com/linux/v5.6.7/source/drivers/usb/core/urb.c#L445


https://elixir.bootlin.com/linux/v5.6.7/source/sound/usb/stream.c#L691


And audio_format_alloc_init missing the sections for SS, SS+ in
usb_submit_urb . Perhpas a common method to make the calculation for all
cases would make it more robust?

Thanks,

Pavel.
