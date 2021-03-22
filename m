Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33069C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 12:08:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997DB6198D
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 12:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997DB6198D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1AF986F;
	Mon, 22 Mar 2021 13:07:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1AF986F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616414909;
	bh=5GBNHdOGkQF5GWk/uL6fy+oR3V9jxg/jLYkdFoEbxeY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JcDZkNBHyrL+Yb4FolHGt7EUZWabmZyjAsoP0nDFPm+K/B1O+1dCRdGvjxoOADjqK
	 swIsgdgdW/Dj1k+Z9r5uobIQY3ZcTMT7vUpCNlh56u2jq+MB1APVjStRFAoS/Ox1kR
	 IC3ga//EaAMJKSEonsf7af+LHWDI9G81h3uQUl2g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E97CF80156;
	Mon, 22 Mar 2021 13:07:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B673F8016B; Mon, 22 Mar 2021 13:07:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C85E6F80107
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 13:07:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C85E6F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cRphNMpY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44DB76197F;
 Mon, 22 Mar 2021 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616414842;
 bh=5GBNHdOGkQF5GWk/uL6fy+oR3V9jxg/jLYkdFoEbxeY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cRphNMpYOXUwh5i/ryvVs6L4FO9ppglCBGe9yYM2JMimaf6dzYsmK16QiUU6wogXn
 fNAfMtKwac8rq9Kp83hwfHpU5ILoP1NtgcyDMMXbrTRJrCRsUsVPGsl2A5GujcdQG/
 DiPjCiKVbBCW9ZKOTpIRpkfN+yq9IUniYytYTtOrm7aKho1hliyYv9u+POZvHdsfOH
 lpgeP+bH9NiRQ0HzTcWdyREnG3W83CFA0wAZ/1tW//Y3noSxUJTN82+VSP9tlZ7LHt
 dE5HaCtNbJYHVHmd5U3qF3vPCBU5P/RpIfm1dQvUJZi8FBNhc97CbT8kVMs8FB6R2k
 KzZ/FybRWTAWg==
Date: Mon, 22 Mar 2021 17:37:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 1/3] soundwire: add master quirks for bus clash and
 parity
Message-ID: <YFiIdTL6tPnqtDy2@vkoul-mobl.Dlink>
References: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
 <20210302082720.12322-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302082720.12322-2-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On 02-03-21, 16:27, Bard Liao wrote:
> Currently quirks are only allowed for Slave devices. This patch
> describes the need for two quirks at the Master level.
> 
> a) bus clash
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
> b) parity
> 
> Additional tests on a new platform with the Maxim 98373 amplifier
> showed a rare case where the parity interrupt is also thrown on
> startup, at the same time as bus clashes. This issue only seems to
> happen infrequently and was only observed during suspend-resume stress
> tests while audio is streaming. We could make the problem go away by
> adding a Slave-level quirk, but there is no evidence that the issue is
> actually a Slave problem: the parity is provided by the Master, which
> could also set an invalid parity in corner cases.
> 
> BugLink: https://github.com/thesofproject/linux/issues/2578
> BugLink: https://github.com/thesofproject/linux/issues/2533
> 

Please do not add blank lines here

> Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> ---
>  include/linux/soundwire/sdw.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index d08039d65825..25f2a14e2e83 100644
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
> @@ -421,8 +422,29 @@ struct sdw_master_prop {
>  	u32 err_threshold;
>  	u32 mclk_freq;
>  	bool hw_disabled;
> +	u64 quirks;
>  };
>  
> +/* Definitions for Master quirks */
> +
> +/*
> + * In a number of platforms bus clashes are reported after a hardware
> + * reset but without any explanations or evidence of a real problem.
> + * The following quirk will discard all initial bus clash interrupts
> + * but will leave the detection on should real bus clashes happen
> + */
> +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
> +
> +/*
> + * Some Slave devices have known issues with incorrect parity errors
> + * reported after a hardware reset. However during integration unexplained
> + * parity errors can be reported by Slave devices, possibly due to electrical
> + * issues at the Master level.
> + * The following quirk will discard all initial parity errors but will leave
> + * the detection on should real parity errors happen.
> + */
> +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY	BIT(1)
> +
>  int sdw_master_read_prop(struct sdw_bus *bus);
>  int sdw_slave_read_prop(struct sdw_slave *slave);
>  
> -- 
> 2.17.1

-- 
~Vinod
