Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8949C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 15:47:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C3B64F9B
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 15:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C3B64F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F8A91789;
	Wed, 10 Mar 2021 16:46:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F8A91789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615391231;
	bh=0s1rr19PpTx1V2pocvsySFbzFiZMTA9Iy8rHYkBguyU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Phs6lPQ4eIob685RBDqKnWdCTeD9tS5+pIlKDPbZJXNN3tXYIz/YrLvytDTsaN7C/
	 JkIlekwU2RKrwaZt5YvL1yDMPktuEdSZy/WTLl8eQNgYYFiCI0V9GjO+rP5xZ6Jl7N
	 ObfnWlioywNsQlc7oEkmdwaY2YhySOxN5tKPphAM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D27FFF8049C;
	Wed, 10 Mar 2021 16:45:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7DD9F80272; Wed, 10 Mar 2021 16:45:26 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70545F8028D
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 16:45:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70545F8028D
IronPort-SDR: WlzUYBEOfBQ9jIrfcApqeT3LCuVVhCp+6RK24vR0yADbf1JQegz2/Rdsh5Py6P/CPQE9T67wYf
 /lXpPFnZ82ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188589643"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; d="scan'208";a="188589643"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 07:45:10 -0800
IronPort-SDR: HqmaViramXuMCp9/kgif+x29hhv50s1Kyy9Okq0ZpTO8MC2xdO7bPrO0r5Mjs1UsmAgF5RtfyO
 VOkV8rq7XeAg==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; d="scan'208";a="403722190"
Received: from huiyingw-mobl.amr.corp.intel.com (HELO [10.212.214.84])
 ([10.212.214.84])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 07:45:09 -0800
Subject: Re: [PATCH v2 2/5] soundwire: qcom: update port map allocation bit
 mask
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, 
 vkoul@kernel.org
References: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
 <20210309141514.24744-3-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <50c83be0-8948-8450-4b91-d43cc97f8640@linux.intel.com>
Date: Tue, 9 Mar 2021 09:55:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309141514.24744-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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



On 3/9/21 8:15 AM, Srinivas Kandagatla wrote:
> currently the internal bitmask used for allocating ports starts with offset 0.
> This is bit confusing as data port numbers on Qualcomm controller are valid
> from 1 to 14. So adjust this bit mask accordingly, this will also help while
> adding static port map support.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/qcom.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 6d22df01f354..f4f1c5f2af0b 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -519,7 +519,7 @@ static void qcom_swrm_stream_free_ports(struct qcom_swrm_ctrl *ctrl,
>   			port_mask = &ctrl->din_port_mask;
>   
>   		list_for_each_entry(p_rt, &m_rt->port_list, port_node)
> -			clear_bit(p_rt->num - 1, port_mask);
> +			clear_bit(p_rt->num, port_mask);
>   	}
>   
>   	mutex_unlock(&ctrl->port_lock);
> @@ -552,13 +552,13 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>   			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>   				/* Port numbers start from 1 - 14*/
>   				pn = find_first_zero_bit(port_mask, maxport);
> -				if (pn > (maxport - 1)) {
> +				if (pn > (maxport)) {

nit-pick: useless parentheses

>   					dev_err(ctrl->dev, "All ports busy\n");
>   					ret = -EBUSY;
>   					goto err;
>   				}
>   				set_bit(pn, port_mask);
> -				pconfig[nports].num = pn + 1;
> +				pconfig[nports].num = pn;
>   				pconfig[nports].ch_mask = p_rt->ch_mask;
>   				nports++;
>   			}
> @@ -580,7 +580,7 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>   err:
>   	if (ret) {
>   		for (i = 0; i < nports; i++)
> -			clear_bit(pconfig[i].num - 1, port_mask);
> +			clear_bit(pconfig[i].num, port_mask);
>   	}
>   
>   	mutex_unlock(&ctrl->port_lock);
> @@ -754,6 +754,9 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>   	ctrl->num_dout_ports = val;
>   
>   	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
> +	/* port numbers are non zero, so mark port 0 */

mask?

> +	set_bit(0, &ctrl->dout_port_mask);
> +	set_bit(0, &ctrl->din_port_mask);
>   
>   	ret = of_property_read_u8_array(np, "qcom,ports-offset1",
>   					off1, nports);
> 
