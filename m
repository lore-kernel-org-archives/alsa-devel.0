Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0834CCA481
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jun 2022 13:48:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 933FB165E;
	Thu, 30 Jun 2022 15:47:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 933FB165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656596915;
	bh=K6USsSMJ8UC9wOjFtx6U82V6WBAGj2etKO7gooeB8dw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t5MXHaPsf1t+HaN93Fznwjysd2hzyYbaQejA1NrACBYijTUGtkEeoxhEtz3f6u6uV
	 VL1mnfbAtD7HqsLaQIiGQyNIUFNhkMQ+9BQjAz2musBIBD9HYuR+SMoul3swxyxs22
	 RksKDAmF0zVHNuPlM5+VIVIvvLsmpOnM9N7Mbns4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 380C3F804D2;
	Thu, 30 Jun 2022 15:47:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77C05F804D8; Thu, 30 Jun 2022 15:47:43 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B1F0F800F5
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2022 15:47:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B1F0F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="HjrBNSOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656596861; x=1688132861;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=K6USsSMJ8UC9wOjFtx6U82V6WBAGj2etKO7gooeB8dw=;
 b=HjrBNSOyBWAY0CIA3YKV/J+lA3QW2JKNNR7B/RmEiCno2R/MEOHe6s7F
 8LE0Hx2pqd5x+8GMSif6Wf8OmY7OvtrmL0H7ONblu0qU84eBBHfx6RfR0
 bizFTl8QgEyxjZ7ah2ToiXw6gUPXwz4tRUZIOqgrrsU+PY9jLVRDge7f0
 P+roWMSvgTAFDfsihpwVd8OsM5lhbxAljXb6lOUYNCCTDpK4376G3gheg
 0RCTA7AwYRLkGFnpRBK/kC3ZtbQachozZhDNhVbZIjBUiuRUZpXFyQyiS
 Gv2SO2yYlflt+SLXBbPbJ+9zonWG2zi5qquxkA4YVeas9q451nKjk7wig w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="283450338"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; d="scan'208";a="283450338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 06:47:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; d="scan'208";a="617980754"
Received: from jhilliar-mobl.amr.corp.intel.com (HELO [10.212.10.157])
 ([10.212.10.157])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2022 06:47:36 -0700
Message-ID: <aee14e9b-9d5f-f243-5834-88d18b4a65db@linux.intel.com>
Date: Thu, 30 Jun 2022 08:09:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa881x: handle timeouts in resume path
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20220630130023.9308-1-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220630130023.9308-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com
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



On 6/30/22 08:00, Srinivas Kandagatla wrote:
> Currently we do not check if SoundWire slave initialization timeout
> expired before continuing to access its registers.
> 
> Its possible that the registers are not accessible if timeout is
> expired. Handle this by returning timeout in resume path.
> 
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Fixes: 8dd552458361 ("ASoC: codecs: wsa881x: add runtime pm support")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

For the two patches

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/codecs/wsa881x.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
> index dc954b85a988..6c8b1db649b8 100644
> --- a/sound/soc/codecs/wsa881x.c
> +++ b/sound/soc/codecs/wsa881x.c
> @@ -1173,11 +1173,17 @@ static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct regmap *regmap = dev_get_regmap(dev, NULL);
>  	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
> +	unsigned long time;
>  
>  	gpiod_direction_output(wsa881x->sd_n, 1);
>  
> -	wait_for_completion_timeout(&slave->initialization_complete,
> -				    msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
> +	time = wait_for_completion_timeout(&slave->initialization_complete,
> +					   msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
> +	if (!time) {
> +		dev_err(dev, "Initialization not complete, timed out\n");
> +		gpiod_direction_output(wsa881x->sd_n, 0);
> +		return -ETIMEDOUT;
> +	}
>  
>  	regcache_cache_only(regmap, false);
>  	regcache_sync(regmap);
