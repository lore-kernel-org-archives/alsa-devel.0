Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB67C11D05
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:50:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BCB207FD
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dG5cDWY7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RjISuM6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BCB207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E2C616A4;
	Thu, 20 Feb 2020 15:49:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E2C616A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582210245;
	bh=get8o0d+6qNp7xrdhfRYOx8pk7dk2IFgfZ5wVTK8lpM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dG5cDWY7vo6mr82XAODmRAsF92buAd+qYUWOPPDAroxZCvZROEqcLU9mIhHF+g8/V
	 wdWwrck1f1q2bY7Fu1lQcHWJWBEAIdTv+7whCTIlU0Ma9c0jCiDR8Or4OuV90wfAk5
	 LN/yueKPwFkrwGgh3aU8EDK/lp4vYVmDE3dJOQwo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3A0CF80145;
	Thu, 20 Feb 2020 15:49:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58489F80148; Thu, 20 Feb 2020 15:49:53 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61083F80101
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 15:49:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61083F80101
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="RjISuM6C"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4e9c6a0000>; Thu, 20 Feb 2020 06:49:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Feb 2020 06:49:47 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 06:49:47 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 14:49:44 +0000
Subject: Re: [PATCH v3 08/10] arm64: tegra: add AHUB components for few Tegra
 chips
To: Sameer Pujar <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-9-git-send-email-spujar@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6b4c7878-cc5b-b8d5-e340-73abe7d079cb@nvidia.com>
Date: Thu, 20 Feb 2020 14:49:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-9-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582210154; bh=8IjmeHutB4327ZKHATUFT1dvnarL52Z/5RCH+yurKHU=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=RjISuM6Cs5qQkZhBl3/51rbPKC2O5r8kASuzixWUzktK5yYnU1Y8xOAitAxatmGV7
 nE+oFxF2UkRCgyi4lcbm0dUPnetHa+tpU7QHZy1jaLUKc1eY8Kv1kb3zzkD8RfHOh+
 eTxI5mc116UTHMwSOR/5G54mnrDfusTjqtdTLuXDlVlYkBa59Rh6dS35DTgyeXCddF
 EbECHEvuoLfno711slw2RwL4ehxzN5DFqpUCYDiLa6I9q+pYh8xxzFsV5z8rwwzHKC
 VN18h/DwQ518Dr6clhSQ2UW0oDdRCn4Dlu74YpctlQgH6XAY7yuEBKgjQgzsdOEvbz
 oge1G/lnOJPpg==
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
> This patch adds few AHUB modules for Tegra210, Tegra186 and Tegra194.
> Following modules are common to all above SoCs,
>  * AHUB added as a child node under ACONNECT
>  * AHUB includes many HW accelerators and below components are added
>    as its children.
>    * ADMAIF
>    * I2S
>    * DMIC
>    * DSPK (added for Tegra186 and Tegra194 only, since Tegra210 does
>      not have this module)
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 231 ++++++++++++++++++++++++++++-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 239 ++++++++++++++++++++++++++++++-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 145 +++++++++++++++++++
>  3 files changed, 613 insertions(+), 2 deletions(-)
Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
