Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8DDC27C4F
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jun 2024 16:07:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAFA81944;
	Thu, 13 Jun 2024 18:06:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAFA81944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718294824;
	bh=6p0sp9pgFRo1PqbzlDQMsuyY3COLLatNjO1bz6AsYto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Dsl1W1BRLSJ6Du9admVCR/YFnHjijFBeNXCtC8qRzzjAbzFNAX8+NFfmkktTY9hhE
	 C0O8hglVp3cWV+qkzt4DnJ3q2Oqpfi0eEAB7wW5GOSi4lJyU5XM23Vfv2qca7gD2zC
	 DL9HN8uSzAjwzjDNSEaVQnpqdzJSFt4oG2Rz/q7o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8E7FF806A9; Thu, 13 Jun 2024 18:02:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 419E6F8973F;
	Thu, 13 Jun 2024 18:02:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62854F802DB; Tue,  4 Jun 2024 16:46:26 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0C682F800FA
	for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2024 16:46:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C682F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=TOlG9xh7
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e72224c395so50289841fa.3
        for <alsa-devel@alsa-project.org>;
 Tue, 04 Jun 2024 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717512379; x=1718117179;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fWM9RazXmkrrcf7cVm+FJhwHBnlPawdSsHuisHuA/0=;
        b=TOlG9xh785MEdNQBR/I1xrxflLVf7L66CwCs+OBXd7L5kBXsdVPdMVEF6h3486N9JR
         8M2rNX+6wdr8CWr1SXQLoqe0pJIODrxmdyBUWQGTOSiUwVAyr1umPgoDM8huCTPMAbei
         gehKjkQ9UiGIhRhkrr0joXsvbU0wHyZ4e9+iA9ELOa6tDVMNbJ5M4jAdG3iuPfP8xlS4
         ur4REG/gslBBmlwyC+sTeAXpR4MGQudmUz/8MH5qyBwuC/j6yzf7BcEIvOwrked9q9p7
         AavCgwr3QfQe3EdbcRfZX3jVVvyKmKNIEcwbPcOxeVlBq/OtiAvN3Oes2r1x+xDEsgnx
         leZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512379; x=1718117179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fWM9RazXmkrrcf7cVm+FJhwHBnlPawdSsHuisHuA/0=;
        b=afEUwpTQErR664H4CAlcG9Qh9t5PsWAxCmeljmXoRP25RfD20bkcuRA+GaAsILGFTS
         dFjkXsFBX08nif4ny0QoHoH+SFg1TMIFP0CgII23gt8juTyDAvS8Dfx6C6r+al8QmlpI
         kH14wwVeWZt8836fwE3y+KjdU/Uy4wZnFPVL/coO5XfmAZtEz+eHHGN5NfBoItStSOU9
         G4+MpbtznRNj6Na5iW5cZc9SNCFrGhOBEMR9+xEgdygQVtaVrPmLaOJkiVIDIQC4N8Lt
         xh7r3E2c06bHYkL1h92NRuCMzNvjnzMEFGfwUxYUMtuum3GqPdzIXFeMHcFWxzgk5hoS
         XpCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxFLLGZXVE8jIlG5yp5OIgURQi1lUhE8HQVpIUQLrLo63I1eG8PYf70kO18DUl5Cyl+DQSCHoAjuHaWYcOdFdgfVgdBHN7QbCsJbk=
X-Gm-Message-State: AOJu0Yzq4P4pFYZ5+4jEmRwyfBbYS2IN8dQd9JXkar+WFtKF3x4hpkoK
	jBLcA3/OlzJJ5uF91+frawTLv/pfmYxj5UvKZ8D6T+7rcii7M1g/4ETfQHUIfPE=
X-Google-Smtp-Source: 
 AGHT+IERd+pOKeaU4WAUxdb915FWhHyou0aFSqNLEgCX/8v3BAB2Hl1Vqes5cCRKx30uO5efQiei6w==
X-Received: by 2002:a2e:6804:0:b0:2e9:81f2:ce03 with SMTP id
 38308e7fff4ca-2ea950f70c0mr70279431fa.20.1717512379323;
        Tue, 04 Jun 2024 07:46:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31be4df2sm7465219a12.47.2024.06.04.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:46:18 -0700 (PDT)
Date: Tue, 4 Jun 2024 17:46:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
Message-ID: <7a0cde5c-db6f-4de1-9dc2-aa2c21fd0210@moroto.mountain>
References: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
 <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: SWNXC4RIKI66DCM4TIFMPGS7HGN66WNJ
X-Message-ID-Hash: SWNXC4RIKI66DCM4TIFMPGS7HGN66WNJ
X-Mailman-Approved-At: Thu, 13 Jun 2024 16:02:21 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SWNXC4RIKI66DCM4TIFMPGS7HGN66WNJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jun 04, 2024 at 12:56:09PM +0100, Mark Brown wrote:
> On Mon, Jun 03, 2024 at 05:16:07PM -0700, Jeff Johnson wrote:
> > make allmodconfig && make W=1 C=1 reports:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/snd-soc-qcom-sdw.o
> 
> Is anyone getting any value from these MODULE_DESCRIPTION()s?  This all
> just seems like a huge amount of noise and I'm having trouble thinking
> of a use case.

The missing MODULE_DESCRIPTION() warnings are very annoying.  We
recently missed a link error issue because the warning was drowned out
in MODULE_DESCRIPTION() warnings.
https://lore.kernel.org/all/202405182038.ncf1mL7Z-lkp@intel.com/

regards,
dan carpenter
