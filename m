Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253EDC1975A
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:05:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FDC207FC
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fkxdTqzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FDC207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE5F41673;
	Wed, 25 Mar 2020 16:04:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE5F41673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585148732;
	bh=8n4hOE0cCa4oZKPZU8tW3JmyTRBm9KIBgFY5Vh8eHG8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fkxdTqzzs0dlafV0KHrq17lk4Lpn28SlgYlsF1iRYvjbp5Nkqj/0uhb0fGjjGrJ3D
	 wqfievBlnvIAjncJwd76S6lnDwKN1eLk4s0IvybLqrjpUbDGJVuY51oeDhK+JQ+Vcn
	 hqjWBtfPWTN7XZHy2J1ExJGHSYR1TahDbiAKawNk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BCA4F801DA;
	Wed, 25 Mar 2020 16:03:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11C8EF801DA; Wed, 25 Mar 2020 16:03:47 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE7F7F8011E
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 16:03:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE7F7F8011E
IronPort-SDR: ilXwOS1u75PH9EGBFCUaKZP5epi//SxNGUdUzvX1aMZLCDXtTTqT4yoniRiUForwDzpLQ2Nm7O
 ccOlzJp6hG6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 08:03:37 -0700
IronPort-SDR: MbAfWu70H1OFgoDyFFH8wN3qWu13HBwUsWMVjmueLECOFz6ySR4+xY0s98oLb384bG9vwqKL/g
 NK2pdP+MlK1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; d="scan'208";a="393654594"
Received: from swmckee-mobl2.amr.corp.intel.com (HELO [10.252.137.27])
 ([10.252.137.27])
 by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 08:03:36 -0700
Subject: Re: [PATCH] ASoC: Intel: Skylake: Add alternative topology binary name
To: Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200325122230.12172-1-mateusz.gorski@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <70860cdd-0017-7e6c-3a87-85e125e236fe@linux.intel.com>
Date: Wed, 25 Mar 2020 09:33:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325122230.12172-1-mateusz.gorski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, tiwai@suse.com
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



On 3/25/20 7:22 AM, Mateusz Gorski wrote:
> This commit adds alternative topology binary file name based on used
> machine driver and fallback to use this name after failed attempt to
> load topology file with name based on NHLT.
> 
> Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
> ---
>   sound/soc/intel/skylake/skl-topology.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 69cd7a81bf2a..344b06df0e15 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3565,8 +3565,20 @@ int skl_tplg_init(struct snd_soc_component *component, struct hdac_bus *bus)
>   
>   	ret = request_firmware(&fw, skl->tplg_name, bus->dev);
>   	if (ret < 0) {
> -		dev_info(bus->dev, "tplg fw %s load failed with %d, falling back to dfw_sst.bin",
> -				skl->tplg_name, ret);
> +		char alt_tplg_name[64];
> +
> +		snprintf(alt_tplg_name, sizeof(alt_tplg_name), "%s-tplg.bin",
> +				skl->i2s_dev->name);

That's progress but is this complete?

skl->i2s_dev->name is the name of the machine driver, I don't see the 
part where this is modified to deal with the number of dmics?

In your topology patches, the names are: hda_dsp_noDMIC hda_dsp_DMIC_2ch 
hda_dsp_DMIC_4ch

How would the relevant file be found based on the number of DMICs on the 
platform? I must be missing something here?

> +		dev_info(bus->dev, "tplg fw %s load failed with %d, trying alternative tplg name %s",
> +				skl->tplg_name, ret, alt_tplg_name);
> +
> +		ret = request_firmware(&fw, alt_tplg_name, bus->dev);
> +		if (!ret)
> +			goto component_load;
> +
> +		dev_info(bus->dev, "tplg %s failed with %d, falling back to dfw_sst.bin",
> +				alt_tplg_name, ret);
> +
>   		ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
>   		if (ret < 0) {
>   			dev_err(bus->dev, "Fallback tplg fw %s load failed with %d\n",
> @@ -3575,6 +3587,9 @@ int skl_tplg_init(struct snd_soc_component *component, struct hdac_bus *bus)
>   		}
>   	}
>   
> +component_load:
> +
> +
>   	/*
>   	 * The complete tplg for SKL is loaded as index 0, we don't use
>   	 * any other index
> 
