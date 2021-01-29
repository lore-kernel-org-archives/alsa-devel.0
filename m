Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD36AC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:34:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803E664E05
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803E664E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8F821695;
	Fri, 29 Jan 2021 16:33:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8F821695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611934442;
	bh=8Bsb+jUzeqhDx3Q3jj4kZBYXhVxsSjlLTqjjud0pOjI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lBsNRXVw+avC9SxdgXH/ThoE7Mr9AKiu6rSgmc9MlMbvMJwW3FxPP99Uf5iiweUAM
	 A4Nc875EqCGp2lRzBVqiCrWVIe8CcSEfqmjU33Lt5m+lmD/1jzpGpKFJLuOyIfvjto
	 bDYSCwCDrxroSNu6ffBJtHIFEk8YFAbFFsO5DRUA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32B32F80130;
	Fri, 29 Jan 2021 16:33:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4CFEF80259; Fri, 29 Jan 2021 16:33:10 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE567F80130
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 16:33:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE567F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="FTcrqo5g"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60142aad0003>; Fri, 29 Jan 2021 07:33:01 -0800
Received: from [10.25.100.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Jan
 2021 15:32:56 +0000
Subject: Re: Re: [PATCH 4/8] ASoC: tegra: Select SND_SOC_RT5659
To: Mark Brown <broonie@kernel.org>
References: <1611920470-24225-1-git-send-email-spujar@nvidia.com>
 <1611920470-24225-5-git-send-email-spujar@nvidia.com>
 <20210129124454.GB4560@sirena.org.uk>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <d6cb9252-246e-d6c7-7500-5f1d1823325c@nvidia.com>
Date: Fri, 29 Jan 2021 21:02:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210129124454.GB4560@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611934381; bh=OzerfymOhuaisHcgPqSCtgP5p9kQaPnt6W9XKcUU0Cw=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=FTcrqo5gTDCrcE6Li4KZnaSbeNn/4CafZ3U3i2EmaKEYBBbq2+5djH7yIGAuyVZXT
 IGD9w70NW+A1HYUno2AyvFZhz5SJkw2B5Wyiw+MAhaBWR8kdO9HrzrOb0G80zDrjC5
 Qx1Ly9ZpBx0/oksa/MlTqgiz37FBWhvSp/9Hpw+qIqrbXauNpYEjkbTmG4EP4B3uJ6
 fUNXFoGvjn3UEebCz0yRvQMgz1Vv4JLZfHKtbVEt9RV/ylI6/HA496OBFy4vtZ6kFr
 6jrIYzmWVlrn9ORnEFdCu1sRtJ87owQgJNWZ4RwxYTxO6ed2v/5YHndmuW8kWgE2H8
 5zhw5uT7tEP/A==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 jonathanh@nvidia.com, sharadg@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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



On 1/29/2021 6:14 PM, Mark Brown wrote:
> On Fri, Jan 29, 2021 at 05:11:06PM +0530, Sameer Pujar wrote:
>> Select SND_SOC_RT5659 to verify external audio over Jetson platforms.
>> Jetson AGX Xavier has an on-board RT5658 audio codec and to use this
>> enable required config.
>>
>>   config SND_SOC_TEGRA_AUDIO_GRAPH_CARD
>>   	tristate "Audio Graph Card based Tegra driver"
>>   	depends on SND_AUDIO_GRAPH_CARD
>> +	select SND_SOC_RT5659
>>   	help
> This is a generic device, not something specific to Jetson, why force
> on a driver that may not be required on other boards using this driver?

Yes specific boards using 'SND_SOC_TEGRA_AUDIO_GRAPH_CARD' may require 
'SND_SOC_RT5659'. But there is no platform specific config. Is there a 
better way to enable config 'SND_SOC_RT5659' conditionally?
