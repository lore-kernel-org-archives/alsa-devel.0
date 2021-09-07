Return-Path: <SRS0=Gs4n=N5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7781DC433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 16:10:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F40761108
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 16:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F40761108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D228516F6;
	Tue,  7 Sep 2021 18:09:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D228516F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631030998;
	bh=XOs/S843hXD22PzqcZw+IsIKyasZco2+ywtaZEvHngs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sTrhFhlRW4a52KjuWfkAviDKMqBYf63O+Pr03Z5XoZ9ayYfsUu0D/7HD5I89+nudF
	 hhVWUJBjhFwzUbrVSIb16XkMv/7kJlG45ZnkoqEPBf+XBrv3dmm1Ed0xxM+ni4aH3W
	 V3/Tlz3ekazJs6GQ3krF9/1bMtbvfXdHAkp3fyKk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61445F800C7;
	Tue,  7 Sep 2021 18:09:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A2CFF80253; Tue,  7 Sep 2021 18:09:07 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3396FF800C7
 for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2021 18:09:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3396FF800C7
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="217081433"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; d="scan'208";a="217081433"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 09:06:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; d="scan'208";a="512893409"
Received: from mrburno-mobl.amr.corp.intel.com (HELO [10.212.10.81])
 ([10.212.10.81])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 09:06:07 -0700
Subject: Re: [PATCH v5 15/21] ASoC: qdsp6: audioreach: add q6apm support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210903112032.25834-1-srinivas.kandagatla@linaro.org>
 <20210903112032.25834-16-srinivas.kandagatla@linaro.org>
 <081e6734-a258-6d21-cf66-f00bfeb38b04@linux.intel.com>
 <b1cfacb4-70b9-7146-00d5-9d680297d900@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f8bd8b94-528d-bf6f-9e84-0e41e4c56382@linux.intel.com>
Date: Tue, 7 Sep 2021 10:04:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b1cfacb4-70b9-7146-00d5-9d680297d900@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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


>>> +    graph->graph = audioreach_alloc_graph_pkt(apm, &info->sg_list,
>>> graph_id);
>>> +    if (IS_ERR(graph->graph)) {
>>> +        kfree(graph);
>>> +        return ERR_PTR(-ENOMEM);
>>> +    }
>>> +
>>> +    spin_lock(&apm->lock);
>>> +    idr_alloc(&apm->graph_idr, graph, graph_id,
>>> +          graph_id + 1, GFP_ATOMIC);
>>
>> does this need to be ATOMIC?
> 
> We are inside spinlock.

but this is not used in an interrupt handler or anything that isn't in a
process context, is it?
