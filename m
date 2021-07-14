Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF9C07E9A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 17:16:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EAB613BE
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 17:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EAB613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FDA516A5;
	Wed, 14 Jul 2021 19:16:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FDA516A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626283015;
	bh=vp/ETeId996xyRz3qOduN7enKz3rxHVdUWm5gPOLU8Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dZeWCRrHZJSFk4zbPNP7jGHuBETzwrdV1ucDjZNhVhOX33nRVyPAMPIjnqqtK3m8X
	 wKF6z4nN235aJKLc8Krba3wLvPp1zw7k7sSQ9Kv25ynSzTElDQCutZEhA7jWpFt3oe
	 slcmCrDssL07bqKXPHv3pHUKjel50gfN6AJRxSlU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A6E6F804E1;
	Wed, 14 Jul 2021 19:14:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0AC4F80269; Wed, 14 Jul 2021 19:14:33 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76AB5F8025B
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 19:14:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76AB5F8025B
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190769959"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="190769959"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2021 10:14:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="413353756"
Received: from alpinagh-mobl1.amr.corp.intel.com (HELO [10.212.71.223])
 ([10.212.71.223])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2021 10:14:28 -0700
Subject: Re: [PATCH v2 07/16] ASoC: qcom: audioreach: add module configuration
 command helpers
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-8-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d3e9bf09-cc72-c527-89b2-5f23a15163e4@linux.intel.com>
Date: Wed, 14 Jul 2021 11:48:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714153039.28373-8-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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


> +static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
> +				       struct audioreach_module *module,
> +				       int direction, uint32_t rate,
> +				       uint32_t num_channels,
> +				       u8 channel_map[PCM_MAX_NUM_CHANNEL],
> +				       uint16_t bits_per_sample)
> +{
> +	struct apm_module_param_data *param_data;
> +	struct payload_media_fmt_pcm *cfg;
> +	struct media_format *header;
> +	int rc, payload_size;
> +	struct gpr_pkt *pkt;
> +	void *p;
> +
> +	if (num_channels < 0 || num_channels > 2)
> +		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);

that doesn't sound good, you flag num_channels as an invalid value but still continue using it.

> +
> +	payload_size = APM_SHMEM_FMT_CFG_PSIZE(num_channels) + APM_MODULE_PARAM_DATA_SIZE;
> +
> +	p = audioreach_alloc_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0,
> +				     graph->port->id, module->instance_id);
> +	if (IS_ERR(p))
> +		return -ENOMEM;
> +
> +	pkt = p;
> +	p = p + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
> +
> +	param_data = p;
> +	param_data->module_instance_id = module->instance_id;
> +	param_data->error_code = 0;
> +	param_data->param_id = PARAM_ID_MEDIA_FORMAT;
> +	param_data->param_size = payload_size - APM_MODULE_PARAM_DATA_SIZE;
> +	p = p + APM_MODULE_PARAM_DATA_SIZE;
> +
> +	header = p;
> +	header->data_format = DATA_FORMAT_FIXED_POINT;
> +	header->fmt_id = MEDIA_FMT_ID_PCM;
> +	header->payload_size = payload_size - sizeof(*header);
> +
> +	p = p + sizeof(*header);
> +	cfg = p;
> +	cfg->sample_rate = rate;
> +	cfg->bit_width = bits_per_sample;
> +	cfg->alignment = PCM_LSB_ALIGNED;
> +	cfg->bits_per_sample = bits_per_sample;
> +	cfg->q_factor = bits_per_sample - 1;
> +	cfg->endianness = PCM_LITTLE_ENDIAN;
> +	cfg->num_channels = num_channels;
> +
> +	if (num_channels == 1) {
> +		cfg->channel_mapping[0] =  PCM_CHANNEL_L;
> +	} else if (num_channels == 2) {
> +		cfg->channel_mapping[0] =  PCM_CHANNEL_L;
> +		cfg->channel_mapping[1] =  PCM_CHANNEL_R;
> +	} else {
> +		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);

already tested above.

> +	}
> +
> +	rc = audioreach_graph_send_cmd_sync(graph, pkt, 0);
> +
> +	kfree(pkt);
> +
> +	return rc;
> +}

> +int audioreach_shared_memory_send_eos(struct q6apm_graph *graph)
> +{
> +	struct data_cmd_wr_sh_mem_ep_eos *eos;
> +	struct gpr_pkt *pkt;
> +	int rc = 0, iid;

useless init

> +	void *p;
> +
> +	iid = q6apm_graph_get_rx_shmem_module_iid(graph);
> +	p = audioreach_alloc_cmd_pkt(sizeof(*eos),
> +				      DATA_CMD_WR_SH_MEM_EP_EOS,
> +				      0,
> +				      graph->port->id, iid);
> +	if (IS_ERR(p))
> +		return -ENOMEM;
> +
> +	pkt = p;
> +	eos = p + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
> +
> +	eos->policy = WR_SH_MEM_EP_EOS_POLICY_LAST;
> +
> +	rc = gpr_send_port_pkt(graph->port, pkt);
> +	kfree(pkt);
> +
> +	return rc;
> +}

> +int q6apm_unmap_memory_regions(struct q6apm_graph *graph,
> +			       unsigned int dir)
> +{
> +	struct audioreach_graph_data *data;
> +	struct apm_cmd_shared_mem_unmap_regions *cmd = NULL;

useless init

> +	struct gpr_pkt *pkt;
> +	void *p;
> +	int rc;
> +
> +	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
> +		data = &graph->rx_data;
> +	else
> +		data = &graph->tx_data;
> +
> +	if (!data->mem_map_handle)
> +		return 0;
> +
> +	p = audioreach_alloc_apm_pkt(sizeof(*cmd),
> +				      APM_CMD_SHARED_MEM_UNMAP_REGIONS, dir,
> +				      graph->port->id);
> +	if (IS_ERR(p))
> +		return -ENOMEM;
> +
> +	pkt = p;
> +	cmd = p + GPR_HDR_SIZE;
> +	cmd->mem_map_handle = data->mem_map_handle;
> +
> +	rc = audioreach_graph_send_cmd_sync(graph, pkt, APM_CMD_SHARED_MEM_UNMAP_REGIONS);
> +	kfree(pkt);
> +
> +	audioreach_graph_free_buf(graph);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(q6apm_unmap_memory_regions);

