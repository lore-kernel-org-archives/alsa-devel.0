Return-Path: <SRS0=cpJH=YO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0763CA9EB5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 04:45:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2A52077C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 04:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dLKX4DEN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6WyMO4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2A52077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52C9F9F6;
	Mon, 21 Oct 2019 06:44:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52C9F9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571633110;
	bh=0BYbCdqJpN6T2TkT0r4baL8qzmzj+NBBARMR3P9bHjk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dLKX4DENqB4Bl6dL+AS3TcBdWEpT9kTZ9IwMfRbt0+aGTllli1hK8WQevioDJVaq/
	 KoM2a13OK36993wlXA8BitjuAmEGoKEc6NW9vQbbhCP5cu20flGO3QlvwXKz1/HcZm
	 hxFMnEowOOS5wDGjjdX/4Do6PXJUBkIzOWowz+TQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8883F80321;
	Mon, 21 Oct 2019 06:44:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27F9FF80368; Mon, 21 Oct 2019 06:44:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C5A5F801EB
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 06:44:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C5A5F801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J6WyMO4d"
Received: from localhost (unknown [122.167.89.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 102972067B;
 Mon, 21 Oct 2019 04:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571633049;
 bh=LVlUwIor1Q0zqTd3c1Z8i6+KPgjp8+NUXpE9o1AUPGg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J6WyMO4de+yhu9NJ87JGfUDk+teLPhNjtBP7DfyEfMwcriRxAM0DBKoshvRyAxjT8
 Rw2crnxAE4eO4ywbrixkkk++fwl0VQ4ay2UipY6mi6JtLiBPAeQ35wGoGk2Gfi2J3p
 I0GCNmT+kV4uyMNPvoDXLVL7Vqf5oyYwTpo0ocII=
Date: Mon, 21 Oct 2019 10:14:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20191021044405.GB2654@vkoul-mobl>
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191011154423.2506-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 spapothi@codeaurora.org, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH v3 2/2] soundwire: qcom: add support for
 SoundWire controller
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 11-10-19, 16:44, Srinivas Kandagatla wrote:

> +static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
> +{
> +	struct qcom_swrm_ctrl *ctrl = dev_id;
> +	u32 sts, value;
> +	unsigned long flags;
> +
> +	ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);
> +
> +	if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
> +		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +		dev_err_ratelimited(ctrl->dev,
> +				    "CMD error, fifo status 0x%x\n",
> +				     value);
> +		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
> +	}
> +
> +	if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
> +	    sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS)
> +		schedule_work(&ctrl->slave_work);

we are in irq thread, so why not do the work here rather than schedule
it?

> +static int qcom_swrm_compute_params(struct sdw_bus *bus)
> +{
> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +	struct sdw_master_runtime *m_rt;
> +	struct sdw_slave_runtime *s_rt;
> +	struct sdw_port_runtime *p_rt;
> +	struct qcom_swrm_port_config *pcfg;
> +	int i = 0;
> +
> +	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
> +		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
> +			pcfg = &ctrl->pconfig[p_rt->num - 1];
> +			p_rt->transport_params.port_num = p_rt->num;
> +			p_rt->transport_params.sample_interval = pcfg->si + 1;
> +			p_rt->transport_params.offset1 = pcfg->off1;
> +			p_rt->transport_params.offset2 = pcfg->off2;
> +		}
> +
> +		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
> +			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
> +				pcfg = &ctrl->pconfig[i];
> +				p_rt->transport_params.port_num = p_rt->num;
> +				p_rt->transport_params.sample_interval =
> +					pcfg->si + 1;
> +				p_rt->transport_params.offset1 = pcfg->off1;
> +				p_rt->transport_params.offset2 = pcfg->off2;
> +				i++;
> +			}

Can you explain this one, am not sure I understood this. This fn is
supposed to compute and fill up the params, all I can see is filling up!

> +static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
> +	.hw_params = qcom_swrm_hw_params,
> +	.prepare = qcom_swrm_prepare,
> +	.hw_free = qcom_swrm_hw_free,
> +	.startup = qcom_swrm_startup,
> +	.shutdown = qcom_swrm_shutdown,
> +        .set_sdw_stream = qcom_swrm_set_sdw_stream,

why does indent look off to me!
-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
