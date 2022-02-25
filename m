Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2F9C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 02:41:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D83C11A74;
	Fri, 25 Feb 2022 03:40:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D83C11A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645756863;
	bh=sHkugUYvFgOCtG28WVfIEVZteUNQ7C7G8TNYzqz/WDA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TmU5Pb/Gydu7Bgq14QAl1Q8iRlNFST+aryyZ/g+FkSGDPYsDbkUIliDSZ4XlBU5Hd
	 htwoMoFcIodybLAr7/PHcJyKVGfrQ0MnOHhtELeVOEcUB3ymdQd98B5huk0EoBXdhb
	 iuSNkvr2nCKMOBlSeaWK2RJG2VsjEFfsJujl1vf8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6ABF2F80508;
	Fri, 25 Feb 2022 03:39:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4233FF80310; Fri, 25 Feb 2022 03:39:23 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E0F9F80169
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 03:39:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E0F9F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="OBZJR3WA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645756760; x=1677292760;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=sHkugUYvFgOCtG28WVfIEVZteUNQ7C7G8TNYzqz/WDA=;
 b=OBZJR3WAeCMo/j9Gkmi2Xqx++5EKsyOU7SG75SKLxxO45Uz2JIzDbHzN
 +7utoNaa+Uh5c7B/FkMfHD9Ny8gTn4BDjrMo/ityX1OcgxYYjfgmyB4tV
 jS1Nc4DZEhxT2vABqSn1uMTUbidL7k7tmij31s3GMo8ZvavWR36pAGdYA
 DT9e6y0qv0BcbI4BmBRzRZJsCLEY0lS6xj4AyGkfXIZTSbu6EheZDsLcE
 lKt19rx921pJirfWIM9qZdCeXcuxuG5xzzKAB8nBaoDZXoZ6Y9XMaaeRT
 jASBlU4hODwzoGRxOWCsE52h8/h2YzBeutwHmLreTfL74StTMvHWKesOE w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="277036151"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="277036151"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:18 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="491832638"
Received: from jsegev-mobl1.ger.corp.intel.com (HELO [10.212.99.193])
 ([10.212.99.193])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:17 -0800
Message-ID: <e63ad06a-a583-b9f0-de00-644cbe389888@linux.intel.com>
Date: Thu, 24 Feb 2022 19:27:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 07/17] ASoC: Intel: avs: Add module management requests
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20220207122108.3780926-1-cezary.rojewski@intel.com>
 <20220207122108.3780926-8-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220207122108.3780926-8-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: upstream@semihalf.com, harshapriya.n@intel.com, rad@semihalf.com,
 tiwai@suse.com, hdegoede@redhat.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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



> +int avs_ipc_init_instance(struct avs_dev *adev, u16 module_id, u8 instance_id,
> +			  u8 ppl_id, u8 core_id, u8 domain,

you should explain the relationship between ppl_id and core_id. It seems
that in the same pipeline different modules instances can be pegged to
different cores, which isn't very intuitive given the previous
explanation that a pipeline is a scheduling unit.

The domain as a u8 is not very clear either, I was under the impression
there were only two domains (LL and EDF)?

> +			  void *param, u32 param_size)
> +{
> +	union avs_module_msg msg = AVS_MODULE_REQUEST(INIT_INSTANCE);
> +	struct avs_ipc_msg request;
> +	int ret;
> +
> +	msg.module_id = module_id;
> +	msg.instance_id = instance_id;
> +	/* firmware expects size provided in dwords */
> +	msg.ext.init_instance.param_block_size =
> +			DIV_ROUND_UP(param_size, sizeof(u32));
> +	msg.ext.init_instance.ppl_instance_id = ppl_id;
> +	msg.ext.init_instance.core_id = core_id;
> +	msg.ext.init_instance.proc_domain = domain;
> +
> +	request.header = msg.val;
> +	request.data = param;
> +	request.size = param_size;

isn't there a need to check if the module can be initialized? there's
got to be some dependency on pipeline state?

> +
> +	ret = avs_dsp_send_msg(adev, &request, NULL);
> +	if (ret)
> +		avs_ipc_err(adev, &request, "init instance", ret);
> +
> +	return ret;
> +}
> +
> +int avs_ipc_delete_instance(struct avs_dev *adev, u16 module_id, u8 instance_id)
> +{
> +	union avs_module_msg msg = AVS_MODULE_REQUEST(DELETE_INSTANCE);
> +	struct avs_ipc_msg request = {0};
> +	int ret;
> +
> +	msg.module_id = module_id;
> +	msg.instance_id = instance_id;
> +	request.header = msg.val;
> +
> +	ret = avs_dsp_send_msg(adev, &request, NULL);
> +	if (ret)
> +		avs_ipc_err(adev, &request, "delete instance", ret);
> +
> +	return ret;

same here, can this be used in any pipeline state?

> +}
> +
> +int avs_ipc_bind(struct avs_dev *adev, u16 module_id, u8 instance_id,
> +		 u16 dst_module_id, u8 dst_instance_id,
> +		 u8 dst_queue, u8 src_queue)

what does a queue represent?

> +{
> +	union avs_module_msg msg = AVS_MODULE_REQUEST(BIND);
> +	struct avs_ipc_msg request = {0};
> +	int ret;
> +
> +	msg.module_id = module_id;
> +	msg.instance_id = instance_id;
> +	msg.ext.bind_unbind.dst_module_id = dst_module_id;
> +	msg.ext.bind_unbind.dst_instance_id = dst_instance_id;
> +	msg.ext.bind_unbind.dst_queue = dst_queue;
> +	msg.ext.bind_unbind.src_queue = src_queue;
> +	request.header = msg.val;
> +
> +	ret = avs_dsp_send_msg(adev, &request, NULL);
> +	if (ret)
> +		avs_ipc_err(adev, &request, "bind modules", ret);
> +
> +	return ret;
> +}
> +
> +int avs_ipc_unbind(struct avs_dev *adev, u16 module_id, u8 instance_id,
> +		   u16 dst_module_id, u8 dst_instance_id,
> +		   u8 dst_queue, u8 src_queue)
> +{
> +	union avs_module_msg msg = AVS_MODULE_REQUEST(UNBIND);
> +	struct avs_ipc_msg request = {0};
> +	int ret;
> +
> +	msg.module_id = module_id;
> +	msg.instance_id = instance_id;
> +	msg.ext.bind_unbind.dst_module_id = dst_module_id;
> +	msg.ext.bind_unbind.dst_instance_id = dst_instance_id;
> +	msg.ext.bind_unbind.dst_queue = dst_queue;
> +	msg.ext.bind_unbind.src_queue = src_queue;
> +	request.header = msg.val;
> +
> +	ret = avs_dsp_send_msg(adev, &request, NULL);
> +	if (ret)
> +		avs_ipc_err(adev, &request, "unbind modules", ret);
> +
> +	return ret;

can this be merged with the bind in a helper, the code looks
quasi-identical with just two lines different.

> +}

