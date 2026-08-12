Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64083C5B56A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:38:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F4326020F;
	Wed, 12 Aug 2026 11:38:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F4326020F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786527516;
	bh=1P9M1rACzeCcjivuF8eDsRiFTyPFiRmDvGHrF7/ykG8=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=apyEk3a07/ia0ngT0GAOaI4FuAB6klyg/oScozca3kC/v1jFZQX5MvqgXbf36a+kL
	 0pdfcu5Qqh0sjQmjeNFZAPCRiago1s+OjDYbVkudGhcXcsLkbMLr5QePJ7KXq2JHoG
	 7PZnBtrhWd292bmb3vScktwI06Uiy74cXK5fMXEw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85B3EF805FB; Wed, 12 Aug 2026 11:38:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CB6EF805FF;
	Wed, 12 Aug 2026 11:38:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DD61F804CF; Wed, 12 Aug 2026 11:37:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786527473;
	b=ZERNs7710d7V4kRXKfshx7PP7sUwKB/m+XlxjGW5tLZBmgchIFFvgIpISRitlYULo1Lr
	 lTwgT3Gl29XSVWlNJ7BTmJP0lZx3PoIQybZQa8tjKN/O69xPo0DDo6uIq65FK929jcjqA
	 M7UxDWhtM6V8rLUWpkEf2tMI9xt4Akm/SKjRFObSfWdVMxTFxGAaHnnBg/gPTu4LlJ/kV
	 wASKfwQu5zrpBDlGsH26CbClG0xhIx7FullRFk6yhlp1DYzsAdcisREjCPOteVCrryuxP
	 FW/BgMtjmhNqtZH0jF6g1X75FQgj3H2V0cdVousktR+vPJ+2FH5+j+Oo7BM3w4uiQEw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786527473;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=1P9M1rACzeCcjivuF8eDsRiFTyPFiRmDvGHrF7/ykG8=;
	b=r7XSANYlvGh1g6cPBlPMKy7EsqnFuFKUPWnK/CS+ZVc5hwUX6ZqFA9wY13JVzSiDIDt4
	 tM2m6mIo/KgWWv0SBM6THrVUCG+sYRDjNmU/zwjxxReGyAsw+DB/dXnv5YB3/qMu7HqFl
	 XTVDKJw4KgphFRDASw2g6WC0YQOUHbaAc0C7xJ7MdODjFmlbxHE4tsjsZ5/4ZV7f4SMgA
	 VLGTy4USSaIbeRuq4YvsYwHm+107A+pDQGGbrAEQZebExHLKeixGa1Fg+OXN6K3eENhM8
	 VYS0Q48n5z+86MuHNjIfpg7WFdnCpwWk1+E4z5EexVfgRA8f5efSSgxXmc9XSEecUgQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 75A06F8014C
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2026 11:37:51 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 39FF22E47;
	Wed, 12 Aug 2026 11:37:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 39FF22E47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1786527469; bh=JGKhDr+q7rU/ew9Qqod2KmmaH5DF69zib1N7orAH27w=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=nvi5NEBBBwKTG2JK4OujFaXpJ6+LXdkA5WlThAawPnwdQJIDAvWIBlXoTxaAPVZYl
	 fEYMB1G32M+BWcbgOmxzV7gAYPzuOFajydBQdJzPI4oPmG0+BdJ+QyChyEcaXqw1RN
	 NqhDj9Pc4pltIjVfaZuxTvua5H6oeUhG7xG3PBII=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Wed, 12 Aug 2026 11:37:47 +0200 (CEST)
Message-ID: <cfe96ec1-c8c7-4336-8c71-088e438ed053@perex.cz>
Date: Wed, 12 Aug 2026 11:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: the ALSA state machine
To: dave@synergy.org
References: <000201dd2787$e39e3f10$aadabd30$@synergy.org>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Cc: ALSA development <alsa-devel@alsa-project.org>
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <000201dd2787$e39e3f10$aadabd30$@synergy.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: NCKAW3RZ23RSE7AQG74CC3U6I3WI43QG
X-Message-ID-Hash: NCKAW3RZ23RSE7AQG74CC3U6I3WI43QG
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NCKAW3RZ23RSE7AQG74CC3U6I3WI43QG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 8/9/26 00:47, dave@synergy.org wrote:
> Hello,
> 	I am trying to debug some ALSA playback code. I have two playback
> devices,. The first is A USB sound bar and the second is A Bluetooth sound
> bar. The issue I am debugging is truncated output on the Bluetooth sound
> bar. The USB sound bar works fine. I've added assertions to understand how
> my code may be getting out of sync with the ALSA state machine.
> 	For reference, I am using the documentation at
> https://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
> 	After opening the device, I check its state and it is always in the
> SND_PCM_STATE_OPEN state, as expected. After initializing the h/w and s/w
> params, however, the document says I should be in the SND_PCM_STATE_SETUP
> state. Instead, however, I am in the SND_PCM_STATE_PREPARED state. I then

It's correct per snd_pcm_hw_params() documentation:

"""
  * After this call, #snd_pcm_prepare() is called automatically and
  * the stream is brought to \c #SND_PCM_STATE_PREPARED state.
"""

> call snd_pcm_prepare() and remain in the SND_PCM_STATE_PREPARED state. I
> then call snd_pcm_start(). In the USB version I get an -EPIPE error. In the

EPIPE usually means that there are not enough data (samples) in the ring buffer.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat
