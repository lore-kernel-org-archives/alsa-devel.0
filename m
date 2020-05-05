Return-Path: <SRS0=O8MK=6T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C20AC47254
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 21:38:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E9620721
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 21:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eBkf9RhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E9620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6009171F;
	Tue,  5 May 2020 23:37:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6009171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588714728;
	bh=bjztD8TC/SQCyw6i3lyw+0Y5CnwWYtvQlVkUHMNQnkc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eBkf9RhEh+vpTt9ttPJQM77gDkukdm6enU1CUp3HFZ5f1DO4fAhNM7Wr3Zcv2vPB3
	 yhd6iTmS16eUpMEbEmk3Cm/zkGVQNhBOTIxLYO8ZKHfpyqfZ3tkeNpaMCqE8/QhFzy
	 Qb4BmtKEyGXrF5hazjMDUiaPPIhhYYCiAHPshQC8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57223F8015B;
	Tue,  5 May 2020 23:37:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1769EF8015F; Tue,  5 May 2020 23:37:55 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE95FF800AD
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2020 23:37:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE95FF800AD
IronPort-SDR: DlbRLDysxWZKSyKC+x2fmQD8zE90dUvy9L52zoiwb/B0cHbkk/1NHmppvoeKlPl4JWWyMDK3U9
 XaGajiWmCSzw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 14:37:43 -0700
IronPort-SDR: P5AEYaNTz4fsEDKgt5psjCxQ1CzS4Ux+L5LE8yhmf/wceQgV3j5swCHADsPLsWnxndvDL5dm2/
 Vu8f0Yq3ffOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; d="scan'208";a="278017251"
Received: from krogers-mobl1.amr.corp.intel.com (HELO [10.255.229.42])
 ([10.255.229.42])
 by orsmga002.jf.intel.com with ESMTP; 05 May 2020 14:37:42 -0700
Subject: Re: [PATCH 13/14] ASoC: amd: RN machine driver using dmic
To: Alex Deucher <alexdeucher@gmail.com>, alsa-devel@alsa-project.org,
 broonie@kernel.org, vijendar.mukunda@amd.com, tiwai@suse.de
References: <20200505205327.642282-1-alexander.deucher@amd.com>
 <20200505205327.642282-14-alexander.deucher@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <262fb234-f940-d3be-4a9b-9f3263cced54@linux.intel.com>
Date: Tue, 5 May 2020 16:37:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505205327.642282-14-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Alex Deucher <alexander.deucher@amd.com>
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



> +static int acp_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct acp_pdm *machine = NULL;
> +	struct snd_soc_card *card;
> +
> +	card = &acp_card;
> +	acp_card.dev = &pdev->dev;
> +
> +	platform_set_drvdata(pdev, card);
> +	snd_soc_card_set_drvdata(card, machine);
> +	ret = devm_snd_soc_register_card(&pdev->dev, card);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"snd_soc_register_card(%s) failed: %d\n",
> +			acp_card.name, ret);
> +		return ret;
> +	}
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"snd_soc_register_card(%s) failed: %d\n",
> +			acp_card.name, ret);
> +		return ret;
> +	}

copy-paste mistake here, the same block appears twice?

> +	return 0;
> +}
> +
> +static struct platform_driver acp_mach_driver = {
> +	.driver = {
> +		.name = "acp_pdm_mach",
> +		.pm = &snd_soc_pm_ops,
> +	},
> +	.probe = acp_probe,
> +};
> +
> +static int __init acp_audio_init(void)
> +{
> +	platform_driver_register(&acp_mach_driver);
> +	return 0;
> +}
> +
> +static void __exit acp_audio_exit(void)
> +{
> +	platform_driver_unregister(&acp_mach_driver);
> +}
> +
> +module_init(acp_audio_init);
> +module_exit(acp_audio_exit);

module_platform_driver(acp_mach_driver) does all this __init and __exit 
for you.

> +
> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRV_NAME);
> 
