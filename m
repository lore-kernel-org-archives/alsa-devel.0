Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAD8C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Mar 2022 08:38:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D29511721;
	Wed,  9 Mar 2022 09:37:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D29511721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646815082;
	bh=br0Ks0x/B/6K1FBNRqE+IVP3UylZgYmhB0SZRUpCtYM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBs6DYGH++KuAwCGK0QevrtEBwjUruV6b7l9sKvNRov2tgF2Q9aJpDIgbOd8n7gL8
	 MS0WX6X4JLHJqbFGHrNVFLwLRY8s8DDdo+lvF9Usywj+hXLQglBiQKL4cN8w1kvCWk
	 hpFREKJv+AWPJfeinwjkwqalPu+J13gT172csoJ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CF59F80155;
	Wed,  9 Mar 2022 09:37:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38FAAF80155; Wed,  9 Mar 2022 09:37:11 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57D07F80155
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2022 09:37:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57D07F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="UWMuuRdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646815025; x=1678351025;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=br0Ks0x/B/6K1FBNRqE+IVP3UylZgYmhB0SZRUpCtYM=;
 b=UWMuuRdOCxZg8a5mzo5bH7SmeAu9evyj8z9XdKjp8uOlIpzsJ3NYKHED
 Cb9GnwdZTE5GIumI2kTX29hGSEdWpYOFuJjOC4//ICwQ+ROrVylGo7AQk
 G+MwKvt8mNd5V5nloOAXSgMPCBknvsBWF4NLz27ejsLZu3ruPzUpzfOMd
 BnHskR3VOhpi25oe9tKjUPISbAQyBuV/VbOqEJlf1nv/5FwyVQc5CEIgF
 pvUYEA2DQ75fg0ZisJlE1d91pQnNeFi7GrTqScrJ1A6yiLXfb93ttcB6k
 A0jQvrTdbdA7Mru6Zy5LJSwnXYkRUIUsWTmFH1LT6uRX5eEhLdb33jIUM Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="255112149"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; d="scan'208";a="255112149"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 00:36:58 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; d="scan'208";a="642073062"
Received: from hedwards-mobl1.ger.corp.intel.com (HELO [10.213.198.86])
 ([10.213.198.86])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 00:36:57 -0800
Message-ID: <f9f6f831-a05d-2d20-8ade-ab717f342ba5@linux.intel.com>
Date: Wed, 9 Mar 2022 08:36:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Intel-gfx] [PATCH v2] ALSA: hda/i915 - avoid hung task timeout
 in i915 wait
Content-Language: en-US
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org, 
 tiwai@suse.de
References: <20220308172759.920551-1-kai.vehmanen@linux.intel.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220308172759.920551-1-kai.vehmanen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: intel-gfx@lists.freedesktop.org, Lucas De Marchi <lucas.demarchi@intel.com>,
 amadeuszx.slawinski@linux.intel.com
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


On 08/03/2022 17:27, Kai Vehmanen wrote:
> If kernel is built with hung task detection enabled and
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT set to less than 60 seconds,
> snd_hdac_i915_init() will trigger the hung task timeout in case i915 is
> not available and taint the kernel.
> 
> Split the 60sec wait into a loop of smaller waits to avoid this.
> 
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Co-developed-by: Ramalingam C <ramalingam.c@intel.com>
> Signed-off-by: Ramalingam C <ramalingam.c@intel.com>
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> ---
>   sound/hda/hdac_i915.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Changes V1->V2:
>   - address local variable naming issue raised by Amadeusz
>     and use Takashi's proposal
> 
> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index 454474ac5716..aa48bed7baf7 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -143,7 +143,7 @@ static bool i915_gfx_present(void)
>   int snd_hdac_i915_init(struct hdac_bus *bus)
>   {
>   	struct drm_audio_component *acomp;
> -	int err;
> +	int err, i;
>   
>   	if (!i915_gfx_present())
>   		return -ENODEV;
> @@ -159,9 +159,11 @@ int snd_hdac_i915_init(struct hdac_bus *bus)
>   	if (!acomp->ops) {
>   		if (!IS_ENABLED(CONFIG_MODULES) ||
>   		    !request_module("i915")) {
> -			/* 60s timeout */

Where does this 60s come from and why is the fix to work around 
DEFAULT_HUNG_TASK_TIMEOUT in a hacky way deemed okay? For instance would 
limiting the wait here to whatever the kconfig is set to be an option?

Regards,

Tvrtko

> -			wait_for_completion_timeout(&acomp->master_bind_complete,
> -						    msecs_to_jiffies(60 * 1000));
> +			/* max 60s timeout */
> +			for (i = 0; i < 60; i++)
> +				if (wait_for_completion_timeout(&acomp->master_bind_complete,
> +								msecs_to_jiffies(1000)))
> +					break;
>   		}
>   	}
>   	if (!acomp->ops) {
> 
> base-commit: fd7698cf0858f8c5e659b655109cd93c2f15cdd3
