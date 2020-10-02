Return-Path: <SRS0=qvVP=DJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38BCC4363D
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:01:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED24920719
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ehr7dFWM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sMvGl79x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED24920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E30A1948;
	Fri,  2 Oct 2020 11:00:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E30A1948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601629279;
	bh=lwgYbZmJFPkAurqNlnXSSgOaaypSaRNIdtsBqZ/LIHY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ehr7dFWM2E5kYQKnxEJUzxpVIy8bL1Aqy/XV+zFCjLaosV8wSxfFnYU0SnZT8PfPU
	 dhjGh4bfOT+9f99pRsZvkih6ZIGmrfP7CUlvLykI97Aedv6PSUruOuro9F5Gpql7Es
	 dZOLxV9H5e3qmUsWn6uzrgoaEwXM6eaph3bSKmhs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B62A9F801ED;
	Fri,  2 Oct 2020 11:00:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 449A2F80247; Fri,  2 Oct 2020 11:00:27 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E36F1F80228
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 11:00:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E36F1F80228
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="sMvGl79x"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f76ec120000>; Fri, 02 Oct 2020 02:00:02 -0700
Received: from [10.25.97.216] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 09:00:03 +0000
Subject: Re: [PATCH v3 07/13] ASoC: audio-graph: Update driver as per new
 exposed members
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
 <1601573587-15288-8-git-send-email-spujar@nvidia.com>
 <877ds9l7xu.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <4e5954f0-992b-5923-ce3c-6ae5d562b2e5@nvidia.com>
Date: Fri, 2 Oct 2020 14:30:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <877ds9l7xu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601629202; bh=oWAlMGZr7e/KMA1zYhU+ALOo7mjETqn4ZiGIG9j4vKw=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=sMvGl79xmGrCX6i92jcB+lTugkyqx8O8vcI0cm7UGuEcphPJVvOVPkKNl2GGVfcGH
 MDRGg4rZIVaEwS6bjPSOm40zS0d/FKepo7xkk/ZmqtjcNp1bgsX2tJaGnpgeVRzGGd
 Y9T+Q1jXhz2NvDN28Qo14paBrjAYY29Oxb9Jr29qfqYhsbTlYc7yX7KC23e1jODG04
 1TkMPPfe0PyZ/4nNPJHpWVvN1KSQKjIlGp1yyeDU5n6Grd+mWBLh+tFDADHt6lZkWD
 BZ5z0pD9MM12lzv6za7kuBgL+qHZGcS3ewsFSoKtySwe7ShYkvu6CdNZ0kH1kdRAAR
 EbXz2FBrex0fw==
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, swarren@nvidia.com, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, linux-kernel@vger.kernel.org, nwartikar@nvidia.com,
 tiwai@suse.com, robh+dt@kernel.org, viswanathl@nvidia.com, sharadg@nvidia.com,
 devicetree@vger.kernel.org, broonie@kernel.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, jonathanh@nvidia.com, rlokhande@nvidia.com,
 mkumard@nvidia.com, dramesh@nvidia.com
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


>> As per the members exposed earlier in the series, audio graph driver
>> is updated to make use of these. Functionally there is no change
>> in behavior if these are not populated. So following changes are made
>> as part of this.
>>
>>   - Update 'dai_link->ops' for DPCM links if a custom 'snd_soc_ops'
>>     is defined by the vendor driver.
>>
>>   - Consider 'force_dpcm' flag status when deciding if a DAI link
>>     needs to be treated as DPCM or not. In doing so the logic is
>>     moved to a separate inline function for a better readability.
>>
>>   - Populate 'dpcm_selectable' flag which is then used to detect
>>     DPCM DAI links.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
> Can we merge [06/13] and [07/13] patches ?

Yes can be merged.
