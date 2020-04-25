Return-Path: <SRS0=c9Fs=6J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B59C54FCB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 18:07:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3EC20714
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 18:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ae5v7VTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3EC20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BEE01675;
	Sat, 25 Apr 2020 20:06:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BEE01675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587838058;
	bh=ZP+SwlNI5tkYvq/UkPZgannJJfEdGBzT6TVjgNCqn4I=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ae5v7VTgPhcx2Yw4Y00VKIizukk9M7VVBnfq9EJs1scLW3s0CTPGd/dvS8mBED1vd
	 XdUGc5hao/I9+HcdZhQluAyc2ia+aAkjidwxUpYMmTFyX99xuhftQW+hza3Ro68m1F
	 lV89/QutDPOy07T6fjUQKjBGUL1Au5+LAZbgyAVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A31CBF80159;
	Sat, 25 Apr 2020 20:06:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3998BF801EC; Sat, 25 Apr 2020 20:06:46 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5CFDF800BE
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 20:06:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5CFDF800BE
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 40419A1F2C75A;
 Sat, 25 Apr 2020 20:06:42 +0200 (CEST)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63ENvnpR23G7; Sat, 25 Apr 2020 20:06:35 +0200 (CEST)
Received: from [192.168.105.191] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 45AB1A1EF2C02;
 Sat, 25 Apr 2020 20:06:35 +0200 (CEST)
Subject: Re: High-bandwidth/multiple transactions per microframe in usb audio?
To: Alexander Tsoy <alexander@tsoy.me>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <ee53ad0d-2d61-545b-7afd-64a5ed37c702@ivitera.com>
 <548c8312bd8ad65993c3169faf30054fdfa83558.camel@tsoy.me>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <3a44ca23-f0ed-af54-3e63-8bf77d833c8f@ivitera.com>
Date: Sat, 25 Apr 2020 20:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <548c8312bd8ad65993c3169faf30054fdfa83558.camel@tsoy.me>
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

Dne 25. 04. 20 v 14:06 Alexander Tsoy napsal(a):
> В Пт, 24/04/2020 в 11:42 +0200, Pavel Hofman пишет:
>> Hi,
>>
>> Please does the current USB audio driver support multiple
>> transactions
>> per microframe (high-bandwidth mode)? I could not find it in
>> endpoint.c
>> but it may be there or somewhere else :-)
> 
> This should be transparent for the driver. See usb_submit_urb()
> function from drivers/usb/core/urb.c. It allows packets larger than
> 1024 for isochronous transfers over High Speed and Super Speed buses.

Alexander, thanks a lot for the info and hint, indeed at
https://github.com/torvalds/linux/blob/master/drivers/usb/core/urb.c#L444

Best regards,

Pavel.
