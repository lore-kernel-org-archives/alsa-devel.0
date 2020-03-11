Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4363C10F27
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:25:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A6320848
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pdghUQ9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A6320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96A64846;
	Wed, 11 Mar 2020 09:25:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96A64846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583915157;
	bh=TR4/i3cYTlVnIqvNUKQrvlEP3L4Fn4IEvor/0OfjOUA=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pdghUQ9YdzxhDdYfSY7U5XCWKYKEaHqurxs++3C82EzN6Rl0fpo/gqICWAmGmO4es
	 WGenzMezw6nEBj6ndRteTy61nwlFP+v5WuvaiYeBfxXNGKjzJ5QfekdEbYDhzFWmby
	 +PC/lAiD2F/Xj8IvC0KA/7seX/HD4Yp+ZKDlkIjw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A385F801A3;
	Wed, 11 Mar 2020 09:25:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFC8EF801EB; Wed, 11 Mar 2020 09:25:04 +0100 (CET)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06761F800BE
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 09:25:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06761F800BE
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 8F82CA1A40B0B;
 Wed, 11 Mar 2020 09:24:59 +0100 (CET)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X4TVpo-iVxyT; Wed, 11 Mar 2020 09:24:59 +0100 (CET)
Received: from [192.168.100.32] (unknown [192.168.100.32])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 62C99A1A40B05;
 Wed, 11 Mar 2020 09:24:59 +0100 (CET)
Subject: Re: [PATCH] alsaloop: reduce cumulative error caused by non-atomic
 samples calculation
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>, alsa-devel@alsa-project.org
References: <1583785794-5173-1-git-send-email-ruslan.bilovol@gmail.com>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <68882db5-b0a8-4a1d-4313-506a9e5a8715@ivitera.com>
Date: Wed, 11 Mar 2020 09:24:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1583785794-5173-1-git-send-email-ruslan.bilovol@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


Dne 09. 03. 20 v 21:29 Ruslan Bilovol napsal(a):
> 
> Be interleaving get_queued_{playback,capture}_samples()
> order, we divide this small error between playback
> and capture paths. I do not see any issues anymore
> with one-way drift of pitch_diff.

Nice simple and effective solution. Thanks a lot!
