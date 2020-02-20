Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A2DC11D05
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:37:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962B620656
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="booOxCK6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Lsp5luzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962B620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBEAA16AC;
	Thu, 20 Feb 2020 15:36:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBEAA16AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582209445;
	bh=8jxG8iaWrYrkwEVod+B1J+l+XYMQtZH5vrU7xhVFUF8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=booOxCK6717ZWxwr2cA9g3BisZ8vsRw9ptaSvntS5+j+ZYQRo4m4UU94f02cdh2VI
	 9KJRFt5Al2ZQl3lrUFn5oAB6wwebYgYjUOJD52vueXKWE7PXUzfL2v8Fr9DcYr+qVj
	 3UswdeeCzCpVdIUweqsvy4EqWyoXMDdij+tTvQ1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76BE9F80145;
	Thu, 20 Feb 2020 15:36:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E576F80101; Thu, 20 Feb 2020 15:36:33 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B675F80101
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 15:36:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B675F80101
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Lsp5luzm"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4e99230000>; Thu, 20 Feb 2020 06:35:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 20 Feb 2020 06:36:27 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 20 Feb 2020 06:36:27 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 14:36:24 +0000
Subject: Re: [PATCH v3 03/10] ASoC: tegra: add Tegra210 based DMIC driver
To: Sameer Pujar <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-4-git-send-email-spujar@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d7e81ada-9711-647d-3c4f-29dd469c6621@nvidia.com>
Date: Thu, 20 Feb 2020 14:36:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-4-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582209315; bh=U31myyW56C4tdiGtd2jJLPSaoyAgelANlRknYewe5kg=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Lsp5luzmKreOs7Qi4z4so5RiHORS2xhCjFw9ZcrXLk4RInNCPoyWDdkg1Py4HeIvW
 9myXHWRIKbEryDtXGnYOuM7WfymAzpvN4UofgD3xzNmICq+U4aDGSTxEbjBxwtY2Ia
 JyGKnfQvO7hVCACBtalSZl/vSraTpfezSF9YIzEQrv0g5rEFqI0bYqW/R8C9hL0px6
 8xhNZXGCwCR60LAjl2oawAhD328kayKTQq9dgpoWOjCknO4JcEISJFc0phpoaFio0b
 1HFtmJxl5hrPDnvlmHe4oZApsnTz5VmtSz/MY6Tnxp1HSXAyp9lD+e0FNpjh0gPXXy
 Jiixv66kxZ0bw==
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
> The Digital MIC (DMIC) Controller is used to interface with Pulse Density
> Modulation (PDM) input devices. The DMIC controller implements a converter
> to convert PDM signals to Pulse Code Modulation (PCM) signals. From signal
> flow perspective, the DMIC can be viewed as a PDM receiver.
> 
> This patch registers DMIC component with ASoC framework. The component
> driver exposes DAPM widgets, routes and kcontrols for the device. The DAI
> driver exposes DMIC interfaces, which can be used to connect different
> components in the ASoC layer. Makefile and Kconfig support is added to
> allow to build the driver. The DMIC devices can be enabled in the DT via
> "nvidia,tegra210-dmic" compatible string. This driver can be used for
> Tegra186 and Tegra194 chips as well.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>

Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
