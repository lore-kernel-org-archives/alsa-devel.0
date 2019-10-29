Return-Path: <SRS0=9b6r=YW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3815ACA9EAE
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:09:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B75E214D9
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Gh4elgwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B75E214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D80421F4;
	Tue, 29 Oct 2019 11:08:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D80421F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572343741;
	bh=btHQd9mA/o7GvUDpk+lD4iJGiw/6z+mLAKhGO81+suA=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gh4elgwIVjOR8v2ZuRdwUbW3BqB3PXYb7I8Daj+ux9HbUoSYnhkSCefI5paduEz6j
	 M+i0PKj38hySJq0g+4I0DW4/RC0TA/94A+LkkYxXWxr+D3X77XJjohDsT+8+a7GnIi
	 5HNjtzqPN+w4z3Y0PB2aWJk2uEtbaMYEW0Tx9oEQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21F8CF8036C;
	Tue, 29 Oct 2019 11:08:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 602F0F80392; Tue, 29 Oct 2019 11:08:09 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6CE93F80269
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 11:08:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CE93F80269
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Oct 2019 03:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; d="scan'208";a="205425907"
Received: from apboie-mobl2.amr.corp.intel.com (HELO [10.252.8.198])
 ([10.252.8.198])
 by FMSMGA003.fm.intel.com with ESMTP; 29 Oct 2019 03:08:00 -0700
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20191025224122.7718-1-pierre-louis.bossart@linux.intel.com>
 <20191025224122.7718-5-pierre-louis.bossart@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <8172a400-880c-b445-0e37-9611d5f76ccb@intel.com>
Date: Tue, 29 Oct 2019 11:07:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025224122.7718-5-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 04/26] ASoC: SOF: Intel: hda-dsp: Add
 helper for setting DSP D0ix substate
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2019-10-26 00:41, Pierre-Louis Bossart wrote:
> From: Keyon Jie <yang.jie@linux.intel.com>
> 
> Adding helper to implement setting dsp to d0i3 or d0i0 status, this will
> be needed for driver D0ix support.
> 
> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> +static int hda_dsp_wait_d0i3c_done(struct snd_sof_dev *sdev, int retry)
> +{
> +	struct hdac_bus *bus = sof_to_bus(sdev);
> +
> +	while (snd_hdac_chip_readb(bus, VS_D0I3C) & SOF_HDA_VS_D0I3C_CIP) {
> +		if (!retry--)
> +			return -ETIMEDOUT;
> +		usleep_range(10, 15);
> +	}
> +
> +	return 0;
> +}
> +
> +int hda_dsp_set_power_state(struct snd_sof_dev *sdev,
> +			    enum sof_d0_substate d0_substate)
> +{
> +	struct hdac_bus *bus = sof_to_bus(sdev);
> +	int retry = 50;
> +	int ret;
> +	u8 value;
> +
> +	/* Write to D0I3C after Command-In-Progress bit is cleared */
> +	ret = hda_dsp_wait_d0i3c_done(sdev, retry);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "CIP timeout before update D0I3C!\n");
> +		return ret;
> +	}
> +
> +	/* Update D0I3C register */
> +	value = d0_substate == SOF_DSP_D0I3 ? SOF_HDA_VS_D0I3C_I3 : 0;

Some indentation or parenthesis would make this cleaner.

> +	snd_hdac_chip_updateb(bus, VS_D0I3C, SOF_HDA_VS_D0I3C_I3, value);
> +
> +	/* Wait for cmd in progress to be cleared before exiting the function */
> +	retry = 50;
> +	ret = hda_dsp_wait_d0i3c_done(sdev, retry);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "CIP timeout after D0I3C updated!\n");
> +		return ret;
> +	}
> +
> +	dev_vdbg(bus->dev, "D0I3C updated, register = 0x%x\n",
> +		 snd_hdac_chip_readb(bus, VS_D0I3C));
> +
> +	return 0;
> +}
> +

I believe hda_dsp_wait_d0i3c_done function could have had its argument 
list simplified. "retry" is passed externally and it is always set to 
50. One could put the "retry" right inside _done function. This or allow 
the caller to modify the sleep period. Another option is to replace 
"retry" with "timeout period" (total timeout, that is) entirely.

In regard to maintenance, both ret checks (resulting in dev_errs) assume 
-ETIMEOUT outcome on _done failure. If said function gets updated in the 
future, these implicit checks might cause problems.

>   static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
>   {
>   	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
> diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
> index ea02bf40cb25..0e7c366b8f71 100644
> --- a/sound/soc/sof/intel/hda.h
> +++ b/sound/soc/sof/intel/hda.h
> @@ -64,6 +64,13 @@
>   #define SOF_HDA_PPCTL_PIE		BIT(31)
>   #define SOF_HDA_PPCTL_GPROCEN		BIT(30)
>   
> +/*Vendor Specific Registers*/

Missing spaces.

> +#define SOF_HDA_VS_D0I3C		0x104A
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
