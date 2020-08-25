Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFFFC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:54:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047F02071E
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ucjNORyd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fsLiRzQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047F02071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72AFE1655;
	Tue, 25 Aug 2020 07:53:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72AFE1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598334865;
	bh=UXnpxOmxm4BmEIzewg4CS4gTJglvQ3ycj57RxxAGu4g=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ucjNORydqLKLhrB2Apw7KzEJ2x74h8Mypv6mPoLpmDZ8cprcbpo32fyRZ2X+lW0kZ
	 1knKzQJHiozRpeEAcxz1eBvZ03wghjkEMshmuJoj3cpGEo7NFpGpJf2jjbrlp6FGoz
	 otkLLBjD6Asz+Ut2XiU1tn6hWvQK5jbJ1+e/xd4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73D74F80245;
	Tue, 25 Aug 2020 07:53:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86B30F8025A; Tue, 25 Aug 2020 07:53:32 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20997F800D1
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 07:53:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20997F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="fsLiRzQw"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f44a7130000>; Mon, 24 Aug 2020 22:52:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 24 Aug 2020 22:53:21 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 24 Aug 2020 22:53:21 -0700
Received: from [10.25.97.151] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 05:53:15 +0000
Subject: Re: [PATCH v2 3/9] ASoC: audio-graph: Identify 'no_pcm' DAI links for
 DPCM
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1596605064-27748-1-git-send-email-spujar@nvidia.com>
 <1596605064-27748-4-git-send-email-spujar@nvidia.com>
 <87pn7ofs19.wl-kuninori.morimoto.gx@renesas.com>
 <97f325a6-96cc-11c5-8027-8c0a159e3da0@nvidia.com>
 <2d3aa11e-3c56-1f7a-3d41-2457f973d55b@nvidia.com>
 <87sgcbwcnf.wl-kuninori.morimoto.gx@renesas.com>
 <14691a05-cb29-a030-0e72-eca900d8eb7e@nvidia.com>
 <87o8mzwajg.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <e9698ac3-0a2e-08a2-3f78-b0be0069d6ee@nvidia.com>
Date: Tue, 25 Aug 2020 11:23:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8mzwajg.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1598334739; bh=bOJlbPEDP7bzEfLTN1ma/hpFcaswtMKhxhFtn3X3KB0=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=fsLiRzQw2KhMMRuKJolVunTD28eXxVDQEasbWsBseJFOJDgUaSFnunqKtJ3hBvnjb
 E7KH1w1J+OjQ3pxSZXZpO+ndOwCuK0G2/xn5odTxVE055PvSbW4ECgZOPS2OGsbbH7
 rOTlyUpcq+sthGswphFXGjEDvltPYqQKPUEiDY1CgM3MnLEhYtWEBV2/wZxieSF4SN
 ezxBnh4qVgtV983svcZeEKtOAZxdKwbwbVIe0utHlM7kG0Oq8ssLOsvFEAUnDYnjBO
 b/eNGzTOIAnxUbM7fpNZ8m4Rvv7XVXAdZ1hImwviKGkkc2sFPkgiMHW91zdOI1622/
 erQHqP+NaoXCg==
Cc: jonathanh@nvidia.com, nicoleotsuka@gmail.com, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, swarren@nvidia.com, linux-kernel@vger.kernel.org,
 nwartikar@nvidia.com, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com,
 viswanathl@nvidia.com, sharadg@nvidia.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
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

Hi Morimoto-san,

>>> Yes, I'm posting fixup patch.
>>>
>>>           https://patchwork.kernel.org/patch/11719919/
>> Just curious that why snd_soc_find_dai() itself cannot be protected,
>> instead of leaving this to callers.
> Because, snd_soc_find_dai() is called both with/without client_mutex.
> (same/sof are calling it with mutex, simple-card/audio-graph are calling without mutex)
>
> Other solution is create both snd_soc_find_dai_with_mutex()/without_mutex().
> I'm not sure which style is best.

I don't know how complex it is to have a unified solution. But if we can 
protect snd_soc_find_dai() itself, things would be simpler may be in 
long term. Right now there are separate source files for soc-core, 
soc-dai and soc-component, but because of two approaches looks like the 
function need to be moved around and need to be placed in soc-core. Also 
the issue might go unnoticed if LOCKDEP is not enabled.

May be start with a wrapper for now and eventually unify?

Thanks,
Sameer.

