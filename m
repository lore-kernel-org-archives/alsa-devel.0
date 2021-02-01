Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3BC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 14:22:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A02D64DAE
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 14:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A02D64DAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2AAD1766;
	Mon,  1 Feb 2021 15:21:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2AAD1766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612189360;
	bh=saXB81rCBp5cIBvK13wj/wHHDWVKYzlvS9EQuCXX8PM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fjFf+0wi2BJ07B3SOYUIr6RPp0IYMwyI6dySs669F/30P+BFJOmmBs2/QEug4sSfQ
	 bISlucU5cLEFE1Hzs9Xv+H6PBNBPktKnbYqiiNHPjusJExW08v3RbAwz+QYVT7V0C+
	 8ODReK2ZptsrncKmZHAZ0V21ZyNv2qbNlAwkhdT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4562BF800E9;
	Mon,  1 Feb 2021 15:21:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6EF5F80153; Mon,  1 Feb 2021 15:21:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78E16F800E9
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 15:21:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78E16F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OFPFpv/g"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26A8464DDE;
 Mon,  1 Feb 2021 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612189299;
 bh=saXB81rCBp5cIBvK13wj/wHHDWVKYzlvS9EQuCXX8PM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OFPFpv/gHreo3nMrGcJ1nGRzWenR5Tzq9Jooii0VBCICl9xgEeP6o43OwFFivofip
 alWyr+BHMaTxclfyYCERmvP+1vFWxCCfYFzQ6uJLhVOWwy7fIH3Wx6EIt8j0n4Kn6H
 7uFiYvsE8v3f41RFPmi1NNlu+hDMhSUFjMF0bhcUya0QbwjNVgzMCQMmkOkPr4aRxC
 /UB/nTrW5CgD+MFM6LLtX5NWC9tO0JHPYhcLucVbvV9xLOlP1uYlpvIDatrtLkVvwr
 edCJs7QelY+qSZ5pVV8GnRVE7i2G5EGuqSCLvyTRy2cXyegwHz5PPsQGnALzC1AC22
 ct8BY8QLyATeQ==
Date: Mon, 1 Feb 2021 19:51:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 4/6] soundwire: qcom: start the clock during initialization
Message-ID: <20210201142134.GC2771@vkoul-mobl>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129173248.5941-5-srinivas.kandagatla@linaro.org>
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On 29-01-21, 17:32, Srinivas Kandagatla wrote:
> Start the clock during initialization.

A detailed log please, which clock..? Also how do older controllers work
w/o this clk

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 3669bac11a32..83df15d83935 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -47,6 +47,8 @@
>  #define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)		(0x101C + 0x40 * (m))
>  #define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK			GENMASK(2, 0)
>  #define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK			GENMASK(7, 3)
> +#define SWRM_MCP_BUS_CTRL					0x1044
> +#define SWRM_MCP_BUS_CLK_START					BIT(1)
>  #define SWRM_MCP_CFG_ADDR					0x1048
>  #define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK		GENMASK(21, 17)
>  #define SWRM_DEF_CMD_NO_PINGS					0x1f
> @@ -345,6 +347,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
>  	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>  
> +	ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
>  	/* Configure number of retries of a read/write cmd */
>  	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
>  	    ctrl->version_step >= 1) {
> -- 
> 2.21.0

-- 
~Vinod
