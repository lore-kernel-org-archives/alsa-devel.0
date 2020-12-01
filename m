Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DBAC64E7B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 07:47:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601582087D
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 07:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c0RKJK7Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GO0Hi6Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601582087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B3B01778;
	Tue,  1 Dec 2020 08:46:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B3B01778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606808823;
	bh=lfccHiT2hKPSbm6X+w0wz2IsmKyXgpWCJLyrGZAxXPc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c0RKJK7ZxQ+HVqJfJt+B6bwU1pBsQsRe9/nUSvjJ0Qr8eVT5KlWghkTbOsSExUCeb
	 qCUKvty+rJmgYiCf7NhN3JGIgbEMC0K62kRohGdgPwYbV/s+I7WDJRPAZN1g3YC6/2
	 S1Bkafbq20gy7FEkrQTPFF6Z/txYbt+UatelOpaM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03D04F8016C;
	Tue,  1 Dec 2020 08:46:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7005BF8016D; Tue,  1 Dec 2020 08:46:11 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A2C5F80139
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 08:46:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A2C5F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="GO0Hi6Jj"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fc5f4b80001>; Mon, 30 Nov 2020 23:46:00 -0800
Received: from [10.25.98.41] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 07:45:56 +0000
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: Use OF graph schema
To: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
References: <20201117013349.2458416-1-robh@kernel.org>
 <20201117013349.2458416-3-robh@kernel.org>
 <CAL_Jsq+eOfhDzPV8A_hhGpkY3zpiVAuZ=Y353Ltn61ecCV2Dqg@mail.gmail.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <51a9b84d-ea93-0871-aa93-d9bdf50d5a47@nvidia.com>
Date: Tue, 1 Dec 2020 13:15:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+eOfhDzPV8A_hhGpkY3zpiVAuZ=Y353Ltn61ecCV2Dqg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1606808760; bh=zgYgcsWSQ5ZLwwDEgMwRA/eS3vCY9/kmIKMLZ9mDae8=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=GO0Hi6Jj2/DmYB/GM7YG4wVWTxSL5zvKh3rdOlYAkMDfoxXTT9tzXMCa5qKVQBXQv
 63OxVvG4DLGOIi0JEV7yTSebsgdIfBz50YlRyi1VyIhFEzgRRrtRyqLQ2+Yk13FtxQ
 wP9nlH98FWQI87aSfZTnIQzWazb82o3KcwvFqIBY+4HPMJX8bgA9Y/x8nDAwlprBPU
 rYkIweFAHYPEnfkxi78BildHYhPsRLBL9kzRWIkw+gLqp47h2mKKTLdB3A4vFMo56W
 Xf2ClgFT5s8347OJDLMSkwY0Px7C1sdzyYiRsMyuf3oj4qGLYTXpur6Wma0H4c9YE3
 sYtXLqHS94GQA==
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Lubomir Rintel <lkundrak@v3.sk>
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

Hi Rob,

>> Now that we have an OF graph schema, let's use it for the
>> audio-graph-port schema.
>>
>> There's no need to define 'ports' nodes as specific bindings must define
>> that and port numbering of the child 'port' nodes.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Note that graph.yaml is part of dtschema now intead of the kernel tree.
>> ---
>>   .../bindings/sound/audio-graph-port.yaml         | 16 ++--------------
>>   1 file changed, 2 insertions(+), 14 deletions(-)
> Hold off on applying this. I think graph.yaml is going to need some
> more refinement.

Would this be OK if below part of the patch is submitted separately in 
case above is not immediately planned?

-        required:
-          - remote-endpoint
-

Currently I have dependency on this for series 
https://patchwork.kernel.org/project/alsa-devel/list/?series=391735&state=*. 


>
> The rest should be able to be applied without this patch.
>
> Rob

