Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013E0C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:49:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6112075E
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C+JsfJvO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0wzNPBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6112075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D34A416F3;
	Wed, 26 Aug 2020 11:48:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D34A416F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598435360;
	bh=Iy0PPrLl7Bd/yyILufkraB05ZmIEaRK3D+xoob+NABs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+JsfJvOI7bWK316NE7lmDr/Jb9sVVHNEF2AmzY3xZYt4AHH3+pFCfCUSZn3i82M0
	 radkTqUVbdEDkoQwxUxyqOt20c3VgJTQeVuiQoMD8gIKs41rhSLp4YnwzJAme6UXte
	 jz6gM5xiJU2ygwaLoh7zDAMX0aF0L2fA8STutwOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 712AEF8016F;
	Wed, 26 Aug 2020 11:48:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84293F801D9; Wed, 26 Aug 2020 11:48:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53337F80143
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 11:48:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53337F80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="n0wzNPBU"
Received: from localhost (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C33EC2075E;
 Wed, 26 Aug 2020 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598435301;
 bh=Iy0PPrLl7Bd/yyILufkraB05ZmIEaRK3D+xoob+NABs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n0wzNPBUocQie5n5JGb5sa+2fSll3loKsiMANLvADZJf2PGrwPs9ClV0OLHylkORD
 da0y3shYsUpokhL0bEOXYPqNPh4O395aiK2sSEUK0jrV01m15hFJgnYBQY0C/Mk6Ny
 hcqrlwsqWjSIGDDqkBxw/7+GKzlZH4znwz/bXiZw=
Date: Wed, 26 Aug 2020 15:18:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 09/11] soundwire: intel: add dynamic debug trace for
 clock-stop invalid configs
Message-ID: <20200826094817.GC2639@vkoul-mobl>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-10-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818024120.20721-10-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
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

On 18-08-20, 10:41, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Detect cases where the clock is assumed to be stopped but the IP is
> not in the relevant state, and add a dynamic debug trace.

you meant a debug print..and it looks like error print below (also in title).

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 7c63581270fd..b82d02af3c4f 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1964,6 +1964,11 @@ static int intel_resume_runtime(struct device *dev)
>  			}
>  		}
>  	} else if (!clock_stop_quirks) {
> +
> +		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
> +		if (!clock_stop0)
> +			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
> +
>  		ret = intel_init(sdw);
>  		if (ret) {
>  			dev_err(dev, "%s failed: %d", __func__, ret);
> -- 
> 2.17.1

-- 
~Vinod
