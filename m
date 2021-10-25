Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F16C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 15:57:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A8660E0B
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 15:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30A8660E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D4F216C7;
	Mon, 25 Oct 2021 17:56:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D4F216C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635177443;
	bh=6v+BkoTNvPSxpt7kJXgv9VacG7N2LWBK6irop9jAahA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lkJw890whojm3TTJw+cxDdDTdCXz6ooLbKOCHv/C8HVdRmNi21P/lS44LEmIUHzRB
	 lAxGQnEfetNAa5r3S3FZ5DdGW/uwZVULMhbPQrMsOhGs2kv+pPNLmHoH+SO8JRSe6f
	 3lTrCpWboUIF5NNjsuKhVma/4IRfKGUinGo42xPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95D50F8010A;
	Mon, 25 Oct 2021 17:56:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B27DF8025A; Mon, 25 Oct 2021 17:56:31 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7693FF8010A
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 17:56:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7693FF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="HcdApW17"
Received: by mail-wm1-x32f.google.com with SMTP id
 67-20020a1c1946000000b0030d4c90fa87so434663wmz.2
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Db2B25rEfKLkiVTUHJs7laJ28rh5Dd1fktdUJTRuQiM=;
 b=HcdApW17lvO9adNo+z7zNuECFnzltC/L9PbFgBvpHbu4gvMM09dQLVA3c74VY2oK7U
 Qp64U4TOk8Kp1s+XNsEgdT91OdprE1r3Hn8Y3VoZgABudbi76bVMqyS7yYAB4VwTIM7U
 CddS3F+uTFJFolcSOqdPGfyNjXw5TCP2qF8N1Qmbsz/RIyiYfC7r4dySTc40O7EsRv1Z
 Ort/JjHa65neZ79sG69Y+KZpzF80SZARty8B7CiOJUZNSkKXrrppWoS4JBMf6r+JkfXX
 WrkgLeRvs9PYbH4mOac9sHZYhuj88uShrWWXRHqRAOrUe/66x0rVqcy+GlcjFmP5mDBx
 ofWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Db2B25rEfKLkiVTUHJs7laJ28rh5Dd1fktdUJTRuQiM=;
 b=B/x9RFUiHzOiWBY0m9259CGeWjzvunmMMH/k+50Za5eh+hxBtkwIQZyV4dFw9nWYL9
 MOmU80neGNvIayHxR4ctu7fE5AG8egFM0KB0JKYJKaGzdHETLkE+hntUfFpBwOIwMBft
 jyjaecbSFZaGCwwPsR6DmFJi6cTqrblePQY2BcO7Jao1QzojCp8tyfrUxFuqGAQl04V8
 iIIuTGOUB16BFEE2TRJ0UWKCJKecF17Z+8ocZlgpcXwKAflyEzsSM6LPn5QCBQP3P8cX
 apYWjoioYpmUMO15rBlMdnbxQARqdauBZFrOxyBZZaCxW/W5FyfdUHAqXJbNnfjq8m+s
 3FFg==
X-Gm-Message-State: AOAM5331QLn3YKev/Hw09yrLdDuslemaGhHQu/VAvVGNJ2PHdCWmNlVH
 KIs3+BbbbsRtphm+/1yhqy4J4A==
X-Google-Smtp-Source: ABdhPJzhoi76q5GOL2yBjpjIEY4bELHeotutWzEjbathm7xYYDMUMqf+3+7Dk2ErnfmLk6OpoKMpqA==
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr20015915wmk.65.1635177383520; 
 Mon, 25 Oct 2021 08:56:23 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id m2sm19155475wml.15.2021.10.25.08.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 08:56:23 -0700 (PDT)
Subject: Re: [PATCH v9 12/17] ASoC: qdsp6: audioreach: add Kconfig and Makefile
To: Mark Brown <broonie@kernel.org>
References: <20211006113950.10782-1-srinivas.kandagatla@linaro.org>
 <20211006113950.10782-13-srinivas.kandagatla@linaro.org>
 <YXbSHubt3Rivh9xp@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0313d98f-d626-7086-8808-663dee2a3560@linaro.org>
Date: Mon, 25 Oct 2021 16:56:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXbSHubt3Rivh9xp@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, tiwai@suse.de, lgirdwood@gmail.com,
 plai@codeaurora.org, pierre-louis.bossart@linux.intel.com,
 bjorn.andersson@linaro.org
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



On 25/10/2021 16:49, Mark Brown wrote:
> On Wed, Oct 06, 2021 at 12:39:45PM +0100, Srinivas Kandagatla wrote:
>> Now that all the code for audioreach and q6apm are in at this point to be
>> able to compile, start adding Kconfig and Makefile changes.
> 
> This doesn't compile with current code for arm64 defconfig:
> 
> /mnt/kernel/sound/soc/qcom/qdsp6/q6apm.c: In function 'q6apm_audio_remove':
> /mnt/kernel/sound/soc/qcom/qdsp6/q6apm.c:703:2: error: too few arguments to function 'snd_soc_tplg_component_remove'
>    703 |  snd_soc_tplg_component_remove(component);
>        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /mnt/kernel/include/sound/soc-dapm.h:15,
>                   from /mnt/kernel/include/sound/soc.h:386,
>                   from /mnt/kernel/sound/soc/qcom/qdsp6/q6apm.c:15:
> /mnt/kernel/include/sound/soc-topology.h:191:19: note: declared here
>    191 | static inline int snd_soc_tplg_component_remove(struct snd_soc_component *comp,
>        |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This will be with the stub for !SND_SOC_TOPOLOGY, the index argument has
> been removed for the actual implementation but not for the stub, the fix
> is in the header.
> 

This patch [1] seems to have remove the argument to 
snd_soc_tplg_component_remove() but not in the stub function.

I can send a patch to fix this

--srini

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/include/sound/soc-topology.h?id=a5b8f71c5477f4327c66a085d9714fe298510819
