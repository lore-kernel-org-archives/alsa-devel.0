Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB44C7EE22
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 10:39:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12B99201;
	Thu, 18 May 2023 12:38:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12B99201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684406362;
	bh=4XvKZXwYNZk3G7p5kAZZJvQCX9gLl4FyBZgvRhfL5eg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Lscy/iFfJURatm/szzfhyynB9Rh+aWYv+LnBHcG/D5js2BY3grG0luTDmK7mDXyfj
	 cXcksj5RSt09QGLlmtI0hOIY9H7TC4c255x7lin4uRugVObOGZ70orreBq/IcsN0T5
	 9EHKrGBpJ3Rqse+492mRcfLxKQHVpe6sWf6/ewXo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C7F6F802E8; Thu, 18 May 2023 12:38:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F10B5F802E8;
	Thu, 18 May 2023 12:38:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4782CF80272; Thu, 18 May 2023 12:37:58 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 069CEF8016D
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 12:37:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 069CEF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=STqpGXAp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684406275; x=1715942275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4XvKZXwYNZk3G7p5kAZZJvQCX9gLl4FyBZgvRhfL5eg=;
  b=STqpGXApnJDSTsdSgLz7mYkV0X9WxiueIvx6l4XK9mj+djYSHgnjJBya
   VfG/Mr+2dQ/mheziZuDfP+61c6yHG+yEtiFH8EpD3LIBj5hOSCs5B2NAs
   ZkUCpmkrMQEg1RFKLc2OtykMI61EI9sxYHGJw/Le7jzT0hVm1xZeVkExY
   SYqHLmmuXXGSVsIOzN5pETxyzhdl2OSjdjj0VF4zKdVMD+qo0PFIOBApc
   fSLPdSq5rjhOfadAzi2jLRDVfA/oQ0mIXO8ORGNWL71ejCo6poN0eOHaH
   z9Z0g3GGkD/j6mfVbH3cfBQX0mamL2qXz4fB2iK3gPC22wMZyNxJ2WDOS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349544822"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="349544822"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 03:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="791929414"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="791929414"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144])
 ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 03:37:48 -0700
Message-ID: <70c5526e-1487-2693-94a3-feb4fc1c187f@linux.intel.com>
Date: Thu, 18 May 2023 12:37:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/20] ASoC: soc-pcm.c: indicate error if stream has no
 playback no capture
Content-Language: en-US
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
References: <87353uqjiu.wl-kuninori.morimoto.gx@renesas.com>
 <871qjeqji7.wl-kuninori.morimoto.gx@renesas.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <871qjeqji7.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QVKUAB6Y3LFPTJJNUI466Y2R567QA5GZ
X-Message-ID-Hash: QVKUAB6Y3LFPTJJNUI466Y2R567QA5GZ
X-MailFrom: amadeuszx.slawinski@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QVKUAB6Y3LFPTJJNUI466Y2R567QA5GZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 5/18/2023 7:46 AM, Kuninori Morimoto wrote:
> soc_get_playback_capture() (A) returns number of substreams for
> playback/capture (B).
> ASoC will probe the Sound Card and mapps CPU<->Codec pair.
> 
> (A)	static int soc_get_playback_capture(...,
> (B)				    int *playback, int *capture)
> 	{
> 		...
> 		if (rtd->dai_link->playback_only) {
> 			*playback = 1;
> 			*capture = 0;
> 		}
> 
> 		if (rtd->dai_link->capture_only) {
> 			*playback = 0;
> 			*capture = 1;
> 		}
> (C)
> 		return 0;
> 	}
> 
> But it might be no playback no capture if it returns playback=0, capture=0.
> It is very difficult to notice about it. This patch indicates error at (C)
> then.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

