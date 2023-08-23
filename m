Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89B8C71134
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Aug 2023 17:22:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C26883B;
	Wed, 23 Aug 2023 19:21:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C26883B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692811340;
	bh=1LSQ0ibvhCpuNGDRVQ3fT/a0N0oWpnYFPW2FcudTjko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZNuN5TkO3VHrArCxgiGQhb57HkzzreBTDyavj42RosBGECOJ1ExR79Au5PYSJqBQs
	 bONP7Uw7i7VRLI2XP7dwp+vx4eIMa6sk4ptIKBMAGxO3HIlsS5rFN5dNTePzqUaggL
	 nh4MAQkLP/jlRL9/DVglILsYm6LIpJ21EE6HiiPI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22672F80537; Wed, 23 Aug 2023 19:21:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DEAB0F8023B;
	Wed, 23 Aug 2023 19:21:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E944BF80158; Wed, 23 Aug 2023 19:20:57 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr
 [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E7E09F80022
	for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2023 19:20:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7E09F80022
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256
 header.s=t20230301 header.b=p1eGtxNY
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id YrXFq32vGOQiUYrXFqJe0n; Wed, 23 Aug 2023 19:20:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1692811253;
	bh=YilPLjsAWAxMFRuKLpbH+AIhWQZHyzpkkkrXHbp8NnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=p1eGtxNYAJtWoXIYRNkuQU2TmowPauX7I20RNz9Q0sQNKAEiiYqVRh+uyxkR02v1P
	 2hqB5ZgknXzE7eI1sOp75WRgi0oFbp3tTo5StkC2KiMY8hk60RvfuYCqI2HZ5+6Dly
	 5IF7Axj20dlTXNj0OWWU69i6tZow0qvfoQf8a945gCIpq5TqqpTzFZBEpzBwIcHzZ3
	 8T+Blv999CcFiX4vkhvamkGzrNf8q1Ngy7fLkp7f//eKw4G8YslB0sQi86F+VhyaNQ
	 ZIPZjIsuaRBaA4TN+25zUcXsuEUCcVqiQY+Vu9gXN/w5y6Pjf5w4HeFBvvLg+NqRlU
	 9fjuPnoj3lbuQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Aug 2023 19:20:53 +0200
X-ME-IP: 86.243.2.178
Message-ID: <ddc14926-45d8-9b20-9523-0fb6afa499b3@wanadoo.fr>
Date: Wed, 23 Aug 2023 19:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ALSA: ac97: Fix possible error value of *rac97
Content-Language: fr
To: Su Hui <suhui@nfschina.com>, perex@perex.cz, tiwai@suse.com
Cc: arnd@arndb.de, robert.jarzmik@free.fr, yangyingliang@huawei.com,
 maciej.szmigiero@oracle.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20230823025212.1000961-1-suhui@nfschina.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230823025212.1000961-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XD3TAONSQ5ZXEMXKR5Y5WPSQGPEFBMPN
X-Message-ID-Hash: XD3TAONSQ5ZXEMXKR5Y5WPSQGPEFBMPN
X-MailFrom: christophe.jaillet@wanadoo.fr
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XD3TAONSQ5ZXEMXKR5Y5WPSQGPEFBMPN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Le 23/08/2023 à 04:52, Su Hui a écrit :
> Before committing 79597c8bf64c, *rac97 always be NULL if there is
> an error. When error happens, make sure *rac97 is NULL is safer.
> 
> For examble, in snd_vortex_mixer():
> 	err = snd_ac97_mixer(pbus, &ac97, &vortex->codec);
> 	vortex->isquad = ((vortex->codec == NULL) ?
> 		0 : (vortex->codec->ext_id&0x80));
> If error happened but vortex->codec isn't NULL, this may cause some
> problems.
> 
> Move the judgement order to be clearer and better.
> 
> Fixes: 79597c8bf64c ("ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer")
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   sound/pci/ac97/ac97_codec.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
> index 80a65b8ad7b9..25f93e56cfc7 100644
> --- a/sound/pci/ac97/ac97_codec.c
> +++ b/sound/pci/ac97/ac97_codec.c
> @@ -2069,10 +2069,9 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
>   		.dev_disconnect =	snd_ac97_dev_disconnect,
>   	};
>   
> -	if (!rac97)
> -		return -EINVAL;
> -	if (snd_BUG_ON(!bus || !template))
> +	if (snd_BUG_ON(!bus || !template || !rac97))
>   		return -EINVAL;
> +	*rac97 = NULL;
>   	if (snd_BUG_ON(template->num >= 4))
>   		return -EINVAL;
>   	if (bus->codec[template->num])

FWIW,

Acked-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

CJ
