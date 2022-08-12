Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56558C00140
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Aug 2022 12:52:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9EB383D;
	Fri, 12 Aug 2022 14:51:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9EB383D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660308742;
	bh=pLT/JhLRJVT6Hx+fXKzxWkT0IVl2IJGUlJL/FYAB+og=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YvwPpckCTQr7ZWt+bdOQ1T7VPMnuUNrg/5T+v7QqvSJRY7HbGwYhGNGwLd9J6mRUB
	 NRaTE99o10cRtWkTpb7GqNzzAoWIO+tpHa2p+wB92+kz+RxISnsi8ECfeIuyEJf0fG
	 JF3zo1HUj72T+jLXg0WRANPJtdhh2FK0DK58Yi4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32A6AF80152;
	Fri, 12 Aug 2022 14:51:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07310F8026A; Fri, 12 Aug 2022 14:51:31 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74EEAF80054
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2022 14:51:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74EEAF80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="TWOKkvCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660308688; x=1691844688;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=pLT/JhLRJVT6Hx+fXKzxWkT0IVl2IJGUlJL/FYAB+og=;
 b=TWOKkvCubdHMkUnovV24BbNv9OQvknSJ9qgc6HqDMmsePRBoN+u9YeLp
 62lHwB9k/lxUz3av7bHOJ/70655IA1Mon9KNq33+04g3SNmqSz3fd0KcQ
 mPuFU96tlqzWqPBpNToQymvL+U1fGPF2oM7iAnq99oGhmP4MZ23XBAIkN
 9XBpq8thynJBh9ff/jL6ek8m4rjbfyie4m84wHCfHqryde4Wn+DusNJkN
 aw30n8fw4MqJJDw2jvaBJKRItblt+YwjdaQL+FoeMDnXEW0Bio26EkF3w
 5rTxjP2iuDL4rkMkb7EmjkCD+bhyHKjmgGReFLQvH8k0gOczS8DBfUN/q Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="353329570"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; d="scan'208";a="353329570"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2022 05:51:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; d="scan'208";a="556506169"
Received: from pkruijer-mobl.ger.corp.intel.com (HELO [10.249.41.102])
 ([10.249.41.102])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2022 05:51:16 -0700
Message-ID: <4fe4853d-a446-1f72-2f32-f63eb6733adc@linux.intel.com>
Date: Fri, 12 Aug 2022 14:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add support for jsl_rt5682_rt1019
Content-Language: en-US
To: Sean Hong <sean.hong@quanta.corp-partner.google.com>, perex@perex.cz,
 tiwai@suse.com
References: <20220812114804.550809-1-sean.hong@quanta.corp-partner.google.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220812114804.550809-1-sean.hong@quanta.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
 peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
 linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, brent.lu@intel.com, yong.zhi@intel.com
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


>  static const struct snd_soc_acpi_codecs mx98360a_spk = {
>  	.num_codecs = 1,
>  	.codecs = {"MX98360A"}
> @@ -78,6 +83,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
>  		.quirk_data = &mx98360a_spk,
>  		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
>  	},
> +	{
> +		.comp_ids = &rt5682_rt5682s_hp,
> +		.drv_name = "jsl_rt5682_rt1019",
> +		.sof_fw_filename = "sof-jsl.ri",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &rt1019p_spk,
> +		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",

this patch adds support for the rt1019, the line above looks like a
copy-paste mistake.

We shouldn't use the same topology files for different platforms, it's
not good maintenance-wise and since we store default values for some
controls it's really not a good idea.

Please use a unique string such as sof-jsl-rt5682-rt1019.tplg, thanks.

> +	},
>  	{
>  		.id = "10134242",
>  		.drv_name = "jsl_cs4242_mx98360a",
