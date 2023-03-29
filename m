Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2649C6FD18
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Mar 2023 16:15:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB653E77;
	Wed, 29 Mar 2023 18:14:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB653E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680106501;
	bh=uBpZwiL0N4mhJ1H7tQBMdgL0O0dWdM50vQHTerxHVkk=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=A1vFfedYaFRRpv6PSE7ilzQ9LQ3fteLVGhm36XP3Txl98vAKemlhu1BcBvW4JOzj+
	 aERbi8Y3XodSPCL4tjEtoY6iFVtXIdCkV4BfNqg0/ZercBasSayA/biUD3FCyThfx8
	 +Adw58JgZS18d+zOp8e82UorbHpSsooP5ufjjZlc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 95C84F80527;
	Wed, 29 Mar 2023 18:13:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56CA4F80272; Wed, 29 Mar 2023 17:43:25 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C9C60F80249
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2023 17:43:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9C60F80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=WpVQV2vB
Received: by mail-pj1-x102d.google.com with SMTP id
 mp3-20020a17090b190300b0023fcc8ce113so18954923pjb.4
        for <alsa-devel@alsa-project.org>;
 Wed, 29 Mar 2023 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680104598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Es16+5r67lDTkeZGkNgX2L6ri/WdoWiVAuB5GMI9+FU=;
        b=WpVQV2vBGC83MtKhnNev0kg80aWJ+jx48URZIlEqdDz2+oA7SNOuueBtYuSR/jjHSe
         5Uk4941khc9MHuFmcxe2eHpRiD3TFRuAqjP8jpnYXUQAld5Ei+zLQaO89wkOn1/7GiKU
         Dsf/HZykv9WD/JmggFTpVjI+h4Nl+r9AoHfn4lpCBiZ7ZTBMLg2YnbUl0I3n0BVeWBqD
         O3tkytSP5BU7R/l+itbMtNDePZpjgHl7Ym3qGIHyTkDU+/0t9ebor29yS6WY3lczWYao
         5Plee9CanuY5Uzg4dXNZWFnpqUBLAC5rG/X9/MFlQb2j1bPohONJPYSH+fW4BtOr5vKT
         ukEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es16+5r67lDTkeZGkNgX2L6ri/WdoWiVAuB5GMI9+FU=;
        b=tesNa8wZfDGnqAlise6yfQnB4Izbr2dq0+B+k8pqVs8tBTloQy2Fam4YyXVaxCGpns
         yeBWUT6WCVR8hMiQeIaZ55W4lSYRKBlSs1xsO5N0bSvr9IhNi5HhEptEObUaCNv36BcB
         Kegs/IdQ02AqovRUA1B60a5bujU2dIxA3DOrw8kpLs2F05//XWf7420H8pkENKuYv4/q
         nWAWzx5qDKnu3WlWFWocFIqg5aLnp2B3LKG8M1ar5NHkw6HmOtRSXOl9ewN+meq0sKgi
         GXdgq04EfGFkjNWUCVy15aJBcwz7kM85xRBauJxdMc6lF8sAg6+MMaXSmC5tKKmNENX+
         U5rA==
X-Gm-Message-State: AAQBX9fIIV3Pd6yKjV6bKJz6Aa7bC6IupFFRtgDizAT2wagg+9xt31qL
	ea2/Lfi75Xx7KzCDuPpSdps=
X-Google-Smtp-Source: 
 AKy350ZXDVdlAQT1MlVwLZOXdf2CwL8TWro1D/n5/ekFA4WdAGgoXvpltfTLuXro/ft7/M7dcNfC7Q==
X-Received: by 2002:a17:902:da8e:b0:19c:c9d0:5bf8 with SMTP id
 j14-20020a170902da8e00b0019cc9d05bf8mr25108787plx.35.1680104598021;
        Wed, 29 Mar 2023 08:43:18 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id
 ay6-20020a1709028b8600b0019a997bca5csm23106033plb.121.2023.03.29.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:43:17 -0700 (PDT)
Date: Wed, 29 Mar 2023 23:43:10 +0800
From: Jianhua Lu <lujianhua000@gmail.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] Asoc: wm_adsp: Add support for loading firmware with
 prefix name
Message-ID: <ZCRcjgMWhV0dp8p0@Gentoo>
References: <20230329130525.15830-1-lujianhua000@gmail.com>
 <57c5a3b3-00cd-5b44-02f4-dedabacc7662@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c5a3b3-00cd-5b44-02f4-dedabacc7662@opensource.cirrus.com>
X-MailFrom: lujianhua000@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: M3L6KQ6EIMB6G2NATMW2A5TZRZ3ABBJZ
X-Message-ID-Hash: M3L6KQ6EIMB6G2NATMW2A5TZRZ3ABBJZ
X-Mailman-Approved-At: Wed, 29 Mar 2023 16:13:32 +0000
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Simon Trimmer <simont@opensource.cirrus.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M3L6KQ6EIMB6G2NATMW2A5TZRZ3ABBJZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Mar 29, 2023 at 04:33:08PM +0100, Richard Fitzgerald wrote:
> On 29/3/23 14:05, Jianhua Lu wrote:
> > For platform using fdt, system_name is NULL, it doesn't provide
> > a way to load firmware with prefix name, so add it.
> 
> This is intended behavior.
> 
> To load per-amp tuning you must know the function of each amp.
> You only know that if you know what hardware platform you are running
> on.
> 
> So if system_name is NULL it should fall back to generic firmware.
Make sense
