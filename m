Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2390EC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 22:24:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B5F0173C;
	Wed, 27 Apr 2022 00:23:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B5F0173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651011855;
	bh=7odo1T722brDyNoPu9I864P2TIN8Ihqu+JwlUWJ8BSI=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P/TgqtHj8i11z4IJ+3aS5QibZ3uWMy4GRbwEivkb9UKaVBBaxrIj+28e0tU51mGCI
	 boQANK+TzevPDv+gnmjgjOMSXpug7+58OUAAv+dcJ9mJlaUzdXl4C6Inp1s2EtoG4s
	 ypE14OmRoBxUMbY5Fbka4LNi1sb4pwyIgfWzxgGo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB8C7F804B4;
	Wed, 27 Apr 2022 00:23:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 327D9F804AC; Wed, 27 Apr 2022 00:23:23 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBCD7F8014B
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2022 00:23:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBCD7F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="cTIGZqoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651011801; x=1682547801;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7odo1T722brDyNoPu9I864P2TIN8Ihqu+JwlUWJ8BSI=;
 b=cTIGZqoLscwPGsEn+nvL0DqgW0EbMYVHTA7yZ55CotX2gkEipcozAD5I
 Ic1CqTekFdcyAmTrLZTuctuR586L1E7zPwkuH6TPpbtPGqHWZRvq5BtFN
 4RssL3H0EwSuBsawilkqDaLDOHYw4aF4uy/kW4waosBT4AgLTwg8tYkBw
 QBqpLB1wkOnCNz8vs4lLF0NB9+y7lVCdnTFMeW319wYMeoGe+20m/jjVs
 MgBMH4u7hMR94CRFj8lVl2+QOAommvaCL//bdtjBuRsOl0vaGHSVPzUv8
 C+c7Z6QSnmgtpIgC7xOpmTmvHGeSUgy4YggpbKpSg/FFG4UjoVEgZ+vT7 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245660714"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="245660714"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 15:23:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="532888600"
Received: from gkanakas-mobl.amr.corp.intel.com (HELO [10.212.152.229])
 ([10.212.152.229])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 15:23:13 -0700
Message-ID: <ed73bdff-f671-e8b3-923a-5760763e944a@linux.intel.com>
Date: Tue, 26 Apr 2022 16:40:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 04/14] ASoC: Intel: avs: non-HDA PCM BE operations
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, 
 broonie@kernel.org
References: <20220426172346.3508411-1-cezary.rojewski@intel.com>
 <20220426172346.3508411-5-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220426172346.3508411-5-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: upstream@semihalf.com, harshapriya.n@intel.com, rad@semihalf.com,
 tiwai@suse.com, hdegoede@redhat.com, amadeuszx.slawinski@linux.intel.com,
 cujomalainey@chromium.org, lma@semihalf.com
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


> +static int avs_dai_nonhda_be_trigger(struct snd_pcm_substream *substream, int cmd,
> +				     struct snd_soc_dai *dai)
> +{
> +	struct avs_dma_data *data;
> +	int ret = 0;
> +
> +	data = snd_soc_dai_get_dma_data(dai, substream);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		ret = avs_path_run(data->path, AVS_TPLG_TRIGGER_AUTO);
> +		if (ret < 0)
> +			dev_err(dai->dev, "run BE path failed: %d\n", ret);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		ret = avs_path_pause(data->path);
> +		if (ret < 0)
> +			dev_err(dai->dev, "pause BE path failed: %d\n", ret);
> +
> +		if (cmd == SNDRV_PCM_TRIGGER_STOP) {
> +			ret = avs_path_reset(data->path);
> +			if (ret < 0)
> +				dev_err(dai->dev, "reset BE path failed: %d\n", ret);
> +		}
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;

TRIGGER_SUSPEND will result in -EINVAL?

Have you tried suspend-resume while playing audio?

> +	}
> +
> +	return ret;
> +}
