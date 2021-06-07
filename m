Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D349C47094
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC98961001
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC98961001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF2EF1671;
	Mon,  7 Jun 2021 15:44:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF2EF1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623073499;
	bh=BClo/AQH6b2spHanAeFObBPI9yjSF7HLk/cGkqc95xw=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k5FizUvJmTHf7QfLJSWzr19zxcPy/bzVyFEOvDgMcQK4MuS3zTmpvf0Ob27p3/wu/
	 lQvYpsV7KvoOGeJeqv+k5nFPNZGuv/0Qg3+EvaAbeV7Gq2m9FLj2AmF6bA4CxTYVK2
	 G+zlEEi8KaQl3KPOavNkS23mqvcnUlE27zyknx0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1F47F8020D;
	Mon,  7 Jun 2021 15:44:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CF84F80212; Mon,  7 Jun 2021 15:44:01 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4A59F801EC
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 15:43:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4A59F801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LacjciDd"
Received: by mail-lf1-x12d.google.com with SMTP id i10so26363679lfj.2
 for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2021 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rynHUKkZxa9A3eifUq0bL9Bb8E1MCzJOU3IrW4Ec2FU=;
 b=LacjciDdo4wka9zD7voFzPUR82dM5PzMM0NZ5BxttPO/sUbqXPamx1iouUOYz4Tmpe
 DDuxlXggx/QRGDCVmQS5tpR9tUNUOKgZBYU6rDEATObQyPSYoZveDV2qi4X5Ku2o8OXl
 uYN2loj+iNA+c0dXqwVo4jxNdMV5kmKVsi/SysnRlyU/BAB1BzjSo34oZae8UuJ8SpOk
 c5HL2knyjMIFg1hz6C+h3AmBY8ojjZqxBa0rJyw1mmBhhgh3eSvIdus1Fjo0G+q4XCsF
 fwm/63RI2xWy7azD9ofGsX3b31qPRlqQLqR2GDLy2xhi/ZV2HGgS57xihQwPK8ivHgJh
 xJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rynHUKkZxa9A3eifUq0bL9Bb8E1MCzJOU3IrW4Ec2FU=;
 b=FehxRW1Gw33tgE3SDnh2vFyk7JcdAQY8fMJmc8pn8DfKwjkO1H7t2HF0sGhkHsG39r
 gb5kXwignzbSKoLd6o4d2wgu9L159PeUfu8CADkFNtEQENX6gPQJ1QMUKtphjLkeKWVo
 GQix8MOuDnunDflAZE5Pv9ZBfpshw0NvbyYL345U1jfyj/cAMCAGEnsVK1oFTrfNXnyG
 IhgY2/pWrvVmv5qULC2BJjhID2CR14saM0o2v74L1i7R4Re/wsY0yFodPoONshfQGgy1
 Hd5KxkHVEAbzpEVcsZA+1o0Z/tqDLGwbEkvPecxPZcV5bn7JU7gfHy3xbYIJIKzayfQX
 7+XA==
X-Gm-Message-State: AOAM530S8IGlcFj2Rbbeolfzse+fs+UIweeNFcmXAbNaYtxKvlTc8Cy6
 YrxSBK1c6gaYm4hpdOxl7PA=
X-Google-Smtp-Source: ABdhPJyDwH/ieMafTpVARxdLcSZ+RnNvA0YYGm4SAkSzAvrqqjqfXefJKxYrqLAJBdQlMBAOpedH9g==
X-Received: by 2002:ac2:519a:: with SMTP id u26mr12017189lfi.639.1623073433632; 
 Mon, 07 Jun 2021 06:43:53 -0700 (PDT)
Received: from [192.168.2.145] (94-29-1-103.dynamic.spd-mgts.ru. [94.29.1.103])
 by smtp.googlemail.com with ESMTPSA id h18sm799067lfe.206.2021.06.07.06.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 06:43:53 -0700 (PDT)
Subject: Re: [PATCH v6 0/4] Unify NVIDIA Tegra ASoC machine drivers
From: Dmitry Osipenko <digetx@gmail.com>
To: Jonathan Hunter <jonathanh@nvidia.com>
References: <20210529154649.25936-1-digetx@gmail.com>
Message-ID: <09a8bd07-d816-038c-8722-82bf0f3cc983@gmail.com>
Date: Mon, 7 Jun 2021 16:43:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210529154649.25936-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ion Agorria <ion@agorria.com>,
 linux-tegra@vger.kernel.org
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

29.05.2021 18:46, Dmitry Osipenko пишет:
> This series squashes all the ASoC machine drivers into a single one,
> this change was suggested by Jon Hunter. It also sets driver_name and
> components string of each card, allowing userspace alsa-lib to find
> UCMs at predictable path.
> 
> Changelog:
> 
> v6: - Fixed missed configuration of AC97 clock rate for the WM9712 codec
>       in the unified driver.
> 
>     - Added new patch that removes now obsolete "utils" helpers and moves
>       code into the unified driver.
> 
>         ASoC: tegra: Squash utils into common machine driver

Jon, please feel free to give yours ack if v6 patches are good to you.
