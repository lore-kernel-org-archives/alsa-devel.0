Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A6C4320A
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 14:22:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE4B601FD
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 14:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FE4B601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A45EB18AE;
	Tue,  3 Aug 2021 16:21:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A45EB18AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628000518;
	bh=k+CUuRdRRouIZZn29tAqe89EIOCRrX9Pf5GpobGyUBw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RW3cxW+gBuG6iGzeRzcjWecsCADfqwtWt/Asf0MkIolimeH/8A8MBFLtXKfLkWAL6
	 5aytKuVcFAW8ATJAkLgRF0EUH5j8XIbJC7dSllKnpHHIsklXLix2HHahai0nV5CtqM
	 njJOFMlPlllcRmu2BbYE9Yb+frnu8nlO9eKnX6Tc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17ADFF8032D;
	Tue,  3 Aug 2021 16:20:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23099F8049E; Tue,  3 Aug 2021 16:20:37 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3B9EF80095
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 16:20:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3B9EF80095
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="274756617"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; d="scan'208";a="274756617"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2021 07:20:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; d="scan'208";a="521269150"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.237.180.77])
 ([10.237.180.77])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2021 07:20:24 -0700
Subject: Re: [PATCH v3 14/20] ASoC: qdsp6: audioreach: add q6apm support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
 <20210803125411.28066-15-srinivas.kandagatla@linaro.org>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <111d4d4f-06f0-b7ca-579a-316e87f24f86@linux.intel.com>
Date: Tue, 3 Aug 2021 16:20:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803125411.28066-15-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com
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

On 8/3/2021 2:54 PM, Srinivas Kandagatla wrote:
> Add support to q6apm (Audio Process Manager) component which is
> core Audioreach service running in the DSP.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

...

> diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
> new file mode 100644
> index 000000000000..6b0b11204f88
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6apm.c
> @@ -0,0 +1,662 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2020, Linaro Limited
> +
> +#include <dt-bindings/soc/qcom,gpr.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/apr.h>
> +#include <linux/wait.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm.h>
> +#include "audioreach.h"
> +#include "q6apm.h"
> +
> +/* Graph Management */
> +struct apm_graph_mgmt_cmd {
> +	struct apm_module_param_data param_data;
> +	uint32_t num_sub_graphs;
> +	uint32_t sub_graph_id_list[0];uint32_t sub_graph_id_list[];


> +} __packed;
> +

...

> +
> +static struct audioreach_graph *q6apm_get_audioreach_graph(struct q6apm *apm,
> +						      uint32_t graph_id)
> +{
> +	struct audioreach_graph *graph;
> +	struct audioreach_graph_info *info;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&apm->lock, flags);
> +	graph = idr_find(&apm->graph_idr, graph_id);
> +	spin_unlock_irqrestore(&apm->lock, flags);
> +
> +	if (graph) {
> +		kref_get(&graph->refcount);
> +		return graph;
> +	}
> +
> +	info = idr_find(&apm->graph_info_idr, graph_id);
> +
> +	if (!info)
> +		return ERR_PTR(-ENODEV);
> +
> +	graph = kzalloc(sizeof(*graph), GFP_KERNEL);
> +	if (!graph)
> +		return ERR_PTR(-ENOMEM);
> +
> +	graph->apm = apm;
> +	graph->info = info;
> +	graph->id = graph_id;
> +
> +	/* Assuming Linear Graphs only for now! */
> +	graph->graph = audioreach_alloc_graph_pkt(apm, &info->sg_list, graph_id);
> +	if (IS_ERR(graph->graph))
> +		return ERR_PTR(-ENOMEM);
Shouldn't graph be freed before returning here?

> +
> +	spin_lock(&apm->lock);
> +	idr_alloc(&apm->graph_idr, graph, graph_id,
> +		  graph_id + 1, GFP_ATOMIC);
> +	spin_unlock(&apm->lock);
> +
> +	kref_init(&graph->refcount);
> +
> +	q6apm_send_cmd_sync(apm, graph->graph, 0);
> +
> +	return graph;
> +}
> +

...

