Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE11C4363A
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 06:16:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4299D207C3
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 06:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XS9SMtCy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bb/IMcgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4299D207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A74A169C;
	Tue, 27 Oct 2020 07:15:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A74A169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603779378;
	bh=vSd1RXftkeGB2tKOn3DZGc1Y++3wPLoXC7ZrsKxSaUc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XS9SMtCy0Z1K1xvne6n2BfdMYGMNUdKBFepbfaZToSjQKsY8e3erwV9G+brFz93F9
	 Yr+il5oysK9hxKlutcIkUjvOTKKZtaNdS0MA0LoHlQaQ/6uxxuwAhTAYLcbZaDBpXU
	 fcR417JkCXWTAACrelESTa/Nv77pzxeX7txl2HQU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 941D8F801D8;
	Tue, 27 Oct 2020 07:15:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EF87F8020D; Tue, 27 Oct 2020 07:15:26 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11C1DF8019D
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 07:15:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11C1DF8019D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Bb/IMcgX"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f97bafa0001>; Mon, 26 Oct 2020 23:15:22 -0700
Received: from [10.25.99.37] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 06:15:12 +0000
Subject: Re: [PATCH v3 1/3] ASoC: dt-bindings: audio-graph-card: switch to
 yaml base Documentation
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <87a6wfay7t.wl-kuninori.morimoto.gx@renesas.com>
 <878sbzay6u.wl-kuninori.morimoto.gx@renesas.com>
 <75ca7528-3177-46cb-73c5-46e32e63ad44@nvidia.com>
 <87k0vcw9zd.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <b4beff3d-2109-7c86-67ad-01071e023f79@nvidia.com>
Date: Tue, 27 Oct 2020 11:45:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0vcw9zd.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603779322; bh=m8eIVXpohAhKwVK7bdPj1gb28+PpYlPtv35EBNssb2o=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=Bb/IMcgXP7YwciqUeFXmYtZAvmHezu3WC2LSWvhz5fK8r6hY/1noRevxG/bBsQyLg
 Ynizs1N1iTcwPcpNnLNo1nX3RFIRrMYK0Fw/ASAflTayJiX3fUnzC+zYF9gBAj+zbv
 6I8syh1u70wFVcnV4mMCCRyTrFi2vSVbLGEBQI8sjS+fQAA8OHVaOHvjPDYzmebmGI
 iGhL0EOySCNE5yf7DWl10eUwHJmESz/pC+8FNBZMC4NptQY/aIjayIEGyoTJZ5IVvA
 u1099Y2Ym49hcJ5KeHRtAzg9Dve87Ns7bTdGcJGnyQFWPUGcMCRczpNtdUelkaj2p6
 nFFxEgkGQwQ1g==
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
>>> ---
> (snip)
>>> +additionalProperties: false
>>> +
>> This needs to be true when other files want to reference this schema
>> and/or define some additional properties.
> *Current* audio-graph-card doesn't assume such case.
> I think you need to update it when you support tegra-audio-graph
This would be applicable when we want to split audio graph documentation 
into two schemas now itself. May be I will do this in my series.
