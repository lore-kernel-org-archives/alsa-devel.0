Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4AEC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Jan 2022 19:29:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BBD81AD0;
	Tue, 11 Jan 2022 20:28:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BBD81AD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641929354;
	bh=4Pe0z4yW2oipnCJMz8dUngQeHvs2SHONvU0o7U6Vuis=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H1aR6nX/ACyxN6Psawwn+T0JndE97v4AxsnmyjhMmS9o4Jl6t25rkvq7cKuLuTfPP
	 GkJDoGRUcDpWD/IRHqrtknE0QeikunMvVwXJyUFurnlpEpvqNXgMmlOSmUwyLnNBmT
	 Gx5O9kY9+xwfcAWiv1e/bnOIQQkZ3I8NuyUTuRNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24FECF80054;
	Tue, 11 Jan 2022 20:28:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B57BF80302; Tue, 11 Jan 2022 20:28:21 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35BFAF800A7
 for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2022 20:28:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35BFAF800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=igorinstitute-com.20210112.gappssmtp.com
 header.i=@igorinstitute-com.20210112.gappssmtp.com header.b="XJK8WGVd"
Received: by mail-pj1-x1032.google.com with SMTP id
 rj2-20020a17090b3e8200b001b1944bad25so642769pjb.5
 for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2022 11:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=P9GGnh4ZAPicH6zFbaaibhXVxtkqcKWl+gDZ/9uGstY=;
 b=XJK8WGVdpyWBTW2rl6/42XtxFt9UrgnqqMQzJoOJEHvBzE5ADG38zKOh8jNEzOzfVa
 OV8Ev2SH3em9lpNTeMncSLR63IzJSOQ3uCrPfKhO/cvEZ23mFf8PenF061eqHnIJL4We
 J7B3DqG7aKDJ9jhdpTer+qaNvtAJW7O3cENRZnc6zG0VVpZXuEqq0/cD/qDyRgwrzyOz
 HK9hzbm2TcA49nYlmVZI+ehPKC9zRKi0SE9NZD6zcKHGlv0Lm9VcJ/GibNqcF61mMlgv
 6B3QyrW6v+xcPyw7BynwSsxIxBgZMSpmAhb32RAaKLg9mUXR8C4vql++jG6GA8lrqwhd
 bRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P9GGnh4ZAPicH6zFbaaibhXVxtkqcKWl+gDZ/9uGstY=;
 b=HXiMDSNHf1ZcXVgyfZqI60j9x1EjjyPxSJzGKp5z4Mi4Hr6Gt2Q8bKU7cfNxzLtAXg
 U2rzQ2aZ1eT1qitYNTkmjp50JgglKqatSp0V/g+E4gA+8wHCqNchZnKICeFlqOmTDJM5
 CBo0pRiDkGpqAQKaZE+RXpTHcbIuLpDkuKCZitybtWpQyU59kYVHuQ8rM89YkfLZ191C
 cMSVsqTl5H5fXc2EL6SgikCOY5a3UWLGIGPU9ReD2ukOtry+ZqPtvGhkAR1mcsF7l4GZ
 Cx8/5jy48ORZcsfdFsGxPppc2Hao291ke0y5ZeoomPwWFYiKaG4WAGxkFvKcKqFOayG9
 1I9w==
X-Gm-Message-State: AOAM5317eYbt8Y+OcfOr3YWA3QaUCbHqoWi9Kn+MYAHa60Tl/qRVap+R
 klu2HvYLKTM6m3MF/uXf3zqgKA==
X-Google-Smtp-Source: ABdhPJwn6iFqQcbHTGhaXHMnTyxbURXfuNpqLv1VIhHz64R5T9Ua0/tnAfrcYo1lrQMclNym60pNsw==
X-Received: by 2002:a17:90a:c254:: with SMTP id
 d20mr4829393pjx.226.1641929289251; 
 Tue, 11 Jan 2022 11:28:09 -0800 (PST)
Received: from localhost ([121.99.145.49])
 by smtp.gmail.com with ESMTPSA id t27sm11926893pfg.41.2022.01.11.11.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 11:28:08 -0800 (PST)
Date: Wed, 12 Jan 2022 08:28:06 +1300
From: Daniel Beer <daniel.beer@igorinstitute.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add support for TAS5805M digital amplifier
Message-ID: <20220111192806.GA10345@nyquist.nev>
References: <61dccc59.1c69fb81.e1d98.02e3@mx.google.com>
 <Yd26p8rF3arufd2R@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd26p8rF3arufd2R@sirena.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Andy Liu <andy-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Derek Simkowiak <derek.simkowiak@igorinstitute.com>
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

On Tue, Jan 11, 2022 at 05:13:11PM +0000, Mark Brown wrote:
> > +static void tas5805m_refresh_unlocked(struct snd_soc_component *component)
> > +{
> > +	struct tas5805m_priv *tas5805m =
> > +		snd_soc_component_get_drvdata(component);
> > +	uint8_t v[4];
> > +	unsigned int i;
> > +	uint32_t x;
> 
> > +	snd_soc_component_write(component, REG_PAGE, 0x00);
> > +	snd_soc_component_write(component, REG_BOOK, 0x8c);
> > +	snd_soc_component_write(component, REG_PAGE, 0x2a);
> 
> This isn't using the regmap paging support and I'm not seeing anything
> that resets the page here.

Hi Mark,

The blob of register writes we get given from PPC3 contains a whole lot
of explicit page and book changes, and there's not an easy way to tell
regmap about this, as far as I know. Do you think it's acceptable to
stick with explicit paging for this reason, or is there a way to make
this work with regmap's paging?

I'll go ahead and address your other comments before resubmitting.

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
