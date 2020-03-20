Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BF3C4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:16:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE1C20739
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ivKWoPBY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6gOnR5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE1C20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED34B17D8;
	Fri, 20 Mar 2020 15:15:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED34B17D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584713790;
	bh=iY20u/IgUH7ck1uzIJTEsr4J0NsnrcVYd97wLs96ABE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ivKWoPBYoh9xcrBgKpqENB+MuGCfALVXHG1rDThfJ2q78KtVsEQzOykWMBkWFoGni
	 P4KT35ACHRRNE3jYY/f+61rLOh5D9zKxIfh4jVZZb1dAUTjkFdhTzUhzdZb3B6kWpl
	 BrrXuGAs967legyOT9jOx61QNzWuweZcIPjYRVqY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A296F80139;
	Fri, 20 Mar 2020 15:15:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D9F1F8015B; Fri, 20 Mar 2020 15:15:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41605F800DD
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 15:15:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41605F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="A6gOnR5S"
Received: from localhost (unknown [122.167.82.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4937220739;
 Fri, 20 Mar 2020 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584713733;
 bh=iY20u/IgUH7ck1uzIJTEsr4J0NsnrcVYd97wLs96ABE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A6gOnR5ST2SPsthWP2DMt5zLXqGWOTdPzerYXOyXz9HbBgUUWJJuHs5BLT3HuznPe
 r1jlv6E5Zp6LeBJakOw7eZVupiM/ousyLYqJ1NXfzHVt38I7Z4BUnS75kKQcr2Z5wD
 tEjKA8VkJyoKcK1a8frGbti8KTYzTLBarbjcAyYc=
Date: Fri, 20 Mar 2020 19:45:28 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: stream: only change state if needed
Message-ID: <20200320141528.GI4885@vkoul-mobl>
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

On 17-03-20, 05:51, Pierre-Louis Bossart wrote:
> In a multi-cpu DAI context, the stream routines may be called from
> multiple DAI callbacks. Make sure the stream state only changes for
> the first call, and don't return error messages if the target state is
> already reached.

For stream-apis we have documented explicitly in Documentation/driver-api/soundwire/stream.rst

"Bus implements below API for allocate a stream which needs to be called once
per stream. From ASoC DPCM framework, this stream state maybe linked to
.startup() operation.

.. code-block:: c

  int sdw_alloc_stream(char * stream_name); "

This is documented for all stream-apis.

This can be resolved by moving the calling of these APIs from
master-dais/slave-dais to machine-dais. They are unique in the card.

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/stream.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 1b43d03c79ea..3319121cd706 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1572,6 +1572,7 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
>  	sdw_acquire_bus_lock(stream);
>  
>  	if (stream->state == SDW_STREAM_PREPARED) {
> +		/* nothing to do */
>  		ret = 0;
>  		goto state_err;
>  	}
> @@ -1661,6 +1662,12 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
>  
>  	sdw_acquire_bus_lock(stream);
>  
> +	if (stream->state == SDW_STREAM_ENABLED) {
> +		/* nothing to do */
> +		ret = 0;
> +		goto state_err;
> +	}
> +
>  	if (stream->state != SDW_STREAM_PREPARED &&
>  	    stream->state != SDW_STREAM_DISABLED) {
>  		pr_err("%s: %s: inconsistent state state %d\n",
> @@ -1744,6 +1751,12 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
>  
>  	sdw_acquire_bus_lock(stream);
>  
> +	if (stream->state == SDW_STREAM_DISABLED) {
> +		/* nothing to do */
> +		ret = 0;
> +		goto state_err;
> +	}
> +
>  	if (stream->state != SDW_STREAM_ENABLED) {
>  		pr_err("%s: %s: inconsistent state state %d\n",
>  		       __func__, stream->name, stream->state);
> @@ -1809,6 +1822,12 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>  
>  	sdw_acquire_bus_lock(stream);
>  
> +	if (stream->state == SDW_STREAM_DEPREPARED) {
> +		/* nothing to do */
> +		ret = 0;
> +		goto state_err;
> +	}
> +
>  	if (stream->state != SDW_STREAM_PREPARED &&
>  	    stream->state != SDW_STREAM_DISABLED) {
>  		pr_err("%s: %s: inconsistent state state %d\n",
> -- 
> 2.20.1

-- 
~Vinod
