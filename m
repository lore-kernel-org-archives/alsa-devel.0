Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA239C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 12:22:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E4160F41
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 12:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75E4160F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC3BB1684;
	Mon, 27 Sep 2021 14:21:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC3BB1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632745356;
	bh=WOCU8XHX7MNiVSZeVl6hA8OzahjpthproEMv8hWDeeM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DmEDEk3iSijg230BwdW18IVVo92O0/hcknzA5+Br1FX5VpCXqVQAOIWm53/0PUcNF
	 HnCl8M9AktsEan6F/1KVeZXLR0XDQQYKzof9rPnwVk6TuBYpF3qpCVzmm+PuAz5qxw
	 CFLAuMSBvBF1BLFF6TIzFlspoT/qItGw2K9+OGGo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FAE1F801F7;
	Mon, 27 Sep 2021 14:21:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16914F80227; Mon, 27 Sep 2021 14:21:43 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0ABFF80147
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 14:21:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0ABFF80147
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="zU/6pGYE"
Received: by mail-wr1-x42f.google.com with SMTP id u18so51650818wrg.5
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y1oO8Q1pVhL1wgXlZ6jgRJOBx8hE/D0mjiLspGYY22I=;
 b=zU/6pGYEYUokOUxUeb8/GAuawoBAl6EG+Hh3TOj/B2OKTm5JQOwVWHX36sIfwNBUma
 GnuIinoxHtg54xUxnSMbAMFAAaE+6gREGDw8cp46lFzz3ugCx5kXy8I03OF2IRY6kEHZ
 mU0owTjSYVivmOesqAVCfTVODIVE+LrLgDFBeDC46uiOQuCc2lZIrDq63TExFfYA7mjz
 Be2TFQCwlnMDC5ylPfDwxChkg5yB4RaJ/A8RoYuAI+ruRh6+Zc8iexhrr6yAPk3QGijl
 tiTnIqyagfIQhWlg03uB5nSI0Nk2ejqoK+pXfi2wjz6tmubUohNgM12z4vhaPDsI4GuU
 Nz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y1oO8Q1pVhL1wgXlZ6jgRJOBx8hE/D0mjiLspGYY22I=;
 b=SeDc6+UZf82hsx9TmRsAS0AaUWpQlpf8xosPqPzi1LL3/HgX6pDgi05LmCVNH9PEIA
 ogSy5F6EXQVBmxjfPrb2msTZkOpCvpGnmHLdz2lPCn41WYe7fpfJOamVl5k8CyXehtWD
 83Qwsb3Blunw0O6qMugr57GFESa52bSmnK43a5H9fJ2aXZEkGxO+iKSNJqksN7KOLqak
 a/XTf7UZ/HOemyE687uOd2VDwHcdm2sWEoMcehpYFMGgwSYPfz+VAI4sZOFH97Iuyfdz
 SDuf2D2vmrO2S14qtQ5Ds/ElVI5kq7O6L3aQHX4sJLMEZx9MrAuwrFrojXuTblpm+4nC
 12yg==
X-Gm-Message-State: AOAM533KOoEgewWRbZdrtmyqbos/G9CLOEx3kpsYqr0VvQkoifRKmQ/B
 25atwf3hHVpxr/x5cJOIXxGKVg==
X-Google-Smtp-Source: ABdhPJwbyY2P8aShYVbbdpFJ3b9wq5kVBsdgTZ2cuTJ/S34IoxiWAZ9GN3oNxdVlTEcaoTXc+GD5Ng==
X-Received: by 2002:a5d:6d07:: with SMTP id e7mr27268884wrq.378.1632745293671; 
 Mon, 27 Sep 2021 05:21:33 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id i18sm16795175wrn.64.2021.09.27.05.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 05:21:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] ASoC: codecs: tx-macro: Enable tx top soundwire
 mic clock
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, agross@kernel.org,
 bjorn.andersson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
 perex@perex.cz, tiwai@suse.com, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
References: <agross@kernel.org; bjorn.andersson@linaro.org;
 lgirdwood@gmail.com; broonie@kernel.org;robh+dt@kernel.org;
 plai@codeaurora.org; bgoswami@codeaurora.org; perex@perex.cz;
 tiwai@suse.com;srinivas.kandagatla@linaro.org; rohitkr@codeaurora.org;
 linux-arm-msm@vger.kernel.org; alsa-devel@alsa-project.org;
 devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
 swboyd@chromium.org; judyhsiao@chromium.org;>
 <1632313878-12089-1-git-send-email-srivasam@codeaurora.org>
 <1632313878-12089-4-git-send-email-srivasam@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1e176dd1-fc8b-09dc-eb73-35b7d268e89a@linaro.org>
Date: Mon, 27 Sep 2021 13:21:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1632313878-12089-4-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Venkata Prasad Potturu <potturu@codeaurora.org>
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



On 22/09/2021 13:31, Srinivasa Rao Mandadapu wrote:
> Enable tx path soundwire mic0 and mic1 clock.
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   sound/soc/codecs/lpass-tx-macro.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 5dcae73..e980b2e 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -1674,6 +1674,8 @@ static int tx_macro_component_probe(struct snd_soc_component *comp)
>   
>   	snd_soc_component_update_bits(comp, CDC_TX0_TX_PATH_SEC7, 0x3F,
>   				      0x0A);
> +	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_AMIC0_CTL, 0xFF, 0x00);
> +	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_AMIC1_CTL, 0xFF, 0x00);

This needs a comment for more clarity to readers.

--srini
>   
>   	return 0;
>   }
> 
