Return-Path: <SRS0=tzFk=HO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63200C433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Feb 2021 15:38:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D127A64E77
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Feb 2021 15:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D127A64E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7645B16D1;
	Fri, 12 Feb 2021 16:38:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7645B16D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613144333;
	bh=l5LMAdbYLxOJQSo86uwvJJN1Bt3jmdDAH3KYeb/ZWdU=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p7frabCh/hdoZTQpLptEDW193sAnqAmNbz0Zk8fZNJJvJWX5lyI05EpmAQFa9St7F
	 tbbIeIDCXnlbeO7xViXfrlVdKZxMwJx/AElX7RjOZxLay7yiVppIanVode04mfdfSQ
	 kHeXx3M4ZGDDA41X8PutEPaiDGpRVy/SqMLql3p4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC84FF8016C;
	Fri, 12 Feb 2021 16:38:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09582F8022B; Fri, 12 Feb 2021 16:38:01 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEF1CF8014B
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2021 16:37:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEF1CF8014B
IronPort-SDR: /jRPebUvwmg59+zXbsLwi42oQLq9fmiZgDe9A/orKfSNtWosCDQGhXze9b5QwFxsEBertHngBq
 7z5cPTcV0LxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="246495857"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; d="scan'208";a="246495857"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2021 07:37:48 -0800
IronPort-SDR: VxYyMm5DYO2dFW3i9YjRYxvYAh+kxNpPX9T5D2TcED+DkFTdUULuh0UYGV2t3XQ4wHAyMix9iz
 EVUTUyc8OQcg==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; d="scan'208";a="399897846"
Received: from nmkayali-mobl1.amr.corp.intel.com (HELO [10.209.51.117])
 ([10.209.51.117])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2021 07:37:47 -0800
Subject: Re: [PATCH] ALSA: hda: Add another CometLake-H PCI ID
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org, 
 tiwai@suse.de
References: <20210212151022.2568567-1-kai.vehmanen@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d3ba8659-81a6-9a6d-05cb-9be9fac9101a@linux.intel.com>
Date: Fri, 12 Feb 2021 09:37:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210212151022.2568567-1-kai.vehmanen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 2/12/21 9:10 AM, Kai Vehmanen wrote:
> Add one more HD Audio PCI ID for CometLake-H PCH.
> 
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/pci/hda/hda_intel.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 801c5dd25707..7ba665e9272c 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2475,6 +2475,8 @@ static const struct pci_device_id azx_ids[] = {
>   	/* CometLake-H */
>   	{ PCI_DEVICE(0x8086, 0x06C8),
>   	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
> +	{ PCI_DEVICE(0x8086, 0xf1c8),
> +	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>   	/* CometLake-S */
>   	{ PCI_DEVICE(0x8086, 0xa3f0),
>   	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
> 
> base-commit: 03cc2c42871ecf90017cace94bfd1ca5ecaf6e48
> 
