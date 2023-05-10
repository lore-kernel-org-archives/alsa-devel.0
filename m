Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E70FC7EE22
	for <alsa-devel@archiver.kernel.org>; Wed, 10 May 2023 06:21:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 501091056;
	Wed, 10 May 2023 08:20:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 501091056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683699689;
	bh=J7b5/M9tUrXef5WmeXG4GbE0QGGEb5sLe1rGiiQOAes=;
	h=Date:To:References:From:Subject:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bWc3Rr8hM4lf4EHDD723EYvfi+g99tM3ca/Es7SK3Dw4QRsSNtmFr4iszbpQBkYJu
	 9FQiCgx+bzdA62wDiggBbJxhqk+kJFcEZlPXuAEqR1HG/xYDJQRwxeTY7/GuKbHUuK
	 Zn2M23gwiepJx9IyBeiL87eFpRpQhp7mfC+m3HIg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D3CAF8032D;
	Wed, 10 May 2023 08:20:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9003FF8032D; Wed, 10 May 2023 08:17:55 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8FF62F802E8;
	Wed, 10 May 2023 08:17:38 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 0150811EF;
	Wed, 10 May 2023 08:17:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 0150811EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1683699458; bh=iSWA2vbtdnqzHut08UQrP1QRZB4ZSw+/s5sMt2tZxDU=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=goxutR8TBeIqiKIOpJPB+XLIzndAQ3goqCL2B1seQgrpf7BOZWE7NyZmgqY/jzV0m
	 u7GVVwzFpY7ky5ah6dfSB9vloW4fM+MT0H/r+kpxa3K12e7nIFZO9c02HiPIdeUjAm
	 Z4OLDjTK39bWKIRMPFeIIkCI5HpF69QhG38M7Vo8=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Wed, 10 May 2023 08:17:30 +0200 (CEST)
Message-ID: <185f52e2-afa5-87fa-c6c3-594f61e5b911@perex.cz>
Date: Wed, 10 May 2023 08:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Geraldo Nascimento <geraldogabriel@gmail.com>,
 Mark Brown <broonie@kernel.org>
References: <ZFMF2cD3nPgpZOpa@finisterre.sirena.org.uk>
 <87o7n0mtv9.wl-tiwai@suse.de> <87ednwmssr.wl-tiwai@suse.de>
 <87wn1jdzuq.wl-tiwai@suse.de> <e76c1395-5eb2-849e-120d-1b7389fc97c7@perex.cz>
 <ZFoUaNKBkIgbW0rD@finisterre.sirena.org.uk>
 <ff43dccf-ba6d-d7fa-352a-5d5a8c4b977f@perex.cz>
 <ZFpaOVRc2E/CZBHI@finisterre.sirena.org.uk>
 <10075912-5c0b-549f-58e1-1323683d250d@perex.cz>
 <ZFr8B5UFx16sz7S0@finisterre.sirena.org.uk> <ZFsWgnAQy5Y/rwyb@geday>
From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: DMARC (Was: Re: [alsa-devel@alsa-project.org: [PATCH 3/5] ASoC:
 mediatek: mt8195-afe-pcm: Simplify runtime PM during probe])
In-Reply-To: <ZFsWgnAQy5Y/rwyb@geday>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: ZEG5YKLLQGP6SCHRE3XM6ZUA25CYRDIP
X-Message-ID-Hash: ZEG5YKLLQGP6SCHRE3XM6ZUA25CYRDIP
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 sound-open-firmware@alsa-project.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZEG5YKLLQGP6SCHRE3XM6ZUA25CYRDIP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 10. 05. 23 5:58, Geraldo Nascimento wrote:
> On Wed, May 10, 2023 at 11:05:59AM +0900, Mark Brown wrote:
>> AFAICT the only other option is munging the From without enclosing the
>> message in a wrapper?  That's potentially marginally less harmful but
>> it's still going to break things badly enough that I'm not sure it's a
>> worthwhile improvement.
> 
> The readymade mitigations for DMARC in mailman 3 are
> "munge_from" and "wrap_message". The fact "wrap_message" messes
> around with signatures in mutt is definitely not a good sign,
> and "munge_from" will change the author's email and name from
> the perspective of git-am.
> 
> The middle way could be to patch mailman 3 to "munge_from" while adding
> the correct "From:" as the first thing in the body of the message if it
> doesn't contain one already. This will make git-am pickup the correct
> author's details and it should be some simple logic.

Unfortunately, changing the message body will break the DKIM message integrity 
(body hash)...

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

