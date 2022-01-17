Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54616C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jan 2022 06:00:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25236175D;
	Mon, 17 Jan 2022 06:59:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25236175D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642399233;
	bh=TuVZ4PVblhqGK5f01b5TY4AFR1IwPzPPr8WCDlWTQj8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JckpzQ5bDx6sru15/klr3Tt+WtbBm1pr9HsBj4P0PyNaQdV1t/wQYOG85xY6cgJEv
	 SK1MLKz4HNOi21xW26PLEGo4raKg6S9QkvXgS571SBVfc2xU7qmYQv1dn2ujxLiV0Y
	 0PZBE922BPcJJpBG9jJpq8fRlxDHTxgj7lh/NU98=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FE13F800EB;
	Mon, 17 Jan 2022 06:59:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B197F80249; Mon, 17 Jan 2022 06:59:40 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28709F800EB
 for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2022 06:59:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28709F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="MStWzEQo"
Received: by mail-pg1-x530.google.com with SMTP id 133so5611894pgb.0
 for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2022 21:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SEqaQCJKDxiFQ3pZ017weFeb+0dnjvIO+EowvolRqQo=;
 b=MStWzEQoU2/kESRCpGambaEvP2Cxi9hVDCklwBIuHO/nQ5lRbMccJUhxzRjZrvVsQR
 5AnAEAphxWtgj1HkV570g6Hp8zEORRxC7jlCANfq2t3lat/AegF7mL9w8OGfUPApbtXv
 6wsoshJHjDaE8zHkwM8NMN9tgaM3qZqcZQVPda7R2v7BCdvYZ/UVBuQF7AGQpj6G0uMQ
 r9sk45X4NuFyUXOXD/rV8u918PinANpazmUma4laOKuOfXtdzKh0+VaPa5Yqo2SDeKMY
 bqvE1w2LmC1ilPPxrdZavk1FCAzYpi2KLrk/HZVR00JRAfGpM/S2X4zKqUvwH6FojGfp
 dQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SEqaQCJKDxiFQ3pZ017weFeb+0dnjvIO+EowvolRqQo=;
 b=3smHnHq4QteOJjKK5Coch2WKXXJrvOdY7ryr4DLBQiQhfsw8D69L4SVykmkGSYIG0p
 VygRwCdmNDg2GptcRU5YYrkXB99+6VfRffXtkEIBb5cqBRO9I20cRRx90U4lsS4fjThn
 crnmHsi7sP0+s1m4ufyzSVdxZbWKkFNNvY83DRwHK+7Lw8FPu3B49C/QgUxMMT5ngl/f
 1+iMPUSXI0utPwS0wRDv+nujIRDNZFnESVI1mKsU28EVq0jQXRs4N58SzdHM4KN7jmQP
 EieMDn2lcbz46Y08JR1P66iym5R4Dhp/7n6UgYgOjwFEtiobM1KEGh4yd8/iq8KQy726
 Hnjw==
X-Gm-Message-State: AOAM532IJ7nN83nyj3NGaYJ7h/BvV3Uu8WqxX9WjxjmHJz3lvodVWdV4
 mPS21bOsGLdC+RMQCvhHb4FG5g==
X-Google-Smtp-Source: ABdhPJyPvEnUvSKO9RLm6mAtrfhvGGimgy8WJTS7FgOIsni8aTvBI9lhcnIJf29AgV+vQPoQEm6Xbg==
X-Received: by 2002:a63:2b02:: with SMTP id r2mr18084089pgr.530.1642399172344; 
 Sun, 16 Jan 2022 21:59:32 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:bc3b:819f:7751:ac96])
 by smtp.gmail.com with ESMTPSA id b2sm12991291pfl.138.2022.01.16.21.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jan 2022 21:59:31 -0800 (PST)
Date: Mon, 17 Jan 2022 13:59:28 +0800
From: Tzung-Bi Shih <tzungbi@google.com>
To: Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: fix unmet dependency on GPIOLIB for
 SND_SOC_DMIC
Message-ID: <YeUFwPHyAfe2ex+0@google.com>
References: <20220117050324.68371-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117050324.68371-1-julianbraha@gmail.com>
Cc: alsa-devel@alsa-project.org, geert+renesas@glider.be,
 linux-kernel@vger.kernel.org, fazilyildiran@gmail.com, tiwai@suse.com,
 lgirdwood@gmail.com, broonie@kernel.org, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Jan 17, 2022 at 12:03:24AM -0500, Julian Braha wrote:
> This is because SND_SOC_MT8195_MT6359_RT1011_RT5682
> selects SND_SOC_DMIC without selecting or depending on
> GPIOLIB, depsite SND_SOC_DMIC depending on GPIOLIB.
> 
> This unmet dependency bug was detected by Kismet,
> a static analysis tool for Kconfig. Please advise
> if this is not the appropriate solution.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
