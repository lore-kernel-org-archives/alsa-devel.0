Return-Path: <SRS0=1bGq=GU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC95FC433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jan 2021 23:58:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D802076C
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jan 2021 23:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D802076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98830177A;
	Mon, 18 Jan 2021 00:57:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98830177A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610927921;
	bh=5f9Q+o//IOyR93a/LDjfI5TClKEg/dF1su/zR9EbIkA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rZh89kSaiBQ4prZXPsGhJUEVfd3BIXxUNZMXnSSbwB6yJT24vqhpscjBqUUwlrBtN
	 JNLBo3oxj/1e+7KN2kcFyVye0yW8eTpxFuJ/5afUmf3MlVuNSJGyRGImxLbfSw5KWS
	 Zj7osCbltN4xHf60bE+pBh2U4lvFJ6P17Iz1XQKQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28E3DF80255;
	Mon, 18 Jan 2021 00:57:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14638F80257; Mon, 18 Jan 2021 00:57:50 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF083F800C0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 00:57:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF083F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="X4Iigl4J"
Received: by mail-lj1-x229.google.com with SMTP id f17so16379210ljg.12
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2021 15:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1XQU/jlKodYjZCARkN0MwwUNSf7G3pxTNeJxAK/aghY=;
 b=X4Iigl4JPmRRWt70bybHbfbzsqjhJFYXEgrlNjJBKCLlsodALvRXU+1alvbqt5lDDw
 NCIXSoOww/egixhTdX9Yn8GtOlJ9aVRYg3Q222L0wRbCPN+ghTEIpPPHs2C+fAAHew8e
 8r8LfTzRS5YZxA9pxfhXReQkzmAKDSqxRA52ilH497PimTDWBczejK7Rc82EoXBN4mbQ
 OS2Of2VWKoEDKh8JJtLutgRzr4J4yI+Nuem2yEVXF0NRZpDq3bHiSmCyHi2tw0Ug6pjV
 dNH8Ox0rJP4UoTkg9NKq/k37gJErTxWAVvcxIqXUliFoOmuIK7ZitjWAThyonz9KM09L
 1u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1XQU/jlKodYjZCARkN0MwwUNSf7G3pxTNeJxAK/aghY=;
 b=diwFjpTLUBLBatTbbKNvHSVkys8gR0YId2kvwgk6W+rb/mAmxEZ3WORn7CzQf4lOwv
 bbhbYsV2PHoxa8mlzyiXjWFn3uvu8Gf5m8qqYBtWOmtO5AasC7dbxpk/vRm5DwaZuVsT
 yHakWqsNbIyA28dPLoag2h0ofQQM3AW7LQZCLO0DlXKMiiN1mXzEQlSyxlHBh5/Oiffo
 9/3wOVSlSd8biXRP5SXEJwE4LyiKcaqiiOGey25DfIo/r+isWghv7ysQ8KqyDCxG6ckj
 xvg5+3mP9kr/Vc/OT4dXFbGzYTmXKyUJG7bqD0CpJtPMHjPiCkyUCak2vtIOHmvISpNC
 AdFw==
X-Gm-Message-State: AOAM5308lJHAwFd8Mr8V9zmMnriNIpWJxUMRGLzB4kI9YmyDvSYutfbn
 X8I1TGxWf6bBb3QNYRBW3B4=
X-Google-Smtp-Source: ABdhPJyDX06Q+PtppeEr5l7IRznkvqdGomix4s8UXi+IWDei4oSR9i5kYdV2yR7yWs0jHERTyFCJOA==
X-Received: by 2002:a05:651c:1022:: with SMTP id
 w2mr9512185ljm.327.1610927865844; 
 Sun, 17 Jan 2021 15:57:45 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru.
 [109.252.192.57])
 by smtp.googlemail.com with ESMTPSA id k10sm1288283lfe.234.2021.01.17.15.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Jan 2021 15:57:45 -0800 (PST)
Subject: Re: [PATCH v1 3/5] ASoC: tegra: ahub: Use
 of_reset_control_array_get_exclusive()
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210112125834.21545-1-digetx@gmail.com>
 <20210112125834.21545-4-digetx@gmail.com> <YAG211gFXExjp7Zh@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68b20608-b0f9-d481-4d38-7b6ba3366795@gmail.com>
Date: Mon, 18 Jan 2021 02:57:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <YAG211gFXExjp7Zh@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Nicolas Chauvet <kwizart@gmail.com>,
 linux-kernel@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 Takashi Iwai <tiwai@suse.com>, Peter Geis <pgwipeout@gmail.com>,
 linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>
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

15.01.2021 18:37, Thierry Reding пишет:
> On Tue, Jan 12, 2021 at 03:58:32PM +0300, Dmitry Osipenko wrote:
>> Some of resets are erroneously missed in the configlink_mods[], like APBIF
>> for example. Use of_reset_control_array_get_exclusive() which requests all
>> the resets. The problem was hidden by the clk driver which implicitly
>> de-asserts the missing resets.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  sound/soc/tegra/tegra30_ahub.c | 66 +++++-----------------------------
>>  sound/soc/tegra/tegra30_ahub.h |  1 -
>>  2 files changed, 9 insertions(+), 58 deletions(-)
> 
> Doing it this way is slightly suboptimal because now we don't actually
> have a way of checking that the DT has all the necessary resets listed.
> 
> Can we not just make the list complete instead to keep the checks in
> place? That should be a much smaller patch, too.

I'll change it in v3.
