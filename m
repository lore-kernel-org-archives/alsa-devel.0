Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B05BC432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 13:36:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F5160FC4
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 13:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74F5160FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F4E617B4;
	Thu,  2 Sep 2021 15:35:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F4E617B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630589808;
	bh=88VOhcgiF1AUALhnSvymAfD1l9V4iZOuCVT+/IP7uno=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VgBZXR/JeR4H9XQwymo5fML/K5ggGaaNH3amRK4F1WSz/tD+HFJyFoFK4RBM9J1no
	 VsKQuZTqJDQryq4xuf6JqsPmaLJKd/7EklCZYT26PFyCEor0ZqZOlwD2WT/VDdorQV
	 wpEBi7Cjb7q4eUbq3Nj1Zzy4fDYcA9z4xN1/Y3oM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C20BBF80125;
	Thu,  2 Sep 2021 15:35:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BE70F80269; Thu,  2 Sep 2021 15:35:56 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F3C6F80125
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 15:35:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F3C6F80125
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="199341880"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; d="scan'208";a="199341880"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2021 06:35:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; d="scan'208";a="467424866"
Received: from leeyapha-desk2.amr.corp.intel.com (HELO [10.251.212.83])
 ([10.251.212.83])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2021 06:35:39 -0700
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add code to manage DSP related clocks
To: Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20210902123216.787025-1-daniel.baluta@oss.nxp.com>
 <20210902123216.787025-2-daniel.baluta@oss.nxp.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Message-ID: <896baddd-5bd7-8f85-91c3-0a4498694d77@linux.intel.com>
Date: Thu, 2 Sep 2021 16:35:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902123216.787025-2-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, festevam@gmail.com,
 kai.vehmanen@linux.intel.com, Daniel Baluta <daniel.baluta@nxp.com>,
 ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, kernel@pengutronix.de, s-anna@ti.com, shawnguo@kernel.org
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

Hi Daniel,

On 02/09/2021 15:32, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> There are two types of clocks:
> 	* DSP IP clocks
> 	* DAI clocks
> 
> This clocks are necessary in order to power up DSP and DAIs.
> 
> We choose to enable DAI clocks here because of the way i.MX8/i.MX8X
> design handles resources (including clocks).
> 
> All clocks are managed by a separate core (named SCU) which communicates
> with Linux managed ARM core via a well known API.
> 
> We parse and enable the clocks in probe function and disable them in
> remove function.
> 
> Future patches will introduce Power Management support so that we
> disable clocks while DSP is not used or system enters power save.

Unfortunately this patch does not apply to next.

I might be a bit too cautius, but I would also add "&& COMMON_CLK" for 
the COMPILE_TEST in Kconfig or select it from where it is appropriate?

> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>   sound/soc/sof/imx/imx-common.c | 77 ++++++++++++++++++++++++++++++++++
>   sound/soc/sof/imx/imx-common.h | 16 +++++++
>   sound/soc/sof/imx/imx8.c       | 32 ++++++++++++++
>   sound/soc/sof/imx/imx8m.c      | 33 +++++++++++++++
>   4 files changed, 158 insertions(+)
> 
> diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
> index 30624fafc632..482c25ab15ce 100644
> --- a/sound/soc/sof/imx/imx8m.c
> +++ b/sound/soc/sof/imx/imx8m.c
> @@ -23,6 +23,20 @@
>   #define MBOX_OFFSET	0x800000
>   #define MBOX_SIZE	0x1000
>   
> +#define IMX8M_DSP_CLK_NUM	3
> +static const char *imx8m_dsp_clks_names[IMX8M_DSP_CLK_NUM] = {

static const char *imx8m_dsp_clks_names[]

+ ARRAY_SIZE(imx8m_dsp_clks_names) instead IMX8M_DSP_CLK_NUM ?


-- 
Péter
