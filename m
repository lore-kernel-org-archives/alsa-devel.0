Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B38EB64D8
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 14:10:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F396982B;
	Wed, 21 Jun 2023 16:09:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F396982B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687356622;
	bh=o+bXHm+qij4RZmFXZzvzBcIxhC0IO3kDLf1U7jrl850=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fMHVxgjgmpboOXEULE7h4V7TGEkhOdDhhIFtYEtm0zzaMjRI7pv4jaHXtlpLfRb8j
	 jhtNTxCKBXCdhDsJT0UchTswjJ1y353XFrLXVIaut4yUYdy3opEpMHq3YfzaFb+opc
	 0wnOrT6MfUrXuytD+tt/+QDBt69vyOvk4ZdtCZZ4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C7A9F80163; Wed, 21 Jun 2023 16:09:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 637CFF80141;
	Wed, 21 Jun 2023 16:09:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 681DCF80141; Wed, 21 Jun 2023 16:09:01 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 84AB3F80093
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 16:08:58 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 762631E36;
	Wed, 21 Jun 2023 16:08:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 762631E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1687356537; bh=hWXdhsVQpB/+odxLGC42YI96+2wDIp0AX9bS19+Gdls=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=hRxm4WlyJw2csmDx+4MIHfUDNvERGecyaCSIxZONPgugcwVP2EkzFT0MtkQimGTzQ
	 p2SQK9SuEZdc6vsQGGJLj712XnD/+bHpNaqzyPhyRDm3oa8c5e+3dIFxRb5+T1l8z0
	 BeqR/fZQCBqx+siJoyuTH6gKZhg9OUiLUMfi+a4s=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Wed, 21 Jun 2023 16:08:48 +0200 (CEST)
Message-ID: <443f697b-fecf-6e8e-0b76-65257aff7da8@perex.cz>
Date: Wed, 21 Jun 2023 16:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: kernel@collabora.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20230620220839.2215057-1-nfraprado@collabora.com>
 <20230620220839.2215057-3-nfraprado@collabora.com>
 <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration
 from 4 to 2 seconds
In-Reply-To: <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LXGZMMRKE3CW6DXXBEDKUERI6LPZPSB6
X-Message-ID-Hash: LXGZMMRKE3CW6DXXBEDKUERI6LPZPSB6
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LXGZMMRKE3CW6DXXBEDKUERI6LPZPSB6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 21. 06. 23 15:08, Mark Brown wrote:
> On Tue, Jun 20, 2023 at 06:08:26PM -0400, Nícolas F. R. A. Prado wrote:
> 
>> -	const int duration_s = 4, margin_ms = 100;
>> +	const int duration_s = 2, margin_ms = 100;
> 
> This doesn't scale the margin with the duration which will affect the
> sensitivity of the test to misclocking.  It should make it less
> sensitive which is *probably* safer but at least worth noting.
> 
> We might also have issues with some of the lower sample rates, IIRC some
> devices are constrained in ways that mean they want a minimum buffer
> size which is harder to satisfy with very short playbacks and low sample
> rates.
> 
> I don't know why Jaroslav picked the 4s number here.

You basically replied yourself. The values (time + margin) were picked to do 
the DMA test for a reasonable time - based on my experience.

I think that the problem is somewhere else here. The overall test timeout 
should be calculated dynamically. All tests may be queried for the maximal 
expected interval based on the hardware/software capabilities. It's a bit 
pitfall to have a fixed time limit where the realtime tests depend on the 
number of devices.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

