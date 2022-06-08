Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C96C43334
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jun 2022 11:05:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A75917B2;
	Wed,  8 Jun 2022 13:05:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A75917B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654686353;
	bh=nUipeWX9I9ioymQSsLJcS5Tg7Pv2+5kAGHr3/1Nvb6A=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ElNOuBXaHXi/wKrDKBjIlpvgO79CgcdF3q8Ie91L8PKZE4uBDKDyheXxZihde/9Kk
	 +Wjcz4+1oRaXwvQEuBU9BhyBi7hs/h/rY3OI7UdSbs0UwRGngD4egU4heDwhBvjf2M
	 gCxbq5MtpSsItIJDmgzdX3rF/wFLAWYPt7WWhXHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4784F8026A;
	Wed,  8 Jun 2022 13:04:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC1B0F804AE; Wed,  8 Jun 2022 13:04:57 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6E76F8026A
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2022 13:04:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6E76F8026A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="R8OVVjXX"
Received: by mail-wm1-x32f.google.com with SMTP id
 h62-20020a1c2141000000b0039aa4d054e2so13195056wmh.1
 for <alsa-devel@alsa-project.org>; Wed, 08 Jun 2022 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=GgaoEba9JTX/8rf6MhX/IHFUfnxIpKajZjqqNMcI1dE=;
 b=R8OVVjXXNfqwmr4RyFvKq0FPMbmCY6x1lamR22m6KbEUlP7j7PiSI2KIoeppC4SkTI
 xaybNffpGSQdTqY6jkv0esrcL16DP7F2oOTT+qLXyRwxrFbguHkD09ewOgbWQ/rPmHud
 jMrp6CRBomTmGje13S+DV2aqBpfwVbrIAglqc9Me4Rtp1obrnEhJARd2O5DPSnViuzqb
 3xY3IScRh2j2EBctqFn2xvlX12ZW8LRDfozoH8yEyhBIDARBqQwkQ59fNGGhRUeWp8BO
 MaUxfLQ1yAArzMEkbK1T/G1lyoOrxFOAbuFGW5tqxSMQxol8P5lPdyRcvsRW8qv4M0eb
 Nc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=GgaoEba9JTX/8rf6MhX/IHFUfnxIpKajZjqqNMcI1dE=;
 b=3y/sBIwG9hB7QJFzqFgFCTj9C7mhLAQ5/r8zrBbX+hjnuq8nXaXoatpJNcglEA6/O5
 Cob9H27P1mP1QKaxKUrpRD7YD7twjUV0aR5tFQ5e/s0FTIJNuhqlFytUgB68diFVILK+
 +y7vxM4jKTOCjKa5UuIYVu2GguJYqf2sDN8KA1ojts1KUo6emf3/7xyMUnIlI8VYLtCR
 FZT5EsBb/0cjRwJDihHxoa36LGxmMCVeMe6JG7YuCjBFkpnHPhpeaAeUttF62suvCPby
 h9lN+ELx/lStWP4XyFW8ud4EX6OccA/BQdsP6s1VtJtVxoAxRw20EyBYOU9djiHtPRUQ
 cb8g==
X-Gm-Message-State: AOAM532A6XW+xKZzU9lhMSsMGgwgukyRUuGi7I2OXh4fOcKuVJQ+AYMd
 w8gNGwrRqt4Lqm1n7YKIzhLpZQ==
X-Google-Smtp-Source: ABdhPJz/cEPCAdCYd2kfWJjqjQ45KHiD/unWUtPlJ67tPiMmmF9NpW0vtFwO0pisM7jXeHZSa+zt6A==
X-Received: by 2002:a7b:c3cd:0:b0:39c:474b:2056 with SMTP id
 t13-20020a7bc3cd000000b0039c474b2056mr22726329wmj.30.1654686285787; 
 Wed, 08 Jun 2022 04:04:45 -0700 (PDT)
Received: from [192.168.86.238]
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.googlemail.com with ESMTPSA id
 o12-20020a5d58cc000000b0020c6b78eb5asm21212543wrf.68.2022.06.08.04.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 04:04:45 -0700 (PDT)
Message-ID: <adb12452-dacd-7fb7-5153-220a2324fa71@linaro.org>
Date: Wed, 8 Jun 2022 12:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] soundwire: qcom: Add flag for software clock
 gating check
Content-Language: en-US
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, agross@kernel.org,
 bjorn.andersson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
 perex@perex.cz, tiwai@suse.com, quic_rohkumar@quicinc.com,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org, vkoul@kernel.org
References: <1654667824-3760-1-git-send-email-quic_srivasam@quicinc.com>
 <1654667824-3760-2-git-send-email-quic_srivasam@quicinc.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1654667824-3760-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 08/06/2022 06:57, Srinivasa Rao Mandadapu wrote:
> Add flag in qcom_swrm_data private data structure for validating
> software colck gating control requirement.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


>   drivers/soundwire/qcom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index a3fccf0..38c3bf5 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -181,6 +181,7 @@ struct qcom_swrm_ctrl {
>   struct qcom_swrm_data {
>   	u32 default_cols;
>   	u32 default_rows;
> +	bool sw_clk_gate_required;
>   };
>   
>   static const struct qcom_swrm_data swrm_v1_3_data = {
