Return-Path: <SRS0=57+Y=CA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4FC433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Aug 2020 18:34:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0BF2072D
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Aug 2020 18:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cKF1Vvjf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMGL7467"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0BF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDDFC15F9;
	Sat, 22 Aug 2020 20:33:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDDFC15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598121257;
	bh=U580NZWa7zqpaSO0tNjys54DQKjuT642Kf8THIdUgDo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cKF1VvjfMgtoa4eYWTLVcZC6sSL++euvFdU/IykfmCsn89mLXEMGtmmwZn/YE7Pi2
	 Mz1KodAZtpBTRLEwhNO2bKQ8ovSFeDTL4NqJ8ZEydUq70FvB8cVfmHfp9z0zpemDea
	 v0RsJDKSNFX/cQ0ygmmMZO3E32HUBja89KwF/uJg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69B75F801ED;
	Sat, 22 Aug 2020 20:33:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA2BDF801F9; Sat, 22 Aug 2020 20:33:24 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B99BF80149
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2020 20:33:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B99BF80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="UMGL7467"
Received: by mail-wm1-x341.google.com with SMTP id u18so4730878wmc.3
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2020 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U580NZWa7zqpaSO0tNjys54DQKjuT642Kf8THIdUgDo=;
 b=UMGL7467DTJb8+SJPT6QSCses9xr9mdEM/lwCiWl6mh5yta039G9x5zLvShgCcH+6Z
 0o5dYojwQ+Bqf+niqX0/1rv4PcV3USs+v+PvFc2ArS+uArFJs4wJgIxnEIfaL4tK1f5h
 XruPeU/IpASORuexX9rKHmhKDHWYsTvQjEy5iuOcGf8y/KTZ1D6AvTVoegLeycQxjnHc
 2Nt8MLB71syftHXYDGeqYwih/2GbO9oEedS3eiuRY4cL1nc4pRCcrQ/Z/C7+73+nqamM
 RQw0//6zSXQAeXA7DMCjtCZnb/e/LpFUwUuIZKDeQ+uDCFIc86b2iPtV4XtRbMaAz9+k
 HvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U580NZWa7zqpaSO0tNjys54DQKjuT642Kf8THIdUgDo=;
 b=E3Lx5qT/yV538YMo2bajiJyXJuXLMID+0EiJt6aQndp3gu74ZUq3O0MeenhFjmuFyX
 U43rFqYwZ1x/vI/gF83q0RjcWFWP3SAckqw1Ji0j3jZH2E/rx8RxKCpADfwYxCmRQZaJ
 V8eWGZiWYBPFkT+qQQp/ItPRVnWws14K0UdGJa8/g6d3ZXShVJ1UrxvTGKG53MnZClCL
 7toKQuP1BqIOJVT5qvSvwgVaD9kYeJpcg/FiIsIWAWHzyUBdCJ9I67bJdegOA+IS4ru8
 XysDfpgDbTOf4p6q+6oAZmQF+m7f8cLADsqG94erPA88AExX09PcUYWQx0hGpDhx6ra7
 Z0zQ==
X-Gm-Message-State: AOAM5307jN8g4vPYUy2jKGxPhQRqgZcA+lGGxvxf5L8Zy2+jVlOa7Y/A
 kiRLaMyeTdNf5J7+I+HLWG0=
X-Google-Smtp-Source: ABdhPJxqDeaOBf1mAITXMQbPMEUZK4P+Gr30pgc7bARwHKBW/VJolnhWGxVARh+KFnHauTqm9xnxzg==
X-Received: by 2002:a1c:3c0b:: with SMTP id j11mr8264889wma.98.1598121200625; 
 Sat, 22 Aug 2020 11:33:20 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
 by smtp.gmail.com with ESMTPSA id o125sm14115318wma.27.2020.08.22.11.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 11:33:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] ucm: Add JackSwitch definition
To: Curtis Malainey <cujomalainey@google.com>
References: <20200820233205.505925-1-cujomalainey@chromium.org>
 <b98a8a77-7652-1995-27ba-eb7b6d30202a@gmail.com>
 <CAOReqxiS6TKxo7REebEs2R22Es1_kgzeq5OAhHONBZ6GYjeyWw@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <7160e4a2-886a-dc04-b47b-48ca8eff812f@gmail.com>
Date: Sat, 22 Aug 2020 21:33:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAOReqxiS6TKxo7REebEs2R22Es1_kgzeq5OAhHONBZ6GYjeyWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, Curtis Malainey <cujomalainey@chromium.org>,
 ALSA development <alsa-devel@alsa-project.org>
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

On 22/08/2020 20:07, Curtis Malainey wrote:
> Typically we use JackDev over JackControl, and this would add similar
> support to what you added but within the context of using an input
> device instead of an ALSA jack.

Oh, I forgot JackDev was actually an upstream thing and thought it was
ChromeOS-specific. In that case I can't really object to JackSwitch
either.

Still, problems with jack detection are common for people who want to
use ordinary Linux distributions on ChromeOS devices and from my point
of view it's "Google makes their things run on JackControl" vs "Someone
makes PulseAudio etc. support JackDev+JackSwitch" to get things working
out of the box in the future. I was trying to propose the former, but I
don't know the merits of either approach, so can't say much other than
that.

Regardless, I appreciate your work on reconciling ChromeOS configs with
upstream configs.
