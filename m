Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E82C4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 12:53:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A17761026
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 12:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A17761026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51AFC169B;
	Mon, 21 Jun 2021 14:53:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51AFC169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624280030;
	bh=lzcrBCdJvPT4l9m1fs4PhVOj4rtbSonPzLcCv6z+poA=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d1OdJ52kz8U8I+zdQxrfqQtFOYJCa0EDimLNef4dOw5ajaRTnbPMFdPxtl2vfHPMs
	 7M9UcP7UnKlYTwwIzGhbBAMu5y5vpoQ7TQgy7RPeFGbL93LtksihCfe+ptue44lvAs
	 tc3w0pjce/4ag1H2OctY6vnpOTxnR4WGSFEa2CqU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0C53F8016A;
	Mon, 21 Jun 2021 14:52:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6DF2CF8016B; Mon, 21 Jun 2021 14:52:58 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50B66F80111
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 14:52:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50B66F80111
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="s69jGoi5"
Received: by mail-wr1-x42b.google.com with SMTP id e22so15978084wrc.1
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=oUbWLR6jP8sFAmnNbGZX4JOnm2ju8K/Z3jaXNl0VaNQ=;
 b=s69jGoi5HE6JfVg/S0mlcw3uDa6K+m3W7p6LfVGYpAdim7suxSey2r56Y8nH5MlurJ
 1iSvlFqJz+adhwc0DG9qlnoIvwE2qxk/sh1WBuZy9NbOXNFkApFLFpGKhmDTnfkYRT6Q
 bUw1UMQBufKlYMS9dBFsRXM5RbTGbhR/Y4+j0A6yQzD4ByQ+13X/Kgl6b/JJKSH41g2f
 rBEPXHRlnNIWe7LjgH2AhOcXIVi1g6VwsXkeHScnPpiig2mPRtlXKxISAcyQYery1FRw
 ZqyKJ35PATKRg5j0xlKRxrPKKqE3xgZX3k4l23kTUkTH/08o7ghWooUIBHuTRjLod9U5
 9Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oUbWLR6jP8sFAmnNbGZX4JOnm2ju8K/Z3jaXNl0VaNQ=;
 b=szooykmAQCuYVwdb0ZthBClhJFxjMIs66FjE6mYTkAZi1XnaU9upkYZzbJGyInf5nO
 Syxn8xkAm+ZTn/iVtbIorLRrV6Yr+ixL6Rx9mBhvHuVbjVxs6vvxZNsKFKbiEqOda7W1
 ajTrAbj7YgjXQvHJ4/sR1tIoy+Ruhd9JD8Hq+OaDBie2X2gv50j4fscF7yV1Yk+yaTwx
 0NwiyhWfaO9maXhwMi6jdSwvLTJ7eYgpTo7ZgUuSlu2AyPoEu09LAEVEMzJCbJHPl47A
 A/AJ//MwtUk9lQ79DluxaPajEXfbBUaPXQZWPMnIxFpnstBu/r5LjiEKY1bCxOvPhhok
 U0Hw==
X-Gm-Message-State: AOAM531lNP/IMOYRsnfkEG/0hy/FWY6uGjY+YyIwr46h3PYsgU6oGT6b
 f+1qPTh0cHHkzBiv62GWR9DQHw==
X-Google-Smtp-Source: ABdhPJwxP79R2nIH3qYcLv/Uw34PrwDf8thNus0OZKbDqKhEbV3YV6hiE/GqoUTsc+Yq2uCtvPPrpQ==
X-Received: by 2002:adf:f587:: with SMTP id f7mr3891667wro.253.1624279971181; 
 Mon, 21 Jun 2021 05:52:51 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id v5sm9953974wml.26.2021.06.21.05.52.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jun 2021 05:52:50 -0700 (PDT)
Subject: Re: [PATCH v3] ASoC: qcom: Fix for DMA interrupt clear reg overwriting
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, agross@kernel.org,
 bjorn.andersson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
 perex@perex.cz, tiwai@suse.com, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
References: <20210609072310.26099-1-srivasam@codeaurora.org>
 <CGME20210617193537eucas1p217b93d091ae8795581b30931ad8c7467@eucas1p2.samsung.com>
 <5ae06ccb-ffd4-ca9f-5a88-1f8bf8b48d37@samsung.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ec4f3faf-2169-3cd2-7471-976f20f77110@linaro.org>
Date: Mon, 21 Jun 2021 13:52:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5ae06ccb-ffd4-ca9f-5a88-1f8bf8b48d37@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

Hi Marek/Srinivasa,


On 17/06/2021 20:35, Marek Szyprowski wrote:
> Hi,
> 
> On 09.06.2021 09:23, Srinivasa Rao Mandadapu wrote:
>> The DMA interrupt clear register overwritten during
>> simultaneous playback and capture in lpass platform
>> interrupt handler. It's causing playback or capture stuck
>> in similtaneous plaback on speaker and capture on dmic test.
>> Update appropriate reg fields of corresponding channel instead
>> of entire register write.
>>
>> Fixes: commit c5c8635a04711 ("ASoC: qcom: Add LPASS platform driver")
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
Can you please try this patch and let us know if this fixes the issue

------------------------->cut<-------------------------------
Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Mon Jun 21 12:38:43 2021 +0100

     ASoC: qcom: lpass-cpu: mark IRQ_CLEAR register as volatile and readable

     Currently IRQ_CLEAR register is marked as write-only, however using
     regmap_update_bits on this register will have some side effects.
     so mark IRQ_CLEAR register appropriately as readable and volatile.

     Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 0b9cbf2ce505..8998697cd1e1 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -525,6 +525,8 @@ static bool lpass_cpu_regmap_readable(struct device 
*dev, unsigned int reg)
                         return true;

         for (i = 0; i < v->irq_ports; ++i) {
+               if (reg == LPAIF_IRQCLEAR_REG(v, i))
+                       return true;
                 if (reg == LPAIF_IRQEN_REG(v, i))
                         return true;
                 if (reg == LPAIF_IRQSTAT_REG(v, i))
@@ -566,9 +568,12 @@ static bool lpass_cpu_regmap_volatile(struct device 
*dev, unsigned int reg)
         struct lpass_variant *v = drvdata->variant;
         int i;

-       for (i = 0; i < v->irq_ports; ++i)
+       for (i = 0; i < v->irq_ports; ++i) {
+               if (reg == LPAIF_IRQCLEAR_REG(v, i))
+                       return true;
                 if (reg == LPAIF_IRQSTAT_REG(v, i))
                         return true;
+       }

         for (i = 0; i < v->rdma_channels; ++i)
                 if (reg == LPAIF_RDMACURR_REG(v, i))

------------------------->cut<-------------------------------

--srini

> This patch landed recently in linux-next as commit da0363f7bfd3 ("ASoC:
> qcom: Fix for DMA interrupt clear reg overwriting"). It breaks ALSA
> playback on DragonBoard 410c (arch/arm64/boot/dts/qcom/apq8016-sbc.dts).
> After applying this patch, running 'speaker-test -l1' never finishes.
> There is no error nor kernel warning message. Before that commit, the
> playback worked fine on that board.
> 
>> ---
>> Changes since v2:
>> 	-- Removed redundant variables.
>> Changes since v1:
>> 	-- Subject lines changed.
>>    sound/soc/qcom/lpass-platform.c | 12 ++++++------
>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
>> index 0df9481ea4c6..f9df76d37858 100644
>> --- a/sound/soc/qcom/lpass-platform.c
>> +++ b/sound/soc/qcom/lpass-platform.c
>> @@ -526,7 +526,7 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
>>    			return -EINVAL;
>>    		}
>>    
>> -		ret = regmap_write(map, reg_irqclr, val_irqclr);
>> +		ret = regmap_update_bits(map, reg_irqclr, val_irqclr, val_irqclr);
>>    		if (ret) {
>>    			dev_err(soc_runtime->dev, "error writing to irqclear reg: %d\n", ret);
>>    			return ret;
>> @@ -650,10 +650,11 @@ static irqreturn_t lpass_dma_interrupt_handler(
>>    	struct lpass_variant *v = drvdata->variant;
>>    	irqreturn_t ret = IRQ_NONE;
>>    	int rv;
>> -	unsigned int reg = 0, val = 0;
>> +	unsigned int reg, val, mask;
>>    	struct regmap *map;
>>    	unsigned int dai_id = cpu_dai->driver->id;
>>    
>> +	mask = LPAIF_IRQ_ALL(chan);
>>    	switch (dai_id) {
>>    	case LPASS_DP_RX:
>>    		map = drvdata->hdmiif_map;
>> @@ -676,8 +677,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
>>    	return -EINVAL;
>>    	}
>>    	if (interrupts & LPAIF_IRQ_PER(chan)) {
>> -
>> -		rv = regmap_write(map, reg, LPAIF_IRQ_PER(chan) | val);
>> +		rv = regmap_update_bits(map, reg, mask, (LPAIF_IRQ_PER(chan) | val));
>>    		if (rv) {
>>    			dev_err(soc_runtime->dev,
>>    				"error writing to irqclear reg: %d\n", rv);
>> @@ -688,7 +688,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
>>    	}
>>    
>>    	if (interrupts & LPAIF_IRQ_XRUN(chan)) {
>> -		rv = regmap_write(map, reg, LPAIF_IRQ_XRUN(chan) | val);
>> +		rv = regmap_update_bits(map, reg, mask, (LPAIF_IRQ_XRUN(chan) | val));
>>    		if (rv) {
>>    			dev_err(soc_runtime->dev,
>>    				"error writing to irqclear reg: %d\n", rv);
>> @@ -700,7 +700,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
>>    	}
>>    
>>    	if (interrupts & LPAIF_IRQ_ERR(chan)) {
>> -		rv = regmap_write(map, reg, LPAIF_IRQ_ERR(chan) | val);
>> +		rv = regmap_update_bits(map, reg, mask, (LPAIF_IRQ_ERR(chan) | val));
>>    		if (rv) {
>>    			dev_err(soc_runtime->dev,
>>    				"error writing to irqclear reg: %d\n", rv);
> 
> Best regards
> 
