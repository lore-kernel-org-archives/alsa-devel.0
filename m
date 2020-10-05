Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADACAC4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:22:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1363120774
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z5XSJcr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1363120774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scripple.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01641178A;
	Mon,  5 Oct 2020 17:21:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01641178A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601911366;
	bh=hC+sldvpFc4u0MxmGOIK0BFU00ZY2X4ec9qZnqXGKMA=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z5XSJcr6IcXgWWa1QJKBvAeqXv6k0z4sfkpdw3LuaVk6BHbyDqNOXxHOvfmrkrb2N
	 9utAcjKxcQmQPCiTzp3EwPpMP57SclUPdQK+/RbysmAb8FEPfRgqDpi56VDm73R6Yr
	 4J8XfJJjc6wjrmhfh2JEffEfwgQ2SQiE7pXIZcWU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89217F80121;
	Mon,  5 Oct 2020 17:21:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36893F8025A; Mon,  5 Oct 2020 17:21:54 +0200 (CEST)
Received: from host.schells.com (host.schells.com [162.211.87.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFEFDF800C9
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 17:21:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFEFDF800C9
Received: from ip72-222-173-254.ph.ph.cox.net ([72.222.173.254]
 helo=benji.seadrac.com) by host.schells.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <alsa@scripple.org>)
 id 1kPSJ3-0007T4-G5; Mon, 05 Oct 2020 08:21:41 -0700
Received: from [IPv6:::1] (localhost [IPv6:::1])
 by benji.seadrac.com (Postfix) with ESMTP id C0D6F239FF8;
 Mon,  5 Oct 2020 08:21:38 -0700 (MST)
Subject: Re: Loopback device respond to changing parameters on the other end.
To: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
References: <44f29dca-c238-d90c-4221-0f5265d61019@schells.com>
 <691bd7f1-cf08-014a-6d8d-da7c50fdab91@ivitera.com>
From: alsa@scripple.org
Message-ID: <3b12f1e6-4689-1cb7-c658-455bea99eccd@schells.com>
Date: Mon, 5 Oct 2020 08:21:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <691bd7f1-cf08-014a-6d8d-da7c50fdab91@ivitera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: cs@schells.com
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

On 10/5/20 12:12 AM, Pavel Hofman wrote:> There used to be a 
notification module parameter (pcm_notify) which
> closed the other loopback side if params changed 
> https://mailman.alsa-project.org/pipermail/alsa-devel/2020-March/165454.html 
> 
> 
> I am afraid it remains to be fixed.
Thanks for the info. That does seem to be what should be the solution. 
It doesn't seem to be being worked though.

I'd still like to know if there's a way to get the new hw_params inside 
the hw_params modify hook.  Certainly that seems like information that 
should be available in the call back.

scripple
