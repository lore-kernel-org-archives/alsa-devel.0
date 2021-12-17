Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20F8C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Dec 2021 17:20:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF4E11B48;
	Fri, 17 Dec 2021 18:19:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF4E11B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639761600;
	bh=GunIw9LtcN5tHnatRmI+rHTqDk/fE8ggWgX3Tg2f3As=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c2vQa88iZEn0nrB1+hjV6Zfcmmb3KU3zu19ZfJ808CK+SSDKCFDuv2caXIKgeCsI5
	 MVWtFdbhIqrKl5ahq325WkazuvpEDdifg3skJO5ZJ4mycmFowLMNuKKJskyrHa4edO
	 fMqjz1qgEXkwLk6ZOaoYnv3A/WuIGuQf7G9gC4Mo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BA3DF800AB;
	Fri, 17 Dec 2021 18:19:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B126F80163; Fri, 17 Dec 2021 18:19:08 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24B2BF800AB
 for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2021 18:19:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24B2BF800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="N+UO0OVM"
Received: by mail-lj1-x234.google.com with SMTP id k23so4469983lje.1
 for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2021 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aD+hC6FqlLZlRa2bYYfAt8xGKCazGEctgmQARu+DDU8=;
 b=N+UO0OVMGnFIK0uWKGSzU0og53fRsylVVAjm+0aq9GOMGpnSHN/MN8kNXkzeAsUDVi
 /r3VLwK2ENO7yz83w5dxYdI5t3Xrv9LkpIuK59aiYvbL0fnapPr85PwHaEBDabE/5kRK
 GWeJrY7WmFCNzRw5gUmLBURUHiKJ9PBeOU2tm2n2GrnLu++HyRIPa3Ye1MwUdAwGGWbE
 WkKXwxi1SujNH17xZAIHeVmtVq7GLDTEgKFP3rosA/WbXc4Kzf5WbVSgbgtx9AG3zGr4
 qMiB+ODoVkA4ZSUPGZPuN5onKzOXsyqQP9UHjAAgMzmkNkZ4L+hZxC1xdF8qDU+/jHL/
 Aong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aD+hC6FqlLZlRa2bYYfAt8xGKCazGEctgmQARu+DDU8=;
 b=P+5LLhSWbuCg4TdSIf2YKIcPdieIkE0lB41ymJ0ICPXrhs/5nYiUWNn+xIpyoZU6hx
 VnX2n+6UaFIAhbQAwbZcQ6QB5aTSetsQ2+jXsoXYmnQZ/4nKUSjrLFVnIm6OgP5PAJuq
 UAac4mKXtq4s68clPXKC1foV2V4O35M3SZMLaZg76dDzRlqp5LbvsvLpaMRRU9EsjqD6
 8TyvyIcRuX54sTewBF6svUDnhjYhNFdPCATNP7gL5eMDP2sQwEJDOXvVn+gOhBtrGVwe
 6uSjZA5CMxos8iybDc+BPXShgVrvA6D+GuX7ax/kcX/J5rfOi2E8RFvoZT7Q5Fy1QTop
 kbpw==
X-Gm-Message-State: AOAM532xe2KRi7lJwSDx8oi1ANNh5eh7ZaMgZXhUiGZKeRkj/rLweoVn
 R+wbYyT8CXQhyIc1NzMpdsE=
X-Google-Smtp-Source: ABdhPJzBjfXZEGXsleWCP8vjNzkIbrIDY0hTHQDynU+0L28mioCf9nBMTGevXSjGLXhOGHJT4nr+6w==
X-Received: by 2002:a05:651c:504:: with SMTP id
 o4mr3649716ljp.242.1639761539376; 
 Fri, 17 Dec 2021 09:18:59 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru.
 [94.29.63.156])
 by smtp.googlemail.com with ESMTPSA id p20sm1470067lfu.151.2021.12.17.09.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Dec 2021 09:18:58 -0800 (PST)
Subject: Re: [PATCH v4 04/22] dt-bindings: host1x: Document optional HDMI
 sound-dai-cells
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-5-digetx@gmail.com> <YbtLJeIxXlVyQhd3@orome>
 <Ybxwovlw2GARzqUO@sirena.org.uk>
 <4edfbff2-ffd9-1c33-de0c-013a29dc286c@gmail.com> <Ybx8XdLGGiQsNMTq@orome>
 <36972e00-0eb9-acb7-d537-3b9a4b53386d@gmail.com>
Message-ID: <e0536860-3fea-e57b-8602-4936bfdcd4a6@gmail.com>
Date: Fri, 17 Dec 2021 20:18:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <36972e00-0eb9-acb7-d537-3b9a4b53386d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
 Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>
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

17.12.2021 15:06, Dmitry Osipenko пишет:
> 17.12.2021 15:02, Thierry Reding пишет:
>> On Fri, Dec 17, 2021 at 02:55:48PM +0300, Dmitry Osipenko wrote:
>>> 17.12.2021 14:12, Mark Brown пишет:
>>>> On Thu, Dec 16, 2021 at 03:20:21PM +0100, Thierry Reding wrote:
>>>>> On Sat, Dec 04, 2021 at 05:37:07PM +0300, Dmitry Osipenko wrote:
>>>>>> Document new optional sound-dai-cells property of HDMI node. This node will
>>>>>> be used as endpoint of HDMI sound DAI graph.
>>>>
>>>>> It's probably best for this to go through ASoC along with the other
>>>>> audio-related bindings.
>>>>
>>>>> Alternatively, I've just sent out a patch that converts the host1x
>>>>> bindings to json-schema, so I could work this into that as well.
>>>>
>>>> It doesn't apply to the ASoC tree for whatever reason so probably best
>>>> to roll it in with those JSON updates.
>>>>
>>>
>>> This hos1tx binding patch indeed will conflict with the Thierry's patch.
>>>
>>> Thierry, will you be able to take the binding patches into the Tegra
>>> tree and resolve all those hos1tx binding conflicts there?
>>
>> Yes, I'll resolve all of those conflicts in the Tegra tree.
> 
> Thank you!
> 
> Mark, then you may apply patches 5-13 to ASoC on top of the Vinod's
> branch, skipping patch #6. Thanks in advance!
> 

I see that Thierry applied only the host1x patch, but not the other
bindings.

Mark, perhaps will be easier if I'll just make the v5 which you could
apply easily without a need to apply only selective patches. I'll try to
post it ASAP.
