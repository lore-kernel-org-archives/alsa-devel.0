Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF641C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 17:05:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A806103C
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 17:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4A806103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92D4A187D;
	Thu, 16 Sep 2021 19:04:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92D4A187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631811899;
	bh=q4RqtIRntVMa6Rg/TYwJDrSsxHezNXjx5lMa5ZlXjv0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T2tUfWMNwsESNFLQJTjROGofF5S4AwmIHfKsar+7zAXHmISBOsdE+wTEUrnKUrsCq
	 pDM1PE0dhKTQYNIMB3uzQonpkvI7Yn+ClsCCQoet4pM0VghFoWWCp/rwiNE4e82KpZ
	 kZ9eCdst5y7b/erVLfPn3igpnNlAtr6oitVXJ6hA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E01F0F80117;
	Thu, 16 Sep 2021 19:04:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A5E7F800D3; Thu, 16 Sep 2021 19:04:07 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21057F80117
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 19:04:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21057F80117
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="222666959"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; d="scan'208";a="222666959"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 10:03:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; d="scan'208";a="554167905"
Received: from xuanguan-mobl.amr.corp.intel.com (HELO [10.213.180.84])
 ([10.213.180.84])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 10:03:56 -0700
Subject: Re: [PATCH v6 16/22] ASoC: qdsp6: audioreach: add module
 configuration command helpers
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210915131333.19047-1-srinivas.kandagatla@linaro.org>
 <20210915131333.19047-17-srinivas.kandagatla@linaro.org>
 <4cd0e63f-107b-d10a-11e9-bced83f487a5@linux.intel.com>
 <00472b83-f02d-70cc-7c6e-cf414dc17754@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dbe12aeb-3200-e7d3-7530-39e2d3aa990c@linux.intel.com>
Date: Thu, 16 Sep 2021 10:40:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <00472b83-f02d-70cc-7c6e-cf414dc17754@linaro.org>
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


>>> +int q6apm_read(struct q6apm_graph *graph)
>>> +{
>>> +    struct data_cmd_rd_sh_mem_ep_data_buffer_v2 *read;
>>> +    struct audioreach_graph_data *port;
>>> +    struct audio_buffer *ab;
>>> +    struct gpr_pkt *pkt;
>>> +    int rc, iid;
>>> +
>>> +    iid = q6apm_graph_get_tx_shmem_module_iid(graph);
>>> +    pkt = audioreach_alloc_pkt(sizeof(*read),
>>> DATA_CMD_RD_SH_MEM_EP_DATA_BUFFER_V2,
>>> +                 graph->tx_data.dsp_buf, graph->port->id, iid);
>>> +    if (IS_ERR(pkt))
>>> +        return -ENOMEM;
>>> +
>>> +    read = (void *)pkt + GPR_HDR_SIZE;
>>
>> same nit-pick on variable naming, with the additional present/past
>> grammar issue that you don't know if it's a read buffer or a pointer to
>> data read in the past.
>>
> 
> do you think adding "_cmd" suffix like read_cmd would make more sense?

My personal preference is read_buffer or write_buffer, less ambiguous
than 'read' or 'write'.

I've started cracking down on the use of 'stream' for a similar reason,
at some point no one know what the code/variables represent.
