Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16195C001B0
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jul 2023 11:48:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D8B1846;
	Mon, 24 Jul 2023 13:47:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D8B1846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690199315;
	bh=HlKjKbV8eSGYQBIcvbzDIb+yA+7AbO7JUoRDIFhHNxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CSONo8id/yvp1W9ukX512p3AXIZ44BMD/1NJsLaKW2Hd9exLzXXthJCUpmw18vP1B
	 M4BGYCm1AA4Is85r0cI0ZjxkfrZu20yhZQNioLDyaVcy5GW0RrGzPyj9DzzoCnI1J+
	 i7P8CF55HxzlI6rBSRQiL38PV+1XFc/n5RdpaUUA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB639F805AE; Mon, 24 Jul 2023 13:46:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1435F805A8;
	Mon, 24 Jul 2023 13:46:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85A4FF8055A; Mon, 24 Jul 2023 13:46:32 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6A691F80163;
	Mon, 24 Jul 2023 13:46:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A691F80163
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LjSlNjuA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690199182; x=1721735182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HlKjKbV8eSGYQBIcvbzDIb+yA+7AbO7JUoRDIFhHNxE=;
  b=LjSlNjuAGzsEwXvazx0eaKJ+2UYZXuKloNAzLfBMr0adyrV52d/kgGyL
   30y0ELEhSy5C+41Iglu3eQmjVMT+Y/dHJCyqZKNPqNQ2DkxUPSLRmPiy6
   9cubnQQRobY8CI0zU/jknP4zy+CPX4+fFvPGe2+EKfRDB1HR3LDnNUnGV
   tU0tqAT4HtyXDNfOWB75E+xbzyttlvnTu20VbtkS9GYlzDshNwHiTLDfl
   s4MSN21h46Mo6qshAdv5LdomY+WjbX1SNOhgb5eb2Wfvhjt0T3WnrzvXA
   XMUT6GWzkZRflqS4jMVqKeQCDQa8xxtuL9/i9rxEed8ox/6/zyul/ayvo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="398322210"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200";
   d="scan'208";a="398322210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2023 04:46:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="760761957"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200";
   d="scan'208";a="760761957"
Received: from sosterlu-mobl.ger.corp.intel.com (HELO [10.249.37.56])
 ([10.249.37.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2023 04:46:14 -0700
Message-ID: <518bb7a9-3a85-2c13-68bf-63baaff176ef@linux.intel.com>
Date: Mon, 24 Jul 2023 12:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/9] ALSA: hda/i915: Allow xe as match for
 i915_component_master_match
Content-Language: en-US
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 alsa-devel@alsa-project.org
Cc: sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-5-maarten.lankhorst@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230719164141.228073-5-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: MYOVCZXFECZIW6LL5VG6YDUPCCWM7T4N
X-Message-ID-Hash: MYOVCZXFECZIW6LL5VG6YDUPCCWM7T4N
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MYOVCZXFECZIW6LL5VG6YDUPCCWM7T4N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/19/23 18:41, Maarten Lankhorst wrote:
> xe is a new driver for intel GPU's that shares the sound related code
> with i915.
> 
> Don't allow it to be modprobed though; the module is not upstream yet
> and we should exclusively use the EPROBE_DEFER mechanism.

I can't figure out what this comment means.

how would the -EPROBE_DEFER mechanism help if the driver that will
trigger a new probe is not upstream?

Not following at all what you intended to explain.

> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  sound/hda/hdac_i915.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index 961fcd3397f40..12c1f8d93499f 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -115,7 +115,8 @@ static int i915_component_master_match(struct device *dev, int subcomponent,
>  	hdac_pci = to_pci_dev(bus->dev);
>  	i915_pci = to_pci_dev(dev);
>  
> -	if (!strcmp(dev->driver->name, "i915") &&
> +	if ((!strcmp(dev->driver->name, "i915") ||
> +		 !strcmp(dev->driver->name, "xe")) &&
>  	    subcomponent == I915_COMPONENT_AUDIO &&
>  	    connectivity_check(i915_pci, hdac_pci))
>  		return 1;
