Return-Path: <SRS0=Pn0z=6U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757A4C4724C
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 16:11:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0388A208DB
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 16:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DLgiWPE3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="a9mOjW6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0388A208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D068171D;
	Wed,  6 May 2020 18:10:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D068171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588781475;
	bh=i1dJW1MbmpMVT4xAbM0x5B5et6ZG7XvSlF8vMqLYk2Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DLgiWPE3H+KSHCPH0bqZVJO9Ub7LIs0sUf7hj95AlukDlTyjqJsGFjYIpvjez0Jmh
	 M1I/eoolkR+dIsHP67SxEjcvEZg5tJPARrSb/7JuVE1TZdTCDMlMbHRpSb3VvMVLp0
	 IZCyEdd64Ol5Rx1rDDoTwhfpqSKORDRq7A0yH2gQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD860F80234;
	Wed,  6 May 2020 18:10:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67DE7F80249; Wed,  6 May 2020 18:10:20 +0200 (CEST)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04426F800AD
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 18:10:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04426F800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="a9mOjW6R"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb2e0e00000>; Wed, 06 May 2020 09:08:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 06 May 2020 09:10:10 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 06 May 2020 09:10:10 -0700
Received: from [10.25.100.73] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 May
 2020 16:10:01 +0000
Subject: Re: Re: [RFC] DPCM for Tegra
To: Mark Brown <broonie@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
References: <1588250483-10014-1-git-send-email-spujar@nvidia.com>
 <1jzhalffhh.fsf@starbuckisacylon.baylibre.com>
 <fe842d81-22da-fbbe-b5e2-9872cefb9d8b@nvidia.com>
 <1jwo5pf7de.fsf@starbuckisacylon.baylibre.com>
 <20200506155311.GG5299@sirena.org.uk>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <74e724ec-72c9-e06a-cada-85110c9b145b@nvidia.com>
Date: Wed, 6 May 2020 21:39:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506155311.GG5299@sirena.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588781280; bh=luEZbp/2pQikNm6FKyeutAkc6bT22MBQsDLNbbelIrA=;
 h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=a9mOjW6RuG26hYzX7UOGzVEZDVrreu3mqV6fw12xry5J1FudrZ+vEg9ndnajwE97Q
 UvxZTMPsQg6LlL2Db0Z+bSoHxp2ygtUeO2JxAJauQRWWKt44llawNCjfCIBKFs3gV9
 LWQi1aF3m7ewByj1PsniavquSAbPLxtrLslPRveM122li9gSihnjFuLY6zgfQU7cWR
 9q3+wy/DGpzQCGvM4l5dJxVFoXIXiw/xbo1bnfP7ib1tdfL8cHi5vn8CSW7DXzO6k4
 FdsOiiYA7EtaQXVOjkZW0TCMFSHgwUH8fBYjN60WgW/unKVFhREP9lKoGw470ibQFw
 mhwElpSkq9KhQ==
Cc: viswanathl@nvidia.com, alsa-devel@alsa-project.org, swarren@nvidia.com,
 kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, spujar@nvidia.com, linux-tegra@vger.kernel.org,
 tiwai@suse.com, nicoleotsuka@gmail.com, atalambedu@nvidia.com,
 nwartikar@nvidia.com, thierry.reding@gmail.com, sharadg@nvidia.com,
 digetx@gmail.com, jonathanh@nvidia.com, rlokhande@nvidia.com,
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



On 5/6/2020 9:23 PM, Mark Brown wrote:
> On Wed, May 06, 2020 at 04:47:09PM +0200, Jerome Brunet wrote:
>> On Wed 06 May 2020 at 16:12, Sameer Pujar <spujar@nvidia.com> wrote:
>>> XBAR currently exports all routing widgets which can be used to
>>> interconnect multiple components and thus implements Mux widgets. Fixing
>>> the routing paths in driver would limit anyone to try a different
>>> combination as per the need, unless driver is modified.
>> I did not mean that you should restrict the routing ability of your SoC,
>> quite the opposite actually.

>> You should just expose it correctly
> Yes, it's going to be less effort in the long run if nothing else.

This is what below reference tried to achieve in the original series, 
where all Mux widgets and corresponding kcontrols were exposed.
[1] 
http://patchwork.ozlabs.org/project/linux-tegra/patch/1582180492-25297-6-git-send-email-spujar@nvidia.com/

However it has DAI declarations too, that was mainly because 
codec-to-codec links were used to connect multiple components. DT would 
expose all these links (please note that machine driver was not sent as 
part of the original series). May be with DPCM these additional DAIs can 
be avoided, but it comes with few challenges highlighted in this RFC patch.


