Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310ECC433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 07:08:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912E861057
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 07:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912E861057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D1D116B4;
	Thu,  1 Apr 2021 09:07:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D1D116B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617260923;
	bh=bVl57d/4fiyUdavdBfO/VSp+JHKCZiAnocwkVoIMVDI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b4+ElIeozRWUEyHw4/jhX7kbis5Agtx9LVsTvSipjev8XCuPCx6YKxWfbfxkRzRRB
	 fG9bjt1gHoFebN1/C7SLu+38X51GN5CHbSx00BDDGr0/CGn+Ox/F5WG6Atr3vjv+nU
	 1m8Obc9FXzzIL9Rlctcw4VB9/vu+VEAjp0bIubs8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D4C4F80240;
	Thu,  1 Apr 2021 09:07:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 144E2F8026B; Thu,  1 Apr 2021 09:07:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90CFDF8013F
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 09:07:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90CFDF8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WDKj2DSp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A6C26100A;
 Thu,  1 Apr 2021 07:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617260856;
 bh=bVl57d/4fiyUdavdBfO/VSp+JHKCZiAnocwkVoIMVDI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WDKj2DSpEzRN15lhYNujT6MLgz+lAhTPmbYQL/gQ9HvrWDCZsNIaXc10i1iM6kwPu
 lVIZdIkzxU19G8GuvpGiTlak0W2qU6fO1J5psT96i4Tq6klhfZJHI+M+Iu2r49jo/q
 Sbkc4PrOV+x6wsh/IUcTHqtGiKesGQEFXsedvxREgu+BtKaTeGw623LU1w/q4lUzhe
 RqMLJ/OHfxG8i8/HXdYnaIQEC3uvOABTD3hLwfVMh6GgxQa183RVQdIvCnWrWyDrDG
 UYvuEPuxhYCyEBqoNxdmdYCCX+DdyYC515m+bd9RHtnNKQEoejKG2CQp6IrOlYV+Ju
 j8tbEDYwYjykA==
Date: Thu, 1 Apr 2021 12:37:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: qcom: wait for fifo space to be available
 before read/write
Message-ID: <YGVxNBKAESSLMeQ+@vkoul-mobl.Dlink>
References: <20210331170033.17174-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331170033.17174-1-srinivas.kandagatla@linaro.org>
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

On 31-03-21, 18:00, Srinivas Kandagatla wrote:
> If we write registers very fast we can endup in a situation where some
> of the writes will be dropped without any notice.
> 
> So wait for the fifo space to be available before reading/writing the
> soundwire registers.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 74 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 6affa3cd4039..9b45717577f2 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -24,6 +24,8 @@
>  #define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
>  #define SWRM_COMP_CFG_ENABLE_MSK				BIT(0)
>  #define SWRM_COMP_PARAMS					0x100
> +#define SWRM_COMP_PARAMS_WR_FIFO_DEPTH				GENMASK(14, 10)
> +#define SWRM_COMP_PARAMS_RD_FIFO_DEPTH				GENMASK(19, 15)
>  #define SWRM_COMP_PARAMS_DOUT_PORTS_MASK			GENMASK(4, 0)
>  #define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
>  #define SWRM_INTERRUPT_STATUS					0x200
> @@ -51,6 +53,8 @@
>  #define SWRM_CMD_FIFO_CMD					0x308
>  #define SWRM_CMD_FIFO_FLUSH					0x1
>  #define SWRM_CMD_FIFO_STATUS					0x30C
> +#define SWRM_RD_CMD_FIFO_CNT_MASK				GENMASK(20, 16)
> +#define SWRM_WR_CMD_FIFO_CNT_MASK				GENMASK(12, 8)
>  #define SWRM_CMD_FIFO_CFG_ADDR					0x314
>  #define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
>  #define SWRM_RD_WR_CMD_RETRIES					0x7
> @@ -104,6 +108,7 @@
>  #define SWR_BROADCAST_CMD_ID    0x0F
>  #define SWR_MAX_CMD_ID	14
>  #define MAX_FIFO_RD_RETRY 3
> +#define SWR_OVERFLOW_RETRY_COUNT 30
>  
>  struct qcom_swrm_port_config {
>  	u8 si;
> @@ -147,6 +152,8 @@ struct qcom_swrm_ctrl {
>  	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);
>  	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
>  	u32 slave_status;
> +	u32 wr_fifo_depth;
> +	u32 rd_fifo_depth;
>  };
>  
>  struct qcom_swrm_data {
> @@ -238,6 +245,63 @@ static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
>  	return val;
>  }
>  
> +static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *swrm)
> +{
> +	u32 fifo_outstanding_cmd, value;
> +	u8 fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
> +
> +	/* Check for fifo underflow during read */
> +	swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +	fifo_outstanding_cmd = FIELD_GET(SWRM_RD_CMD_FIFO_CNT_MASK, value);
> +
> +	 /* Check number of outstanding commands in fifo before read */
> +	if (fifo_outstanding_cmd)
> +		return 0;
> +
> +	do {
> +		usleep_range(500, 510);
> +		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +		fifo_outstanding_cmd = FIELD_GET(SWRM_RD_CMD_FIFO_CNT_MASK, value);
> +		if (fifo_outstanding_cmd > 0)
> +			break;
> +	} while (fifo_retry_count--);
> +
> +	if (fifo_outstanding_cmd == 0) {
> +		dev_err_ratelimited(swrm->dev, "%s err read underflow\n", __func__);
> +		return -ENOMEM;

ENOMEM ? that should be EIO, we expected data but didnt get it in read
fifo

> +	}
> +
> +	return 0;
> +}
> +
> +static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *swrm)
> +{
> +	u32 fifo_outstanding_cmd, value;
> +	u8 fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
> +
> +	/* Check for fifo overflow during write */
> +	swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +	fifo_outstanding_cmd = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
> +
> +	/* Check number of outstanding commands in fifo before write */
> +	if (fifo_outstanding_cmd != swrm->wr_fifo_depth)
> +		return 0;

maybe the comment should say, check for space in write fifo?

> +
> +	do {
> +		usleep_range(500, 510);
> +		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +		fifo_outstanding_cmd = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
> +		if (fifo_outstanding_cmd < swrm->wr_fifo_depth)
> +			break;
> +	} while (fifo_retry_count--);
> +
> +	if (fifo_outstanding_cmd == swrm->wr_fifo_depth) {
> +		dev_err_ratelimited(swrm->dev, "%s err write overflow\n", __func__);
> +		return -ENOMEM;

EIO or better error code here too

-- 
~Vinod
