Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0FC432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:44:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51CA20709
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IKgo8Xz9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wUE42iaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51CA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 564A3839;
	Thu, 14 Nov 2019 22:43:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 564A3839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573767842;
	bh=3M7Dtjd5YcblzKfgMVSZO6S3OBJy4PJ3dc56E5yj1mI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKgo8Xz9KmI81CbeYncJoXJnIcQw3Qz0Wu+oDHFQEhfHPm2bAF2/gOwff+pNn9d8D
	 LGPVNHGJD0dxbHK2v2zxHhlFZQlB+FTB39PHMJt0BGjx9QJ8LGR+krUYpM5G3IKAsI
	 T4gsvjhSUhDG7bDPc2Rre43yg1+5BqMwb/D8ia8c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3948F800CD;
	Thu, 14 Nov 2019 22:43:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9BF0F800CF; Thu, 14 Nov 2019 22:43:09 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BABA9F800CC
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 22:43:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BABA9F800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="wUE42iaD"
Received: by mail-io1-xd42.google.com with SMTP id i13so8565178ioj.5
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 13:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OuheF7AXL4KEuu5esQPEloYFJLM+rFePn8qyxHsJg4E=;
 b=wUE42iaD6J1KTnO6y4RL65zgRjxgDPIY7aq2aHxhzZu5x6ofXzqnxA+0DXq/qIVUML
 7KRqZAALfvu+NQu9Vmsx4y5oEzQVnM6t3yQ8P9Hm2Ngq0OIhAynC6/6LP/dGxBXsXRO6
 XR2k1Fj3AgwmxXH47ULMm9OkqlrjAktMcd2U6sMT61CTpGWHWGgppw4OANG7N2qQSzxr
 yug/9tMdELD8J8RcfdGOKwRTWjmRbakgdcpr8I7K53bFHbEXnNIs5AgOpjai2gp06HrD
 WteTQ5K8sa87CqvVRhlJu4qeg/vrch7Ws+qH9aLbXBPf8bKvAQHDMmIaSTi8qR70mI8E
 7ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OuheF7AXL4KEuu5esQPEloYFJLM+rFePn8qyxHsJg4E=;
 b=rRnmuVbvk9BH4IqRQgPeaBQDcJHIzamAsirK+u65aGDDE++W1iyAj/RxQhkA7CxX1U
 +Qq4YBiKN3U5ZsgoQHr7JMA+za97TqLAqI/zmvaQMNqYDX6R4ByLgompwcSB9zLDgj9C
 cjklP9tegmiLV85S2Y2P3wL7GTWExDc82vfIBXT29wAwKywggtIXl7H/YYPgqZck71zZ
 Gr8rgPt3HzD7Gs9O5OtPvUtTE/2PCfPXTfdpPRU7TPiWB1EsnsIvw6B9neby1ydrWdtE
 glVkVdG+WIH0evaUnmvqmUCwWOWhc++6lya86DsWfoh8EQBCPvQ2eoI+alERB9yxzyvm
 dEqQ==
X-Gm-Message-State: APjAAAXMxizvzNkimM4PaQ07C04Xl5TG6Vs72jz2QyQKMbx7r+8kkpLp
 ZVYLmOaJCyWJKXD4VaTNHFx1uw==
X-Google-Smtp-Source: APXvYqykHIZm7W8ks21s27PuMpYGDitmGtY9cXfyCZVREuyY1mIarwRIzqjtcnv99tMPNLWzr/a8fw==
X-Received: by 2002:a02:3f1e:: with SMTP id d30mr668548jaa.102.1573767784130; 
 Thu, 14 Nov 2019 13:43:04 -0800 (PST)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
 by smtp.gmail.com with ESMTPSA id c10sm955237ilq.37.2019.11.14.13.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2019 13:43:03 -0800 (PST)
Date: Thu, 14 Nov 2019 14:43:01 -0700
From: Ross Zwisler <zwisler@google.com>
To: Jacob Rasmussen <jacobraz@chromium.org>
Message-ID: <20191114214301.GA159315@google.com>
References: <20191114190844.42484-1-jacobraz@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191114190844.42484-1-jacobraz@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Jacob Rasmussen <jacobraz@google.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Bard Liao <bardliao@realtek.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5645: Fixed typo for buddy jack
	support.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, Nov 14, 2019 at 12:08:44PM -0700, Jacob Rasmussen wrote:
> Had a typo in e7cfd867fd98 that resulted in buddy jack support not being
> fixed.
> 
> Fixes: e7cfd867fd98 ("ASoC: rt5645: Fixed buddy jack support.")
> Cc: <zwisler@google.com>
> Cc: <jacobraz@google.com>
> CC: stable@vger.kernel.org

Need to add your signed-off-by.  With that added you can add:

Reviewed-by: Ross Zwisler <zwisler@google.com>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
