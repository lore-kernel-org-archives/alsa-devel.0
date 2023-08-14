Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35609C001E0
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Aug 2023 10:56:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E645F82B;
	Wed, 16 Aug 2023 12:55:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E645F82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692183392;
	bh=FKWotQqYRdiVUQJCmJyqJV0tN2V5OkzGmkEHpZKmh4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=L0WzA3UqIQzhH0VXk81Bm17n7YjIxoQXl+BFmGcllFy81sehglpyrZq246gxOTcFE
	 XLzbS1z4ahvju5gGTUVxzEdJTYwgDKhq84J59llw/HGiupZxplQtg4GnIY3Dvwp+HB
	 ek6gpoFF5sl9Mf5GDXhPPE+BYiY2RZYYZPgT6BZU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D38FAF8016D; Wed, 16 Aug 2023 12:55:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 83CC2F8016D;
	Wed, 16 Aug 2023 12:55:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4A44F8025F; Mon, 14 Aug 2023 20:01:06 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C4D3F801EB
	for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2023 20:01:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C4D3F801EB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=o2xON38b
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-76d198deb34so38330885a.1
        for <alsa-devel@alsa-project.org>;
 Mon, 14 Aug 2023 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692036058; x=1692640858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tsRBGViAhNebKd5MnVOTPBp/gGIN2Nz27Fo4yeO8Lw=;
        b=o2xON38b55OMcP+9aeVCKAf7PDYoRHOs8uWXiNOj0qT0oZYhnPZqNK1dDuTE/wgufK
         ZaYA50NAKaSgw9BrID4a3c/Jf3SIa9v2meuCIaeuo99R5kqcrCdxtsHPwyRBlaOng3kf
         yWHi+edmLvYi6dT0ey8942c6CGDP5dOHeTJi2p0UODnhvMXQwTYMd31oNM8kZmvjfxgb
         4vbsO8YTWmJNBbssmSaaGbBtEwQM1Mwz71vZHvrHWCEC6zhEUSGW/OtriK+qTsqOgH0F
         TP+8KKTZLd9wQUpM7iPzy9Ca0GP+/sxP+py0ULPb911WVAtL+RUZxuk18mxLMA3ROmUe
         mwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036058; x=1692640858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tsRBGViAhNebKd5MnVOTPBp/gGIN2Nz27Fo4yeO8Lw=;
        b=U5sgPxqr2QIg9iiLQwzx4q1D5ugw0Qt8VrBRAxglGdWDHfXzahxzIMCImriRMPVgdh
         AME3x9mbCNEiPaZGvYo+EBqtBAEgpSexdcx+cgwmJVObEOdArkxG13rF5s5fW353xrwM
         uECVK4T+kPVPy+vVKsqxfrj8twbJYTZ5BHVJRwipLcJXhXedLJ0XX14rxnwy7UZFACdF
         xQctrajufRaD7a1nb0a9kM0imJtVPWGPoPmIYeQpfAurnvNs4q4qYDP3y+i8ia4Wrcqk
         K3MkgjIXYPtSI5wd77vLLtbLTn1G1Fuq8eUEmhC5Qv89oaybgf+tgpMo0Jb+009IwgwW
         Dovw==
X-Gm-Message-State: AOJu0YzsGDguIuNpK3zPQr9bJdA1TbzhfOVSYiwM9pKEnM1+CP/0eMgQ
	DloPqrJDM13So7XsVE71t9U=
X-Google-Smtp-Source: 
 AGHT+IFEqw/RGrnPlmw/yIuBGX4A0RDWc3YSEIiJelddsXJNppOAsQK356tYQvQDrVV3Qjm/IilxFQ==
X-Received: by 2002:a05:620a:1a89:b0:767:346c:4b37 with SMTP id
 bl9-20020a05620a1a8900b00767346c4b37mr15078520qkb.7.1692036058179;
        Mon, 14 Aug 2023 11:00:58 -0700 (PDT)
Received: from arch (c-68-32-9-74.hsd1.mi.comcast.net. [68.32.9.74])
        by smtp.gmail.com with ESMTPSA id
 i5-20020a05620a074500b00767f00a9c67sm3182843qki.95.2023.08.14.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:00:57 -0700 (PDT)
Date: Mon, 14 Aug 2023 14:00:55 -0400
From: Brady Norander <bradynorander@gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	alsa-devel@alsa-project.org, broonie@kernel.org
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@linux.intel.com,
	perex@perex.cz, tiwai@suse.de, cujomalainey@chromium.org
Subject: Re: [PATCH] ALSA: hda: intel-dsp-cfg: Add Chromebook quirk to ADL/RPL
Message-ID: <ZNpr18oSz1bDayj1@arch>
References: <20230814012637.487602-1-bradynorander@gmail.com>
 <dfdc7097-6286-f3a5-be41-eafd73fe128b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfdc7097-6286-f3a5-be41-eafd73fe128b@linux.intel.com>
X-MailFrom: bradynorander@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 75EVITIQK3LTBGNIQ37QL4BIPSNQ6F56
X-Message-ID-Hash: 75EVITIQK3LTBGNIQ37QL4BIPSNQ6F56
X-Mailman-Approved-At: Wed, 16 Aug 2023 10:55:02 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/75EVITIQK3LTBGNIQ37QL4BIPSNQ6F56/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Aug 14, 2023 at 08:54:15AM -0500, Pierre-Louis Bossart wrote:
> same here, I don't think we can blindly add quirks.
> 
> One might argue it doesn't hurt but not all SKUs are supported by Chrome.

Fair enough. I wasn't sure which SKUs were used in Chrome platforms and
which ones weren't so I figured it would be safer to include all of them
than miss some that are needed. I can resend the patch without the quirk
for the PX SKUs.
