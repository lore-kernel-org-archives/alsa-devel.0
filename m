Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C117C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 08:46:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790BA6137C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 08:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 790BA6137C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE1711687;
	Mon,  4 Oct 2021 10:45:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE1711687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633337191;
	bh=rWrqEGh/cZq4hcrLd7cqC0rOQXLLK99gk10HWa4Ocn8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vt5knRCo10Tjss0f0IwDKwC6ouDNn1RiY7YsvouqnWcw20gyfXPQQGqMf2fdGjitA
	 S+2/cqDgOHDNA99yAM9LTAj+nbpN7wZcLb64VmjIzh61fMOR70rZ6Hqx5Q0GSCmfUZ
	 sMLGnSERU2ieaJnBGVUxJdkUDwRvofz24sKGLIQo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42350F80229;
	Mon,  4 Oct 2021 10:45:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09D6BF80240; Mon,  4 Oct 2021 10:45:39 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54B3AF80171
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 10:45:29 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 990BAA003F;
 Mon,  4 Oct 2021 10:45:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 990BAA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1633337128; bh=GyxVEALYjAZmDQ/V4158CFwkWVvEKHOCKxihnfuJl8Q=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=meHn+LHgxY+OTS3tGlHUSfQaRovK1KZEkv8fnFmEqIdCe50Wep4dXvK98zlI6ehVO
 qnsLxBAgyOkJl0TGRGSrc3Wb4/CdBC29Wdqu3TcHrOiAJz8ZZQOlO0m6q7nxEj0bCA
 47r+vf5toORPEbyIM1xkShQcz3kLK+uvN2xJo2bc=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  4 Oct 2021 10:45:26 +0200 (CEST)
Message-ID: <c350bd52-8be4-fceb-15b1-30692f9d7f49@perex.cz>
Date: Mon, 4 Oct 2021 10:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] alsaloop: Adding openctl_elem debug log
Content-Language: en-US
To: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
References: <20211001080028.6423-1-pavel.hofman@ivitera.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20211001080028.6423-1-pavel.hofman@ivitera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 01. 10. 21 10:00, Pavel Hofman wrote:
> When debugging what ctl elem was found and opened (if any) a debug log is
> helpful.
> 
> Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
> ---
>   alsaloop/pcmjob.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/alsaloop/pcmjob.c b/alsaloop/pcmjob.c
> index 8b72af4..845ab82 100644
> --- a/alsaloop/pcmjob.c
> +++ b/alsaloop/pcmjob.c
> @@ -1191,6 +1191,11 @@ static void openctl_elem(struct loopback_handle *lhandle,
>   		if (err < 0) {
>   			snd_ctl_elem_value_free(*elem);
>   			*elem = NULL;
> +		} else {
> +			if (verbose)
> +				snd_output_printf(lhandle->loopback->output,
> +						"Opened PCM element %s of %s, device %d, subdevice %d\n",
> +						name, snd_ctl_name(lhandle->ctl), device, subdevice);
>   		}
>   	}
>   }
> 

Applied. Thank you.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
