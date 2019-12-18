Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED76C2D0D2
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:26:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4AF2467E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MBa4UAFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4AF2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55B1E1666;
	Wed, 18 Dec 2019 17:25:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55B1E1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576686384;
	bh=1Dy/uJ+9YFarMvmbc2YomuIFmHKIOTDsIZY5/8kgkbc=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MBa4UAFRtR8V7CgQ1DAE0DWZsA+XfoImPDQzgSxf8+KIh2aybN18q00ZyAf7Lgr7A
	 M+6gaC1MF7MIu3Z47+qtxhSif/0t4fRuZb2EiROjDBOqlyaU4TPyMmPkgBv5s6cPRW
	 +DfaiDv3XNBo7srs/1f8E7DTPC79t0mjyfXqGqNQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EA4EF80266;
	Wed, 18 Dec 2019 17:24:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04D02F80266; Wed, 18 Dec 2019 17:23:55 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22320F80257
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 17:23:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22320F80257
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 08:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="415881656"
Received: from dshoemak-mobl.amr.corp.intel.com (HELO [10.251.3.243])
 ([10.251.3.243])
 by fmsmga005.fm.intel.com with ESMTP; 18 Dec 2019 08:23:46 -0800
To: Takashi Iwai <tiwai@suse.de>
References: <20191126141423.21523-1-pierre-louis.bossart@linux.intel.com>
 <s5h4kyqzpge.wl-tiwai@suse.de>
 <0131b134-46dc-991f-230b-fe843f43f078@linux.intel.com>
 <s5hd0cm16vf.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f442ed39-1a86-28fb-b42c-b0e5273cd79a@linux.intel.com>
Date: Wed, 18 Dec 2019 09:21:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <s5hd0cm16vf.wl-tiwai@suse.de>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: Intel: add PCI ID for
	CometLake-S
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




>>> I guess the change in ifdef for cml_desc definition is still missing.
>>
>> Not sure what change you are referring to?
> 
> Take a look at the definition of cml_desc.  It's wrapped with
> 
> #if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_LP) || \
>          IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_H)
> 
> but this wasn't updated for the new COMETLAKE_S.

Ah yes, that's a problem. will fix.

>>> Also, can we reduce even the ifdef around sof_dev_desc definitions by
>>> __maybe_unused atttribute?
>>
>> Sorry, I am not following your suggestion. I would really like to keep
>> the ifdefs for now, and while it can be seen as overkill to have
>> descriptors that are identical in some cases the past experience shows
>> it's useful when we have to add quirks for specific 'hardware
>> recommended programming sequences'.
> 
> What I suggested was simple, just dropping ifdef by something like
> 
> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
> index bbeffd932de7..297632a54f1b 100644
> --- a/sound/soc/sof/sof-pci-dev.c
> +++ b/sound/soc/sof/sof-pci-dev.c
> @@ -36,8 +36,7 @@ MODULE_PARM_DESC(sof_pci_debug, "SOF PCI debug options (0x0 all off)");
>   
>   #define SOF_PCI_DISABLE_PM_RUNTIME BIT(0)
>   
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
> -static const struct sof_dev_desc bxt_desc = {
> +static const struct sof_dev_desc __maybe_unused bxt_desc = {
>   	.machines		= snd_soc_acpi_intel_bxt_machines,
>   	.resindex_lpe_base	= 0,
>   	.resindex_pcicfg_base	= -1,
> @@ -52,10 +51,8 @@ static const struct sof_dev_desc bxt_desc = {
>   	.ops = &sof_apl_ops,
>   	.arch_ops = &sof_xtensa_arch_ops
>   };
> -#endif
>   
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
> -static const struct sof_dev_desc glk_desc = {
> +static const struct sof_dev_desc __maybe_unused glk_desc = {
>   	.machines		= snd_soc_acpi_intel_glk_machines,
>   	.resindex_lpe_base	= 0,
>   	.resindex_pcicfg_base	= -1,
> @@ -70,10 +67,8 @@ static const struct sof_dev_desc glk_desc = {
>   	.ops = &sof_apl_ops,
>   	.arch_ops = &sof_xtensa_arch_ops
>   };
> -#endif
> .....
>   
> 
> Then the issue I pointed above can be solved as well.

The ifdefs are still needed in the PCI IDs tables

static const struct pci_device_id sof_pci_ids[] = {
#if IS_ENABLED(CONFIG_SND_SOC_SOF_MERRIFIELD)
	{ PCI_DEVICE(0x8086, 0x119a),
		.driver_data = (unsigned long)&tng_desc},
#endif
#if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
	/* BXT-P & Apollolake */
	{ PCI_DEVICE(0x8086, 0x5a98),
		.driver_data = (unsigned long)&bxt_desc},
	{ PCI_DEVICE(0x8086, 0x1a98),
		.driver_data = (unsigned long)&bxt_desc},
#endif
#if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
	{ PCI_DEVICE(0x8086, 0x3198),
		.driver_data = (unsigned long)&glk_desc},
#endif

so for consistency I personally prefer the matching ifdef for the 
descriptors.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
