Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B51CDB465
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Oct 2023 13:59:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD82F6C1;
	Thu, 19 Oct 2023 15:58:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD82F6C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697723960;
	bh=d2zyIpz9KTMDXjPOy/YkOZnXCaYKL+V5m6mU/jGW7Dw=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WwNXdrWQ0AAF3dzWM2Ipw17zBnjItttSPNT/0bElMQ6/LmXaw4zQgj41sIm2MoH52
	 LAMT8FGrXCLmD8y1HkBE9mLay+qq/+MXcOAujKouQX7CWQs5ZDj6wq7McpvvS+pHSe
	 jvhCRvfKH71WMPBmCLiKyrmzN4TmVx1Dtt2ydUyI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01B32F8027B; Thu, 19 Oct 2023 15:57:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AA71BF8032D;
	Thu, 19 Oct 2023 15:57:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D846EF8025F; Thu, 19 Oct 2023 15:57:48 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F129DF80166
	for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2023 15:57:40 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A49F91A5C;
	Thu, 19 Oct 2023 15:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A49F91A5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1697723859; bh=VbrQlKGp64+tufbF3jfBek996tzyKMID8pq0XAYLhMw=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=R8lL5Ambci/eHukS3P2CpEAp4qiQ+NuPU+/9XzT4wgMIFQgkRp2ejDIo26lDiga2A
	 wUAocCYbc10ZYhvY7UwV4x5NFJ5eS/vgKOwY6dSX7aDN0B5r0LTJfE92pjgq26ygAL
	 QIBm0gOQJUE+oSLdyCXLEFuDoTU/tUB69xfWXCWo=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Thu, 19 Oct 2023 15:57:35 +0200 (CEST)
Message-ID: <8f62db8c-b10c-0256-a56c-28b998d1a3bc@perex.cz>
Date: Thu, 19 Oct 2023 15:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.de
References: <20231017-coroner-blurt-edffe8@meerkat>
From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Migrating this list to a different platform (take 2)
In-Reply-To: <20231017-coroner-blurt-edffe8@meerkat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 3HWOIDJDL2XTVV4MNG3BUXI665SWPAYA
X-Message-ID-Hash: 3HWOIDJDL2XTVV4MNG3BUXI665SWPAYA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3HWOIDJDL2XTVV4MNG3BUXI665SWPAYA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello Konstantin,

On 17. 10. 23 22:25, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> I'm told that a while back there were some discussions to migrate this list to
> vger, but the process never really got finalized.
> 
> I would like to restart this discussion again, because I am in the middle of
> vger list migrations and it seems like an opportune moment to bring this up.
> 
> There are the following benefits to gain after migration:
> 
> - it becomes an open list that doesn't require much moderator involvement

I think that it may be the main reason to migrate it. How do you handle the 
inbound spam? It's the only reason, why our mailing list is moderated.

> - the messages are DMARC-compliant when received by subscribers

It seems that the mailman3 operates correctly with a simple fix.

> - the infrastructure is supported and monitored by LF IT 24/7

We have no big outages for our mail list right now. The server is monitored in 
a hosting center, too.

> However, there will be the following impacts:
> 
> - we can try to set up a forward from the old address, but previous attempts
>    to do so with mailman had mixed results
> - if the old address is set up to forward mail to the new address, then anyone
>    sending to both addresses will get doubles of everything, which can be
>    annoying
> - setting up a hard bounce at the old address would probably be preferable,
>    but it's a "ripping off the bandaid" kind of approach

Ideally, the e-mail address of the list should be preserved, but I guess that 
an option to redirect DNS MX records to LF servers is not possible, right?

> If you are interested in migrating the list, I suggest we move it to
> alsa-devel@lists.linux.dev and not vger, solely because vger is in the process
> of migration itself and it would be easier to use the lists.linux.dev domain
> at this stage than to go with vger.kernel.org.
> 
> I am happy to provide any more info if you have any questions.

Thank you,
	Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

