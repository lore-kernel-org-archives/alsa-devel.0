Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F4BC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:13:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DFE65229
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DFE65229
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52708191D;
	Mon,  8 Mar 2021 17:12:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52708191D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615219991;
	bh=gZztSvAGzczQ0/ouV075+MWu9uLC4rjsuPMVLasNEI0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MOL63iG79eBpZ4a616UOy9ngJSTrcyGY3S8SdAHF334fl5wUu4WySUsdnH0B8YcfE
	 bS37e6gqMMtS/pY4Y/maJ7ziVzzO7d5ymPgRebBZNsKS4Zs/w2ToXiRYAJ1nTYKzMv
	 h1fZdZ/I9KM1Nj5U+zlKaCVaZwjOoZiFluZ74G/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0E30F804ED;
	Mon,  8 Mar 2021 17:08:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F08ACF804E5; Mon,  8 Mar 2021 17:08:48 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BEA8F804AF
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 17:08:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BEA8F804AF
IronPort-SDR: PvzsDBx5HOdLnFbnufegdr++9nLHsYIyARSqHVE6oWq7BYLJUxK+wMvC/bviYr6PmljyfgeK8P
 UuMEyz+M84Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273083318"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; d="scan'208";a="273083318"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 08:08:39 -0800
IronPort-SDR: 2VERmWGctb+b5z/m+BKxlPqrNO9O0q4LWw6g4Par9ALswrtH4t1omCAI5olzZPl+6b0BgjWcV5
 IUE1gHVED7gg==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; d="scan'208";a="430419063"
Received: from dbdavenp-mobl1.amr.corp.intel.com (HELO [10.212.234.206])
 ([10.212.234.206])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 08:08:38 -0800
Subject: Re: [PATCH v3 8/9] soundwire: qcom: add auto enumeration support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
 <20210308134957.16024-9-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ab00438b-dbb9-e6c6-019a-d50494e5dee1@linux.intel.com>
Date: Mon, 8 Mar 2021 09:56:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308134957.16024-9-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
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


> +static int qcom_swrm_enumerate(struct sdw_bus *bus)
> +{
> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +	struct sdw_slave *slave, *_s;
> +	struct sdw_slave_id id;
> +	u32 val1, val2;
> +	bool found;
> +	u64 addr;
> +	int i;
> +	char *buf1 = (char *)&val1, *buf2 = (char *)&val2;
> +
> +	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
> +		/*SCP_Devid5 - Devid 4*/
> +		ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_1(i), &val1);
> +
> +		/*SCP_Devid3 - DevId 2 Devid 1 Devid 0*/
> +		ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_2(i), &val2);
> +
> +		if (!val1 && !val2)
> +			break;
> +
> +		addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
> +			((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
> +			((u64)buf1[0] << 40);
> +
> +		sdw_extract_slave_id(bus, addr, &id);
> +		found = false;
> +		/* Now compare with entries */
> +		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
> +			if (sdw_compare_devid(slave, id) == 0) {
> +				u32 status = qcom_swrm_get_n_device_status(ctrl, i);
> +
> +				found = true;
> +				if (status == SDW_SLAVE_ATTACHED) {
> +					slave->dev_num = i;
> +					mutex_lock(&bus->bus_lock);
> +					set_bit(i, bus->assigned);
> +					mutex_unlock(&bus->bus_lock);
> +
> +				}

you haven't changed that part, if the device is not in DT we should 
still set bus->assigned::i

