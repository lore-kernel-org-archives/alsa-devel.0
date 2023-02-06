Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CF3C636D3
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Feb 2023 15:26:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F71F41;
	Mon,  6 Feb 2023 16:25:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F71F41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675697168;
	bh=OPV7fBrNq8/Xo71sRPntj5HhKlY8I/b14Hm6sBeyN+8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=rr+REVp4HesxBJTrneS2PPqP/HhJ8p0WJKJcrP+Z66fWx5X8qMNjgYpZ98YChIh6y
	 vfg+URU9qetFMshTaPW4ZBKPfQ0JNQuhF7z4o1a4U1QUQ/zjG9HhGAwiQt9hFe73JB
	 k2T4tgDPtvbdwjtU2cFJ4WXKm7aI/BOL+9CQF9po=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26786F804E7;
	Mon,  6 Feb 2023 16:25:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D267F804F1; Mon,  6 Feb 2023 16:25:16 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BC54F800E3
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2023 16:25:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BC54F800E3
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=XVj8pkml
Received: by mail-wm1-x330.google.com with SMTP id
 az4-20020a05600c600400b003dff767a1f1so3839584wmb.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2023 07:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2nMe8GsG73JtrRY8L76K8cwAKXUQFf+VX6Y6nrNRGi0=;
 b=XVj8pkml7MiCc7rZl7cFHH1blnDwraUfb3LHhc2VbQCfibve7wexpOiy/W31KZqoI2
 oy3n5fg+yAclfkxXdLyQuA6qvzk8KX6aC0t7Iw9OCED5IZkI/WH/ImYAupUK03YSuMFF
 rBLMsVTADUAI9W6RWuzTnm3lEZp9sTu6iYvn5MZj3Ub2bXRtebzrSBEIRj5wzJXPUKm+
 7bPKrSJm2GPrrQJ5MlbFFW8Pkm5rZza/PfzS1OfDwUGUhhrY2Zhj/simzJBpDNvns/8c
 KjYFxiEJoNDlknrCDyy9ICxqOintotGKqnTdGr6r7d+uRUTKr5PvUmTVqLyX6XPiYiJG
 HB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2nMe8GsG73JtrRY8L76K8cwAKXUQFf+VX6Y6nrNRGi0=;
 b=Fnai4Vffj4VCD/bVGK0UoTZv545NV+3XNldp5kuO8armAY9COWvOk3gE8tuV0qtetR
 Dbhlsm17gDw7hMu27xKVQxbvuW66NSDfaZVGN1RBoQ2TdMlq9GLsBl1r/AfvOaMPPL+d
 O/06O/Wg1ReTAEN+cofJ3bOVg5v/Gt/zkAZKo1OAeLVVyPlxpdZxZMyNPn9XsAYcCPtB
 4VmOoDx4ZOn//2NZ5iiut3ZU9pRmocV+EMZc+mxcgwJex+VZUcfBUfFbW2SMfGVFtQAQ
 jFevZv3CLSMxcjFhEgTXr4C9o5rzvmoMc88cIv0IRChUEIqaaDj+FM6rlJl6HezfG9K+
 lGmA==
X-Gm-Message-State: AO0yUKUUVkE2IyLjFyKulTzQZoX4lMeKUM2jKZbn4n0nwtISy5xxLytN
 vbHoiXFxp1y74XGtLGP0ENirVTIIvLI=
X-Google-Smtp-Source: AK7set/rpzn1InDqbYCt7SOwog1HsznUpuVYczFy969TUtec7KdXKGyCuAYRjLiv1c7LTdjoH7eLBA==
X-Received: by 2002:a05:600c:1716:b0:3df:f7cc:4da2 with SMTP id
 c22-20020a05600c171600b003dff7cc4da2mr101383wmn.16.1675697110085; 
 Mon, 06 Feb 2023 07:25:10 -0800 (PST)
Received: from [192.168.21.204] (surfbythesea.plus.com. [81.174.134.71])
 by smtp.gmail.com with ESMTPSA id
 l4-20020adff484000000b002c3ed120cf8sm1714727wro.61.2023.02.06.07.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Feb 2023 07:25:09 -0800 (PST)
Message-ID: <2695b295-7814-09e3-f93f-95e6e66c1108@gmail.com>
Date: Mon, 6 Feb 2023 15:25:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Overflow in calculating audio timestamp
Content-Language: en-GB
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, o-takashi@sakamocchi.jp
References: <70ff4e3a-b171-131c-a039-4fc99aa4bbfc@gmail.com>
 <Y9xWlbhPg3PteH5G@workstation>
 <2598bf64-708c-cf62-e634-44db5a850226@gmail.com>
 <74350bce-a6ea-c3b8-7b00-4deb47f7e623@perex.cz>
 <4398e3f3-ea2f-1e23-d64b-39723e4790d2@linux.intel.com>
From: Alan Young <consult.awy@gmail.com>
In-Reply-To: <4398e3f3-ea2f-1e23-d64b-39723e4790d2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


On 04/02/2023 00:54, Pierre-Louis Bossart wrote:
> I am not following how the boundary comes into play for cases where the
> timestamp comes directly from a link counter, and is not related to the
> DMA hw_ptr at all.


I don't think it does. This is all only for the 
SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT case.

