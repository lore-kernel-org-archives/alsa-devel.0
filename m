Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82738C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:15:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2901720717
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DhXZAxDq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="U3Bs7RfV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="Ha+v9TSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2901720717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E16E7167D;
	Thu, 17 Sep 2020 21:14:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E16E7167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600370102;
	bh=+A3GyX3EIuvaRXVq7oYWarw+OjGUzWdNEe9UVXDEnZk=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DhXZAxDqMh3FQ9V1LLf9g2EU4TkLdjZ/N3vnaBYXV649rDY6TD2usYj3n3WTz5cbj
	 X3Sz0X0pbgzzMdE9hrSEwvxL22s8X42Y9MWjP2HpgLlN026e2I0t0aN8Izb8gVL3NW
	 2L0ZafH8m0noIRBZqSUWRJ6cW0b/3FLd2ET4JCUo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66287F8013A;
	Thu, 17 Sep 2020 21:14:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50A41F80212; Thu, 17 Sep 2020 21:14:10 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29270F8013A
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 21:13:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29270F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="U3Bs7RfV"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="Ha+v9TSQ"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 36E3DA2BACB52;
 Thu, 17 Sep 2020 21:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1600370037; bh=+A3GyX3EIuvaRXVq7oYWarw+OjGUzWdNEe9UVXDEnZk=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=U3Bs7RfVYkvIThSIUoqndhqbY6/yj9M2hbHtCXaDW+VN4hsvE55dfFhoOu1Q2Fxy7
 +1C5fZmMICbF0dAPDQgBOnZ/qTwQeL+Cht7yfxOvXbnxu1h2wFKXb3kM2r4oVMTjmm
 StpniyCQASSei9Z4lDMlrAga/BOhRarTvRZMb0gY=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N0faAWPmAmoH; Thu, 17 Sep 2020 21:13:51 +0200 (CEST)
Received: from [192.168.105.119] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id ADE64A2BACB4F;
 Thu, 17 Sep 2020 21:13:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1600370031; bh=+A3GyX3EIuvaRXVq7oYWarw+OjGUzWdNEe9UVXDEnZk=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=Ha+v9TSQVDRQrHzuKMnOIJl2bp1cszRZRGyAaFfIxXjq+t26kTub7kAe/S8iG7VrS
 TczG0P6oHXy05ZIW1Fr6sxEN9Y1TLl8Ynj7FNa+IOzrZQs7BXnJCCsvcLpbY8fuWio
 lU/nwDQr6FTcr+a7HkPL78nw8wTsg3BGvQ5SrbAA=
Subject: Re: pcm_meter.c issue at s16_update
To: Go Peppy <peppy.player@gmail.com>, alsa-devel@alsa-project.org
References: <CAANJKekdzYeO7vp9o30a4yiB0M8mqjpuf2ZOPem4d8Ma_V8bjA@mail.gmail.com>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <f05763b6-7b1a-29d1-3072-0642bca3d306@ivitera.com>
Date: Thu, 17 Sep 2020 21:13:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAANJKekdzYeO7vp9o30a4yiB0M8mqjpuf2ZOPem4d8Ma_V8bjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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

Hi,

Dne 15. 09. 20 v 5:40 Go Peppy napsal(a):
> 
> Just to remind what the issue is - while switching from one web radio
> station to another there is a high CPU usage for about 20 seconds. Because
> of that high CPU consumption almost all other processes are blocked.

20 seconds is only due to 32bit kernel on RPi. On 64bit machines the 
boundary value is usually many orders of magnitude larger, basically 
making the method never finish.

With regards,

Pavel.
