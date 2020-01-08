Return-Path: <SRS0=reWy=25=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF7FC33C9E
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:47:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0599F2073A
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FTk9L7q1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="Dn/SOaBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0599F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8238170D;
	Wed,  8 Jan 2020 10:30:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8238170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578475859;
	bh=RaLqjYZP20LC8weu5N6V0NzQo5u2EyisfnSkQKCq4lc=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FTk9L7q1/DdPi8kJCo2adPQH8gbApQ8mh/Vx29ApvMecM6fBMKcTh2K5zj/u49EqX
	 4a/psaF9RUGYEa9yk04aM8s0hMFyj19z9G0wR/qs3fvLdW2UL7IWVv/A6FdfxC49Ql
	 iFDgcqvfa7qymu9qgQVivE/7ZOCvy3iesAAaKb68=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5997BF80149;
	Wed,  8 Jan 2020 10:30:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89E2BF80159; Wed,  8 Jan 2020 10:30:07 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B2E8F8010B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2020 10:29:56 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5123DA003F;
 Wed,  8 Jan 2020 10:29:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5123DA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1578475796; bh=NOMF12Z492qKFfZQNJjWlxJcU+cfzz3wlX1rnauCMEU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Dn/SOaByeBtaUI2NEe+FUKRs3eT6kplXvA3Mj+pFanbl5acaieh5rvIbEN5y38YVz
 X+vm0cn7D4fjlUcv6tPkO8AoypIGwJO+VsbtsZZff81GPqQ/xc+hAnt2sFpy+gMSLA
 8UzpD9XhBwCRHtGjUlmSsURxuX+SyVU6PtJYDHPs=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  8 Jan 2020 10:29:53 +0100 (CET)
To: Kailang <kailang@realtek.com>,
 "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
References: <6d3af68aa0fe48848c62943e9a342698@realtek.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <e37b9322-5f47-2d8d-45d0-100169300747@perex.cz>
Date: Wed, 8 Jan 2020 10:29:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <6d3af68aa0fe48848c62943e9a342698@realtek.com>
Content-Language: en-US
Cc: "\(alsa-devel@alsa-project.org\)" <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] Add quirk for Lenovo X1 Yoga
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 08. 01. 20 v 10:19 Kailang napsal(a):
> Hi Takashi,
> 
> Attach patch was for Lenovo X1 Yoga.

Remove the 'Fixes:' line. It's the different device. Otherwise:

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> 
> BR,
> Kailang
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
