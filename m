Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788B4C282D3
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:37:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79FF260388;
	Wed,  5 Mar 2025 10:37:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79FF260388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741167448;
	bh=nQV/6oTFPhfR1TN58aYGPWe8NOf/9PYSR4k+fw+SQDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cEmeZ1ir8NQ2HdU2jde4mYY2jUKXCehkM5EdH4kc1lhNbpuqAkxuBE34v3/gv2EzC
	 Z9GXO4Gsd+8PEaZCclDJVCKTs8VUxdT1oMiPLzUpB40KCY+QQ/nO6tlXe/C/uaOqsv
	 1rGiv/5VCoNGiWb7QKdB5Rao2PZPonDtFVBsXlk8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC984F80679; Wed,  5 Mar 2025 10:35:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DDD2F80677;
	Wed,  5 Mar 2025 10:35:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C825F8021D; Thu, 27 Feb 2025 00:16:31 +0100 (CET)
Received: from mail.nihil.gay (unknown [IPv6:2a01:4f8:c012:1016::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9D451F80116
	for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2025 00:16:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D451F80116
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nihil.gay header.i=@nihil.gay header.a=rsa-sha256
 header.s=2021 header.b=CfgwO0nq;
	dkim=pass (2048-bit key) header.d=nihil.gay header.i=@nihil.gay
 header.a=rsa-sha256 header.s=2021 header.b=bkh/F9Dw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nihil.gay; s=2021;
	t=1740611784; bh=nQV/6oTFPhfR1TN58aYGPWe8NOf/9PYSR4k+fw+SQDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CfgwO0nqi08V/NNcibUaMeRzkjgy8Y3mt/8vd7IcNm/pzKQ1570MF3kYkPH8nfCAc
	 tg4BaaXZE7wFOva71BdcXmWYYwSb+xXYCT7pywluNxt42GdYjHQcN25u0lNV2DJk08
	 EjA9JwzsW/Lt7P/Z/HFRaK0WXYFgdFd6SeEttKXT6RlplKNEIJFf0B1f1O5QQ3adUq
	 vFD+Xd3PCRpZ3z/ONBYC5NAgNJ6LxHGok2nzGbKaqlxYjk2hvrchnw10vkjNco1/Bo
	 TIUPIdSb5jZ3gPstIL6ljKwvEd3SJZxSJ73tdRDOuh8A8Y8UK60dGFoJF8ATbSnv6n
	 iI05KZqnYH9RA==
Received: by mail.nihil.gay (Postfix, from userid 114)
	id A02299D17F; Wed, 26 Feb 2025 23:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nihil.gay; s=2021;
	t=1740611783; bh=nQV/6oTFPhfR1TN58aYGPWe8NOf/9PYSR4k+fw+SQDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bkh/F9Dwv1QyN43rA9jrcql5lFeH22cBnD4O+ae+NVaGxBLi4Qcpu7xGsFeJkeVle
	 /eEzbMSj0iVeaQF49IQ1/dgO6v+ZL1NWKiqd6T9vRuCTDsqSs8Q+Egpl/BnND8ktDg
	 aKwiQ6BoPuvwWcU0wFH2gkg/HDnGf+Bh+TcCegtfJrOHDaJb6LjmM9xhsE2LMv4laA
	 INgmgOMAO5Q5t0rq3kaDuPrMuTJ/7VmYMLGduelu/iCyXv28obM7dzexyNv+0PrqNF
	 9suzyrvhnMDT0ieQ3VEK0VLxGZkv4Oep9r5amwefkyWycwnjTia45GNzTRBtyfHL1a
	 eEcAk/uaXpvzw==
Received: from [10.0.0.2] (host-80-117-39-60.retail.telecomitalia.it
 [80.117.39.60])
	(Authenticated sender: lena@nihil.gay)
	by mail.nihil.gay (Postfix) with ESMTPSA id 5379F9CFF6;
	Wed, 26 Feb 2025 23:16:23 +0000 (UTC)
Message-ID: <527b73fe-892f-476e-95e7-7c0cd09df1d0@nihil.gay>
Date: Thu, 27 Feb 2025 00:15:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ALSA USB quirk mixer driver question
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <6f03b7d6-97d5-48a4-be6f-a1df481971fc@nihil.gay>
 <87cyf557kv.wl-tiwai@suse.de>
Content-Language: en-US
From: Lena <lena@nihil.gay>
In-Reply-To: <87cyf557kv.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: lena@nihil.gay
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: B22BX6GMFCAXQHHOC5ABKQW6YJCNCXR7
X-Message-ID-Hash: B22BX6GMFCAXQHHOC5ABKQW6YJCNCXR7
X-Mailman-Approved-At: Wed, 05 Mar 2025 09:35:49 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B22BX6GMFCAXQHHOC5ABKQW6YJCNCXR7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thanks for the reply!

So, if i understand correctly, instead of going through 
sound/usb/mixer_quirks.c, i need to create a standalone USBHID driver 
that exposes the ALSA kcontrols and then the ALSA userspace understands 
that it's the same interface and 'links' the UAC/isochronous audio part 
and the standalone ALSA mixer kcontrol part that has the volume knobs, 
mute, output select and input impedance/phantom power/headphone gain 
switches such that an userspace application (like alsamixer) treats it 
all as a single thing.

Does this driver then belong in sound/usb/ (given it imports the API in 
<sound/control.h>) or somewhere else (e.g. drivers/hid/usbhid/, 
drivers/usb/)?

Thanks again,

Lena
