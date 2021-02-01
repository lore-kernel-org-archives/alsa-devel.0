Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B83C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 10:29:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFF364E27
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 10:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFF364E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55AD116B2;
	Mon,  1 Feb 2021 11:29:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55AD116B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612175391;
	bh=cYt/4tFrkPkgMO34ziTHv/Xl1CcvzqikMpKc4YYIK3E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/ybqqVfN6cIhyGxWU4KgaFCt+C8+OrZmUyAbMiUAfxGyBfEvXnXpqxrkgby/6GE2
	 77Q1N3GnpR/fmJtRxo1/TiS90sD5IpsBdYxlnlY3BbClzRCnD+qzB9BXUDJsCt7T+J
	 oD1P1HZkFJrVsMdoA3Q2vmKKgxJf001htc7iGAc0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDE14F800E2;
	Mon,  1 Feb 2021 11:29:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7330F80154; Mon,  1 Feb 2021 11:28:57 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D4FFF800E2
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 11:28:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D4FFF800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="b6ZoHjs8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5D4F64E11;
 Mon,  1 Feb 2021 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612175328;
 bh=cYt/4tFrkPkgMO34ziTHv/Xl1CcvzqikMpKc4YYIK3E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b6ZoHjs8fw7VKf4QcU0XyCtgxal6MYEuJbZNANShek+No1IBv7+gBIir6zc58xDDB
 niMTmXK/7Wg8ljX3fe5HS4knDBq7ghL3y3B91toy8awjKPwncJ+emGAfwf7ZAtU/Wu
 y+YIZ2c3tffyUU7Xhe3aeUcnKp4PL3CuBrAWSFRCkD0l8L/gsEG1ktHS5JVgnx9Bwd
 coyzEzfty0ggFc7/mnIKWPxuKMVeaX9DkUf76A9JbLmyLjNJC0nCU3l3N5CvNK9Abt
 DmNmEunjd6gg9e7pBBb1AFhVBsWMz2b8VxqD/2OT9eQa+8V6LMM5eXMfUvyPBup/dl
 ZJ1VKiWZoJ6mQ==
Date: Mon, 1 Feb 2021 15:58:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the
 mask is enabled
Message-ID: <20210201102844.GU2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

On 26-01-21, 16:37, Bard Liao wrote:
> The SoundWire specification allows a Slave device to report a bus clash
> with the in-band interrupt mechanism when it detects a conflict while
> driving a bitSlot it owns. This can be a symptom of an electrical conflict
> or a programming error, and it's vital to detect reliably.
> 
> Unfortunately, on some platforms, bus clashes are randomly reported by
> Slave devices after a bus reset, with an interrupt status set even before
> the bus clash interrupt is enabled. These initial spurious interrupts are
> not relevant and should optionally be filtered out, while leaving the
> interrupt mechanism enabled to detect 'true' issues.
> 
> This patch suggests the addition of a Master level quirk to discard such
> interrupts. The quirk should in theory have been added at the Slave level,
> but since the problem was detected with different generations of Slave
> devices it's hard to point to a specific IP. The problem might also be
> board-dependent and hence dealing with a Master quirk is simpler.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c       | 10 ++++++++++
>  include/linux/soundwire/sdw.h |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 6e1c988f3845..d394905936e4 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1240,6 +1240,7 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
>  static int sdw_initialize_slave(struct sdw_slave *slave)
>  {
>  	struct sdw_slave_prop *prop = &slave->prop;
> +	int status;
>  	int ret;
>  	u8 val;
>  
> @@ -1247,6 +1248,15 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (slave->bus->prop.quirks & SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH) {
> +		/* Clear bus clash interrupt before enabling interrupt mask */
> +		status = sdw_read_no_pm(slave, SDW_SCP_INT1);
> +		if (status & SDW_SCP_INT1_BUS_CLASH) {
> +			dev_warn(&slave->dev, "Bus clash detected before INT mask is enabled\n");
> +			sdw_write_no_pm(slave, SDW_SCP_INT1, SDW_SCP_INT1_BUS_CLASH);
> +		}
> +	}
> +
>  	/*
>  	 * Set SCP_INT1_MASK register, typically bus clash and
>  	 * implementation-defined interrupt mask. The Parity detection
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index f0b01b728640..a2766c3b603d 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -405,6 +405,7 @@ struct sdw_slave_prop {
>   * command
>   * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
>   * @hw_disabled: if true, the Master is not functional, typically due to pin-mux
> + * @quirks: bitmask identifying optional behavior beyond the scope of the MIPI specification
>   */
>  struct sdw_master_prop {
>  	u32 revision;
> @@ -421,8 +422,11 @@ struct sdw_master_prop {
>  	u32 err_threshold;
>  	u32 mclk_freq;
>  	bool hw_disabled;
> +	u32 quirks;

Can we do u64 here please.. I dont know where we would end up.. but
would hate if we start running out of space ..


>  };
>  
> +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
> +
>  int sdw_master_read_prop(struct sdw_bus *bus);
>  int sdw_slave_read_prop(struct sdw_slave *slave);
>  
> -- 
> 2.17.1

-- 
~Vinod
