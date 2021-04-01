Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01444C43460
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 07:25:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37D061056
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 07:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37D061056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5B8316BD;
	Thu,  1 Apr 2021 09:24:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5B8316BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617261913;
	bh=QTnz+6jGcvYfBHbJRGBNxgg3sk4PrA6WsodxoS43ESU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VR6nJmh9iY+YEAKfl8LiX2/malP+0zFM6wiepFWR/gT45Lt6ugzDUa8x+rvNz+t/2
	 02K5Hb3GaFqpSlXgAZXxKhyJw1jyKhNsdheBEhU2KfnnrjtfBF+GREsuX+hh/tjyDe
	 2eOZH7EG7+KoBIFXic19Ob8Vl56+c1YbkggOyEV4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 694D0F8013C;
	Thu,  1 Apr 2021 09:24:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F209BF80272; Thu,  1 Apr 2021 09:24:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 728E1F8013C
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 09:24:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 728E1F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iLEIbHNJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7BB56101E;
 Thu,  1 Apr 2021 07:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617261857;
 bh=QTnz+6jGcvYfBHbJRGBNxgg3sk4PrA6WsodxoS43ESU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iLEIbHNJkGB0NFObdCK7gpCmPVD4KaJpzmuIm/d5lUy5SAcJLDoxf9MbGHC5FmzzD
 lKlelSAxNMmFMs5Qz3e9nIYEvPbPm3Vxo3Swhxa/FgsCxV2UOr7FnO9EYAoSyneHjO
 6+eUDHE3L07aU6xaWL3uLosHkrY+RyswCd616bSSw1B3nW9/Szeql7N+xR7FJ9z7pm
 xFophTyXhdWtSOfGKp41VSxOe8mSMsk/WTGK7gQz/wRFlQAilRdjHtZL1gbEWzOSFi
 c6jah7hrwaEuKY0Y3Q/MCv0s2NmyJMXyzMsi4Y0NWY72YIvRAEmrTI6NBhVPWozxJe
 0DlfuhEokyc/w==
Date: Thu, 1 Apr 2021 12:54:13 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/2] soundwire: add macro to selectively change error
 levels
Message-ID: <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
 <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

On 31-03-21, 09:13, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We sometimes discard -ENODATA when reporting errors and lose all
> traces of issues in the console log, add a macro to add use dev_dbg()
> in such cases.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/bus.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 40354469860a..8370216f95d4 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -227,4 +227,12 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
>  void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
>  int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
>  
> +#define sdw_dev_dbg_or_err(dev, is_err, fmt, ...)			\
> +	do {								\
> +		if (is_err)						\
> +			dev_err(dev, fmt, __VA_ARGS__);			\
> +		else							\
> +			dev_dbg(dev, fmt, __VA_ARGS__);			\
> +	} while (0)

I see a variant in sof code and now here, why not add in a
dev_dbg_or_err() and use everywhere?

Thanks
-- 
~Vinod
