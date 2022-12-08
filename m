Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA95C4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Dec 2022 16:26:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 096F3191A;
	Thu,  8 Dec 2022 17:25:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 096F3191A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670516789;
	bh=UgZMaJNVDbsqnMpEhkJkw2Xg5u/rG6Zyijp9PDtnyxY=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qNIbQ46hqUVTKAf9P/tVS07AZ7jMOMhnF2EBuIadE3g9j1qdODCpJjrnK5r1ukh+Y
	 w2wQOkSvK96joT86+iJ4r9UsvPXt4CDUUKFyyc4zz+IK+8f493q2ZG7kUOko6TfcyU
	 VNnU3y5y6ofIyDzM0WC/2ABwdnPhom03xcb9NIDI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD46FF801D8;
	Thu,  8 Dec 2022 17:25:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83946F80089; Thu,  8 Dec 2022 17:25:37 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 441ACF80089
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2022 17:25:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 441ACF80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="VRUqopMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670516732; x=1702052732;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UgZMaJNVDbsqnMpEhkJkw2Xg5u/rG6Zyijp9PDtnyxY=;
 b=VRUqopMrw3j34nKPiNmnaYOoGH1RFjO5Vg9nnutBIe8PfDzBg+qKl5h6
 LlROAujEMyVvTWVUNShukZpL/UN051ZCtAjUanX7ffh4vU7roni3Z+1hR
 VCObqTl21WIZs/zFUD7/o/YxMJyYqQMns/dFnRz3+VXZMVq00VWxrYiuB
 hAWmUAM7GueTiAFrH8qljO62MBHxo4SrFA2u+OAg8T8YMuA9OhX9jXhBW
 Wnv23378MQmoP1FrfQ4npkdJaYKX+q6aNAqTAldlequ6EHz9NKZk8CmZ7
 hHbWBQk5uRf7cpoRNoUkbuk3zbPIUnTxozGgy0PRMm5QVBEpF4JG7RHnC Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="296903754"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; d="scan'208";a="296903754"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2022 08:25:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="677810622"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; d="scan'208";a="677810622"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.223])
 ([10.99.249.223])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2022 08:25:24 -0800
Message-ID: <5dd6e067-bc93-ad01-8cf2-3bb5c9a45443@linux.intel.com>
Date: Thu, 8 Dec 2022 17:25:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/3] ALSA: hda/hdmi: fix i915 silent stream programming
 flow
Content-Language: en-US
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org, 
 tiwai@suse.de
References: <20221208154358.3848764-1-kai.vehmanen@linux.intel.com>
 <20221208154358.3848764-2-kai.vehmanen@linux.intel.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20221208154358.3848764-2-kai.vehmanen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: intel-gfx@lists.freedesktop.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
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

On 12/8/2022 4:43 PM, Kai Vehmanen wrote:
> The i915 display codec may not successfully transition to
> normal audio streaming mode, if the stream id is programmed
> while codec is actively transmitting data. This can happen
> when silent stream is enabled in KAE mode.
> 
> Fix the issue by implementing a i915 specific programming
> flow, where the silent streaming is temporarily stopped,
> a small delay is applied to ensure display codec becomes
> idle, and then proceed with reprogramming the stream ID.
> 
> Fixes: 15175a4f2bbb ("ALSA: hda/hdmi: add keep-alive support for ADL-P and DG2")
> Link: https://gitlab.freedesktop.org/drm/intel/-/issues/7353
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Tested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>   sound/pci/hda/patch_hdmi.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 7a40ddfd695a..a0ba24165ae2 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -2879,9 +2879,28 @@ static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
>   				 hda_nid_t pin_nid, int dev_id, u32 stream_tag,
>   				 int format)
>   {
> +	struct hdmi_spec *spec = codec->spec;
> +	int pin_idx = pin_id_to_pin_index(codec, pin_nid, dev_id);

Shouldn't return value from pin_id_to_pin_index() be checked? It seems 
that it can return -EINVAL.

> +	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
> +	int res;
> +
>   	haswell_verify_D0(codec, cvt_nid, pin_nid);
> -	return hdmi_setup_stream(codec, cvt_nid, pin_nid, dev_id,
> -				 stream_tag, format);
> +
> +	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
> +		silent_stream_set_kae(codec, per_pin, false);
> +		/* wait for pending transfers in codec to clear */
> +		usleep_range(100, 200);
> +	}
> +
> +	res = hdmi_setup_stream(codec, cvt_nid, pin_nid, dev_id,
> +				stream_tag, format);
> +
> +	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
> +		usleep_range(100, 200);
> +		silent_stream_set_kae(codec, per_pin, true);
> +	}
> +
> +	return res;
>   }
>   
>   /* pin_cvt_fixup ops override for HSW+ and VLV+ */

