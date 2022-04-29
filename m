Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1691C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Apr 2022 16:01:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19CFF15F2;
	Fri, 29 Apr 2022 18:00:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19CFF15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651248062;
	bh=43clqtMKY7OLVL5siXjCuDXZucacliyaNKPzZqBr0nY=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pBTmnQCISlzudCN/8AObH7N0UHHVryYDsk92Ume6+variA2VI5ckHepmjZFCc0PM8
	 jNfjVBuhZcJH0R6TyndlH2WKAN46FKFvQUqSV/EeXXREf/g/0Zk6rX39ODhMtXjJ9j
	 HHhX6NFsxOYMXWFMdqYK98/okLA0awmuu1ISVOcI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D4A0F802E3;
	Fri, 29 Apr 2022 17:59:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E42CEF8047B; Fri, 29 Apr 2022 17:59:52 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C37EEF80269
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2022 17:59:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C37EEF80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="kpu2e3ho"
Received: by mail-wr1-x429.google.com with SMTP id e2so11362245wrh.7
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2022 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Qwzc9FpCSz0qYfi90/a+oI4zUvRcyTR9uF9e5GlaFYk=;
 b=kpu2e3hoMvbGf4KZrs1ZwopuoSWpvL5Z1QBQCdWeIAt83oTjkF9nANtk/JwwtDF/oq
 IxPDa9NAIGiBI9X7vXsMr7SOg4sVQkRWGXZKpC0XpxqQCVfJr2LCtNNcUfHs7AEP8wTH
 S191+ez6mC7f8a8IZtl3sAyNzBwU381YcXs5BZQ7So3OtEQQi3lVw2xEmxyEk3QBBOxJ
 g/WksCFjGJotvy5/4JkQR2E4YqV2YZtOV7NE1ng0fYub8jihQfSL1L00GlDOteKe8tmd
 pRGsHr6fVxtU+vFVj09AdlENRB0OlfK6U9evtUKlKPGk8WCv0B7noPBMvB7/EAHbOok2
 xHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Qwzc9FpCSz0qYfi90/a+oI4zUvRcyTR9uF9e5GlaFYk=;
 b=0e0Vz7EssBoBhR9WeZBrNsLZAXixqVJaUf9EcQB3lZyWk18Hav4OYG4Rc8qvbxWpJE
 3K0QuDZ1EnbCrmLSEe6UmS/oQTJji0NwWWof6RBm+y/5FXEEbq8BjTIOLP3GOnfws+EG
 BAlXzqNCOkG+ktpUNASz40qEtz4I9BDbPhheqp0MIvfXa5Nnkqi0sNWu1FrcB9ANtAHS
 TbqT/2UeNZXEx9U72V3nWDPs8CJuIYYnS6SLI1nlVm9JJxJdOy/utZU5Zy9BwHU/uTw9
 CpVDQ1C7gbvzgdlQ+NGKfZjcxWygkQY9CdFH7N4K3TErtqrqqXu3htVZ6hjWWTqO1Wj+
 qYDA==
X-Gm-Message-State: AOAM5309rWgSn/8AN+ADlRQbRnbgiIFkT6MP+3gaVAi71EqbLesUN5t4
 y1F7P9A5KCBKFK9eoJHN5wowtw==
X-Google-Smtp-Source: ABdhPJwboWFlK14XxhOvzRQMiKUYaS7nkctHz9phfhIzjJ75HBJUacL+7vOigxl2HVkU0hc+Y5KgJw==
X-Received: by 2002:a05:6000:1ac9:b0:20a:f656:e925 with SMTP id
 i9-20020a0560001ac900b0020af656e925mr7887056wry.554.1651247983973; 
 Fri, 29 Apr 2022 08:59:43 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.googlemail.com with ESMTPSA id
 190-20020a1c19c7000000b00392c344c842sm2845015wmz.43.2022.04.29.08.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Apr 2022 08:59:43 -0700 (PDT)
Message-ID: <d18fb6ea-6da6-cab3-1aca-48cbfcc74efa@linaro.org>
Date: Fri, 29 Apr 2022 16:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/5] soundwire: qcom: use pm_runtime_resume_and_get()
Content-Language: en-US
To: Bard Liao <yung-chuan.liao@linux.intel.com>, alsa-devel@alsa-project.org, 
 vkoul@kernel.org
References: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
 <20220426235623.4253-6-yung-chuan.liao@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220426235623.4253-6-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, bard.liao@intel.com
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



On 27/04/2022 00:56, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Use pm_runtime_resume_and_get() to replace the pm_runtime_get_sync() and
> pm_runtime_put_noidle() pattern.
> 
> No functional changes.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   drivers/soundwire/qcom.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index c40c25f2d264..c244d31805cc 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -510,12 +510,11 @@ static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>   	struct qcom_swrm_ctrl *swrm = dev_id;
>   	int ret;
>   
> -	ret = pm_runtime_get_sync(swrm->dev);
> +	ret = pm_runtime_resume_and_get(swrm->dev);
>   	if (ret < 0 && ret != -EACCES) {
>   		dev_err_ratelimited(swrm->dev,
> -				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>   				    __func__, ret);
> -		pm_runtime_put_noidle(swrm->dev);
>   		return ret;
>   	}
>   
> @@ -1059,12 +1058,11 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
>   	struct snd_soc_dai *codec_dai;
>   	int ret, i;
>   
> -	ret = pm_runtime_get_sync(ctrl->dev);
> +	ret = pm_runtime_resume_and_get(ctrl->dev);
>   	if (ret < 0 && ret != -EACCES) {
>   		dev_err_ratelimited(ctrl->dev,
> -				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>   				    __func__, ret);
> -		pm_runtime_put_noidle(ctrl->dev);
>   		return ret;
>   	}
>   
> @@ -1253,12 +1251,11 @@ static int swrm_reg_show(struct seq_file *s_file, void *data)
>   	struct qcom_swrm_ctrl *swrm = s_file->private;
>   	int reg, reg_val, ret;
>   
> -	ret = pm_runtime_get_sync(swrm->dev);
> +	ret = pm_runtime_resume_and_get(swrm->dev);
>   	if (ret < 0 && ret != -EACCES) {
>   		dev_err_ratelimited(swrm->dev,
> -				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>   				    __func__, ret);
> -		pm_runtime_put_noidle(swrm->dev);
>   		return ret;
>   	}
>   
