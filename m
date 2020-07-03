Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA526C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:48:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51555206DD
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F5ZQjJ7m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMgDqgWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51555206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B908916C9;
	Fri,  3 Jul 2020 11:47:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B908916C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593769717;
	bh=XMwIZoS+ES1pcCZM6+QyEv/zeEoGdAQC0ZuATXvuR5g=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F5ZQjJ7mJ2fw/xA86LvsD+S9LBcnvowSzkhFSxv5exSPOiiGzBl3JiQNHRoHD1F9K
	 lL940+9uQhJ4HkTSV6viHKQmwf11mjQ5g/oXmQelp8nzzHDEVVXcG/QifUO7+s0Rmf
	 A5MUg3Dq5aqI+jcZSJNZ9QBtjxgbI2H+nwwOJjCg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A24CF80217;
	Fri,  3 Jul 2020 11:47:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB861F8021D; Fri,  3 Jul 2020 11:47:45 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92E10F800E0
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 11:47:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92E10F800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="LMgDqgWY"
Received: by mail-wm1-x344.google.com with SMTP id g10so10584082wmc.1
 for <alsa-devel@alsa-project.org>; Fri, 03 Jul 2020 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CkcJhb/CNLx6sxUe4/rACgYtwPj1y+jwOacbPr50x+o=;
 b=LMgDqgWYbV1ZdV2LtPqUvab8ZY0vFAONXEIH4JLdgaLKjTv+JbfmTKXCgEPPkZLyzW
 HigqLuD7MComI4DLhGktyLL0ZVy+DYZ9DZPT7nsnq/wugK2N+EPcAgu5W1Jyaa8sOgwH
 YePRTaGZE0HTQpRqUovayORqwiVS90wk13Mt3oA+FZnKonc0pIE9vB4paaYYPEUcJkV5
 Xpog7VEhMaYXz30xj7wL43As28gv49KjE9AOM18IjzVkMW/OEkrjBR4cAqJYc9B57URd
 iLZVddIUUWayocz+8SkwXERSqfm26ClOov8LghNpeWYBx3CxlguJtye4KLJ8+sv73F6u
 kreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CkcJhb/CNLx6sxUe4/rACgYtwPj1y+jwOacbPr50x+o=;
 b=p4+fvBXA0ySZ8QkcCooPWJGd7kpDivALyElVkEVAwpw9PQw92V7W5NOZmV8U1NtxCI
 2K3dhYN1MSDP9JDnsuJ95L0+TjGUjFR/UVJVTnJZ8fZutX9yqIj0Lf3Ru8fPTz0nHEaK
 VOx5JKtvMTDLxnpL9Z0a2CoGjX+YQVELjCrAEJMc8z76+PJXIz6aowBlf9zVrsIOVCbW
 2tAplG7YfNhAqy9FdbiB2P3nNOr8UYaU8htLO/Fx42PdOWs+9NEt0llLcZQu1E14yUM0
 jH1hUiEpvsuaU/ONIRsO+e5LKEqGn00n2EvITKBnl7WaCjuuGePKvHLtTC/fT3GVcane
 NZDQ==
X-Gm-Message-State: AOAM530u5my1lsBPLkqYbJC2lTYdGpSzmVAMR8wvItXywCM3nW3pn+O3
 tn8xM4ptqPGfuli0bWw26Btv3A==
X-Google-Smtp-Source: ABdhPJxUfA4HJx4Qj0EEgXwmd8e1DOTHGcqfQjIPYwamRL2l5AP7q+n0kNWsBx+aP3bY74kbgonzAA==
X-Received: by 2002:a1c:5418:: with SMTP id i24mr34495057wmb.47.1593769661935; 
 Fri, 03 Jul 2020 02:47:41 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id c11sm12711773wmb.45.2020.07.03.02.47.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 03 Jul 2020 02:47:41 -0700 (PDT)
Subject: Re: [RFC PATCH] ALSA: compress: add support to change codec profile
 in gapless playback
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org
References: <20200702111114.32217-1-srinivas.kandagatla@linaro.org>
 <90ed95e0-8b01-6c87-b86b-dfa463181527@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2444711a-319e-1f9b-1289-7744bb1a2987@linaro.org>
Date: Fri, 3 Jul 2020 10:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <90ed95e0-8b01-6c87-b86b-dfa463181527@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 vathota@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 broonie@kernel.org, ckeepax@opensource.cirrus.com
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

Thanks Pierre for the comments,

+Adding Patric Lai into loop,



On 02/07/2020 16:00, Pierre-Louis Bossart wrote:
> 
> 
> On 7/2/20 6:11 AM, Srinivas Kandagatla wrote:
>> For gapless playback its possible that each track can have different
>> codec profile with same decoder, for example we have WMA album,
>> we may have different tracks as WMA v9, WMA v10 and so on
>>
>> Existing code does not allow to change this profile while doing gapless
>> playback.
>>
>> This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
>> userspace to set this new parameters required for new codec profile.
> 
> That does not seem fully correct to me. WMA profiles are actually 
> different encoding schemes - specifically the WMA 10 LBR.
> 
> The premise for gapless playback was that the same codec and profile be 
> used between tracks, so that the same internal delay was used. If you 
> look at the output data, it's made of zeroes for N samples, and then you 
> see decoded data. When you change tracks, the first N samples actually 
> come from the previous track.
> 
> If you change coding schemes between tracks, you cannot call this 
> gapless playback. You will both remove the last N samples of the 
> previous track and insert M zeroes (for the new decoder).
> 
> If you wanted to support such a mode, you would need to provide an 
> indication of the delay difference, e.g. by looking at the ID3 tags and 
> let firmware realign. Unfortunately, you don't send this information 
> with the new IOCTL? You would also need firmware tricks for the first 
> decoder to flush out its output and the new decoder to realign.
> 
> I also don't see how one might end-up with different profiles for an 
> album in the first place. The gapless use came mostly from ripping live 
> music recorded on audio CDs in different tracks, and it would have taken 
> a twisted mind to select different encodings between tracks.
> 
> If the 'album' is really a playlist, then the gapless playback as 
> supported by the ASoC compressed layer is nearly useless. What you would 
> really want is cross-fade but that's a different use case and 
> implementation that would be needed.

Patrick seems to have discussed this topic in detail at one of the audio 
conf!

He might want to add more to this discussion.


Thanks,
srini
