Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00A1C48260
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Feb 2024 17:59:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE77B82C;
	Thu,  8 Feb 2024 18:59:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE77B82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707415166;
	bh=tQmlYHUhEty4mHV4CMckgvDZZYA665Avgi2W87VZ5/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fy1OrgPNU15qvyilZZ9WeWr5U3PP1vgrRuapR9ZJx0R28Il7mrdN1iaC/zh0oTS12
	 B7VRpckUvSlDSIMBKTu2MPvHFQ12u8/aforQ5VZG98L9SX0mVQ9fZBfgbADLpokl1v
	 xAcpQxcM7j/yuTETxsr+oJ0DBTIX464leU3yYdZc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83D24F8057A; Thu,  8 Feb 2024 18:58:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AA78F805AB;
	Thu,  8 Feb 2024 18:58:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51148F801EB; Thu,  8 Feb 2024 18:58:50 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr
 [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CCD7F800EE
	for <alsa-devel@alsa-project.org>; Thu,  8 Feb 2024 18:58:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CCD7F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256
 header.s=t20230301 header.b=bt6l/+E5
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Y8eLrzbSOF1QfY8fXrnOuI; Thu, 08 Feb 2024 18:58:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1707415122;
	bh=c8xcuO0OsJENL1xB6fz0nq1SolddnbYqgdO4mg6NbnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bt6l/+E5K1gbryuBcoKxEB73waSVLWOSoUtrezPgseIBh2SG9FD1BCgovYne690r7
	 ZjcJsKr+S4XHmMeGVzBIrnnmc0WD/5B31vIc3x19SZYqqM2UcJ50moetFoIwRuwIKX
	 ppdSSKGbzLRCAgTCO5QINXmfZjHj1ML0DVLxjHzQPf+j3h1tBX5gSX3uoqwjc8t9Ik
	 zT8PASzP95n3ypYTHZaBIEvOfOJKCXQod37TK8nynvhnF7RaF0Z3XICbO00h6DYreD
	 NZReNvQY+LacQ6p9Jp/vFMJYk1lm3Bept5OZUMLu4hK4weghOXC/UR8F20BKPjrWYH
	 5eEVD0/Nx06hA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Feb 2024 18:58:42 +0100
X-ME-IP: 92.140.202.140
Message-ID: <d1a48a3c-cb2e-4dee-8fef-850296787234@wanadoo.fr>
Date: Thu, 8 Feb 2024 18:58:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: core: Remove usage of the deprecated
 ida_simple_xx() API
Content-Language: en-MW
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 alsa-devel@alsa-project.org
References: 
 <8402a9a8a45937fe2e62617ff0c7408503692b20.1702745212.git.christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: 
 <8402a9a8a45937fe2e62617ff0c7408503692b20.1702745212.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ONDOOINR7AP7HLAHB2KRH3FLU7N3P3T6
X-Message-ID-Hash: ONDOOINR7AP7HLAHB2KRH3FLU7N3P3T6
X-MailFrom: christophe.jaillet@wanadoo.fr
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ONDOOINR7AP7HLAHB2KRH3FLU7N3P3T6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Le 16/12/2023 à 17:47, Christophe JAILLET a écrit :
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So change this change allows one more
> device. Previously address 0xFE was never used.
> 
> Fixes: 46a2bb5a7f7e ("slimbus: core: Add slim controllers support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> /!\ Untested /!\
> 
> The change of behavior is motivated by the comment in
> drivers/slimbus/slimbus.h stating that /* Manager's logical address is set
> to 0xFF per spec */, so all other values, including 0xFE should be valid,
> IMHO.
> 
> So considering this as a bug-fix, I added a Fixes tag.
> ---
>   drivers/slimbus/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index d43873bb5fe6..01cbd4621981 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -436,8 +436,8 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
>   		if (ret < 0)
>   			goto err;
>   	} else if (report_present) {
> -		ret = ida_simple_get(&ctrl->laddr_ida,
> -				     0, SLIM_LA_MANAGER - 1, GFP_KERNEL);
> +		ret = ida_alloc_max(&ctrl->laddr_ida,
> +				    SLIM_LA_MANAGER - 1, GFP_KERNEL);
>   		if (ret < 0)
>   			goto err;
>   

Hi,

gentle reminder.

All patches to remove the ida_simple API have been sent.
And Matthew Wilcox seems happy with the on going work. (see [1])

Based on next-20240207
$git grep ida_simple_get | wc -l
38

https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
50

https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
81

Thanks
CJ

[1]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/
