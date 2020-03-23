Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29248C54EEB
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7BD20637
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Edg4sGUh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnrXSUpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7BD20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC9F6852;
	Mon, 23 Mar 2020 17:05:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC9F6852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584979583;
	bh=8gXikLrzpZ5UZZK8kgeHssbC1E5TNKICl+e91mn3MGE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Edg4sGUhrhoWUjL+FfyJ5h9tGbef/p6nQqN8hXo4jeuzWErK/k/VO34iPPzwUpzG0
	 33v2nODMhzllV6c/BFp2Qr+eBDR6XeuzKd2r0WOhlzYTF6PfNztQutCnx4dwAm8VvW
	 khPYo5LsGrB9zqsWUj1SxMpgQEoMfl0ezOn01X6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76142F80147;
	Mon, 23 Mar 2020 17:05:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 210CBF80158; Mon, 23 Mar 2020 17:05:30 +0100 (CET)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6BAD0F800B9
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 17:05:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BAD0F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="OnrXSUpt"
Received: by mail-lj1-x244.google.com with SMTP id s13so15227209ljm.1
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E5FPfWElFKdMpZuvQ9h2jaYCgsUPtm/4IuEU5E0aiwA=;
 b=OnrXSUptfAUolkAuOXhiZeTpTm8ihay0iQKBsP3Kd/dLGggrA1xtTPVI0Rgw2fCYXE
 iFEnxMki/UGXNKKOKs80goGAZ65RfvVxSUrMwyPb5KDSnpvFUrQ/Bw8s9qouc3OCVbJC
 /8oF4FV+HiB+E5d4Q7gHX2DktkCNR0wrHs6x5arcC319JecRoRLS4tHpvgxsNmLFDntZ
 A/bbpAx25k+hhK0qucX+RFWPbHGvxI3+IBY3r6+VFWKCYzxKxUjumeMgmMYzGYHerZ5Q
 g95YVOMXMz9d+h+yAwwY6FW8t0yTs3jSmYaJH5ziagHNeik+wYpuNASDNwBPkQUMjON0
 kWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E5FPfWElFKdMpZuvQ9h2jaYCgsUPtm/4IuEU5E0aiwA=;
 b=EUrJQW6s+VoqWknevmtuJcxErcbnPb60E/NpUedlgCjzSz6oi7ecrNFfQ9gZmF4aYn
 salcilDCumU22wOvZJhTGXqAXBKkv6T0SQtclvzSN7SJz8PvpiTgMnQmkc+iPnZZjc8J
 h7RC8l+ehOZo3q9MYM9x9Srkek4IW0jQV7IgBcNiC4egljIMEnELgSaQhvPHVUlRFu3Z
 ByUubd8tTOJrgrx6WvRTb4ZQXwcoUD+jABah8YuebEQ7+2UQhFUT4m17IcqnQHqRhiG7
 Sqx+2cl/MRX3Cf1wl2iHr8xb8CSqQdIhSiloiGqY+M6ShrJoC5uSfsmRDzcs5y8neASh
 i78Q==
X-Gm-Message-State: ANhLgQ3RMnHLJ/bj+SLHcOVnp03WQAiHzlGzDI0PlRoak8aPCYtVDE7U
 TUF0oR7R1afKj+3hDNsNG4Q=
X-Google-Smtp-Source: ADFU+vs/52TdNiAJfdd41fBWuyLzmoaHbR0mqPud/4CTPhvMMKxvtjN9OkjWJMiXDjzMGMQp1+xibg==
X-Received: by 2002:a2e:9982:: with SMTP id w2mr14229389lji.11.1584979525397; 
 Mon, 23 Mar 2020 09:05:25 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru.
 [94.29.39.224])
 by smtp.googlemail.com with ESMTPSA id c13sm941220ljj.37.2020.03.23.09.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 09:05:24 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] Support built-in Mic on Tegra boards that use
 WM8903
To: Jon Hunter <jonathanh@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
References: <20200320205504.30466-1-digetx@gmail.com>
 <c27c2087-14cf-614d-a8c0-05072a54f24b@wwwdotorg.org>
 <da88ddff-e665-8cee-6f03-1a396602b076@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8b7a8eb3-98ed-71cb-5bd7-9c784ec24d68@gmail.com>
Date: Mon, 23 Mar 2020 19:05:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <da88ddff-e665-8cee-6f03-1a396602b076@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org
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

23.03.2020 18:59, Jon Hunter пишет:
> 
> 
> On 20/03/2020 22:30, Stephen Warren wrote:
>> On 3/20/20 2:55 PM, Dmitry Osipenko wrote:
>>> Hello,
>>>
>>> This small series adds audio route for built-in microphone on NVIDIA Tegra
>>> boards that use WM8903 CODEC. In particular this is needed in order to unmute
>>> internal microphone on Acer A500 tablet device. I'm planning to send out the
>>> device tree for the A500 for 5.8, so will be nice to get the microphone
>>> sorted out. Please review and apply, thanks in advance.
>>
>> It's been a long time since I looked at this code, but the series looks
>> plausible,
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>>
>> (I wonder why machine->gpio_int_mic_en was already parse but never used!)
> 
> Looking at the ventana schematics, it appears that the internal-mic
> signals was connected to a header and not an actual mic, so maybe we
> never had a proper internal-mic on any board but allowed one to be
> connected.

I guess cardhu may have a mic, judging by downstream kernel sources (I
don't have cardhu schematics).

> Anyway, looks good to me as well.
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
