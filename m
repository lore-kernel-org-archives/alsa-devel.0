Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C14C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 15:04:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3476105A
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 15:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A3476105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CD1B18E4;
	Tue,  3 Aug 2021 17:03:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CD1B18E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628003081;
	bh=TLpxvSp3hqaVK8jTuzsC2aCzFMN40lpTKFH7l0/WgZk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cYq0mUko51kUIrkex0j9P40rnfCwLwj60Y1hRMC/nr/5zqUbC8GRuWRqlvloOuViH
	 Sxn7D+v9bYte4mHSSWhij9dUSvduSHRevQ7XObFoTBamOoSPLoP17vzim5xuTejScC
	 j+awbCzrwpRmkMUMFD4c3eLzlG/34VaMzn8xIjq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E479F80095;
	Tue,  3 Aug 2021 17:03:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D903CF802E8; Tue,  3 Aug 2021 17:03:49 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FEA4F80095
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 17:03:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FEA4F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="OulZ+skW"
Received: by mail-wr1-x42a.google.com with SMTP id c9so5394503wri.8
 for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2021 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MLcnQRQ3HG/oUU50Ea/zscPi9zN/+argRjQJApZeFtQ=;
 b=OulZ+skW/jbW+6RQJ4tiZbbdHB+a6JC9HT1Dty7Aq0iJERpp68bK8zfQ8uUrNPSrIR
 zEq5CkxWW/SRFREk9hBYcfR9GQ4XTIwSwDU3aS687qp62R6PIlZz7HgJ3D5Xl9aVsnMD
 95w6HXBPJLblvP+j19CD7hAb/MzI/9HTmhAyT1W/ILIk6ue4dhK6EQC9K5u5yhlejU5Q
 BgLWbVLoPhLrdXx+8xfyFvIPx8ZFazuGLubVv0/hhxoaUUt3dkIqiqXnK/Pkwuhe63Nf
 Ou2CUNkVE/uQs/WYBkFkc+gL6HGFybsdFCXpWBumX6BKkySYAaoqUi22lKiPonlYx5y0
 YJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MLcnQRQ3HG/oUU50Ea/zscPi9zN/+argRjQJApZeFtQ=;
 b=TlGuUy5j2cTBC+kF78rHRELOSKHg5qMVCVTb7WD8KlmZ94iNNzRWwBQu+PJVijEGBz
 hwqdoze2h4YXSFQX69zB4H/ZLzRGI5R9C0zCaB+HygNZjf5sbscTQPdqDkaF0HRx8gJy
 IC8GAwQnK5E5x8loKAuKFxWE6vSw8tKDi3r2Zg47cmPzuxa/f3KoRA3YVuWxnbismVKR
 Bh7fU7SempgFkUaFC1HIiukTWxPRukxRUaMwlbTYIqGdRrm+sxTH5DP4o8+yPxypayOD
 0HlbnYlIkbMnBFjS2CODE/ZKBJqoCFnoikxb432CYVTPp9lQoqQ1IZwZjVbGVuS5+908
 Nv9Q==
X-Gm-Message-State: AOAM530W4R+wfTMxr2aCV835cFCAFju1ycLeTeOBjj+2HheIAWymkN9J
 5VE85A7NyQj9/rd2I41BmUJITg==
X-Google-Smtp-Source: ABdhPJzGIpULgTwFL85kuSrkEfqQCTjDhcOoK6n5pTb6hxtX6ju7JQSRL+UtHUEbRp4pSzcOb1GW4A==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr24423704wrq.98.1628003016485; 
 Tue, 03 Aug 2021 08:03:36 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id g11sm8272964wrd.97.2021.08.03.08.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 08:03:36 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] ASoC: qcom: Add AudioReach support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
 <0e6e4e03-c92a-be27-ba9d-e0993ced1ba6@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e55596cc-9e2b-109b-19de-3bb95b1157ce@linaro.org>
Date: Tue, 3 Aug 2021 16:03:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0e6e4e03-c92a-be27-ba9d-e0993ced1ba6@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com
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

Hi Pierre,
Thanks,

I did run cppcheck --enable=all  before sending this out,


On 03/08/2021 16:00, Pierre-Louis Bossart wrote:
> There are quite a few cppcheck warnings due to unnecessary
> initializations for loop variables, see suggested patch below.
> 
> And a number of renames that were missed.
> 
> cppcheck --platform=unix64 --force --max-configs=1024 --inconclusive
> --enable=all --suppress=variableScope --suppress=shiftTooManyBitsSigned
> --suppress=arithOperationsOnVoidPointer --suppress=bitwiseOnBoolean
> sound/soc/qcom/qdsp6/

I will try these ones and fix all the warnings before next spin!

--srini
> 
> 
> Checking sound/soc/qcom/qdsp6/audioreach.c ...
> sound/soc/qcom/qdsp6/audioreach.c:248:32: style:inconclusive: Function
> 'audioreach_alloc_pkt' argument 1 names different: declaration
> 'pkt_size' definition 'payload_size'. [funcArgNamesDifferent]
> void *audioreach_alloc_pkt(int payload_size, uint32_t opcode,
>                                 ^
> sound/soc/qcom/qdsp6/audioreach.h:657:32: note: Function
> 'audioreach_alloc_pkt' argument 1 names different: declaration
> 'pkt_size' definition 'payload_size'.
> void *audioreach_alloc_pkt(int pkt_size, uint32_t opcode, uint32_t token,
>                                 ^
> sound/soc/qcom/qdsp6/audioreach.c:248:32: note: Function
> 'audioreach_alloc_pkt' argument 1 names different: declaration
> 'pkt_size' definition 'payload_size'.
> void *audioreach_alloc_pkt(int payload_size, uint32_t opcode,
>                                 ^
> sound/soc/qcom/qdsp6/audioreach.c:265:36: style:inconclusive: Function
> 'audioreach_alloc_cmd_pkt' argument 1 names different: declaration
> 'pkt_size' definition 'payload_size'. [funcArgNamesDifferent]
> void *audioreach_alloc_cmd_pkt(int payload_size, uint32_t opcode,
>                                     ^
> sound/soc/qcom/qdsp6/audioreach.h:653:36: note: Function
> 'audioreach_alloc_cmd_pkt' argument 1 names different: declaration
> 'pkt_size' definition 'payload_size'.
> void *audioreach_alloc_cmd_pkt(int pkt_size, uint32_t opcode, uint32_t
> token,
>                                     ^
> sound/soc/qcom/qdsp6/audioreach.c:265:36: note: Function
> 'audioreach_alloc_cmd_pkt' argument 1 names different: declaration
> 'pkt_size' definition 'payload_size'.
> void *audioreach_alloc_cmd_pkt(int payload_size, uint32_t opcode,
>                                     ^
> sound/soc/qcom/qdsp6/q6apm.c:326:16: style:inconclusive: Function
> 'q6apm_map_memory_regions' argument 4 names different: declaration
> 'bufsz' definition 'period_sz'. [funcArgNamesDifferent]
>          size_t period_sz, unsigned int periods)
>                 ^
> sound/soc/qcom/qdsp6/q6apm.h:137:16: note: Function
> 'q6apm_map_memory_regions' argument 4 names different: declaration
> 'bufsz' definition 'period_sz'.
>          size_t bufsz, unsigned int bufcnt);
>                 ^
> sound/soc/qcom/qdsp6/q6apm.c:326:16: note: Function
> 'q6apm_map_memory_regions' argument 4 names different: declaration
> 'bufsz' definition 'period_sz'.
>          size_t period_sz, unsigned int periods)
>                 ^
> sound/soc/qcom/qdsp6/q6apm.c:326:40: style:inconclusive: Function
> 'q6apm_map_memory_regions' argument 5 names different: declaration
> 'bufcnt' definition 'periods'. [funcArgNamesDifferent]
>          size_t period_sz, unsigned int periods)
>                                         ^
> sound/soc/qcom/qdsp6/q6apm.h:137:36: note: Function
> 'q6apm_map_memory_regions' argument 5 names different: declaration
> 'bufcnt' definition 'periods'.
>          size_t bufsz, unsigned int bufcnt);
>                                     ^
> sound/soc/qcom/qdsp6/q6apm.c:326:40: note: Function
> 'q6apm_map_memory_regions' argument 5 names different: declaration
> 'bufcnt' definition 'periods'.
>          size_t period_sz, unsigned int periods)
>                                         ^
> sound/soc/qcom/qdsp6/q6apm.c:471:35: style:inconclusive: Function
> 'q6apm_write_async' argument 5 names different: declaration 'flags'
> definition 'wflags'. [funcArgNamesDifferent]
>          uint32_t lsw_ts, uint32_t wflags)
>                                    ^
> sound/soc/qcom/qdsp6/q6apm.h:131:36: note: Function 'q6apm_write_async'
> argument 5 names different: declaration 'flags' definition 'wflags'.
>           uint32_t lsw_ts, uint32_t flags);
>                                     ^
> sound/soc/qcom/qdsp6/q6apm.c:471:35: note: Function 'q6apm_write_async'
> argument 5 names different: declaration 'flags' definition 'wflags'.
>          uint32_t lsw_ts, uint32_t wflags)
>                                    ^
> 
> Checking sound/soc/qcom/qdsp6/q6prm.c ...
> sound/soc/qcom/qdsp6/q6prm.c:158:63: style:inconclusive: Function
> 'q6prm_set_lpass_clock' argument 3 names different: declaration 'attri'
> definition 'clk_attr'. [funcArgNamesDifferent]
> int q6prm_set_lpass_clock(struct device *dev, int clk_id, int clk_attr,
>                                                                ^
> sound/soc/qcom/qdsp6/q6prm.h:72:63: note: Function
> 'q6prm_set_lpass_clock' argument 3 names different: declaration 'attri'
> definition 'clk_attr'.
> int q6prm_set_lpass_clock(struct device *dev, int clk_id, int attri,
>                                                                ^
> sound/soc/qcom/qdsp6/q6prm.c:158:63: note: Function
> 'q6prm_set_lpass_clock' argument 3 names different: declaration 'attri'
> definition 'clk_attr'.
> int q6prm_set_lpass_clock(struct device *dev, int clk_id, int clk_attr,
>                                                                ^
> 
