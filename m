Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8160BC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Feb 2022 17:46:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A26BD17EC;
	Tue,  1 Feb 2022 18:45:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A26BD17EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643737583;
	bh=kKqE4Sj09HDpH4YvIhjnTjK8aNimmNPXPIh9zoQQAx8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BErJMs5Cl6LGE4ppI7/LJGTMVnpjMGr2KqAaFItbEIlYukv1Qd+NvpexJkxsMUTar
	 qwt0gN9tkm6BxIaB9mUwtvYFQZtY1cOZq97CkbNSkFdQRb0C6KUE3VCwNpgK99sH2h
	 tPdi/fZqfWleNyC5a2QxqbHN0V2tFAG+HcnE+fIU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ACE7F800F8;
	Tue,  1 Feb 2022 18:45:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 040E2F8012C; Tue,  1 Feb 2022 18:45:32 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65EA4F80089
 for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2022 18:45:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65EA4F80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="JT39to3C"
Received: by mail-io1-xd2c.google.com with SMTP id 9so22262740iou.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2022 09:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hZJGDi4O38yZhJdwibyuJTdCKMidi1j6wS2HcvSmoow=;
 b=JT39to3C36+ZOsdkWRmlycM58WEzIi02MD2At9C+vYNsMBlFs/gnUF8kQHiW5KgjMV
 aWUxLEtmEcTX7xh1rj3AGThTMH8F3HDpXr++mGTx0xaZgrGltnEJjcT8vLeRUzk1+koC
 UnSk4IDWihdzb9R/rib+f2rvSiuONHqew6Veg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hZJGDi4O38yZhJdwibyuJTdCKMidi1j6wS2HcvSmoow=;
 b=647vRk0A2H40/GDPzkMO/xj8zs70ayvBR14+GrpCXRN0eYJ2XpsQaktV6t27wjRV2J
 FzHQR25acDptK+8kQl63BghMZJwOvIdeAzatA/kCnDOCCd3bxo09WfFD0g05RcjPGD4P
 1HD5wW/LJ7GReOrorQNXpeJxmBg1y6C0RbIgaliLS3FdDh1Xu9fMEZBdhzdjYsqautTq
 Ogcb021Ul+ofSnwYpB+pd39LY/7GRJs2e/j4UL8VddO8YfR/k9m4TWWPcTRqlgQI1IJI
 fJXbBCRNM+A2mgrrab20qHmMR75SFhugJ+AElyW/mTbzUrIJTgw/RzkAR/UFfD41uEKT
 2L7A==
X-Gm-Message-State: AOAM5313TTy/yX6S0VNyD58+PINwQ16Uj+WOfG06BA2kx2UKPrWPlJit
 5Ht0QZFW+8qz8FgD8vOtSADtXg==
X-Google-Smtp-Source: ABdhPJxu24Z2OMYalmTSNKDV1Z7lmV7+UiQTl3i3BGPSDKUuSjsIdUqyKL957baWoqv5R+htZecIyA==
X-Received: by 2002:a05:6602:158b:: with SMTP id
 e11mr9772951iow.93.1643737526680; 
 Tue, 01 Feb 2022 09:45:26 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
 by smtp.gmail.com with ESMTPSA id t7sm18456372ilu.37.2022.02.01.09.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Feb 2022 09:45:26 -0800 (PST)
Subject: Re: [PATCH] kselftest: alsa: Check for event generation when we write
 to controls
To: Mark Brown <broonie@kernel.org>
References: <20220201151551.21497-1-broonie@kernel.org>
 <0e1bc48d-ff3e-a4f8-5f81-d6902e89458d@linuxfoundation.org>
 <YflxOnS65NDyx5Ul@sirena.org.uk>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dbdb5e4b-37de-d17a-d149-5c735d016115@linuxfoundation.org>
Date: Tue, 1 Feb 2022 10:45:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YflxOnS65NDyx5Ul@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
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

On 2/1/22 10:43 AM, Mark Brown wrote:
> On Tue, Feb 01, 2022 at 09:18:52AM -0700, Shuah Khan wrote:
>> On 2/1/22 8:15 AM, Mark Brown wrote:
> 
>>> +int wait_for_event(struct ctl_data *ctl, int timeout)
>>
>> Let's make this static.
> 
> None of the other functions in this file are static, that'd be a further
> change to make the whole file consistent rather than having a mix I
> think.
> 

Let's plan for it as a separate patch then.

thanks,
-- Shuah
