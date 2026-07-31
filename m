Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4758EC5516D
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:27:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ACF260202;
	Fri, 31 Jul 2026 13:27:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ACF260202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785497247;
	bh=v00CygaBfSotvzud8f48P4hXB1pxtsv9GvantoXQr+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kUWSF8KxQEa1nMp7UdUjB2+rYMcGwGqfLRf+EdWX7WJqUJJEspBo3+5jbk64yK80K
	 zuYGpFQka4P2g2e8eYvXUTsBw90JFJPQTE25IgZO/sQyZF//CdEkTzDerE3tDaLH+C
	 wDP9/LUex9OeWhCR9OGkGWvEfaKpQVyXaq/ZarqY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6F79F805BE; Fri, 31 Jul 2026 13:26:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A53E6F80600;
	Fri, 31 Jul 2026 13:26:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D34DCF8051F; Fri, 31 Jul 2026 13:26:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785497199;
	b=Ozc1hO4K7RWHlvSYzVzXK+y+t/IZneSJJo+2Zz6zQOFNL98Vgu5K9xmg5x6/vx8fPmmL
	 qegeoYXYgY7vexSyu50OW9wKIYzhbdVqVviazbQeK8RP/F3WmrcNirGegOnI5gyTZLzu8
	 5mwLpjWCSANq4zqkaFv1LcqQpRY61OiwNDVbEHTz8mPm9+u4yoZpGvaYOftHOmWzNzd/8
	 bT+zUl79eLqclvX7u/MaxAK6eb0G/g3Mco/KtFMHXHPaXrR1kqnOpiJlOR9dwhPHJMw/9
	 7A+af8tnkqQEba8CXHOeG4b/XxWc2QN91l3J0TkT8BImr+OM5gx+YpWPNCELHPfXZjQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785497199;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=v00CygaBfSotvzud8f48P4hXB1pxtsv9GvantoXQr+8=;
	b=KllrMfD/g3B3g82cSZqsURUf4RXbu6t5LI+9Bg3PC7wMYA98jyFbNlZqruaq+daSkfNt
	 ae+wHNW0rVDQJBNPBcUebXa1v7PpUhKtIv73I7p3Ud4oMFwfJsmPc3prvNnNDt4JQuF+Z
	 tXvYEMxNfDmJxYoQZmdqr/P7efaj4vT46VLeWXDu1Jaecsp3qYVlCDEF7/4miIepMP5rz
	 balmH7ItqzzbLJUFmCHORuqf9lKaV0Ov4PdnkKkvwZimbHT5wZWFBAPBH+4Q1+4YGUxPY
	 wHhmIgVqY8mGNkoxbF8BOPoS8qxWE0LHZldGMpsc1XDIE9QVguIv4QjARhUs4LMKqAg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 37D89F800F3
	for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2026 13:26:37 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9F7D040FC5;
	Fri, 31 Jul 2026 13:26:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9F7D040FC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1785497195; bh=xNg2Y57IcV+xr3/Fa65w9ipsUiMEwVHvd75T3d8+CpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uKh0zXGICOBZGuSExhP9wgJB7SYGrPf6ezCAYDNmY2RkOosxquutAcl+ipn6nbzUL
	 kt7mJrvnGy36OI11BXP01E10puSdlus/Y2T8S48D4y4lJ7RZQG0Y/YAeSkV7RuoMvV
	 Thc0RRIGM0v2VzstmjnWL8jbsIZKMPOiUQJu0Ztg=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Fri, 31 Jul 2026 13:26:30 +0200 (CEST)
Message-ID: <a425ef69-fa5c-4306-a9e5-9b3a48eb7901@perex.cz>
Date: Fri, 31 Jul 2026 13:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [alsa-devel] alsactl restore fails for INTEGER64 control
To: "Sheetal ." <sheetal@nvidia.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mohan kumar <mkumard@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
 Jon Hunter <jonathanh@nvidia.com>
References: 
 <DSSPR12MB999212CD0AF414E51769382046CAF82@DSSPR12MB999212.namprd12.prod.outlook.com>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: 
 <DSSPR12MB999212CD0AF414E51769382046CAF82@DSSPR12MB999212.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SQ5H4TJ6IWFZZ3WKZQLYJA6E3MM3BS7E
X-Message-ID-Hash: SQ5H4TJ6IWFZZ3WKZQLYJA6E3MM3BS7E
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SQ5H4TJ6IWFZZ3WKZQLYJA6E3MM3BS7E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 7/15/26 10:53, Sheetal . wrote:
> Hi Alsa team,
> 
> We have a mixer control with a range of 0 .. 0xffffffff and are considering exposing it as SND_CTL_ELEM_TYPE_INTEGER64.
> However, alsactl restore appears to fail when the saved value is small enough to be parsed as a config INTEGER rather than INTEGER64.
> Example state snippet:
> 
> control.N {
>     iface MIXER
>     name 'ABC control'
>     value [
>         1
>         0
>     ]
> }
> 
> The restore then fails with:
> alsactl: set_control:<line>: Cannot write control '<card>:0:0:ABC control 1:0' : Invalid argument
> 
>  From alsactl/state.c, INTEGER64 restore goes through config_integer64(), which calls snd_config_get_integer64():
> https://github.com/alsa-project/alsa-utils/blob/master/alsactl/state.c
> It does not appear that snd_config_get_integer64() accepts a plain INTEGER node for an INTEGER64 control:
> https://github.com/alsa-project/alsa-lib/blob/master/src/conf.c#L3203
> 
> If this is a known issue, what is the recommended way to handle it?
> I would appreciate any guidance or recommendations and look forward to your response.

It's clear issue in alsactl. I tried to fix this in commit [1]. I also 
introduced new function snd_config_get_llong() in alsa-lib [2], because there 
are few other callers with similar usage.

Thank you for the report.

					Jaroslav

[1] 
https://github.com/alsa-project/alsa-utils/commit/85db8a95f7f4c5bdb353033d50d5e4c14011dd11 

[2] 
https://github.com/alsa-project/alsa-lib/commit/36118b8898ad3da18def6153f6aa3392390bf0a0

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat
