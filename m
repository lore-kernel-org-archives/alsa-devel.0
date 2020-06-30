Return-Path: <SRS0=uo8V=AL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F800C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:04:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B15206B6
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qqFpZfhh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB5gffAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B15206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B28921697;
	Tue, 30 Jun 2020 18:04:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B28921697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593533094;
	bh=m7bZWP2joANZChJ6MhUAkqCWwrdxb/SV7J2T8q0fe/8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qqFpZfhhqM2BZhO9DnafgqR2myf9/W+miiJPIjVvCZSFK31oSe0KIid4Q+dOGLTdE
	 rcJVdu6auhnX4ANesorqqBGLWXRpGkq+fvCjP7w2W+czT12YBWL1iAg5oggjlXeJRa
	 ez69wZER1izUJEnyJCyaEhlin5Dlj5ipRXqdyIik=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A9FDF801D8;
	Tue, 30 Jun 2020 18:04:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7B78F801F2; Tue, 30 Jun 2020 18:04:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2D2AF8013E
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2020 18:03:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2D2AF8013E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fB5gffAU"
Received: from localhost (unknown [122.182.251.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EAA1D206B6;
 Tue, 30 Jun 2020 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593533033;
 bh=m7bZWP2joANZChJ6MhUAkqCWwrdxb/SV7J2T8q0fe/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fB5gffAU8qe8AYGHLC7/rY/DsixukA2syobwl3+zuu+8MvM2B5K5g7N/ASQlQ3Nfg
 v1ikgcLy457otS1waweRAUEtFNjwTG0Pq7vyks35wytfCWCb6/3st3nBUQLH6CLTzo
 RKFbRG3FY75ubBj9jmmcoKlmfmywcuDEo0l73qng=
Date: Tue, 30 Jun 2020 21:33:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 2/5] soundwire: stream: add helper to startup/shutdown
 streams
Message-ID: <20200630160349.GR2599@vkoul-mobl>
References: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
 <20200622212332.16277-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622212332.16277-3-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
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

On 23-06-20, 05:23, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> To handle streams at the dailink level, expose two helpers that will
> be called from machine drivers.
> 
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/stream.c    | 90 +++++++++++++++++++++++++++++++++++
>  include/linux/soundwire/sdw.h |  2 +
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index a9a72574b34a..48daf4b48f51 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -13,6 +13,9 @@
>  #include <linux/slab.h>
>  #include <linux/soundwire/sdw_registers.h>
>  #include <linux/soundwire/sdw.h>
> +#include <sound/core.h>

Do we really need core header?

> +#include <sound/pcm.h>
> +#include <sound/soc.h>
>  #include "bus.h"
>  
>  /*
> @@ -1826,3 +1829,90 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>  	return ret;
>  }
>  EXPORT_SYMBOL(sdw_deprepare_stream);
> +
> +static int set_stream(struct snd_pcm_substream *substream,
> +		      struct sdw_stream_runtime *sdw_stream)

sdw_set_stream() please

> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *dai;
> +	int ret = 0;
> +	int i;
> +
> +	/* Set stream pointer on all DAIs */
> +	for_each_rtd_dais(rtd, i, dai) {
> +		ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream,
> +						 substream->stream);
> +		if (ret < 0) {
> +			dev_err(rtd->dev,
> +				"failed to set stream pointer on dai %s",
> +				dai->name);

lets use one line and shiny new 100 char limit, would make code read
better!

> +			break;

So on error should unset of stream pointer be done?

> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +int sdw_startup_stream(void *sdw_substream)

Can we have kernel doc style Documentation for exported APIs?

> +{
> +	struct snd_pcm_substream *substream = sdw_substream;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sdw_stream_runtime *sdw_stream;
> +	char *name;
> +	int ret;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		name = kasprintf(GFP_KERNEL, "%s-Playback", substream->name);
> +	else
> +		name = kasprintf(GFP_KERNEL, "%s-Capture", substream->name);
> +
> +	if (!name)
> +		return -ENOMEM;
> +
> +	sdw_stream = sdw_alloc_stream(name);
> +	if (!sdw_stream) {
> +		dev_err(rtd->dev, "alloc stream failed for substream DAI %s",
> +			substream->name);
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	ret = set_stream(substream, sdw_stream);
> +	if (ret < 0)
> +		goto release_stream;
> +	return 0;
> +
> +release_stream:
> +	sdw_release_stream(sdw_stream);
> +	set_stream(substream, NULL);
> +error:
> +	kfree(name);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sdw_startup_stream);
-- 
~Vinod
