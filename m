Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6205C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 20:55:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FDF81F73;
	Fri, 25 Feb 2022 21:54:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FDF81F73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645822507;
	bh=yLRnLCXtrLIk5qxlExxp1wQ/05M8NhQ4xtMtWE2xZxM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rLQvPEslNtWdP4eH5GRuG3r58sA5D81iQVPyWTNefQBihUYyFx7MFybCdyPqzpDAU
	 /NTRtc7qjsM4R2S5cAE8WmavfuEs+18f4+KaevVF0iUoZmSWqS+hDCXM0hbg0OQu+4
	 ZhZQOw3ORo37PgCodK1iEcEVuSN4cVn7Q/0O6SnU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C8D1F8051D;
	Fri, 25 Feb 2022 21:52:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B17CF804FC; Fri, 25 Feb 2022 21:52:39 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 384ECF80132
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 21:52:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 384ECF80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="d7KjKIeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645822355; x=1677358355;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=yLRnLCXtrLIk5qxlExxp1wQ/05M8NhQ4xtMtWE2xZxM=;
 b=d7KjKIeueZKD5Qz+2Qlhrave+pD5ndwXh6SLa6HA7D1EcuPC98jOmGTA
 lxRDZVGkitAj1zemUbJhXktl728u7Jnq/yh80cmF5ovkMNL/E9qN1p76/
 0YxY8RCFP39+uYLF3/w7cLMorMC7pT+9AAKKxHXAQSHQlBYw3bkcy6ORx
 ISEHoeLGBWLrLwBGMmf0/+AVV96f+3e/TYn1WQ/bmYMXH9FSB9cflumC8
 ZvvZDNdFhYAa+ExRDKlVMhNfZ7HvJhXhjcKEUI4bq0281teWo5Il2JZ00
 jTOg+T0B74Woxc8InDxBNp98QkL1Zc6m4cnZviviMBaM+XPV8CcPlN9el w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="313296128"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; d="scan'208";a="313296128"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 12:52:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; d="scan'208";a="777520550"
Received: from nnwogbe-mobl1.amr.corp.intel.com (HELO [10.212.101.231])
 ([10.212.101.231])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 12:52:32 -0800
Message-ID: <33814efe-010d-d9a0-dc3f-90b0cf5241ba@linux.intel.com>
Date: Fri, 25 Feb 2022 13:09:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [RFC 06/13] ASoC: Intel: avs: Parse path and path templates tuples
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20220207132532.3782412-1-cezary.rojewski@intel.com>
 <20220207132532.3782412-7-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220207132532.3782412-7-cezary.rojewski@intel.com>
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
> Path template is a pattern like its name suggests. It is tied to DAPM

the name really doesn't suggest anything to me, and I have no idea what
a 'pattern' represents for graph management.

You really ought to uplevel and expose the concepts earlier

> widget which represents a FE or a BE and is used during path

'a widget which represents a FE or a BE'. I do not see a 1:1
relationship between widget and FE/BE. these are different concepts/levels.

> instantiation when substream is opened for streaming. It carries a range
> of available variants - actual implementation of a runtime path on
> AudioDSP side. Only one variant of given path template can be
> instantiated at a time and selection is based off of audio format
> provided from userspace and currently selected one on the codec.

well, the last part is the fundamental problem that I am trying to explain.

The codec rate is not necessarily fixed as you seem to assume. There are
many cases where the codec rate can be changed depending on the audio
format changes happening in the DSP.

It is an invalid assumption to assume the codec rate is selected
arbitrarily. It's often the case but that's more of a DPCM limitation
than a design guiding principle we should build on.


> +static struct avs_tplg_path_template *
> +avs_tplg_path_template_create(struct snd_soc_component *comp, struct avs_tplg *owner,
> +			      struct snd_soc_tplg_vendor_array *tuples, u32 block_size)
> +{
> +	struct avs_tplg_path_template *template;
> +	int ret;
> +
> +	template = devm_kzalloc(comp->card->dev, sizeof(*template), GFP_KERNEL);
> +	if (!template)
> +		return ERR_PTR(-ENOMEM);
> +
> +	template->owner = owner; /* Used when building sysfs hierarchy. */

sysfs is a showstopper if the intent is to let userspace modify the
hierarchy.

Even for read-only information, it's not clear to me what application
would ever read this information. debugfs seems more appropriate?

please clarify what the intended use might be.


> +	INIT_LIST_HEAD(&template->path_list);
> +	INIT_LIST_HEAD(&template->node);
> +
> +	ret = parse_path_template(comp, tuples, block_size, template, path_tmpl_parsers,
> +				  ARRAY_SIZE(path_tmpl_parsers), path_parsers,
> +				  ARRAY_SIZE(path_parsers));
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return template;
> +}

>  struct avs_tplg_path {
>  	u32 id;
> +
> +	/* Path format requirements. */
> +	struct avs_audio_format *fe_fmt;
> +	struct avs_audio_format *be_fmt;

this doesn't seem quite right or assumes a very narrow set of DPCM uses.

First I am not sure why there is only one format possible on both FE and
BE sides. If you have multiples paths to represent all possible
combinations of FE and BE formats, then it will become really confusing
really quickly.

This representation would also not scale if there are multiple FEs are
connected to the same BE, or conversely one FE is connected to multiple
BEs. It's also quite possible that the different BE and FE have
different formats, e.g. you could mix 24 and 32 bit data.

In addition, it is a really bad assumption to think that the BE is
independent of the FE. In cases where its format can be adjusted, we
would want constraints to be identified and select the 'best' possible
BE format.

> +
> +	struct list_head ppl_list;
> +
> +	struct avs_tplg_path_template *owner;
> +	/* Path template path-variants management. */
> +	struct list_head node;
>  };
>  
>  struct avs_tplg_pipeline {
