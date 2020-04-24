Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2FEC2BA1A
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:40:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9BF20767
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WqAHYQyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9BF20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60F3D16A0;
	Fri, 24 Apr 2020 11:39:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60F3D16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587721249;
	bh=x2gp2/fbjFbxpBuijZ41lNkp0XU8gn6JbbmLOnFn/Qw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WqAHYQyCxY1pc+EurIkpsFL6J10Xu3f4ZVQeiJZCasry+dTsG/bWFgiGxK4vj+lfh
	 G8ZZy1e+16XaHirlwv6SdJPLJ7YR6IU+quErc8XCm4NNv3bUnirKSKmJN1xz3PMJMc
	 FWrtazVXa3Di4Yd748FVDxBBRgeaAEAwb5vc+Prk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE997F80121;
	Fri, 24 Apr 2020 11:39:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81FE8F80142; Fri, 24 Apr 2020 11:39:57 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BDC5F80117
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 11:39:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BDC5F80117
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 9A7D1A1F2BCF5;
 Fri, 24 Apr 2020 11:39:45 +0200 (CEST)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sQAKygH1canS; Fri, 24 Apr 2020 11:39:40 +0200 (CEST)
Received: from [192.168.105.191] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 31226A1F2BCEB;
 Fri, 24 Apr 2020 11:39:40 +0200 (CEST)
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Improve frames size computation
To: Alexander Tsoy <alexander@tsoy.me>, alsa-devel@alsa-project.org
References: <20200424022449.14972-1-alexander@tsoy.me>
 <11dca14b-39a7-635a-a62f-ea10f21aa697@ivitera.com>
 <a876d867496c2c58866a626430dd2f174f16c107.camel@tsoy.me>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <a55e9f9e-c5fa-8602-1766-7b6602e03ef1@ivitera.com>
Date: Fri, 24 Apr 2020 11:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a876d867496c2c58866a626430dd2f174f16c107.camel@tsoy.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, Gregor Pintar <grpintar@gmail.com>,
 Roope Salmi <rpsalmi@gmail.com>
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



Dne 24. 04. 20 v 11:29 Alexander Tsoy napsal(a):
> 
> "sync endpoints" actually means "feedback endpoints" here. This is the
> terminology used by the driver. So it is not the type of
> synchronization of the endpoint for which this function is being
> called. :)
> 
> Probably comment I made for snd_usb_endpoint_next_packet_size() is
> slightly inaccurate, because this function will be also used for
> asynchronous endpoints in the case feedback endpoint is not configured
> for some reason.
> 

OK, thanks for the implementation. Being a noob I got confused. But
still maybe a few words like in your message could clear the noob
confusion, thanks for considering.

Regards,

Pavel.
