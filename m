Return-Path: <SRS0=PVpb=XA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F750C3A5A5
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:16:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69A4206A1
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q5Cz1yLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69A4206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3A19167D;
	Thu,  5 Sep 2019 15:15:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3A19167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567689359;
	bh=5bAcasrGWn3tPQmMp1aQpl3qSsXUoUrSX2raiSqMqtc=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q5Cz1yLFDLuSWBXpL6VrwWz76li2E35btbk1sLWbXm/DFEeOVZLE50hIVdsfg3KNZ
	 CYGTbHqljhz0u7LAjLZQY77Y3TqhdjoIBIHSLcYkM+ASQxSIRjQg2S8wa7he5/SaXy
	 ZuVVX6v7VTCT4VX7/hwHslUFHl/73h9snlgqOjxY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 576AEF803D1;
	Thu,  5 Sep 2019 15:15:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6500F80448; Thu,  5 Sep 2019 15:15:06 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C80CF80171
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2019 15:15:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C80CF80171
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 06:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; d="scan'208";a="177298824"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga008.jf.intel.com with ESMTP; 05 Sep 2019 06:15:00 -0700
Received: from ravisha1-mobl1.amr.corp.intel.com (unknown [10.255.36.89])
 by linux.intel.com (Postfix) with ESMTP id 9C73B580105;
 Thu,  5 Sep 2019 06:14:58 -0700 (PDT)
To: YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, daniel.baluta@nxp.com
References: <20190905064400.24800-1-yuehaibing@huawei.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d5a4b443-7530-75de-731f-b13cde66aea7@linux.intel.com>
Date: Thu, 5 Sep 2019 08:14:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905064400.24800-1-yuehaibing@huawei.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Fix COMPILE_TEST
 error
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 9/5/19 1:44 AM, YueHaibing wrote:
> When do compile test, if SND_SOC_SOF_OF is not set, we get:
> 
> sound/soc/sof/imx/imx8.o: In function `imx8_dsp_handle_request':
> imx8.c:(.text+0xb0): undefined reference to `snd_sof_ipc_msgs_rx'
> sound/soc/sof/imx/imx8.o: In function `imx8_ipc_msg_data':
> imx8.c:(.text+0xf4): undefined reference to `sof_mailbox_read'
> sound/soc/sof/imx/imx8.o: In function `imx8_dsp_handle_reply':
> imx8.c:(.text+0x160): undefined reference to `sof_mailbox_read'
> 
> Make SND_SOC_SOF_IMX_TOPLEVEL always depends on SND_SOC_SOF_OF
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/sof/imx/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> index fd73d84..5acae75 100644
> --- a/sound/soc/sof/imx/Kconfig
> +++ b/sound/soc/sof/imx/Kconfig
> @@ -2,7 +2,8 @@
>   
>   config SND_SOC_SOF_IMX_TOPLEVEL
>   	bool "SOF support for NXP i.MX audio DSPs"
> -	depends on ARM64 && SND_SOC_SOF_OF || COMPILE_TEST
> +	depends on ARM64|| COMPILE_TEST
> +	depends on SND_SOC_SOF_OF
>   	help
>             This adds support for Sound Open Firmware for NXP i.MX platforms.
>             Say Y if you have such a device.
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
