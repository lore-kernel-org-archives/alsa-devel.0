Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC1DC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 02:43:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 165D31B11;
	Fri, 25 Feb 2022 03:42:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 165D31B11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645757011;
	bh=74+49TCrMQ7jAxfbjbaydv86+No0xoF1y8SiKLJpHgE=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=crWx49mkpLXNpa1APBqQRyr19mRRHJJChA125dRzWJGmhjo+G1SqmO5JCBxlYaweq
	 XUByl4SY/fUnEkCTp66C+qKtgFLZBGMERppye4LQC6I3hwtYNOWWCXsuVUoED247hz
	 3hlDWtCvVi2ocrLP0DGGd+kIAZ3QsOfqwrsXodvs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 613DFF80542;
	Fri, 25 Feb 2022 03:39:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6E25F80534; Fri, 25 Feb 2022 03:39:44 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1AA2F8052F
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 03:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1AA2F8052F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="awJIYpkq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645756782; x=1677292782;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=74+49TCrMQ7jAxfbjbaydv86+No0xoF1y8SiKLJpHgE=;
 b=awJIYpkqybRYunu/VMmNbIOAXzETpCfVnc1w53R8ZdHtHTs8eqgqCpGB
 W6oEGSnXVQr+rvE8bg1BeG8vcMBzXG9/J+tYM7hF6pMnYIUD43CbhKMRF
 DhxWNAqusi7Zcz2+q3mQvfpLyl9rFO5JKYkU0m1yGuEFN4EFzTs17ybDl
 ZhE7l3y0sSya6KVD2ayMNBuehLhzKMg14ACZkm1VmpOnRz8IfVQEHwAGy
 pGCOo1KQ6yzWHFAe1jH87pxRrelw/KdVDZJhVwztXEQGJYubUbtOxvoW6
 azmUx7n3ESjqs5Uz9qgwc/n+VRk+7MbZj2fYQQfwekr5RMQ8htAR4tqeR w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252133441"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="252133441"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="491832725"
Received: from jsegev-mobl1.ger.corp.intel.com (HELO [10.212.99.193])
 ([10.212.99.193])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:32 -0800
Message-ID: <14f6c074-e898-6479-879f-6e3bc5152f07@linux.intel.com>
Date: Thu, 24 Feb 2022 20:21:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 16/17] ASoC: Intel: avs: Code loading over CLDMA
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20220207122108.3780926-1-cezary.rojewski@intel.com>
 <20220207122108.3780926-17-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220207122108.3780926-17-cezary.rojewski@intel.com>
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


> +int avs_cldma_load_library(struct avs_dev *adev, struct firmware *lib, u32 id)
> +{
> +	struct hda_cldma *cl = &code_loader;
> +	int ret;
> +
> +	hda_cldma_set_data(cl, (void *)lib->data, lib->size);
> +	/* transfer modules manifest */
> +	hda_cldma_transfer(cl, msecs_to_jiffies(AVS_CLDMA_START_DELAY_MS));
> +	/* DMA id ignored as there is only ever one code-loader DMA */

consider adding new lines to make comments more readable. this is a bit
of an eyesore.

> +	ret = avs_ipc_load_library(adev, 0, id);
> +	hda_cldma_stop(cl);
> +
> +	if (ret) {
> +		ret = AVS_IPC_RET(ret);
> +		dev_err(adev->dev, "transfer lib %d failed: %d\n", id, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int avs_cldma_load_module(struct avs_dev *adev, struct avs_module_entry *mentry)
> +{
> +	struct hda_cldma *cl = &code_loader;
> +	const struct firmware *mod;
> +	char mod_name[128];

use kasprintf?

> +	int ret;
> +
> +	snprintf(mod_name, sizeof(mod_name), "%s/%s/dsp_mod_%pUL.bin",
> +		 AVS_ROOT_DIR, adev->spec->name, mentry->uuid.b);
> +
> +	ret = avs_request_firmware(adev, &mod, mod_name);
> +	if (ret < 0)
> +		return ret;
> +
> +	hda_cldma_set_data(cl, (void *)mod->data, mod->size);
> +	hda_cldma_transfer(cl, msecs_to_jiffies(AVS_CLDMA_START_DELAY_MS));
> +	ret = avs_ipc_load_modules(adev, &mentry->module_id, 1);
> +	hda_cldma_stop(cl);
> +
> +	if (ret) {
> +		dev_err(adev->dev, "load module %d failed: %d\n", mentry->module_id,
> +			ret);
> +		return AVS_IPC_RET(ret);
> +	}
> +
> +	return 0;
> +}

