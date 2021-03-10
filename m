Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08465C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 17:51:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8D664F7F
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 17:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8D664F7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 293321766;
	Wed, 10 Mar 2021 18:50:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 293321766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615398688;
	bh=o4N6ZKSLN0+xlNuOqMsUpd4bWDTAxvfyNPR1ZGjoZAs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mDPX5TnsvldCbJQe6HSy9a3047/Yf4Ftw0Lahzk3ipFG44tPejAWbisSzOhfLC4xI
	 OvIVrANFqAFrZ1loUufqPoYMfEiIS8JCsXma5uEScmVho6s8Dv6ug+d5mH/KRDsnki
	 +BrRxe2Xh2XKIuW5ggk0vGCBWPR2YwoJH69a99eI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80D04F8014E;
	Wed, 10 Mar 2021 18:50:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1523F8016C; Wed, 10 Mar 2021 18:50:24 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 987E3F8012F
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 18:50:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 987E3F8012F
IronPort-SDR: RMUbj+Cj7fkHwUz8+vluNAnSM/9JHXAOljRoInazb0tzmKaWaC42zzHsBNN5PEsx0P69T/l+6o
 ePbTnbtIH65Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="273564549"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; d="scan'208";a="273564549"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 09:50:17 -0800
IronPort-SDR: b2evOkNO/0UV6Pdj15EO+j1vjXvRxRE4shFbKJsY9eS2FoRoq5gKfFz4l6WnU3f+scbmfAzhk1
 loVURsv0Rv6w==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; d="scan'208";a="403766454"
Received: from huiyingw-mobl.amr.corp.intel.com (HELO [10.212.214.84])
 ([10.212.214.84])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 09:50:15 -0800
Subject: Re: [PATCH V2] ASoC: soc-core: Prevent warning if no DMI table is
 present
To: Mark Brown <broonie@kernel.org>
References: <20210303115526.419458-1-jonathanh@nvidia.com>
 <91480f92-a3f5-e71f-acdc-ea74488ab0a1@linux.intel.com>
 <20210310133534.GD4746@sirena.org.uk>
 <6a2352e6-f2b7-def1-de58-52fbeb7846e5@linux.intel.com>
 <20210310161814.GA28564@sirena.org.uk> <s5hzgzbvube.wl-tiwai@suse.de>
 <9b073d01-f2fe-a99b-e53c-4a0b3f95ca05@linux.intel.com>
 <20210310165235.GD28564@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cf03ce61-1501-e0e7-6887-d921c7d1af62@linux.intel.com>
Date: Wed, 10 Mar 2021 11:50:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310165235.GD28564@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>
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



On 3/10/21 10:52 AM, Mark Brown wrote:
> On Wed, Mar 10, 2021 at 10:41:18AM -0600, Pierre-Louis Bossart wrote:
> 
>> would this work?
> 
>> if (!IS_ENABLED(CONFIG_DMI))
>>      return 0;
> 
> Build time dependencies aren't going to help anything, arm64 (and to my
> understanding some future x86 systems, LynxPoint IIRC) supports both DT
> and ACPI and so you have kernels built with support for both.

well, that's what I suggested initially:
        if (is_of_node(card->dev->fwnode))

I used the of_node test as a proxy for 'no DMI' since I am not aware of 
any means to detect if DMI is enabled at run-time.

