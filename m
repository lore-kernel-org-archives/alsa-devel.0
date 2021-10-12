Return-Path: <SRS0=z7f8=PA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA1CC433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 09:06:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5A761056
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 09:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF5A761056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEE90169D;
	Tue, 12 Oct 2021 11:05:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEE90169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634029581;
	bh=DBxnCCO2P3Qk06FRo9xV98rHWkw9hGIIio5a1sodtwA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sUWsVwOOhihUkimIliSnYzMg8P4bJWbMNk0dogD0pazH2A8sAmacReeEgHWMbNvk8
	 nOuYmgPesgswfjyH+Ye46Zhvl4C/Pd01ReRmOu/qUR+xZgOIPCiVhWw4wzKDOFJ6oH
	 b/Vm21fcbeSKHXCanY9vcMgcvZxC7e2Ce95kqNgk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAF41F804E6;
	Tue, 12 Oct 2021 11:04:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EFE7F804ED; Tue, 12 Oct 2021 11:04:46 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36BF0F804E6
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 11:04:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36BF0F804E6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="W6+2A3mu"
Received: by mail-wr1-x429.google.com with SMTP id e12so64708602wra.4
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UwNILf/oluFUUL5PRUd2S4kE1LT5CdgyGEGUgX5bbxQ=;
 b=W6+2A3muXydBcHY/YF74R9Dh7MLGWONPA3LeeKLsKxiK1FD/dPcgXuStynOCL0/KsM
 4rHWc0ij/gMMghBussGkcCz1tQ9RIEAbQ0R31is7iooKjUj4dG9918VvbE/IZxdNFugB
 I9uXtMBGeUpQdz9qDmS588A6fge1rY7zFDa6M6+IgdCoLymzCByNymv7gbkbPgWJtg/2
 Pw+JbagwgQT6P3Fe65I9XHmGEMNFS12b7+R33ZxJ/SvPmH8eyP4ZCzxbq25itDhjs2u+
 Q1InWToDbUEWIR1RLik2xe0SJ+lsQMQPRvBTSC2GIlPEzeE1RoiHZ0eWUN8gcQJcs5dn
 rm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UwNILf/oluFUUL5PRUd2S4kE1LT5CdgyGEGUgX5bbxQ=;
 b=G85v2Lh6OSebtR3L+z5IIyG6PclFkNJjluMnrmLDT49HtmVCDlnicbsyGbfdbhNFGx
 XjvhqVIvnYcxh1l/oVZ0s3xYdG2zu+PKaIClPTaxHeJCftr5z4f/ajAxXoRbYrd2UgHw
 hveV7l1dyYhdOEBbchjz7LjcaFvmQTwLgCCyVZFcYXp8g6Zyc7OUU0XQ2/IuClKufobk
 AdbWFjwObA62kaiHN4skgpZea3M3WthhWQYdQJDY0ETbxBr6gjMxivH3INEvI9CUzUQ3
 cBOCZitP4jAt8c0SmxZqbRhG1WtGN5zKhYPNrwV7DmlKqael8ovT/Nv9ITJqRXbXgF7O
 JwAA==
X-Gm-Message-State: AOAM531lw6/pgXi7Ds+rthdYF2WvhJUdL/E/72l7JGvGds7NSDAwfsGy
 o85NYdgoD5h6ZIsAHp4MTA16Mw==
X-Google-Smtp-Source: ABdhPJwRzweIQF2jbPBf/OBl+c01b0VQ2tg2Le+bMbucYkda7/fJjKV7wd4vuvPXckxhCnHoc+8CsQ==
X-Received: by 2002:adf:fb44:: with SMTP id c4mr30838267wrs.179.1634029479152; 
 Tue, 12 Oct 2021 02:04:39 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id c17sm9909734wrq.4.2021.10.12.02.04.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 02:04:38 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] ASoC: codecs: tx-macro: Update tx default values
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, agross@kernel.org,
 bjorn.andersson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
 perex@perex.cz, tiwai@suse.com, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
References: <1633702144-19017-1-git-send-email-srivasam@codeaurora.org>
 <1633702144-19017-5-git-send-email-srivasam@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9261e403-9cbf-d955-d555-1e9cbbdde3df@linaro.org>
Date: Tue, 12 Oct 2021 10:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1633702144-19017-5-git-send-email-srivasam@codeaurora.org>
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



On 08/10/2021 15:09, Srinivasa Rao Mandadapu wrote:
> Update mic control register default values to hardware reset values
> lpass sc7280.
> 
> Fixes: c39667ddcfc5 (ASoC: codecs: lpass-tx-macro: add support for lpass tx macro)

I dont think this should have fixes tag, as you are adding default 
values for sc7280.

with that fixed,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   sound/soc/codecs/lpass-tx-macro.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index d472af1..6742405 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -272,7 +272,7 @@ struct tx_macro {
>   
>   static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
>   
> -static const struct reg_default tx_defaults[] = {
> +static struct reg_default tx_defaults[] = {
>   	/* TX Macro */
>   	{ CDC_TX_CLK_RST_CTRL_MCLK_CONTROL, 0x00 },
>   	{ CDC_TX_CLK_RST_CTRL_FS_CNT_CONTROL, 0x00 },
> @@ -1781,9 +1781,10 @@ static const struct snd_soc_component_driver tx_macro_component_drv = {
>   static int tx_macro_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>   	struct tx_macro *tx;
>   	void __iomem *base;
> -	int ret;
> +	int ret, reg;
>   
>   	tx = devm_kzalloc(dev, sizeof(*tx), GFP_KERNEL);
>   	if (!tx)
> @@ -1805,6 +1806,20 @@ static int tx_macro_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> +	/* Update defaults for lpass sc7280 */
> +	if (of_device_is_compatible(np, "qcom,sc7280-lpass-tx-macro")) {
> +		for (reg = 0; reg < ARRAY_SIZE(tx_defaults); reg++) {
> +			switch (tx_defaults[reg].reg) {
> +			case CDC_TX_TOP_CSR_SWR_AMIC0_CTL:
> +			case CDC_TX_TOP_CSR_SWR_AMIC1_CTL:
> +				tx_defaults[reg].def = 0x0E;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +
>   	tx->regmap = devm_regmap_init_mmio(dev, base, &tx_regmap_config);
>   
>   	dev_set_drvdata(dev, tx);
> 
