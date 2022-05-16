Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264F6C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 16 May 2022 16:32:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D506484B;
	Mon, 16 May 2022 18:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D506484B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652718745;
	bh=ak/tDBEqGakmgo/bKttKdgOT5M3jiNtP/2gMfzgqz9w=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=epfcJK4wlsJMC0NtNOXlp6ZaoYKMgtgontVV4VL6sFhgl6clQlqf4iOkN56bUCbDD
	 qj5W0+YBAntArV0wX3KJwuR0vWfjegahFmmLe/zZPF8haVsuaA6faSXyH4t0VTWABf
	 mjEPtwzSMb4I2VL2juduop2D3mmHBhG8N5Q6Pp5o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30998F8012F;
	Mon, 16 May 2022 18:31:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22442F8014B; Mon, 16 May 2022 18:31:33 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E893F800F8
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2022 18:31:26 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5E528A003F;
 Mon, 16 May 2022 18:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5E528A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1652718686; bh=PDXwH95oQ6qSlr8QETN9zWwL2T8DWG3tcmVp1MA6LcY=;
 h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
 b=RF+T3iMFo6yco1m3xox5JiZx/SI+bmifQx0Qf4gZwH2hPo8pTwQv6gE//AsnzZ78X
 SrfV0ZZxdik1N+VvPouZBQZ6KzgKnArE5E5QVJQYvyWkZ8ySWhPqQVY3ilegmbkEIX
 G8QVgK2JX0eoHgHu4/PWOggj5sELfUB8ySgiPX4M=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 16 May 2022 18:31:24 +0200 (CEST)
Message-ID: <7d2feff6-e84f-3512-0bcf-f331b5a807a9@perex.cz>
Date: Mon, 16 May 2022 18:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: UCM2 configuration guide
Content-Language: en-US
To: Peter Wedder <pwedder@protonmail.com>
References: <VwoP3j4nu98HV-5itWgDOdFuspSQQHQI_W_SS_WSy25y82ZLj0VupitgOTUv0AmrvI1q7Xx6gJHtm-g68W8QJWgpndDFrd_f-SA8pNp0qp0=@protonmail.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <VwoP3j4nu98HV-5itWgDOdFuspSQQHQI_W_SS_WSy25y82ZLj0VupitgOTUv0AmrvI1q7Xx6gJHtm-g68W8QJWgpndDFrd_f-SA8pNp0qp0=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>
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

On 14. 05. 22 19:43, Peter Wedder wrote:
> Hello,
> 
> I have been working on an article to describe the process of writing UCM2 configuration to split multi-channel devices into smaller devices, particularly in the context of USB audio interfaces. This is a common problem with enthusiast/studio USB audio interfaces and it happens to be a pet peeve of mine.
> 
> I recently contributed a profile for the Behringer UMC204HD (https://github.com/alsa-project/alsa-ucm-conf/pull/128) and found the process to be a little intimidating, but with a lot of help from Perexg I managed to get it working. I would like to help other potential contributors out by explaining the process step by step.

It's because many things are work-in-progress and there's a tight relation 
between UCM and the alsa-lib's configuration.

> I was considering posting the article to the Fedora Magazine (https://fedoramagazine.org/), since that's the distro I use. However, I wanted to check with you, the ALSA maintainers, first, because the intent of the article is to encourage readers to contribute UCM configurations for their own cards, and I thought perhaps a potential surge of contributions is not something you want at the moment.

At the time there's a lot of USB cards configs waiting for the merge, but I'd 
like to clean the configs at first. The per card configurations should not 
bother so much with the alsa-lib configurations. Also, I'd like to support the 
channel management (split) by the applications. The implementation may be 
completely hidden in the included common blocks.

> Let me know what you think -- is this a welcome idea or should I forget it? I have a draft of the article available here: https://gist.github.com/brndd/ccec98a575f7c0422d50402937439227

Thank you for this work. The document looks nice for users dealing with the 
support for this type of hardware. Please, wait a moment to complete this 
support. I will be happy to co-operate with you to finish this.

I created an issue #154 
(https://github.com/alsa-project/alsa-ucm-conf/issues/154) and I'll try to 
update it until this is finished.

					Jaroslav

BTW: perexg = me

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
