Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2C2C433B4
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 08:02:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA9560BD3
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 08:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA9560BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D691E167B;
	Wed,  7 Apr 2021 10:01:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D691E167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617782569;
	bh=NlkQZJdK3YQr2pJN1tC9jnO4VLCHOe0YejQV58FY4K8=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RZVMKViMMv/cMQbPw6yHE1ybRTwOxGXYNkhwphapjaNdijdHoCQd3mqKjc+mShs83
	 cldxTBlaQHOsGcbl9/XiCHzU/PLpGi3gmsqcbePqFQXJ61CanRNmq34kzpe7YLrHyC
	 yKGWqeqP8Ldgg805CJm/13nrQngbkk2M+1sReyqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46BD6F800BD;
	Wed,  7 Apr 2021 10:01:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 121FEF8016A; Wed,  7 Apr 2021 10:01:58 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAE91F800BD
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 10:01:46 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C44F3A003F;
 Wed,  7 Apr 2021 10:01:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C44F3A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1617782505; bh=QT5zhwawmfUx8o3Hm+J+gy/1GF2mpoqEA9CIX6THvXw=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=Ml1Ssgd6EIib/Hu+LziyEuppE2eDYVnmxYyBFE+a0er7Jzf5JYCK0VEXnwJQUV7/o
 Sbiua7ffoUTZYJZwjh5rjFe7/mZ4ungm2OEAK6UpO2JBoS0NQhOzw8aEYamKTdNvow
 cGClx2/5k5K65J0yhSQrs2JB1wDgNmAyMxCjO/Jo=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  7 Apr 2021 10:01:41 +0200 (CEST)
Subject: Re: [PATCH] ALSA: aloop: Fix initialization of controls
To: Jonas Holmberg <jonashg@axis.com>, tiwai@suse.de,
 alsa-devel@alsa-project.org
References: <20210407075428.2666787-1-jonashg@axis.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <78b5bd70-5bd0-8733-ce2e-247708278460@perex.cz>
Date: Wed, 7 Apr 2021 10:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210407075428.2666787-1-jonashg@axis.com>
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

Dne 07. 04. 21 v 9:54 Jonas Holmberg napsal(a):
> Add a control to the card before copying the id so that the numid field
> is initialized in the copy. Otherwise the numid field of active_id,
> format_id, rate_id and channels_id will be the same (0) and
> snd_ctl_notify() will not queue the events properly.
> 
> Signed-off-by: Jonas Holmberg <jonashg@axis.com>

Nice hit. Thanks.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> ---
>  sound/drivers/aloop.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
> index 52637180af33..80b814b9922a 100644
> --- a/sound/drivers/aloop.c
> +++ b/sound/drivers/aloop.c
> @@ -1571,6 +1571,14 @@ static int loopback_mixer_new(struct loopback *loopback, int notify)
>  					return -ENOMEM;
>  				kctl->id.device = dev;
>  				kctl->id.subdevice = substr;
> +
> +				/* Add the control before copying the id so that
> +				 * the numid field of the id is set in the copy.
> +				 */
> +				err = snd_ctl_add(card, kctl);
> +				if (err < 0)
> +					return err;
> +
>  				switch (idx) {
>  				case ACTIVE_IDX:
>  					setup->active_id = kctl->id;
> @@ -1587,9 +1595,6 @@ static int loopback_mixer_new(struct loopback *loopback, int notify)
>  				default:
>  					break;
>  				}
> -				err = snd_ctl_add(card, kctl);
> -				if (err < 0)
> -					return err;
>  			}
>  		}
>  	}
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
