Return-Path: <SRS0=/b47=CC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE82C43460
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 06:35:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804F023110
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 06:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cu5SXl/r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VcDPIq6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804F023110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2C8215F2;
	Mon, 24 Aug 2020 08:25:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2C8215F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598250401;
	bh=bu4S1o0t1k67wd6jkLrUvVbUkgHzYTQDQHw64cM1iYI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cu5SXl/rj41iulCPqGrCFfs08/DpZL3WtoA4sbzmZFgDhNQwh1kuFWgeuYmglA9ki
	 c2RgW14yIxfih0n18HifAdruJRTm1MOd1CtvAzUgcJPI73guqeQT2Y9S1z/Ba+ZKNZ
	 yxSkmMBEc6bP6Ptr5L1tAfvMPRgXmic99TRB3CKw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 822D1F8016F;
	Mon, 24 Aug 2020 08:25:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85A37F801D9; Mon, 24 Aug 2020 08:25:48 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0900F8013D
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 08:25:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0900F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="VcDPIq6o"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f435d1f0000>; Sun, 23 Aug 2020 23:24:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sun, 23 Aug 2020 23:25:32 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sun, 23 Aug 2020 23:25:32 -0700
Received: from [10.25.97.151] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 06:25:29 +0000
Subject: Re: More Generic Audio Graph Sound Card idea
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
References: <87k0xszlep.wl-kuninori.morimoto.gx@renesas.com>
 <20200821121844.GF4870@sirena.org.uk>
 <878se4zybn.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <58220f32-0b3e-d666-5bb0-bbeae27f6aab@nvidia.com>
Date: Mon, 24 Aug 2020 11:55:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878se4zybn.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1598250271; bh=yjoar7lifL7A5b9THjEuNgsg0t4LhT07x3ZGR5CbQBo=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=VcDPIq6ozceVNwKF3bXIGb8X9kMZE4ufZRJ8aCGhCHJZ0jWwG5ylsTE4n6QyT4SWp
 VJn+kE2HL3DliY8TRzY2JxFqOublqSBt/zhWsd0yjDGzGrfSqjalK8Yqn+AwFDulEZ
 VUXELJ1FCwcMGlmbKEPQMAZeGnNnUT/SaB7uJHqJMg5NzqTRfSBj0vslGYrlA8eAjo
 2PF/oggF3nCaTgXdmGdcM3JJ6pcpgnwnj9m4U/wpq1jxKiqgoLHn7wfFobESWinhwx
 zJWTF4S7rBMu3OX64I8P/TH5Khn/ppCDMM6SGcsejXoOdnt1ncA0QiRuZAXga4kW5J
 99E+QBrCOmPxg==
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

Hi Morimoto-san,

On 8/24/2020 5:55 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Mark
> Cc Sameer
>
>> Having an audio-graph-card2 isn't ideal but may be required at least
>> during development :/  Ideally we'd be able to have the new driver parse
>> both binding formats (or rather, have the new binding format be new use
>> cases for the same binding format) and only use -card2 while it's in
>> development.
> If you want to update current audio-graph-card without creating new
> audio-graph-card2, I'm OK about it. But need adjusting / agreement.
>
> Current audio-graph-card "DSP" user is only me, and I'm using it only locally.
> Thus upstream doesn't get damage if I removed "audio-graph-scu-card"
> (= DSP use case) support.

> OTOH, Sameer is posting patch for "-cc-" support. If it was accepted
> and he used it on upstream (= on tegra),
> keeping compatibility will be very difficult and/or code will be very confusable.
>
> If Sameer can OK and wait new audio-graph-card, maybe we have no compatibility issue.
> But in such case, 1st version of new audio-graph-card might be not enough for him.
> Sameer need to waiting / testing / adjusting / etc, etc...

The series [0] introduces small deltas to resolve issues I am facing. As 
you see, most of the implementation is unchanged for the graph-card 
driver. Hence I am not sure if we need a new driver now. If at all it 
gets complicated in future, the "-cc-" compatible can be moved to new 
driver? Please note that the new "-cc-" compatibility is added to 
address following and some of these are discussed in [1].
- DPCM usage with component model (where there can be N number of 
components available and M (<= N) of them can be connected together to 
form an audio path). For example the path would be like,
FE -> BE_1 -> BE_2 -> ... -> BE_M.
- I am extending dpcm_path_get() for this reason and DAI ops get called 
for all connected components.

[0] https://lkml.org/lkml/2020/8/5/42
[1] https://lkml.org/lkml/2020/4/30/519
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

