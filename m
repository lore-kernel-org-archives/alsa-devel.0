Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF4EC77B7C
	for <alsa-devel@archiver.kernel.org>; Thu,  4 May 2023 17:07:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CF2122E2;
	Thu,  4 May 2023 19:06:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CF2122E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683220061;
	bh=QMHLbNAGQBqCJ8mQhUZPicaopaEkasG2xKy9HvZ1YgI=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i9j6yn9NJ4USDiJVeocncNYsy6vgdoZ0/XHxWEBBWggKnv3f27fOmCX7H+arjsryj
	 JQv1KT5plf+wJXg9zG9XSffm+GmP7s0FVgDSO8Vfn5/E04NkcfVc4C+T5vV5e51kL3
	 s1InoaXyzkpN26j7hNqJdK0RtZ2vB3KzoHBJ9554=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9F46F8052D;
	Thu,  4 May 2023 19:06:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9917DF8052D; Thu,  4 May 2023 19:06:22 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57978F80114
	for <alsa-devel@alsa-project.org>; Thu,  4 May 2023 19:06:17 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6AFDB11E9;
	Thu,  4 May 2023 19:06:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6AFDB11E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1683219976; bh=29sB7SpHmlDNzIbLjCd08EXP5OnP+LCAK2ACkyJxKbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RtbRA0rIt+bRBL5x6bZOWE0YkV8u8RoCMzvJDpqHhpGTUc357PzHvozwplTbvYM9p
	 ai/Hyf6l9ew+8DGwoiPM2Wj7+n46+5h7X9aloEzn/mHw0UtDadRgH+Wc6+sZqmRJgw
	 88iHoxn38+IBIdKhHMQpHKDgEhWB7I3KrFLszhGw=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Thu,  4 May 2023 19:06:13 +0200 (CEST)
Message-ID: <574a7e28-1b1c-e2c5-ff2e-f206c8956db7@perex.cz>
Date: Thu, 4 May 2023 19:06:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] ALSA: pcm: fix snd_pcm_playback_silence() with
 free-running mode
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20230504130007.2208916-1-oswald.buddenhagen@gmx.de>
 <87cz3gkyz9.wl-tiwai@suse.de> <c2e501b7-68bc-947b-645e-e425dcd20c65@perex.cz>
 <ZFO5B+1+HaIz4B4X@ugly> <877ctokv6x.wl-tiwai@suse.de> <ZFPQ68qLr2fy1qRs@ugly>
 <87ttwsjbrx.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <87ttwsjbrx.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: D3BHUJBFF2TARCVGNV6TX5LND2XRVMV5
X-Message-ID-Hash: D3BHUJBFF2TARCVGNV6TX5LND2XRVMV5
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D3BHUJBFF2TARCVGNV6TX5LND2XRVMV5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 04. 05. 23 18:34, Takashi Iwai wrote:

> The acceptance of your patch was my failure, yeah.  I should have
> rejected it.  So this failure doesn't happen again.  You're seeing the
> result now.

We can keep the header comments and just revert the code for now. If Oswald is 
not willing to work on this further, I'll look into this tomorrow. I see the 
points to be fixed. But I don't think that we are in hurry - the code was 
there for years so it's time to fix it properly.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

