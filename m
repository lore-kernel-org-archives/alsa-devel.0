Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DABCC43461
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:35:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D2621D43
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G2ktMNUl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I2wKJ8ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D2621D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F29A816E0;
	Wed,  9 Sep 2020 13:34:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F29A816E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599651307;
	bh=AW9aCEppQ1PWe1ui8WdhRnuH6phLokycYeAIW79/LBA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2ktMNUlw3G5cJyRuy7tRywtC9qyxHEBJj/MSziszZyoGbHGysFi2g7YLaIExcqGp
	 fkcUFYh3p9R130rGfNFmF1hmhEgqZLxO5UY080wxilOOt9TBfSPsqkC41XmrDa/plg
	 3mTXHgilBGb2/RZfAztsHg4DCNJW5JMLObit0U1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47654F8021C;
	Wed,  9 Sep 2020 13:34:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17E90F80227; Wed,  9 Sep 2020 13:33:50 +0200 (CEST)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 881A4F8015F
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 13:33:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 881A4F8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="I2wKJ8ZN"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f58bd060000>; Wed, 09 Sep 2020 04:31:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 09 Sep 2020 04:33:33 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 04:33:33 -0700
Received: from [10.25.101.11] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 11:33:30 +0000
Subject: Re: More Generic Audio Graph Sound Card idea
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
References: <87k0xszlep.wl-kuninori.morimoto.gx@renesas.com>
 <20200821121844.GF4870@sirena.org.uk>
 <878se4zybn.wl-kuninori.morimoto.gx@renesas.com>
 <87d032mnfo.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <2e96d353-e1e9-2f6b-cf51-9ba993d6c4ea@nvidia.com>
Date: Wed, 9 Sep 2020 17:03:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87d032mnfo.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1599651078; bh=I/ZlyI6SgWUUEeJG8CljIdhyF3KptJM49/tx7irv6to=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=I2wKJ8ZNVSOnfvHkCYlfusPE0JJrrPvkOelG6qbQFhn73ZVCgqM1WwF40kauPMQ0l
 00Q+9q8XVBlX2M57sbf4M6h/j6O3aAs23nVN+kaVmrl1U2JzePYOyPGspvwAkGpz8d
 Lc60Xcp2kfDth0KUKTCFEHfO5rUigQJ5qAhXTCLrbev/1Z+kn63PKdCAZeXxP6X9G1
 H1O3+3eAAuDbyIKDdxMScVbckz0d1ddhyaPFKra+KrMsABGzxq1zuutI8HClR1jqTJ
 UFQ6IAfxrV7+DRxR1O8ePrUYv72AUn7kjqBOz//lEBdVIMkfFeS5kdimzIi7RK8+Zw
 SkXa0KvsVYukw==
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Hi Mark, Morimoto-san,


>>> Having an audio-graph-card2 isn't ideal but may be required at least
>>> during development :/  Ideally we'd be able to have the new driver parse
>>> both binding formats (or rather, have the new binding format be new use
>>> cases for the same binding format) and only use -card2 while it's in
>>> development.
>> If you want to update current audio-graph-card without creating new
>> audio-graph-card2, I'm OK about it. But need adjusting / agreement.
>>
>> Current audio-graph-card "DSP" user is only me, and I'm using it only locally.
>> Thus upstream doesn't get damage if I removed "audio-graph-scu-card"
>> (= DSP use case) support.
>>
>> OTOH, Sameer is posting patch for "-cc-" support. If it was accepted
>> and he used it on upstream (= on tegra),
>> keeping compatibility will be very difficult and/or code will be very confusable.
>>
>> If Sameer can OK and wait new audio-graph-card, maybe we have no compatibility issue.
>> But in such case, 1st version of new audio-graph-card might be not enough for him.
>> Sameer need to waiting / testing / adjusting / etc, etc...
> The problem I'm feeling is that new card (= let's call it as card2 here) and
> Sameer's posting "-cc-" are conflicted / no-compatibility.
> It expands card1 DPCM detection.
>
> The good things having "-cc-" is that he can use it immediately.
> the bad things is that it is dificult to keep compatibility between "card1 + -cc-" and "card2".
>
> Creating card2 for development purpose is very welcome for me, and card1 user :)
> But after that, if we want to merge card1 and card2, we need to drop "-cc-" support unfortunately.
> If we want to keep "-cc-", we need to have both card1 / card2.
>
> So, how to handle it ?
>
>
Need your help for clarity on above. Currently I cannot publish v3 for 
[0] unless above is resolved.

[0] https://lkml.org/lkml/2020/8/5/42

Thanks,
Sameer.
