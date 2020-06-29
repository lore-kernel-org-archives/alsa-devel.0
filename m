Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEA2C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:30:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDD822597
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TJdSE0KI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jv2lz5H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDD822597
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E8B2846;
	Mon, 29 Jun 2020 19:29:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E8B2846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593451830;
	bh=E5kNIoniva59sSrWaXeaNlZX3pmbRp9mWpARj6EJvRs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TJdSE0KItea1eK9RxRrdjMV1i08ChrsjgTZeljweN22CzVQ7QEP/dT8J7Fjs/RL8z
	 Rmiqa6C79WBe1Uqoxm3uUIl5ud/h3vQzFK6Y5xLfKkqLp4zaJRFlzpqzL3pGvC/yhk
	 Jo+YXtKcflvuXEmtMsEKKJ+9kwCxSVD+Yj7dMLQk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 931E9F800BA;
	Mon, 29 Jun 2020 19:29:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A4F6F8020C; Mon, 29 Jun 2020 19:29:36 +0200 (CEST)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A97EAF800BA
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 19:29:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A97EAF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Jv2lz5H9"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efa24980000>; Mon, 29 Jun 2020 10:27:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 29 Jun 2020 10:29:30 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 29 Jun 2020 10:29:30 -0700
Received: from [10.25.103.164] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jun
 2020 17:29:20 +0000
Subject: Re: [PATCH v4 16/23] ASoC: soc-pcm: Get all BEs along DAPM path
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-17-git-send-email-spujar@nvidia.com>
 <871rly1wem.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <d45bf2fc-3baa-fd68-4d96-345ab7b99df9@nvidia.com>
Date: Mon, 29 Jun 2020 22:59:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <871rly1wem.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593451672; bh=VngQ8+Vmfzw1t09YiyiqerLv/mWB5JEXAQux2nHccrU=;
 h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=Jv2lz5H9kDXCcAWkYYs5hZM0NYd+3onwc+585S9DakRaHHx/t/LOpP+rd/KNOLsoz
 OTYjJIhz2oUDmDPaIG6xqdV1cskod1HL9KDOI5VInL+3RbBoGgOAyxNgRygOca9cr0
 pgV7//H4S4IWitR/1BCkmRU3YH4zbE7GUqHYd8NdXyHYI8KpNr8zo0VCzuWLMh21as
 0a1RA8Kmd4WT/3BRJSc7aYao9U7IuW5tmtOLV37hdQ6YB+i03Zrc7w4qEXAC4MgF+K
 GHpFGcGeQJlvHxD0oYDxJk+aoolbQ3jirK4U7mgrEVKG1RvPaW7zk/S3rl8DMx8KNc
 6pmn4s6Fc8iLg==
Cc: jonathanh@nvidia.com, nicoleotsuka@gmail.com, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, swarren@nvidia.com, linux-kernel@vger.kernel.org,
 spujar@nvidia.com, nwartikar@nvidia.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, tiwai@suse.com, viswanathl@nvidia.com, sharadg@nvidia.com,
 broonie@kernel.org, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 digetx@gmail.com, rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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



On 6/29/2020 7:11 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>> dpcm_end_walk_at_be() stops the graph walk when first BE is found for
>> the given FE component. In a component model we may want to connect
>> multiple DAIs from different components. A new flag is introduced in
>> 'snd_soc_card', which when set allows DAI/component chaining. Later
>> PCM operations can be called for all these listed components for a
>> valid DAPM path.
> (snip)
>> @@ -1069,6 +1069,7 @@ struct snd_soc_card {
>>        int num_of_dapm_widgets;
>>        const struct snd_soc_dapm_route *of_dapm_routes;
>>        int num_of_dapm_routes;
>> +     bool component_chaining;
> snd_soc_card has many /* bit field */ variables.
> Please use it instead of bool.

OK, will use.
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

