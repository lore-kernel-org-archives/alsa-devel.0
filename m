Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDBFECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Oct 2022 18:30:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC9D61683;
	Mon, 31 Oct 2022 19:29:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC9D61683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667241026;
	bh=VFoRZA6JMSG/cvaV9p1LWvpAvO6bRrZRnl/P0/MDl5U=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ftm/FlamXLCm8l+P67dBcGIgMagbjGVJbWlJgxJlMirN+17eLCI9WqP9VS2+rbwVb
	 hMOFTbFKlZ5aEVhjm93YzEAXl7PAk5TqAXpNkTSyRTjaSpgEaORV6QKhsrEuu1XsY1
	 rco5K0e2cc/idu7qSjpJMyK964Q6aG0yK24cuEtw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C4E7DF800E1;
	Mon, 31 Oct 2022 19:29:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EE7CF80558; Mon, 31 Oct 2022 19:29:05 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F226F80552
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 19:28:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F226F80552
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="d4CnvNDI"
Received: by mail-wm1-x329.google.com with SMTP id 5so7628672wmo.1
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kUHDIHfTHvE+Ti0vvj6SEtCpulXlPZfgxMR3wyAbMCg=;
 b=d4CnvNDIxCD0H28VAA+U0guyZMJ2QYN1DogRcqfmXvo7eqA/MMwaXIZGRCy6QrN4dv
 7Sf+ptYULqcK24JSQ/EpUTF+axOypIbCU85mcegZ60tW6xxE+fGN1TzpfLRAdYwZJZCx
 IPpixdP818jos4menf+0spQQbJEwu9jeYLF0Omlmi9uBTLfoZA2OQgg39y+Q0i0SuqkW
 gkypUcTGx5PuUGkjmk04oofHprRtWWGYP0wB9S8t5crGw7jb+ty4DOdZzknW1kPyRaw5
 8a+uiUBFUkpDq/mRmEZyoDA7Tcszp8sj5i28QJzDuaVKQJHDxuL4HhLcdhOXwoV+FZmJ
 6iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kUHDIHfTHvE+Ti0vvj6SEtCpulXlPZfgxMR3wyAbMCg=;
 b=ftJhRSzTi2RP/9GcvfwJQj+9UfyEaE3uBAEhSJPwPotu+qCQTSQG2xwcAyrydRqDth
 z6W2GxbMmZS/Frc9Ub7V14DwMCuGe/p9ka0paGUDRuINWj+2rXTY0yUnbENLicpIIGvn
 wP1K5xfezVAR+RprwH81s83Kxp2LUrM7R5LlEgXqoqiuzRiJV01wg2TEwg9IG8W5pQI1
 CVGPFdPm4ty3yJ3AC57tGFvKTpVcv9d8Py2YWArlAEjNY/v9ZRStNBc+c8C2vSEsADHL
 OP2xg2Y0MkT3aTK+ujgzgTjXl6pMgtzLoBveJt1J0tDPz2XChAljVmL6WfB58mf/JEJz
 AWVA==
X-Gm-Message-State: ACrzQf0YQHiISMJzpqZ6WI5F3SUN4Oj3aj/ch/fROx7XUMmpqI57RKf+
 v7Iv9tNMNJ2FAX1IM31uqM22og==
X-Google-Smtp-Source: AMsMyM4GnNmljpEATOt6DHzH3LtKOU2Knri8PMbYG1W2OFAlPUdsGeaW15eeeBvjdqXHpbSJehvGWQ==
X-Received: by 2002:a05:600c:1549:b0:3ce:794f:d801 with SMTP id
 f9-20020a05600c154900b003ce794fd801mr9129071wmg.63.1667240937823; 
 Mon, 31 Oct 2022 11:28:57 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
 by smtp.googlemail.com with ESMTPSA id
 f7-20020a1c6a07000000b003a3170a7af9sm7894668wmc.4.2022.10.31.11.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Oct 2022 11:28:57 -0700 (PDT)
Message-ID: <57a8c6f4-0bea-f596-e50f-cfe441764eee@linaro.org>
Date: Mon, 31 Oct 2022 18:28:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] slimbus: stream: handle unsupported bitrates for
 presence rate
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220930100015.259106-1-krzysztof.kozlowski@linaro.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220930100015.259106-1-krzysztof.kozlowski@linaro.org>
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



On 30/09/2022 11:00, Krzysztof Kozlowski wrote:
> Handle errors of getting presence rate for unsupported stream bitrate,
> instead of sending -EINVAL in change content message.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> ---

Applied both,
thanks,

--srini
> 
> Changes since v1:
> 1. Rebase (drop development pieces in the context).
> 2. Return prrate (which has errno) instead of -EINVAL.
> 3. Add Rb tag.
> ---
>   drivers/slimbus/stream.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
> index d5ce974e880b..f631d5ed9809 100644
> --- a/drivers/slimbus/stream.c
> +++ b/drivers/slimbus/stream.c
> @@ -204,7 +204,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>   {
>   	struct slim_controller *ctrl = rt->dev->ctrl;
>   	struct slim_port *port;
> -	int num_ports, i, port_id;
> +	int num_ports, i, port_id, prrate;
>   
>   	if (rt->ports) {
>   		dev_err(&rt->dev->dev, "Stream already Prepared\n");
> @@ -221,6 +221,13 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>   	rt->bps = cfg->bps;
>   	rt->direction = cfg->direction;
>   
> +	prrate = slim_get_prate_code(cfg->rate);
> +	if (prrate < 0) {
> +		dev_err(&rt->dev->dev, "Cannot get presence rate for rate %d Hz\n",
> +			cfg->rate);
> +		return prrate;
> +	}
> +
>   	if (cfg->rate % ctrl->a_framer->superfreq) {
>   		/*
>   		 * data rate not exactly multiple of super frame,
> @@ -241,7 +248,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>   		port = &rt->ports[i];
>   		port->state = SLIM_PORT_DISCONNECTED;
>   		port->id = port_id;
> -		port->ch.prrate = slim_get_prate_code(cfg->rate);
> +		port->ch.prrate = prrate;
>   		port->ch.id = cfg->chs[i];
>   		port->ch.data_fmt = SLIM_CH_DATA_FMT_NOT_DEFINED;
>   		port->ch.aux_fmt = SLIM_CH_AUX_FMT_NOT_APPLICABLE;
