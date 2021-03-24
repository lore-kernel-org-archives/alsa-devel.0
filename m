Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC44AC433C1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 17:53:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345EC61A20
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 17:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345EC61A20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00D04165D;
	Wed, 24 Mar 2021 18:52:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00D04165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616608386;
	bh=ahq5xV6ErNi302Et72HHppIcgTNmry8oKxpGagPYPxE=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vOi/InvkkTfi4DJQEVDAHQok3phkgY4bLu4HVIJKrLbJ9H3LkVU41/HofYbzyKW4P
	 BGJ027EZ9/gbrEKzIH0j/4jXLtfc3EZ2yO+y5EmD3H0HHNH7ISudc7qjD1hiG0H816
	 fT5tM+gVoLyO98JC44aOI7Wj5KWvaRQgF88hDDG0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C8DEF8012B;
	Wed, 24 Mar 2021 18:52:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BC1CF8016B; Wed, 24 Mar 2021 18:52:14 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CD68F8012B
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 18:52:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CD68F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="rafG6BzZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=cWD1YkAT602Bo4ovvV2QDn6jkJrROrkUMXV1Y4u1zvo=; b=rafG6BzZ8GeOVQwTMWlD9nvQjW
 S3i5Xkk1WjYAT74bBSg5+zjx5LgImQVIdrIfRhqNKLlTOfmgXn6Rh+rnxhrpJ8S4cQL767+IUPrGn
 +NojTCgFP5waIB35XQf30goq9Psg5AuDtucB+Ue8w9b40pE++dOGozNlgpYpd9SQki+8jJSmuDz1x
 DwJskEuaZAsW0O7qwzWGpRbH4PUTHjQZztGCssPkr5QP3XRy986b2BiGNwBuRRJ4VSxXwVzwPc2dQ
 1SLhlvabLE40l4ky1kbQIhLc/x4Vfu0ZlQ2/OjJmRnIQfhvZgvUYXGvaFIo3Ez9uTl6BeD8ADU2sO
 F1agfxAw==;
Received: from [2601:1c0:6280:3f0::3ba4]
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lP7ex-00Beb1-Cw; Wed, 24 Mar 2021 17:51:29 +0000
Subject: Re: [PATCH] ALSA: pcm: A typo fix
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, perex@perex.cz,
 tiwai@suse.com, broonie@kernel.org, mirq-linux@rere.qmqm.pl,
 lars@metafoo.de, joe@perches.com, huawei@kernel.org,
 viro@zeniv.linux.org.uk, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20210324065612.31362-1-unixbhaskar@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6d2e91a2-a013-c9b1-8725-1715253d0646@infradead.org>
Date: Wed, 24 Mar 2021 10:51:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324065612.31362-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 3/23/21 11:56 PM, Bhaskar Chowdhury wrote:
> 
> s/unconditonally/unconditionally/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  sound/core/pcm_native.c | 80 ++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 17a85f4815d5..9884961bca7d 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> 
> -	return 0; /* unconditonally stop all substreams */
> +	return 0; /* unconditionally stop all substreams */
>  }
> 
> --

Please fix line 1472 (in linux-next) while you are touching this file:

 * Return: Zero if succesful, or a negative error code.


-- 
~Randy

