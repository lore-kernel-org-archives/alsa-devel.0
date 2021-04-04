Return-Path: <SRS0=LXLF=JB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF162C433B4
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Apr 2021 08:17:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B887D61369
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Apr 2021 08:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B887D61369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85FC616BB;
	Sun,  4 Apr 2021 10:16:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85FC616BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617524226;
	bh=ptK+O7aZUWQ9CNODSW0KkzMGYT8ME7vYnCsz5KUyzmc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VbRdB3or5H+R8wzsUyHH3Tc5I0zO4VmgDaDRNlxC5O/PB7gYgnE9iGYsOkajAxc0c
	 qPM6NyzSvcsguB7/ZFO7PPVU8OKywjYqJIstf7kH61L2p63NNwNntHjG/SU88YXsiW
	 ClS7qoO1GQ7312ScaRp6PeJZi5PXsB4ZjQDqj7Uo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C1A6F80168;
	Sun,  4 Apr 2021 10:16:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F863F8020B; Sun,  4 Apr 2021 10:16:14 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AFBDF80127
 for <alsa-devel@alsa-project.org>; Sun,  4 Apr 2021 10:16:07 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 2740EA003F;
 Sun,  4 Apr 2021 10:16:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 2740EA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1617524167; bh=QKsWo5B1+eTNDs2yNSwFFc2n1wn2A6/Acc8QQqdkCj8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pm9g5d4KeY9uEAYgRkt9yz0ho1S/R1zWHRV8PB/82DuBiv+IAepKY87GHbu1QKswU
 NXeIxPqgyuqM7NrXLauVt/B0puc+JNkX7sRVERbptW4a4sqePjkQliah67DvjMo9/3
 0MoPPEXYvHXFnhv/dwapmzgMI5aP98+QmynhSigI=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sun,  4 Apr 2021 10:16:03 +0200 (CEST)
Subject: Re: [PATCH] ALSA: core: control_led: fix memory leak in
 snd_ctl_led_set_state()
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de
References: <20210404064031.48711-1-o-takashi@sakamocchi.jp>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <f0490845-a455-ceb7-3dae-6dda23cef070@perex.cz>
Date: Sun, 4 Apr 2021 10:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210404064031.48711-1-o-takashi@sakamocchi.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 04. 04. 21 v 8:40 Takashi Sakamoto napsal(a):
> When inquired control element is not in led group, snd_ctl_led_set_state()
> attempts to add the element into the group, according to function
> arguments. Although an memory object is allocated for led instance, it's
> left as is without being released.
> 
> This commit fixes the memory leak.
> 
> Fixes: 22d8de62f11b ("ALSA: control - add generic LED trigger module as the new control layer")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  sound/core/control_led.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> index 788fd9e275e0..b97f118cd54e 100644
> --- a/sound/core/control_led.c
> +++ b/sound/core/control_led.c
> @@ -161,6 +161,7 @@ static void snd_ctl_led_set_state(struct snd_card *card, unsigned int access,
>  			list_add(&lctl->list, &led->controls);
>  			UPDATE_ROUTE(route, snd_ctl_led_get(lctl));
>  		}
> +		kfree(lctl);

NAK: The lctl pointer is added to led->controls list to track the related
kctl. The kfree is called from snd_ctl_led_clean().

				Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
