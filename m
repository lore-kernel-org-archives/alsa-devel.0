Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA01C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 05:03:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9CB208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 05:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FBRLbMNo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaqjnY1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9CB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 420D8167C;
	Fri, 21 Aug 2020 07:02:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 420D8167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597986185;
	bh=keywDDnmc2BgdhkVQo4jd6Uf3rJXgxmDUgazsUR4kHU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FBRLbMNoqJ6vmM2R2zOT6WNLrTPZDPehAzAtEQ8ObuuMYcecX3apymLPBanttaBbM
	 RuC7A3jqSYRr1w3p8b8bc0VWRnKlHV2d6jqaqd8oYg8SJmpR596T8LlTjNC6csx3Yr
	 3Oglz48zmbKWlO0ylg8eeUhSPYqyli75QsYDxGXA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BC66F80216;
	Fri, 21 Aug 2020 07:02:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B230F80218; Fri, 21 Aug 2020 07:02:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7ECDF800D2
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 07:02:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7ECDF800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jaqjnY1j"
Received: from localhost (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 28C57208E4;
 Fri, 21 Aug 2020 05:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597986124;
 bh=keywDDnmc2BgdhkVQo4jd6Uf3rJXgxmDUgazsUR4kHU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jaqjnY1jUD/EE/weN+QRcHhIfwnA6shexdxHlqictJXVnjtmLACrg6OktI6asGzAi
 l2/SrNW89m35FhlEPidgDvvw9CG782isX6FVDeQycw8yu6M+TiLDrWYisPewKjoXSV
 GOV1DP9pXMqZ2lscIl36v3GJ3/Ae7DBM4NbtJvfQ=
Date: Fri, 21 Aug 2020 10:31:59 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel: fix CONFIG_PM and CONFIG_PM_SLEEP
 confusion
Message-ID: <20200821050159.GH2639@vkoul-mobl>
References: <20200820140441.9478-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820140441.9478-1-yung-chuan.liao@linux.intel.com>
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

On 20-08-20, 22:04, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> When CONFIG_PM_SLEEP is not defined, GCC throws compilation warnings:
> 
> drivers/soundwire/intel.c:1816:12: warning: ‘intel_resume’ defined but
> not used [-Wunused-function]
>  1816 | static int intel_resume(struct device *dev)
>       |            ^~~~~~~~~~~~
> 
> drivers/soundwire/intel.c:1697:12: warning: ‘intel_suspend’ defined
> but not used [-Wunused-function]
>  1697 | static int intel_suspend(struct device *dev)
> 
> Fix by adding the missing CONFIG_PM_SLEEP.

Can you rather use __maybe for for these rather than wrapping in another
ifdef, that is the recommended way to do this

Thanks

> Note that we could move code around and use only 2 ifdefs, but this
> will generate conflicts so let's do this when all the pm handling is
> merged.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index dbcbe2708563..a2f0026cb2c1 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1525,7 +1525,7 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
>   * PM calls
>   */
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  
>  static int intel_suspend(struct device *dev)
>  {
> @@ -1562,6 +1562,9 @@ static int intel_suspend(struct device *dev)
>  
>  	return 0;
>  }
> +#endif
> +
> +#ifdef CONFIG_PM
>  
>  static int intel_suspend_runtime(struct device *dev)
>  {
> @@ -1624,6 +1627,9 @@ static int intel_suspend_runtime(struct device *dev)
>  
>  	return ret;
>  }
> +#endif
> +
> +#ifdef CONFIG_PM_SLEEP
>  
>  static int intel_resume(struct device *dev)
>  {
> @@ -1691,6 +1697,9 @@ static int intel_resume(struct device *dev)
>  
>  	return ret;
>  }
> +#endif
> +
> +#ifdef CONFIG_PM
>  
>  static int intel_resume_runtime(struct device *dev)
>  {
> @@ -1797,7 +1806,6 @@ static int intel_resume_runtime(struct device *dev)
>  
>  	return ret;
>  }
> -
>  #endif
>  
>  static const struct dev_pm_ops intel_pm = {
> -- 
> 2.17.1

-- 
~Vinod
