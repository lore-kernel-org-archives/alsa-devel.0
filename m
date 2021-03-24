Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E54C433C1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 18:35:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B9061A07
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 18:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B9061A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B8BF15E0;
	Wed, 24 Mar 2021 19:34:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B8BF15E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616610936;
	bh=jTMgjoze1YIV7jw/ExZeJkhD7cCSOjq3gE1YSK2uvnE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RpqxTHRVwidOnhXbs3JNhUWo82n6oODUuZadvSYlQS9VzK4O9RicTlqHWHJSAKYvb
	 VLqtpVjbl7xfJlxTL5KRACu8WY2hEcu+76VNU2JuaH/Prz6vZy3BDaizKClBEMBAYV
	 oejnOUxriONIq+0OGp2bu/uY6qscirutm69ggsvo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21CEEF80156;
	Wed, 24 Mar 2021 19:34:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C52DF8016B; Wed, 24 Mar 2021 19:34:42 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1371F80104
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 19:34:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1371F80104
IronPort-SDR: aWYnHcknZ8IL9rz/XOEfU8faHTDh15ETevJBQIhAThz0UYpV0hhbr/91LQNbncPPUqdSd2Slrb
 JWcFfbX+04Kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177882213"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="177882213"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 11:34:30 -0700
IronPort-SDR: DBGGqH/ddT71uKvj9eCeEkB5CEzLGE8F3KVq0bHk39sEFvsMn2lt5SgyPfd/X/vuEwaDQ9gG0o
 h9AUcDRbK+Ig==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="436130475"
Received: from jmtabang-mobl2.amr.corp.intel.com (HELO [10.213.166.106])
 ([10.213.166.106])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 11:34:29 -0700
Subject: Re: [PATCH 1/2] ASoC: Intel: kbl: Add MST route change to kbl machine
 drivers
To: vamshi.krishna.gopal@intel.com, alsa-devel@alsa-project.org
References: <20210324175200.44922-1-vamshi.krishna.gopal@intel.com>
 <20210324175200.44922-2-vamshi.krishna.gopal@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2ee1a18e-8771-b8f7-0452-f96403bd7fe4@linux.intel.com>
Date: Wed, 24 Mar 2021 13:34:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324175200.44922-2-vamshi.krishna.gopal@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: harshapriya.n@intel.com, sathya.prakash.m.r@intel.com, broonie@kernel.org,
 biernacki@google.com, pierre-louis.bossart@intel.com
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


> diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> index dc3d897ad280..1d6b2855874d 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> @@ -91,7 +91,9 @@ static const struct snd_soc_dapm_widget kabylake_widgets[] = {
>   	SND_SOC_DAPM_SPK("Spk", NULL),
>   	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
>   	SND_SOC_DAPM_SPK("DP", NULL),
> -	SND_SOC_DAPM_SPK("HDMI", NULL),
> +	SND_SOC_DAPM_SPK("HDMI1", NULL),
> +	SND_SOC_DAPM_SPK("HDMI2", NULL),
> +	SND_SOC_DAPM_SPK("HDMI3", NULL),

that seems consistent with other BXT/KBL machine drivers, but...

>   	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
>   			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
>   			SND_SOC_DAPM_POST_PMD),
> @@ -108,9 +110,6 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
>   	{ "MIC", NULL, "Headset Mic" },
>   	{ "DMic", NULL, "SoC DMIC" },
>   
> -	{ "HDMI", NULL, "hif5 Output" },
> -	{ "DP", NULL, "hif6 Output" },
> -

... this doesn't:

other machine drivers use this:

	{"HDMI1", NULL, "hif5-0 Output"},
	{"HDMI2", NULL, "hif6-0 Output"},
	{"HDMI2", NULL, "hif7-0 Output"},

And if you start changing HDMI support, you should also fix the other 
machine drivers that used the same pattern, e.g.

kbl_da7219_max98927.c\0129:	{ "HDMI", NULL, "hif5 Output" },
kbl_rt5663_max98927.c\0214:	{ "HDMI", NULL, "hif5 Output" },

>   	/* CODEC BE connections */
>   	{ "HiFi Playback", NULL, "ssp0 Tx" },
>   	{ "ssp0 Tx", NULL, "codec0_out" },
> 
