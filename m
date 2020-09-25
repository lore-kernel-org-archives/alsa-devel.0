Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D12FC4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:13:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192ED2311D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UQ/H9ff7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192ED2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10155189C;
	Fri, 25 Sep 2020 15:12:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10155189C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601039605;
	bh=UfQKgu0zdzxDkTtIq111j2C2IbuNJphUdgS7Ylg/lTU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UQ/H9ff7cjc5iAviTAqZKyOkA0G0k86JBF6f5lZums8ZjBP+cISQtKbMtSNQv9j0w
	 AfKdy9JBXEJjJw+e9/B3zXNEEKobwIL3bskBVl/MeriiPvO5r0bSIYVx+JtLxnxUnR
	 dBe90626uduw9fGZaOO+A3A+/gGLl6qvf3nwhIfM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E89BF800DA;
	Fri, 25 Sep 2020 15:12:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5442CF80162; Fri, 25 Sep 2020 15:12:33 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDECCF80162
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 15:12:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDECCF80162
IronPort-SDR: qmvDPJpECo3wbdUHedXiIT/CytG0TDuJLoskxEDb6cNUzhLj0R2BnkyBSIxpAHshzIy9G85XBk
 AjxbwUee9bNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="149288321"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; d="scan'208";a="149288321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 06:12:17 -0700
IronPort-SDR: dMMBxGcPo9STqViUY7Aq22CcrQ4X7+X+9yd9oxEb8XWtx2Gtfjv+XTz75iCMZ4j608TAnMmFy3
 mNj2AQwzk4BQ==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; d="scan'208";a="336655318"
Received: from sboyapat-mobl2.amr.corp.intel.com (HELO [10.209.154.99])
 ([10.209.154.99])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 06:12:16 -0700
Subject: Re: [PATCH 1/2] regmap: add support to regmap_field_bulk_alloc/free
 apis
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20200925092804.23536-1-srinivas.kandagatla@linaro.org>
 <20200925092804.23536-2-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eb7af426-ab00-b444-e578-cf3c4b329c95@linux.intel.com>
Date: Fri, 25 Sep 2020 08:12:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925092804.23536-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, srivasam@codeaurora.org, rafael@kernel.org,
 gregkh@linuxfoundation.org, tiwai@suse.com, lgirdwood@gmail.com,
 rohitkr@codeaurora.org, linux-kernel@vger.kernel.org
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



On 9/25/20 4:28 AM, Srinivas Kandagatla wrote:
> Usage of regmap_field_alloc becomes much overhead when number of fields
> exceed more than 3.
> QCOM LPASS driver has extensively converted to use regmap_fileds.

Multiple typos scattered in this patch: fileds -> fields?

> 
> Using new bluk api to allocate fields makes it much more cleaner code to read!

bulk api?

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Tested-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   drivers/base/regmap/regmap.c | 100 +++++++++++++++++++++++++++++++++++
>   include/linux/regmap.h       |  11 ++++
>   2 files changed, 111 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index aec3f26bf711..271740a163ad 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -1270,6 +1270,106 @@ struct regmap_field *devm_regmap_field_alloc(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
>   
> +
> +/**
> + * regmap_field_bulk_alloc() - Allocate and initialise a bulk register field.
> + *
> + * @regmap: regmap bank in which this register field is located.
> + * @rm_field: regmap register fileds with in the bank.
> + * @reg_field: Register fields with in the bank.
> + * @num_fields: Number of register fileds.
> + *
> + * The return value will be an -ENOMEM on error or zero for success.
> + * Newly allocated regmap_fields should be freed by calling
> + * regmap_field_bulk_free()
> + */
> +int regmap_field_bulk_alloc(struct regmap *regmap,
> +			    struct regmap_field **rm_field,
> +			    struct reg_field *reg_field,
> +			    int num_fields)
> +{
> +	struct regmap_field *rf;
> +	int i;
> +
> +	rf = kcalloc(num_fields, sizeof(*rf), GFP_KERNEL);
> +	if (!rf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_fields; i++) {
> +		regmap_field_init(&rf[i], regmap, reg_field[i]);
> +		rm_field[i] = &rf[i];
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(regmap_field_bulk_alloc);
> +
> +/**
> + * devm_regmap_field_bulk_alloc() - Allocate and initialise a bulk register
> + * fields.
> + *
> + * @dev: Device that will be interacted with
> + * @regmap: regmap bank in which this register field is located.
> + * @rm_field: regmap register fileds with in the bank.
> + * @reg_field: Register fields with in the bank.

within?

> + * @num_fields: Number of register fileds.
> + *
> + * The return value will be an -ENOMEM on error or zero for success.
> + * Newly allocated regmap_fields will be automatically freed by the
> + * device management code.
> + */
> +int devm_regmap_field_bulk_alloc(struct device *dev,
> +				 struct regmap *regmap,
> +				 struct regmap_field **rm_field,
> +				 struct reg_field *reg_field,
> +				 int num_fields)
> +{
> +	struct regmap_field *rf;
> +	int i;
> +
> +	rf = devm_kcalloc(dev, num_fields, sizeof(*rf), GFP_KERNEL);
> +	if (!rf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_fields; i++) {
> +		regmap_field_init(&rf[i], regmap, reg_field[i]);
> +		rm_field[i] = &rf[i];
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_alloc);
> +
> +/**
> + * regmap_field_bulk_free() - Free register field allocated using
> + *                       regmap_field_bulk_alloc.
> + *
> + * @field: regmap fields which should be freed.
> + */
> +void regmap_field_bulk_free(struct regmap_field *field)
> +{
> +	kfree(field);
> +}
> +EXPORT_SYMBOL_GPL(regmap_field_bulk_free);
> +
> +/**
> + * devm_regmap_field_bulk_free() - Free a bulk register field allocated using
> + *                            devm_regmap_field_bulk_alloc.
> + *
> + * @dev: Device that will be interacted with
> + * @field: regmap field which should be freed.
> + *
> + * Free register field allocated using devm_regmap_field_bulk_alloc(). Usually
> + * drivers need not call this function, as the memory allocated via devm
> + * will be freed as per device-driver life-cyle.
> + */
> +void devm_regmap_field_bulk_free(struct device *dev,
> +				 struct regmap_field *field)
> +{
> +	devm_kfree(dev, field);
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_free);
> +
>   /**
>    * devm_regmap_field_free() - Free a register field allocated using
>    *                            devm_regmap_field_alloc.
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 0c49d59168b5..a35ec0a0d6e0 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1189,6 +1189,17 @@ struct regmap_field *devm_regmap_field_alloc(struct device *dev,
>   		struct regmap *regmap, struct reg_field reg_field);
>   void devm_regmap_field_free(struct device *dev,	struct regmap_field *field);
>   
> +int regmap_field_bulk_alloc(struct regmap *regmap,
> +			     struct regmap_field **rm_field,
> +			     struct reg_field *reg_field,
> +			     int num_fields);
> +void regmap_field_bulk_free(struct regmap_field *field);
> +int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap *regmap,
> +				 struct regmap_field **field,
> +				 struct reg_field *reg_field, int num_fields);
> +void devm_regmap_field_bulk_free(struct device *dev,
> +				 struct regmap_field *field);
> +
>   int regmap_field_read(struct regmap_field *field, unsigned int *val);
>   int regmap_field_update_bits_base(struct regmap_field *field,
>   				  unsigned int mask, unsigned int val,
> 
