Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A15C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 09:56:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE17D2245C
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 09:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE17D2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 225B017B6;
	Mon, 18 Jan 2021 10:55:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 225B017B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610963776;
	bh=F0dlXsKp/JOnRbjkRXA8voIo/rWoSzaJPvvtoA+w7pc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OMGq7Ncj/+OQGlW1x4iWhnzXfFw3aTJn2QFow7EjaBb7erBk4C4CbeowSZBLx3mh5
	 Bk+3a5be6sptHJ4xp6wou99x3ufl5QCFTCJaon4WtLJXUowbdyaM4mawhTG2jD1lDB
	 6Bt8tFcy1G5bhbOe/gjIvy+Bqi2x+8dnkgL0Xa7A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62388F80166;
	Mon, 18 Jan 2021 10:55:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA43EF8016E; Mon, 18 Jan 2021 10:55:22 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48D9EF800C0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 10:55:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48D9EF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="EM3w46xM"
Received: by mail-wm1-x32f.google.com with SMTP id r4so13193151wmh.5
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 01:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=yQySp1I8dFlNRZ6TD27mEdeFa/4xBBrxR4vuqWLafeM=;
 b=EM3w46xMJCikT6pc8p5LzxRmPXG4HmSnVkSjwPfCOJon/tBwwlsZi2ieazcVLmtHlq
 EqRb1Dy6VT33nWYEcocTvZX6ZFAaetOYEbz+owufRCsbbviwwQOMXczFnAgIBd73+Qfw
 3RDX/4VrJ57YGxWS1qq9Ey5DWgPiAwJhzaHGx/86NMIWZJFZwUukekdz7lIFCQQEDHMj
 jhhwAe7SUmBP0X9Fx9EMS1cvexbx5sG9kQQfLfNZK/TYVeOSoB7UyrEqV8vireMTDydW
 ty+nCLNeYmuI3ynzLufT7etS1YG14NT1c24MtRd6bPFD5lLVIeB/eOPmZFrG37r0FBzn
 lBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yQySp1I8dFlNRZ6TD27mEdeFa/4xBBrxR4vuqWLafeM=;
 b=dQeBpL0JCDk0uciE0vSbhkdVFz4lLKgUY3zOQ03hOvHosPWmKg9LB+L8j7Be122ao+
 4uz4Ah379xWhMYJ9ZIW4RvkQfRPB5ruPtOuEHv4T1acrxXTvuCOSDv4QnQt71/CBmmLU
 DdV+IQF+U5+YfznDaCuISLdQGVETXkVQcTVGxSAqGUp1JAmJNDW+ZpX72qO25aaCrfr+
 ew57tn6l+J1uNJoLp2QgYpEiQUol7WENFOpvT07/qpRaKzHdjxffutt+tKMwF6C+gYZl
 Lo70U4V8A/XH09MXlouVYuS32L5VaPREHbFjngiGI4+c7E6k+X9XqGUf+RQ1lnDzsNxp
 fSvw==
X-Gm-Message-State: AOAM530BmK7Xs9tHyB7fSzYCRBncxLd66g96aEDDdXONWMAQGX/EoouE
 MIN4YzzEr8IskXInqgJ/NQ+wtA==
X-Google-Smtp-Source: ABdhPJzLhP1CCxFTPbYev6ZBSYyZSUO95R17hQJYKV68+tkak1J7y9dicSOAK6pN4T3m+Clh+pIYng==
X-Received: by 2002:a1c:4e:: with SMTP id 75mr7199354wma.150.1610963712403;
 Mon, 18 Jan 2021 01:55:12 -0800 (PST)
Received: from dell ([91.110.221.158])
 by smtp.gmail.com with ESMTPSA id c2sm24225161wrt.87.2021.01.18.01.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 01:55:11 -0800 (PST)
Date: Mon, 18 Jan 2021 09:55:09 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 00/12] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210118095509.GA4903@dell>
References: <20210117160555.78376-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210117160555.78376-1-hdegoede@redhat.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>
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

On Sun, 17 Jan 2021, Hans de Goede wrote:

> Hi All,
> 
> This series reworks the arizona codec jack-detect support to use
> the snd_soc_jack helpers instead of direct extcon reporting.
> 
> This is done by reworking the extcon driver into an arizona-jackdet
> library and then modifying the codec drivers to use that directly,
> replacing the old separate extcon child-devices and extcon-driver.
> 
> This brings the arizona-codec jack-detect handling inline with how
> all other ASoC codec driver do this.
> 
> This was developed and tested on a Lenovo Yoga Tablet 1051L with
> a WM5102 codec.
> 
> The MFD, ASoC and extcon parts can be merged independent from each-other
> although that could lead to a case where both the extcon driver and
> the new arizona-jackdet library will try to do jack-detection. If we
> end up with a git tree in that state then one of the 2 will fail to
> load because the other will already have claimed the IRQs, so this
> is not a problem really.
> 
> Or the entire series could be merged through the MFD tree if people
> prefer that.
> 
> Note that this series also paves the way for some further cleanups,
> removing some jackdetect related variables like hp_ena and hp_clamp
> from the arizona data struct shared between all the MFD child devices.
> I've deliberately not done that cleanup as part of this patch-series,
> since IMHO the series is big enough as is. These cleanups can be done
> in a follow-up series once this series has landed.

Would you mind using `git format-patch` to create your cover-letters
in the future please?  This one is missing useful information such as
the diff-stat and patch list.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
