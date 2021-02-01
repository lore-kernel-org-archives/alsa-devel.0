Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C35C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 14:17:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD7764EA4
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 14:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD7764EA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2CBF1709;
	Mon,  1 Feb 2021 15:16:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2CBF1709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612189067;
	bh=IOhAKRWhf9s2LcVyWgiTkYA1yms+M5h8BHth71Hm2PY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F4xvbqftn451VUIoDz5wOB9bJTHQrkGGwyW7eeijLZCJKe0wezlJfYx1rxCKTYp3+
	 gz4rJOLypahA2dqubb+c48zgxEzxJnUzQVDP4l1Ili3I7ewhHJOFPzs5mI7Z72mt8H
	 Gm8m2Nzg0Rj7PU/uR7ARzg6WVPDc+oshB6NYZLA8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51189F80152;
	Mon,  1 Feb 2021 15:16:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 910DCF80154; Mon,  1 Feb 2021 15:16:56 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53472F800E9
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 15:16:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53472F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PTmpqvje"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B07B164EA3;
 Mon,  1 Feb 2021 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612189006;
 bh=IOhAKRWhf9s2LcVyWgiTkYA1yms+M5h8BHth71Hm2PY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PTmpqvje7zZKA/bW7tfxiXdRdSMZGDscrq8TlBV2tWqfAfYpPMVxtkIITYwUTMDHN
 eLiIRNyp4ID63PQQpYoqAV2zgBo3CJ/wo6czRnNc453UAjc893x3Km0t4eh+/M00gZ
 VgMUKJjUO8x7+VDO8e58o57Ic8ZvCn1iLBHuxakUlcqHPWqaJ6shi+z3rYtfhf3PeQ
 7MaEmUW/igDHAHqFI3NNG1sSQWJ1+wKDb/UdJtja85R+PDejlkVPxbLa7Y9rgnQNBi
 Q3LqZ0w06lF8pZ7t2/Ie6Eafnw4RovSsZm6w2K8gDyAJIXnkGpSlaY0oEiCNaY7B/V
 hbjT7gIlPc0wA==
Date: Mon, 1 Feb 2021 19:46:42 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/6] soundwire: qcom: set continue execution flag for
 ignored commands
Message-ID: <20210201141642.GB2771@vkoul-mobl>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
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
> version 1.5.1 and higher IPs of this controller required to set
> continue execution on ingored command flag. This patch sets this flag.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index da6e0d4e9622..3669bac11a32 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -40,6 +40,7 @@
>  #define SWRM_CMD_FIFO_CMD					0x308
>  #define SWRM_CMD_FIFO_STATUS					0x30C
>  #define SWRM_CMD_FIFO_CFG_ADDR					0x314
> +#define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
>  #define SWRM_RD_WR_CMD_RETRIES					0x7
>  #define SWRM_CMD_FIFO_RD_FIFO_ADDR				0x318
>  #define SWRM_ENUMERATOR_CFG_ADDR				0x500
> @@ -345,7 +346,16 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>  
>  	/* Configure number of retries of a read/write cmd */
> -	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR, SWRM_RD_WR_CMD_RETRIES);
> +	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
> +	    ctrl->version_step >= 1) {

why not use raw version value?

        if (ctrl->raw > 0x10501 )

> +		/* Only for versions >= 1.5.1 */
> +		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
> +				SWRM_RD_WR_CMD_RETRIES |
> +				SWRM_CONTINUE_EXEC_ON_CMD_IGNORE);
> +	} else {
> +		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
> +				SWRM_RD_WR_CMD_RETRIES);
> +	}
>  
>  	/* Set IRQ to PULSE */
>  	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
> -- 
> 2.21.0

-- 
~Vinod
