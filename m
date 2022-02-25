Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1C2C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 02:43:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7078C1AB7;
	Fri, 25 Feb 2022 03:42:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7078C1AB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645756978;
	bh=lK+F/K8sddvv4NKQjE9W+Yz3/aEg8j9pHI+RJnDq4ec=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCn9km+UjPPuIQiOKvpbgKKAGwO2b06Ea4Uk8Memroyb+QaSTIqml2w9kYfFgvqg0
	 GxHhm3pDqizGdn93jy2VtwUTaTJ6duJiP33+uPZ++MVvoiokcTXtaNMb0RYRa+1aAc
	 PSHXXjRr7zAczlVcVeEgH1QqsPTrhjVWAIMsqtBk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18389F80538;
	Fri, 25 Feb 2022 03:39:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FB6FF8052D; Fri, 25 Feb 2022 03:39:41 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A780F8052F
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 03:39:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A780F8052F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="fnkRniVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645756778; x=1677292778;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lK+F/K8sddvv4NKQjE9W+Yz3/aEg8j9pHI+RJnDq4ec=;
 b=fnkRniVwdvcUSuvTyJ7gRw64wgyy8MycrCEzXR/+8ttWgPmR4x6ByPee
 7nvd+HXaV4LZdGULbQTQ4qDtYPkRJTOkTLumCuluUBtn/4eZLd/4l5inS
 kh8A7EHZ2R2M8mL4YEmzgVi7/kM5eWDOwOzOvS3r1lAcaRaO9aT3Mk9Ow
 0NqgSrLPU1ZNECWDNz3MUQiuK6ti3NTi9RvOPwupnb/3+oLzdlkR8+Fbg
 7T/AVH/f5H84I8R1OLhY4oLx0d6h66TOOKg4oANaBNutq1oRwGDQ7LUMI
 srPvBvobzVXgzfuJXkLSGdbUNfhRwenzCGRdYScH8voFdXFB23JMre6Uj w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252133438"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="252133438"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="491832706"
Received: from jsegev-mobl1.ger.corp.intel.com (HELO [10.212.99.193])
 ([10.212.99.193])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:28 -0800
Message-ID: <945de468-e2c2-a609-ac6f-a668ddee13a7@linux.intel.com>
Date: Thu, 24 Feb 2022 20:15:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 14/17] ASoC: Intel: avs: General code loading flow
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20220207122108.3780926-1-cezary.rojewski@intel.com>
 <20220207122108.3780926-15-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220207122108.3780926-15-cezary.rojewski@intel.com>
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



> +#define AVS_FW_INIT_TIMEOUT_MS		3000

another timeout?

skl-sst.c:#define SKL_BASEFW_TIMEOUT    300
skl-sst.c:#define SKL_INIT_TIMEOUT      1000
bxt-sst.c:#define BXT_BASEFW_TIMEOUT    3000
cnl-sst.c:#define CNL_INIT_TIMEOUT      300
cnl-sst.c:#define CNL_BASEFW_TIMEOUT    3000

> +#define AVS_ROOT_DIR			"intel/avs"
> +#define AVS_BASEFW_FILENAME		"dsp_basefw.bin"
> +#define AVS_EXT_MANIFEST_MAGIC		0x31454124
> +#define SKL_MANIFEST_MAGIC		0x00000006
> +#define SKL_ADSPFW_OFFSET		0x284
> +
> +static bool debug_ignore_fw_version_check;

this_is_a_very_long_variable_name_isn_t_it?

> +module_param_named(ignore_fw_version, debug_ignore_fw_version_check, bool, 0444);
> +MODULE_PARM_DESC(ignore_fw_version, "Verify FW version 0=yes (default), 1=no");

You should clarify the purpose of the version check, and why this driver
needs different firmware binaries and versions than what was already
released to linux-firmware.


> +static int avs_fw_manifest_strip_verify(struct avs_dev *adev, struct firmware *fw,
> +					const struct avs_fw_version *min)
> +{
> +	struct avs_fw_manifest *man;
> +	int offset, ret;
> +
> +	ret = avs_fw_ext_manifest_strip(fw);
> +	if (ret)
> +		return ret;
> +
> +	offset = avs_fw_manifest_offset(fw);
> +	if (offset < 0)
> +		return offset;
> +
> +	if (fw->size < offset + sizeof(*man))
> +		return -EINVAL;
> +	if (!min)
> +		return 0;
> +
> +	man = (struct avs_fw_manifest *)(fw->data + offset);
> +	if (man->version.major != min->major ||
> +	    man->version.minor != min->minor ||
> +	    man->version.hotfix != min->hotfix ||
> +	    man->version.build < min->build) {
> +		dev_warn(adev->dev, "bad FW version %d.%d.%d.%d, expected %d.%d.%d.%d or newer\n",
> +			 man->version.major, man->version.minor,
> +			 man->version.hotfix, man->version.build,
> +			 min->major, min->minor, min->hotfix, min->build);

usually when the relevant firmware is not found, the distributions and
users like to see a message informing them of the location of the
firmware binaries.

see thread with Bruce Perens and Jaroslav at
https://github.com/thesofproject/sof-bin/issues/22

> +
> +		if (!debug_ignore_fw_version_check)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int avs_dsp_load_basefw(struct avs_dev *adev)
> +{
> +	const struct avs_fw_version *min_req;
> +	const struct avs_spec *const spec = adev->spec;
> +	const struct firmware *fw;
> +	struct firmware stripped_fw;
> +	char *filename;
> +	int ret;
> +
> +	filename = kasprintf(GFP_KERNEL, "%s/%s/%s", AVS_ROOT_DIR, spec->name,
> +			     AVS_BASEFW_FILENAME);
> +	if (!filename)
> +		return -ENOMEM;
> +
> +	ret = avs_request_firmware(adev, &fw, filename);
> +	kfree(filename);
> +	if (ret < 0) {
> +		dev_err(adev->dev, "request firmware failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	stripped_fw = *fw;
> +	min_req = &adev->spec->min_fw_version;
> +
> +	ret = avs_fw_manifest_strip_verify(adev, &stripped_fw, min_req);
> +	if (ret < 0) {
> +		dev_err(adev->dev, "invalid firmware data: %d\n", ret);

should you not release the firmware in all error cases?

if this is handled at a higher level, please add a comment.

> +		return ret;
> +	}
> +
> +	ret = avs_dsp_op(adev, load_basefw, &stripped_fw);
> +	if (ret < 0) {
> +		dev_err(adev->dev, "basefw load failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = wait_for_completion_timeout(&adev->fw_ready,
> +					  msecs_to_jiffies(AVS_FW_INIT_TIMEOUT_MS));
> +	if (!ret) {
> +		dev_err(adev->dev, "firmware ready timeout\n");
> +		avs_dsp_core_disable(adev, AVS_MAIN_CORE_MASK);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

