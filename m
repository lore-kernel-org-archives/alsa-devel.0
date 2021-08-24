Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB1C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 01:43:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C913361373
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 01:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C913361373
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC75484A;
	Tue, 24 Aug 2021 03:42:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC75484A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629769378;
	bh=7kppC3OzCHSblRwZuLkjLSMoPoKwHzWc05438wrkjcg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=do/hWQmUWumnIxXXMmyRHsPSsHcmmxnbvFeaWzhR+9onQkR3FRdvfQuoQRitfcnOo
	 ctf6exd9FQsMfnlfncUaEA8XS7LDn5V+BfVZutTGfNvXknywhawgC3qw5jfgrLlBLS
	 8GVxRRdFNluUNHdsIABwev0ZMxCdGf30oJ4BJzuE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A34CF801D5;
	Tue, 24 Aug 2021 03:42:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06245F801D8; Tue, 24 Aug 2021 03:41:52 +0200 (CEST)
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.70.206])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B6B3F80087
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 03:41:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B6B3F80087
Received: from localhost (unknown [192.168.167.32])
 by regular1.263xmail.com (Postfix) with ESMTP id A09A71B42;
 Tue, 24 Aug 2021 09:41:28 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.19] (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P4269T140595588744960S1629769282126384_; 
 Tue, 24 Aug 2021 09:41:23 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dfd36154bac7861c5a1b7918fe326a5b>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: zhengxing@rock-chips.com
X-RCPT-COUNT: 7
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH 14/15] ASoC: rockchip: i2s: Add support for 'rockchip,
 clk-trcm' property
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, broonie@kernel.org,
 heiko@sntech.de, linux-rockchip@lists.infradead.org
References: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
 <1629716076-21465-5-git-send-email-sugar.zhang@rock-chips.com>
 <5017702.Vq9jUBFu5T@archbook>
From: sugar zhang <sugar.zhang@rock-chips.com>
Message-ID: <a17f688f-3219-33e2-bf75-3c5d197ba274@rock-chips.com>
Date: Tue, 24 Aug 2021 09:41:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5017702.Vq9jUBFu5T@archbook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Xing Zheng <zhengxing@rock-chips.com>
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

Hi Nicolas,

On 2021/8/23 19:47, Nicolas Frattaroli wrote:
> On Montag, 23. August 2021 12:54:35 CEST Sugar Zhang wrote:
>> From: Xing Zheng <zhengxing@rock-chips.com>
>>
>> If there is only one lrck (tx or rx) by hardware, we need to
>> use 'rockchip,clk-trcm' to specify which lrck can be used.
>>
>> Change-Id: I3bf8d87a6bc8c45e183040012d87d8be21a4c133
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
>> ---
>>   sound/soc/rockchip/rockchip_i2s.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/sound/soc/rockchip/rockchip_i2s.c
>> b/sound/soc/rockchip/rockchip_i2s.c index 6ccb62e..b9d9c88 100644
>> --- a/sound/soc/rockchip/rockchip_i2s.c
>> +++ b/sound/soc/rockchip/rockchip_i2s.c
>> @@ -54,6 +54,7 @@ struct rk_i2s_dev {
>>   	bool is_master_mode;
>>   	const struct rk_i2s_pins *pins;
>>   	unsigned int bclk_ratio;
>> +	unsigned int clk_trcm;
>>   };
>>
>>   /* tx/rx ctrl lock */
>> @@ -321,7 +322,6 @@ static int rockchip_i2s_hw_params(struct
>> snd_pcm_substream *substream, struct snd_soc_dai *dai)
>>   {
>>   	struct rk_i2s_dev *i2s = to_info(dai);
>> -	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>>   	unsigned int val = 0;
>>   	unsigned int mclk_rate, bclk_rate, div_bclk, div_lrck;
>>
>> @@ -421,13 +421,6 @@ static int rockchip_i2s_hw_params(struct
>> snd_pcm_substream *substream, regmap_update_bits(i2s->regmap, I2S_DMACR,
>> I2S_DMACR_RDL_MASK,
>>   			   I2S_DMACR_RDL(16));
>>
>> -	val = I2S_CKR_TRCM_TXRX;
>> -	if (dai->driver->symmetric_rate && rtd->dai_link->symmetric_rate)
>> -		val = I2S_CKR_TRCM_TXONLY;
>> -
>> -	regmap_update_bits(i2s->regmap, I2S_CKR,
>> -			   I2S_CKR_TRCM_MASK,
>> -			   val);
>>   	return 0;
>>   }
>>
>> @@ -531,7 +524,6 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
>>   			    SNDRV_PCM_FMTBIT_S32_LE),
>>   	},
>>   	.ops = &rockchip_i2s_dai_ops,
>> -	.symmetric_rate = 1,
>>   };
>>
>>   static const struct snd_soc_component_driver rockchip_i2s_component = {
>> @@ -750,6 +742,18 @@ static int rockchip_i2s_probe(struct platform_device
>> *pdev) else if (of_property_read_bool(node, "rockchip,capture-only"))
>>   		soc_dai->playback.channels_min = 0;
>>
>> +	i2s->clk_trcm = I2S_CKR_TRCM_TXRX;
>> +	if (!of_property_read_u32(node, "rockchip,clk-trcm", &val)) {
>> +		if (val >= 0 && val <= 2) {
>> +			i2s->clk_trcm = val << I2S_CKR_TRCM_SHIFT;
>> +			if (i2s->clk_trcm)
>> +				soc_dai->symmetric_rate = 1;
>> +		}
>> +	}
>> +
>> +	regmap_update_bits(i2s->regmap, I2S_CKR,
>> +			   I2S_CKR_TRCM_MASK, i2s->clk_trcm);
>> +
>>   	ret = devm_snd_soc_register_component(&pdev->dev,
>>   					      &rockchip_i2s_component,
>>   					      soc_dai, 1);
> Hello,
>
> I recommend doing the same thing with clk-trcm that I'm going to do in v3 of
> my i2s-tdm driver, as per Robin Murphy's suggestion:
>
> Have tx-only and rx-only be two boolean properties. I named them
> rockchip,trcm-sync-tx-only and rockchip,trcm-sync-rx-only.
>
> I also recommend only shifting the value when writing it to registers, and
> storing it in its unshifted state for debug reasons.
okay, will do in v2.
> My probe function looks like this:
>
> 	i2s_tdm->clk_trcm = TRCM_TXRX;
> 	if (of_property_read_bool(node, "rockchip,trcm-sync-tx-only"))
> 		i2s_tdm->clk_trcm = TRCM_TX;
> 	if (of_property_read_bool(node, "rockchip,trcm-sync-rx-only")) {
> 		if (i2s_tdm->clk_trcm) {
> 			dev_err(i2s_tdm->dev, "invalid trcm-sync
> configuration\n");
> 			return -EINVAL;
> 		}
> 		i2s_tdm->clk_trcm = TRCM_RX;
> 	}
> 	if (i2s_tdm->clk_trcm != TRCM_TXRX)
> 		i2s_tdm_dai.symmetric_rate = 1;
>
> When writing clk_trcm to a register, I then just do:
>
> 	regmap_update_bits(i2s_tdm->regmap, I2S_CKR, I2S_CKR_TRCM_MASK,
> 			   i2s_tdm->clk_trcm << I2S_CKR_TRCM_SHIFT);
>
> This way if I need to add an error message or debug print somewhere, then
> clk_trcm is still either 0, 1 or 2.
>
> In general, we should look into supporting both i2s and i2s-tdm controllers in
> the same driver if possible. This way we don't need to duplicate work like
> this. Do you think this is feasible to do? When I looked at the register maps
> I saw that the bits I2S/TDM uses were reserved in the I2S version of the
> controller, so I think it should work.

It's possible, but will make the driver much more complicate(a lot of 
'if...else...').

Though the registers were compatible, but the design is totally 
different, such as clks, reset signal,  pins and core logic.

so, split into two drivers to support old controller and new one.

> Regards,
> Nicolas Frattaroli
>
>
>
>
>
-- 
Best Regards!
张学广/Sugar
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.



