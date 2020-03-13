Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67187C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:17:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86C120746
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Dj0npv+s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmdrL9J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86C120746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C19C17DA;
	Fri, 13 Mar 2020 13:16:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C19C17DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584101819;
	bh=72stC87vAGNEh1dMEhTskoYmn70OoLqSvfVHo5iRsrc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dj0npv+sjGxpxqDR9RwMkdHOq5iMJ10bGvA6+cuRn7QMiPK6OEeWjvTJh+e+gBr+F
	 54Nr7RAGc3JwJ5dkaxAg2chDQXfR4GKWnFBtj1+2aUGe+B9IoL48El5fAE+8qDLoeB
	 njb6IP9ZKs44TZB6dXYZxAmQ+EySzmqMx6lCGTGk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EF9DF801A3;
	Fri, 13 Mar 2020 13:16:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C45EFF801F7; Fri, 13 Mar 2020 13:15:31 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EEE2F80086
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 13:15:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EEE2F80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="dmdrL9J8"
Received: by mail-wm1-x343.google.com with SMTP id 6so9670479wmi.5
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Us+slyMydZd/eqziQ4Za2MmMvMvI/Alts84+tTbnLIk=;
 b=dmdrL9J8Py6pjzSo9zxb1Yfa1SYLqBuFeXStUEe356hzKeaAzHXVcOgPyuyyrEefAl
 lRQUAClgr46+cGoe9EiUoCs9iFeVJEJJMexF8D13T9wf6eAyiCk4qCsQ07DW561IuBYO
 hnPfwa5/OCPwap5maFvMYyxIkukrBuOIgBYqdi1yNzTqopWHa2q/1oQm8iZLJG0lGt+n
 6sqAlipnm0nYh/0p3RgYOw4QKViq2p6lOKel6B3y71wEAXvZ41vPjaUWivg2ZVoznsSK
 FU6fgQkETfifKTe817Ea4sPB/g74dG66ohFKeJ3bFRb2KRKwWH2opOCdQnWdzpfY79C6
 9s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Us+slyMydZd/eqziQ4Za2MmMvMvI/Alts84+tTbnLIk=;
 b=tEwyGZNEz3DSNqWWMVDKLYd4ryBr6iRZIlNyK+cZsQMuR+/MDEmpndeiA2ATl9oqCD
 5jEaT57pcjcmWPc+7Hi2s7kYRcfErzSnPFs/3Ev+g1eTCUAi0PqhiqJCuxM0E3o/RWr0
 xLEbdC/heWU4GeiCW2WN1bixMBJuTejkuz6Jy2nohtFkpCZ0DEg7sCm73FGDZyRPr9b0
 GybwlVSk4tApykemGbvcp0aMZXXsFiKEZlc+NDO6qoOyxM0dwvbLZkkPp0uLrKyWhPXm
 vQaUvcUOowHvJ4+WH34QfS7JC8amEW9V6+nZvdvDbKrdx5I2rZKkvsGjsB++Ev9VfmBr
 4H2Q==
X-Gm-Message-State: ANhLgQ3978FvmH4ZJRuvYyLdYrevZT67Jw7TsH5SmhoBdKHM2yaZ7Lqf
 4TWxFtvWRAJqA736cskJTWaCgg==
X-Google-Smtp-Source: ADFU+vveUbU45uEhQYSZ4Gbmvwbf1schWKEpmcGYLn3cvPLdTqdNnZeTOPyZ6EBJ9iwM90TrudsIvQ==
X-Received: by 2002:a1c:208a:: with SMTP id g132mr10174291wmg.44.1584101721737; 
 Fri, 13 Mar 2020 05:15:21 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id
 a184sm17302709wmf.29.2020.03.13.05.15.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Mar 2020 05:15:20 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 3/9] ASoC: qcom: q6asm: pass codec profile to
 q6asm_open_write
To: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
References: <20200313101627.1561365-1-vkoul@kernel.org>
 <20200313101627.1561365-4-vkoul@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <15823832-0639-f868-9338-091bceaba6bd@linaro.org>
Date: Fri, 13 Mar 2020 12:15:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200313101627.1561365-4-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-kernel@vger.kernel.org
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



On 13/03/2020 10:16, Vinod Koul wrote:
> Codec profile is required to be passed for WMA codecs so that we know
> the codec profile present and tell DSP accordingly, so update this API
> to pass the codec profile as argument
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
>   sound/soc/qcom/qdsp6/q6asm.c     | 2 +-
>   sound/soc/qcom/qdsp6/q6asm.h     | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index c0d422d0ab94..8f245d03b6f5 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -250,7 +250,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
>   
>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>   		ret = q6asm_open_write(prtd->audio_client, FORMAT_LINEAR_PCM,
> -				       prtd->bits_per_sample);
> +				       0, prtd->bits_per_sample);
>   	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
>   		ret = q6asm_open_read(prtd->audio_client, FORMAT_LINEAR_PCM,
>   				       prtd->bits_per_sample);
> @@ -652,7 +652,7 @@ static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
>   	prtd->bits_per_sample = 16;
>   	if (dir == SND_COMPRESS_PLAYBACK) {
>   		ret = q6asm_open_write(prtd->audio_client, params->codec.id,
> -					prtd->bits_per_sample);
> +				params->codec.profile, prtd->bits_per_sample);
>   
>   		if (ret < 0) {
>   			dev_err(dev, "q6asm_open_write failed\n");
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 36e0eab13a98..64eb7b6ba305 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -858,7 +858,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
>    * Return: Will be an negative value on error or zero on success
>    */
>   int q6asm_open_write(struct audio_client *ac, uint32_t format,
> -		     uint16_t bits_per_sample)
> +		     u32 codec_profile, uint16_t bits_per_sample)
>   {
>   	struct asm_stream_cmd_open_write_v3 *open;
>   	struct apr_pkt *pkt;
> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
> index 6764f55f7078..1cff7f68b95d 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.h
> +++ b/sound/soc/qcom/qdsp6/q6asm.h
> @@ -55,7 +55,7 @@ void q6asm_audio_client_free(struct audio_client *ac);
>   int q6asm_write_async(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
>   		       uint32_t lsw_ts, uint32_t flags);
>   int q6asm_open_write(struct audio_client *ac, uint32_t format,
> -		     uint16_t bits_per_sample);
> +		     u32 codec_profile, uint16_t bits_per_sample);
>   
>   int q6asm_open_read(struct audio_client *ac, uint32_t format,
>   		     uint16_t bits_per_sample);
> 
