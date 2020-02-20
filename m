Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9730EC11D05
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:17:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B3E208CD
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cSH1uW5P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dg+NdGs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B3E208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71EB716C7;
	Thu, 20 Feb 2020 16:17:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71EB716C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582211871;
	bh=h+ZJeFbRNh2AGJAllCxTv7sFYFkW6XkjMkhExmn5l9o=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cSH1uW5PZfDKjMkRM3Ob2lQAgYqOESuiiIJd3ryc3gLh3L2Jau38CAbpPyN8uuqYH
	 r0+7HaUe8jKVsWiCmBrHbLdA8RmDz6oc1zk3f5AYhlNIZ7DSTBqV65OyV4zGSrMQij
	 IXeDdfVRyVqwmE4oLTjzAh8DW2wmfZuwTrRkuUyA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9A50F80145;
	Thu, 20 Feb 2020 16:17:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1144BF80148; Thu, 20 Feb 2020 16:16:59 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA9C4F80114
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 16:16:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA9C4F80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="dg+NdGs1"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4ea29d0000>; Thu, 20 Feb 2020 07:15:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 20 Feb 2020 07:16:53 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 20 Feb 2020 07:16:53 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 15:16:50 +0000
Subject: Re: [PATCH v3 07/10] ASoC: tegra: add Tegra210 based ADMAIF driver
To: Sameer Pujar <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-8-git-send-email-spujar@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <995e806f-e5be-cb17-3660-93caa627e8e9@nvidia.com>
Date: Thu, 20 Feb 2020 15:16:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-8-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582211741; bh=+sa5Zfhg7sZegJxxsD1lRhsDyJDuz5MxqEfd/IWF328=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=dg+NdGs1RsXzpnF7JjXzRn6Uz5Vo6B5aTTATAh78j+BdqHfezmvnrTeRjOTuQKZwD
 t7kJLC04loNxljRxrK6zZh8/QVZ4AA6eZhIIYxg3iiQo03WTAakLTeKQoH87xkvStq
 f4S+b4NgfjQiUa4s8BRwqnKK0gwCzfdVOmsUV8Dhn75kO9ekEx7bHiOcapBGvrgejk
 PpdkV14X6L4EJ4hqK1gbD2fOwo6ew6sG+Jec1MEE0b6OrITbR32TW755kAmYNrszXS
 ZaeOdWdck+zyKBBvKb7zVrAV3k/8XfcABlx6sm1sRoMX0un5XbuVLopcHb0LnOCUjj
 zv92pxJVvHMng==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 viswanathl@nvidia.com, sharadg@nvidia.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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


On 20/02/2020 06:34, Sameer Pujar wrote:
> ADMAIF is the interface between ADMA and AHUB. Each ADMA channel that
> sends/receives data to/from AHUB must intreface through an ADMAIF channel.
> ADMA channel sending data to AHUB pairs with an ADMAIF Tx channel and
> similarly ADMA channel receiving data from AHUB pairs with an ADMAIF Rx
> channel. Buffer size is configuranle for each ADMAIF channel, but currently
> SW uses default values.
> 
> This patch registers ADMAIF driver with ASoC framework. The component
> driver exposes DAPM widgets, routes and kcontrols for the device. The DAI
> driver exposes ADMAIF interfaces, which can be used to connect different
> components in the ASoC layer. Makefile and Kconfig support is added to
> allow to build the driver. The ADMAIF device can be enabled in the DT via
> "nvidia,tegra210-admaif" compatible binding.
> 
> Tegra PCM driver is updated to expose required PCM interfaces and
> snd_pcm_ops callbacks.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/tegra/Kconfig           |  12 +
>  sound/soc/tegra/Makefile          |   2 +
>  sound/soc/tegra/tegra210_admaif.c | 884 ++++++++++++++++++++++++++++++++++++++
>  sound/soc/tegra/tegra210_admaif.h | 164 +++++++
>  sound/soc/tegra/tegra_pcm.c       | 222 +++++++++-
>  sound/soc/tegra/tegra_pcm.h       |  23 +-
>  6 files changed, 1305 insertions(+), 2 deletions(-)
>  create mode 100644 sound/soc/tegra/tegra210_admaif.c
>  create mode 100644 sound/soc/tegra/tegra210_admaif.h

Aside from Randy's comment ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
