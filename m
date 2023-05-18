Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B58C77B7D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 10:40:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCC9A741;
	Thu, 18 May 2023 12:39:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCC9A741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684406417;
	bh=9MTueHUzcHvwjSKJNSFBUqdy6R4Em/U7psqcjXPTB/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=P347uZ7LyNUJRFWAXmq9oKNW2JZec/q5ESAJyicxHD0jgVDdG9UiLk1lf1KsqLVyL
	 9K77xbAQ+h0QQZp2d2ghCIddzSpLw1wANtiQ2a6VOJf02MBQv8jM12r/UsrQG3y1Q1
	 a1fxdV1yiyIxhcgc3sdAa0syQ+aphexgfTdryjUk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E08B9F805AD; Thu, 18 May 2023 12:38:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74694F805AB;
	Thu, 18 May 2023 12:38:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2AFFF805A9; Thu, 18 May 2023 12:38:25 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C42F8F805A8
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 12:38:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C42F8F805A8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m1HnXZgv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684406305; x=1715942305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9MTueHUzcHvwjSKJNSFBUqdy6R4Em/U7psqcjXPTB/s=;
  b=m1HnXZgv8P345tgR0PliK5a6xCVLScVFjRt27/gmIw5zgrSrLB461vYk
   ChCeuqLJIh62OoZ0wcEr874y5iGu9/JPwUf7/z1mTARclQqNfsHyDoozA
   LvMQrCxyDrAuu/xRFWowm89Jbb/kTLjK1oXzZMeMAY/TZwhc2d5DBgbmM
   7nKrg14f9BSjbDvw7ll2Te48olUoFqS4hv00y4x2aAyh0tJ/mcRf5aUyK
   5s9QRNLDV0cNv3LlXyweo+eBYRVqOUYjkkzyLfqINsf5Q9xQTA13rKSef
   7YbZed5Z2tpfGboL8tOttW16pbgQso5jeYBwMpT0lW3VmJYttPzvRb2f8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349544961"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="349544961"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 03:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="791929826"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="791929826"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144])
 ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 03:38:20 -0700
Message-ID: <ebd7a5ee-f712-f7da-ec39-41b0692469a8@linux.intel.com>
Date: Thu, 18 May 2023 12:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/20] ASoC: soc-pcm.c: tidyup playback/capture_only at
 soc_get_playback_capture()
Content-Language: en-US
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
References: <87353uqjiu.wl-kuninori.morimoto.gx@renesas.com>
 <87v8gqp4ww.wl-kuninori.morimoto.gx@renesas.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <87v8gqp4ww.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JB6GYPODZHAVAIYSHS3Y3ZORSUHY66NI
X-Message-ID-Hash: JB6GYPODZHAVAIYSHS3Y3ZORSUHY66NI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JB6GYPODZHAVAIYSHS3Y3ZORSUHY66NI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 5/18/2023 7:47 AM, Kuninori Morimoto wrote:
> soc_get_playback_capture() (A) returns number of substreams for
> playback/capture, and then, we can use playback/capture_only flag (X)(Y).
> 
> (A)     static int soc_get_playback_capture(...)
> 	{
> 		...
> (X)		if (dai_link->playback_only) {
> (*)			*playback = 1;
> 			*capture = 0;
> 		}
> 
> (Y)		if (dai_link->capture_only) {
> 			*playback = 0;
> (*)			*capture = 1;
> 		}
> 		...
> 	}
> 
> But this flag should not have effect to opposite side stream (*).
> This patch tidyup it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

