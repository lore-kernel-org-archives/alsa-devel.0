Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86166C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 20:55:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AACDC1F60;
	Fri, 25 Feb 2022 21:54:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AACDC1F60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645822522;
	bh=tbIDNlWamBhHIie+rxTQLbjoFqW1L/yu/l0KQmdnfGQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yf0eqHjxj3zMKxBKawX+nEf9QpCBGRpuirUmwVFYwXp7RAnIAHlnzbBvJIO0fg3uS
	 YojKT+iPUBr0cQ183F18oNpwgQ/Qf+KPdSwY7To2X1paV5xyR5AdEXSna9LfYDC82E
	 cj66KvyZJLg5BouPz4LABOvuwCMsHHd1LB7/xW0w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 906F9F80132;
	Fri, 25 Feb 2022 21:52:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FACBF8020D; Fri, 25 Feb 2022 21:52:39 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CF0EF800B6
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 21:52:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CF0EF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="KhrNEOP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645822357; x=1677358357;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tbIDNlWamBhHIie+rxTQLbjoFqW1L/yu/l0KQmdnfGQ=;
 b=KhrNEOP9koVkPkJLEKbh0W1IM0uU2bSWuYTwkt7Dsn08cUF9E/vzecam
 HQioWVpFipTulJpH8nnsA+0T7FijhLNEQGvLGEKM2LRehZ6XhUIys4X1Y
 W1lpvTfy3B8iOLK+w6FxyC0E9ludtjHRSOKctvawACIcszf0DMbRbVlon
 Xd5IcuiQh1PQG6H+NQO8j0kuBx1faHcRSnZM6nE5GTbdfNfwfDnQ2mhIE
 0S7NCscdeTq2jnqXkxiwCHlVcRXkjEsr8C2oZ7dmKZxeTBmSP1UQmLdfT
 0NouD+DZa+5cVJhQCFZ/DXjEeE3s/0vyWGu+jEhJMan3cLG/VJ23i8ZVG w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="313296131"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; d="scan'208";a="313296131"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 12:52:35 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; d="scan'208";a="777520570"
Received: from nnwogbe-mobl1.amr.corp.intel.com (HELO [10.212.101.231])
 ([10.212.101.231])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 12:52:34 -0800
Message-ID: <20d0c619-443f-b714-269a-0a71b5f09cef@linux.intel.com>
Date: Fri, 25 Feb 2022 13:25:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [RFC 08/13] ASoC: Intel: avs: Declare path and its components
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20220207132532.3782412-1-cezary.rojewski@intel.com>
 <20220207132532.3782412-9-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220207132532.3782412-9-cezary.rojewski@intel.com>
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



On 2/7/22 07:25, Cezary Rojewski wrote:
> Declare representatives for all crucial elements which stream on ADSP
> side is made of. That covers pipelines and modules subject which are
> presented by struct avs_path_pipeline and avs_path_module respetively.

respectively

> While struct avs_path_binding and struct avs_path do not represent any
> object on firmware side directly, they are needed to help track the
> interconnections and membership of every pipeline and module created.

> +struct avs_path {
> +	u32 dma_id;

that is very surprising...

This would seem to limit the concept of an avs path to a single host DMA
channel, which somewhat contradicts that there can be multiple pipelines
in the same path, or that a path can contain mixers.

And even if this is a single dma, what does this represent? the
stream_tag? the BE DMA for SSP/DMIC?

Please clarify the concepts first, it's frustrating to discover this at
patch 8.

> +	struct list_head ppl_list;
> +	u32 state;
> +
> +	struct avs_tplg_path *template;
> +	struct avs_dev *owner;
> +	/* device path management */
> +	struct list_head node;
> +};

> +struct avs_path_binding {
> +	struct avs_path_module *source;
> +	u8 source_pin;
> +	struct avs_path_module *sink;
> +	u8 sink_pin;
> +
> +	struct avs_tplg_binding *template;

I must admit not clearly seeing how the definitions of
'avs_path_binding' and 'avs_tplg_binding' are related.


More specifically, having a template for something that directly
connects a source to a sink is far from intuitive.

> +	struct avs_path_pipeline *owner;
> +	/* pipeline bindings management */
> +	struct list_head node;
> +};
> +
> +#endif
