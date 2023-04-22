Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FB2C6FD18
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Apr 2023 10:09:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 757D3ECD;
	Sat, 22 Apr 2023 12:08:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 757D3ECD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682158144;
	bh=rXOPslBoBlhZNGBdMmqogJrqQRhdnAyJxoeKsIsVOic=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LGKVkOZuzM6L8cu+q1uESltRHUnbWUh9EJU0aE+A5xOQ+9CKIR3MdW01ZXJq6FwQa
	 BqgE5C1/owsMxDy6t+AlNckvbHmPsT64K0cVCj5rDxLJHyZj2lBkc3I7+lD5ngsJMy
	 xy3LACQBjCoB2Q1Az4KVyjGjsKHUccn6nx9qdwjc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5145F80155;
	Sat, 22 Apr 2023 12:07:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7FA1F80155; Sat, 22 Apr 2023 12:07:44 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 860A7F800AC
	for <alsa-devel@alsa-project.org>; Sat, 22 Apr 2023 12:07:35 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4A4FE11CF;
	Sat, 22 Apr 2023 12:07:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4A4FE11CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1682158054; bh=d0r/rqFhIyFt1kVxaACSHWNwV0dxJ5RqZcz95TNwcmo=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=U6Jr/uDSYo7Gk9yrxE/EUBTk6ygUKWnJMJGQ+yiA1nLxzicv2O4iX9lnhN2cGrO8k
	 HcFmBnf258E3k0g+tYU/LCHTfeQV5c4bmpRMapiwS0gGKTb/bfCVDScurW0yVpYqMo
	 0esm9JcmpMBzJvKvIh8nbI1ik5OX6htB5Z5XRnF4=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Sat, 22 Apr 2023 12:07:32 +0200 (CEST)
Message-ID: <42c32ed5-84f4-ad4f-c7b6-ae3a2ad89a8c@perex.cz>
Date: Sat, 22 Apr 2023 12:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Request to configure libhinawa and hinawa-rs repositories
Content-Language: en-US
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <20230422005622.GA55854@workstation>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230422005622.GA55854@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: GNTC2RS5JQZSCGDVPSAOHIBKAKRHHTAD
X-Message-ID-Hash: GNTC2RS5JQZSCGDVPSAOHIBKAKRHHTAD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GNTC2RS5JQZSCGDVPSAOHIBKAKRHHTAD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 22. 04. 23 2:56, Takashi Sakamoto wrote:
> Hi Jaroslav,
> 
> Thanks for your administration in many repositories hosting on github.com.
> 
> I'd like you to change 'About' messages for the two repositories, since
> I decide to host some repository in git.kernel.org.
> 
> * For libhinawa repository
>    * 'Mirror of https://git.kernel.org/pub/scm/libs/ieee1394/libhinawa.git/
>       for user support and continuous integration '
> * For hinawa-rs repository
>    * 'Mirror of https://git.kernel.org/pub/scm/libs/ieee1394/hinawa-rs.git/
>       for user support and continuous integration '

Hi Takashi,

	the information was changed as requested.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

