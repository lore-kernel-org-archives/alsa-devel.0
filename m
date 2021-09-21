Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68831C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 18:51:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224F661242
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 18:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 224F661242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30620826;
	Tue, 21 Sep 2021 20:50:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30620826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632250262;
	bh=w7bMoJqF3XbxwZ73g7N/nQxt92UoRU/NZ7f3HvR5FyI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MeJirm1xGcxAJpMvWTIOWEQeoBEwUEoppyRalMwYQMLOjXq4XcggfsDXoJ0i5gkWf
	 AZvpZN6j+y9LX18vWbsk9QhN/i+ZkPv9MHCvejdqLQ86g+9P+6RNSfCnEEqZSPr2TD
	 +Z4tJdfURfGFZCmD8nlnfbSB6wCqAgclA/A3KQQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BD9BF802BE;
	Tue, 21 Sep 2021 20:50:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8789F802BE; Tue, 21 Sep 2021 20:50:09 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1E1EF8025F
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 20:50:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1E1EF8025F
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="210521541"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; d="scan'208";a="210521541"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 11:49:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; d="scan'208";a="512431686"
Received: from rudymgal-mobl1.amr.corp.intel.com (HELO [10.212.82.111])
 ([10.212.82.111])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 11:49:58 -0700
Subject: Re: [PATCH v7 15/22] ASoC: qdsp6: audioreach: add q6apm support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210921133709.4973-1-srinivas.kandagatla@linaro.org>
 <20210921133709.4973-16-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fdb5cd4d-4b8b-3dea-872a-f225a5c90d1f@linux.intel.com>
Date: Tue, 21 Sep 2021 12:05:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210921133709.4973-16-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
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


> +static void apm_populate_connection_obj(struct apm_module_conn_obj *obj,
> +					struct audioreach_module *module)
> +{
> +	obj->src_mod_inst_id = module->src_mod_inst_id;
> +	obj->src_mod_op_port_id = module->src_mod_op_port_id;
> +	obj->dst_mod_inst_id = module->instance_id;
> +	obj->dst_mod_ip_port_id =	module->in_port;

alignment seems off?


> +void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct list_head *sg_list, int graph_id)
> +{
> +	void *p;

move this as last declaration to have a nice reverse christmas tree style?

> +	int payload_size, sg_sz, cont_sz, ml_sz, mp_sz, mc_sz;
> +	struct apm_module_param_data  *param_data;
> +	struct audioreach_container *container;
> +	struct apm_graph_open_params params;
> +	struct audioreach_sub_graph *sgs;
> +	struct audioreach_module *module;
> +	int num_modules_per_list;
> +	int num_connections = 0;
> +	int num_containers = 0;
> +	int num_sub_graphs = 0;
> +	int num_modules = 0;
> +	int num_modules_list;
> +	struct gpr_pkt *pkt;

[...]

> +static struct audioreach_graph *q6apm_get_audioreach_graph(struct q6apm *apm, uint32_t graph_id)
> +{
> +	struct audioreach_graph_info *info;
> +	struct audioreach_graph *graph;
> +
> +	mutex_lock(&apm->lock);
> +	graph = idr_find(&apm->graph_idr, graph_id);
> +	mutex_unlock(&apm->lock);
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
> +	graph->graph = audioreach_alloc_graph_pkt(apm, &info->sg_list, graph_id);
> +	if (IS_ERR(graph->graph)) {
> +		kfree(graph);
> +		return ERR_PTR(-ENOMEM);

why not return graph->graph (store and return the value before freeing
graph)?

> +	}
> +
> +	mutex_lock(&apm->lock);
> +	if (idr_alloc(&apm->graph_idr, graph, graph_id, graph_id + 1, GFP_KERNEL) < 0) {
> +		dev_err(apm->dev, "Unable to allocate graph id (%d)\n", graph_id);
> +		kfree(graph);
> +		mutex_unlock(&apm->lock);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	mutex_unlock(&apm->lock);
> +
> +	kref_init(&graph->refcount);
> +
> +	q6apm_send_cmd_sync(apm, graph->graph, 0);
> +
> +	return graph;
> +}

> +static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
> +{
> +	struct data_cmd_rsp_rd_sh_mem_ep_data_buffer_done_v2 *rd_done;
> +	struct data_cmd_rsp_wr_sh_mem_ep_data_buffer_done_v2 *done;
> +	struct apm_cmd_rsp_shared_mem_map_regions *rsp;
> +	struct gpr_ibasic_rsp_result_t *result;
> +	struct q6apm_graph *graph = priv;
> +	struct gpr_hdr *hdr = &data->hdr;
> +	struct device *dev = graph->dev;
> +	uint32_t client_event;
> +	int ret = -EINVAL;
> +	phys_addr_t phys;
> +	int token;
> +
> +	result = data->payload;
> +
> +	switch (hdr->opcode) {
> +	case DATA_CMD_RSP_WR_SH_MEM_EP_DATA_BUFFER_DONE_V2:
> +		client_event = APM_CLIENT_EVENT_DATA_WRITE_DONE;
> +		mutex_lock(&graph->lock);
> +		token = hdr->token & APM_WRITE_TOKEN_MASK;
> +
> +		done = data->payload;
> +		phys = graph->rx_data.buf[token].phys;
> +
> +		if (lower_32_bits(phys) != done->buf_addr_lsw ||
> +		    upper_32_bits(phys) != done->buf_addr_msw) {
> +			dev_err(dev, "WR BUFF Unexpected addr %08x-%08x\n",
> +				done->buf_addr_lsw, done->buf_addr_msw);
> +			ret = -EINVAL;

since you don't return here you might invoke graph->cb() below, is this
desired?

> +		} else {
> +			ret = 0;
> +			graph->result.opcode = hdr->opcode;
> +			graph->result.status = done->status;
> +		}
> +		mutex_unlock(&graph->lock);
> +		if (graph->cb)
> +			graph->cb(client_event, hdr->token, data->payload,
> +				  graph->priv);
> +
> +		break;
> +	case APM_CMD_RSP_SHARED_MEM_MAP_REGIONS:
> +		graph->result.opcode = hdr->opcode;
> +		graph->result.status = 0;
> +		rsp = data->payload;
> +
> +		if (hdr->token == SNDRV_PCM_STREAM_PLAYBACK)
> +			graph->rx_data.mem_map_handle = rsp->mem_map_handle;
> +		else
> +			graph->tx_data.mem_map_handle = rsp->mem_map_handle;
> +
> +		wake_up(&graph->cmd_wait);
> +		ret = 0;
> +		break;
> +	case DATA_CMD_RSP_RD_SH_MEM_EP_DATA_BUFFER_V2:
> +		client_event = APM_CLIENT_EVENT_DATA_READ_DONE;
> +		mutex_lock(&graph->lock);
> +		rd_done = data->payload;
> +		phys = graph->tx_data.buf[hdr->token].phys;
> +		if (upper_32_bits(phys) != rd_done->buf_addr_msw ||
> +		    lower_32_bits(phys) != rd_done->buf_addr_lsw) {
> +			dev_err(dev, "RD BUFF Unexpected addr %08x-%08x\n",
> +				rd_done->buf_addr_lsw, rd_done->buf_addr_msw);
> +			ret = -EINVAL;

same here, you will call wake_up and conditionally the callback.

> +		} else {
> +			ret = 0;
> +		}
> +		mutex_unlock(&graph->lock);
> +		wake_up(&graph->cmd_wait);
> +
> +		if (graph->cb)
> +			graph->cb(client_event, hdr->token, data->payload,
> +				  graph->priv);
> +		break;
> +	case DATA_CMD_WR_SH_MEM_EP_EOS_RENDERED:
> +		break;
> +	case GPR_BASIC_RSP_RESULT:
> +		switch (result->opcode) {
> +		case APM_CMD_SHARED_MEM_UNMAP_REGIONS:
> +			graph->result.opcode = result->opcode;
> +			graph->result.status = 0;
> +			if (hdr->token == SNDRV_PCM_STREAM_PLAYBACK)
> +				graph->rx_data.mem_map_handle = 0;
> +			else
> +				graph->tx_data.mem_map_handle = 0;
> +
> +			wake_up(&graph->cmd_wait);
> +			ret = 0;
> +			break;
> +		case APM_CMD_SHARED_MEM_MAP_REGIONS:
> +		case DATA_CMD_WR_SH_MEM_EP_MEDIA_FORMAT:
> +		case APM_CMD_SET_CFG:
> +			graph->result.opcode = result->opcode;
> +			graph->result.status = result->status;
> +			if (result->status) {
> +				dev_err(dev, "Error (%d) Processing 0x%08x cmd\n",
> +					result->status, result->opcode);
> +				ret = -EINVAL;

and here as well.

> +			} else {
> +				ret = 0;
> +			}
> +			wake_up(&graph->cmd_wait);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}

> +static int apm_callback(struct gpr_resp_pkt *data, void *priv, int op)
> +{
> +	gpr_device_t *gdev = priv;
> +	struct q6apm *apm = dev_get_drvdata(&gdev->dev);
> +	struct device *dev = &gdev->dev;
> +	struct gpr_ibasic_rsp_result_t *result;
> +	struct gpr_hdr *hdr = &data->hdr;
> +	int ret = 0;
> +
> +	result = data->payload;
> +
> +	switch (hdr->opcode) {
> +	case APM_CMD_RSP_GET_SPF_STATE:
> +		apm->result.opcode = hdr->opcode;
> +		apm->result.status = 0;
> +		/* First word of result it state */
> +		apm->state = result->opcode;
> +		wake_up(&apm->wait);
> +		break;
> +	case GPR_BASIC_RSP_RESULT:
> +		switch (result->opcode) {
> +		case APM_CMD_GRAPH_START:
> +		case APM_CMD_GRAPH_OPEN:
> +		case APM_CMD_GRAPH_PREPARE:
> +		case APM_CMD_GRAPH_CLOSE:
> +		case APM_CMD_GRAPH_FLUSH:
> +		case APM_CMD_GRAPH_STOP:
> +		case APM_CMD_SET_CFG:
> +			apm->result.opcode = result->opcode;
> +			apm->result.status = result->status;
> +			if (result->status) {
> +				dev_err(dev, "Error (%d) Processing 0x%08x cmd\n",
> +					result->status, result->opcode);
> +				ret = -EINVAL;

same pattern, you will call wake_up even on an error?

> +			}
> +			wake_up(&apm->wait);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}

