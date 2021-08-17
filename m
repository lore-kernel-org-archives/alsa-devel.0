Return-Path: <SRS0=htQG=NI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED78C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 10:08:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A718A60F58
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 10:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A718A60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diwic.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A64F915F2;
	Tue, 17 Aug 2021 12:07:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A64F915F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629194920;
	bh=9qIjPnJn/4NCrX0uShFhBIEwAR/ebE7vAbczWCOCDx4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MA0X+UqXoPrcb/+pja+OwbqfwsYeKcNgoXdDJYa5RvzdNdMaOUoOzE+XlF0Q+nYx6
	 6mxQXFAtNLAMotf3rVX645eq5XcBUe/KKSJROHPu1Uw3qwtC3EI28LHpmtPv9HFGL8
	 uDVN8HfVx/NH3Eure1Yj2/qYwzX8+xkjlej4TMpg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3634CF8026D;
	Tue, 17 Aug 2021 12:07:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9215FF80272; Tue, 17 Aug 2021 12:07:48 +0200 (CEST)
Received: from ns4.inleed.net (mailout4.inleed.net
 [IPv6:2a0b:dc80:cafe:104::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F4EBF80134
 for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2021 12:07:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F4EBF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=diwic.se header.i=@diwic.se
 header.b="RA8/ABIa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=diwic.se;
 s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R0O0nDozV/7eL+wWnwvl982I9qpYMOqZM0Clfq6kzV8=; b=RA8/ABIalwXfco/x2BX5iz13KI
 BUksOoW8f6aBqo44QPGB3V97xLwSXTVmUgqJe0tl4/EcEFfFbDs1m1Paqv5ERSJP4Awqtzsta3QkI
 sRiKWIBOvNz4AL4KJ9evJCmh/ufGtja8RgaVGhxufJMKOIJ2YtWp8Kq+H6hcJqGcU76wzPl/sEL+I
 VjRheqrCUiebzIRJI7pHEpM/Wqsrqh1nkIqfWf5yElpQrGy5S+fY2MNR9pUP4c1fbl3ijYhwwt0Zn
 zYg9wTroj0VU/fIoFCd8Tl0udwfdktfbcJHXQINCjS3M9iuDrLxKtZb6WTLBYhyG/8dmoGtZ2zTAS
 pc9gNinA==;
Received: from c83-254-143-147.bredband.tele2.se ([83.254.143.147]
 helo=[192.168.5.6]) by ns4.inleed.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <coding@diwic.se>)
 id 1mFw0T-00C15D-F9; Tue, 17 Aug 2021 12:07:41 +0200
Subject: Re: [PATCH 0/2] alsa-lib patches for rawmidi tstamp framing
To: Takashi Iwai <tiwai@suse.de>
References: <20210816160625.17796-1-coding@diwic.se>
 <s5htujofxaw.wl-tiwai@suse.de>
From: David Henningsson <coding@diwic.se>
Message-ID: <458d04a3-5e99-d96f-b930-1b09044656d1@diwic.se>
Date: Tue, 17 Aug 2021 12:07:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <s5htujofxaw.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Id: coding@diwic.se
Cc: alsa-devel@alsa-project.org
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


On 2021-08-17 07:35, Takashi Iwai wrote:
> On Mon, 16 Aug 2021 18:06:23 +0200,
> David Henningsson wrote:
>> Well, now that we're about to release a kernel with support for rawmidi tstamp framing,
>> how about some alsa-lib support for it as well?
> Sure, that's the missing piece.
> But, could you give a bit more description to each patch?
Do you mean commit message?

I could just write this for patch 1/2 (i e, copy the doc section added 
in the patch):

Optionally, incoming rawmidi bytes can be put inside a frame of type snd_rawmidi_framing_tstamp_t.
The main current benefit is that can enable in-kernel timestamping of incoming bytes, and that
timestamp is likely to be more precise than what userspace can offer.

Tstamp type framing requires a kernel >= 5.14 and a buffer size that is a multiple of
sizeof(snd_rawmidi_framing_tstamp_t). It is only available on input streams.

And this for patch 2/2:

Adds a "clock type" parameter to the "rawmidi" test program, that when 
used and combined with -i (and -v to be useful), activates tstamp type 
framing with the specified clock type.

I hope this description makes it possible for you to review the patch 
content as well.

Thanks,

// David

