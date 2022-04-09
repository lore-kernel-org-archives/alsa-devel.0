Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57205C433F5
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Apr 2022 20:37:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B121D1729;
	Sat,  9 Apr 2022 22:36:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B121D1729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649536630;
	bh=YH1KYIUY2qEz2O1SC/5M1ZyYTc9GTVd2feI8AyDJ7bQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qm2VQ7moRJv9R/KXDqynDL+r8XQc5IqMhPE8CrYx4m9Xff6f3LMsPketbAyd0wKeK
	 5D+OllONls7PxPfP9mkHwiQXvjKzGqyNTHe5qxeqNvpG7cMxdhmgCapugQdcbQX0Q8
	 j9o98fCCKgMPfhiAXHq/YZNsnULBFax6nFBE8I88=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B698F80155;
	Sat,  9 Apr 2022 22:36:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83FB4F80253; Sat,  9 Apr 2022 22:36:18 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAFC2F80054
 for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2022 22:36:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAFC2F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LlJXRttn"
Received: by mail-oi1-x229.google.com with SMTP id e189so12208566oia.8
 for <alsa-devel@alsa-project.org>; Sat, 09 Apr 2022 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Sw9XDpU5uI5p73R0ixtjbNY1SV8v6quaADBM74EVTyY=;
 b=LlJXRttnHGXfO1kX+w/tO1LbKJ1JsdftQtefhbwCFhzCMSkcjkvppca/4VakjWLRxK
 T2W8HNCUt3hT7Aq61Q7ofcsd+csyPsJsTL4e/gYDTY3O4dtXvDIS+Tffc6ewnUgWwOnb
 el6xZVwvNMMGI11PSyvWwPpajNpR37PzS/OAnRrLyvrJoMSNh9DSm+T+R6kykJJI/Apr
 71gnOarrDT8Fj6OuacWpLxWYdi/egQDYcOwpul5tGQ+u6j14YhgcqXSCNNiYsBbZmIul
 LrJMxgcB4K22Kbq49Xg1OTN5Nnrwg7IjFff8jOFhCHdfFRMjywmD2hdYfYW0jpb2uiFk
 pHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Sw9XDpU5uI5p73R0ixtjbNY1SV8v6quaADBM74EVTyY=;
 b=wipCis3kPUhA0zh6mEwh6Un/naCNe5CUSpgNzJfzf9DKWpfVRoW7ocO58mAa/7TtnY
 5Mvw8zRceP0yIV4N0hZFLAgds1N0lZ+1/CfnMbbpz7XuaRUhZ9zBKx1fUbd5xLse0kQq
 62koIqfObNMJwYVOmf6S9PA1FO1vFwgcDhj2FVpqfzvk2pa03YknItjZMEEKLnFdndzj
 O41GRDR99jwYkofjlWpT/YDIMIo5dL9ODoCVOjKZTzjJzK6cLpvkTLZbZKqyvahNAHLd
 kWqMC862PVAcCPEgYzgRE4Ay1TNQETLNwc6CSMhlxng0shtnSbUBoyAYZf+1brELs39l
 Ygpg==
X-Gm-Message-State: AOAM530KMlcLdxOcbTHwkirhgx2jMFGIMdwhI7N571JPths5F+uOXVDq
 aQ7nrRERMSuyvah8P3ikcpU=
X-Google-Smtp-Source: ABdhPJzb5WK0fX1wg23QIBb2K9gBZUX4HFZjP3/4P5KWwdGa2+DAuYB3pgA/01v79xnPEFWRIBdsjA==
X-Received: by 2002:a05:6808:d4c:b0:2f8:d0d2:d06c with SMTP id
 w12-20020a0568080d4c00b002f8d0d2d06cmr2336059oik.285.1649536569305; 
 Sat, 09 Apr 2022 13:36:09 -0700 (PDT)
Received: from geday ([2804:7f2:8006:103:60b1:f833:388a:391])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a056820050d00b003297b35bc63sm6551018ooj.40.2022.04.09.13.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Apr 2022 13:36:08 -0700 (PDT)
Date: Sat, 9 Apr 2022 17:36:17 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: usb-audio: Increase max buffer size
Message-ID: <YlHuQWqGM+3T3HUP@geday>
References: <20220407212740.17920-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407212740.17920-1-tiwai@suse.de>
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

On Thu, Apr 07, 2022 at 11:27:40PM +0200, Takashi Iwai wrote:
> The current limit of max buffer size 1MB seems too small for modern
> devices with lots of channels and high sample rates.
> Let's make bigger, 4MB.

Hi Takashi,

I did some math and 4MB is still too little for some extreme hardware
like the Behringer Wing, which is USB 2.0 by the way. According to my
calculations, at 192 KHz and 48 channels, even with this 4MB patch, we
would still have only 151.7 ms of buffer for the Wing.

Therefore my suggestion is to expose the MAX_BUFFER_BYTES as Kconf.

Do you think this is plausible?

Thanks,
Geraldo Nascimento

> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 6a460225f2e3..37ee6df8b15a 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -659,7 +659,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
>  #define hwc_debug(fmt, args...) do { } while(0)
>  #endif
>  
> -#define MAX_BUFFER_BYTES	(1024 * 1024)
> +#define MAX_BUFFER_BYTES	(4 * 1024 * 1024)
>  #define MAX_PERIOD_BYTES	(512 * 1024)
>  
>  static const struct snd_pcm_hardware snd_usb_hardware =
> -- 
> 2.31.1
> 
