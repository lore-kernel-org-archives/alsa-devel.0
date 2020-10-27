Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF60C55179
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 06:05:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1BC207BB
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 06:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RKFbkXbn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D3DUonb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1BC207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 759D31689;
	Tue, 27 Oct 2020 07:04:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 759D31689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603778700;
	bh=yCJkYl3yrlRSFGXgo8G/f5269t/0Tgfkz+ytyxmRiIA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RKFbkXbn2+z08nh471EAuNbjL1naEhyEdIeOUBxJE1ylAP++E7lGhxeqZNcKAhE+0
	 AslGckaJyZeENsxETqmoE35VrI5k7PTjoWjBXjIUVZmqdtX5W5WgkhfWJAmbZdOHo8
	 5XDRKWVj4gbp4kP+rW53dTy/zVnIUu1JWosqrpuA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AFBDF801D8;
	Tue, 27 Oct 2020 07:04:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02306F80086; Tue, 27 Oct 2020 07:04:06 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A8CEF8019D
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 07:03:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A8CEF8019D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="D3DUonb4"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f97b84f0000>; Mon, 26 Oct 2020 23:03:59 -0700
Received: from [10.25.99.37] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 06:03:52 +0000
Subject: Re: [PATCH v3 1/3] ASoC: dt-bindings: audio-graph-card: switch to
 yaml base Documentation
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <87a6wfay7t.wl-kuninori.morimoto.gx@renesas.com>
 <878sbzay6u.wl-kuninori.morimoto.gx@renesas.com>
 <75ca7528-3177-46cb-73c5-46e32e63ad44@nvidia.com>
 <87h7qgw848.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <eba1f18a-0b2e-d52b-593a-9ef5304f9199@nvidia.com>
Date: Tue, 27 Oct 2020 11:33:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7qgw848.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603778639; bh=j5+Ddn/F47IduMD7D47vsNvoRG9UFowAZei94y/ho/4=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=D3DUonb4PTxHrjJnyPM11NJIK257d4N2PhCaZ/jFn56di3CkO5DaKQJf3/gqv+9go
 mWXSiDquNXbUqJ/0KfhTtsIiejMgJmOGOfZit3UwLGMYaf+Kj9F5Pa/QBmusaWgJx0
 ggkPeUCpnnYXTYGFcMUddfNYELSglMAR9miqfmyAZNbJ+/sFqbxrRCR0h2Pl16bqST
 ZRDQiHdvH+lvt7/dOXdIR/xAEMv11g3Cw+iEMZbZPzXXz4lyGiclasEd1zftEwh2n/
 KAaczMJqG+b7dmq9XIrldnLwxSGTNLKYCGRqInDornWengyQhw1QdqugHLgpbsA6r8
 Rky2FoXC18Myg==
Cc: devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org
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

Hi Morimoto-san,

>>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>
>>> This patch switches from .txt base to .yaml base Document.
>>>
>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> (snip)
>> Since I am trying to re-use most of audio-graph for Tegra, can
>> 'compatible' be moved to a separate schema?
>> For example,
>> audio-graph.yaml -> defines all the common stuff
>> audio-graph-card.yaml -> audio-graph.yaml + 'compatible' property
>> Similarly, tegra-audio-graph-card.yaml -> audio-graph.yaml + Tegra
>> 'compatible' property
> I'm not expert of Json-Schema, and it sound very expert technique for me.
> (It always indicates me unknown errors...)
> I'm posting this patch since many month ago, and not yet accepted
> for many reasons (audio-graph DT is very complex).
> I spend many times for it and finally come to the point where it
> can (might) be accepted.
> I'm sorry but I want to finish this work,
> this means I don't want to customize it any more.
> If I try it, it needs more month...

I am not a json-schema expert either :) From earlier comments on Tegra 
audio graph series, above re-use is possible I suppose. I depend on your 
audio-graph documentation and for 'compatible' I am seeing error. So I 
thought it may be fine to split audio-graph into two json-schemas now 
itself. Otherwise I need to do it separately in my series if I want to 
re-use your audio-graph, which is fine with me.
