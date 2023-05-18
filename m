Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE376C77B7D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 10:40:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D8FD1FC;
	Thu, 18 May 2023 12:39:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D8FD1FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684406435;
	bh=692sRGlEXaIJcj6VYVlt3QasYF1QStzQntLZ66Zh5K8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nZ8jy58SryCpuyDcAcxyDIL2Ibiz9fPaydJczK8ee5wUEaAMfWvL8prcqRAlqJajR
	 +8OjdKs0FXkUAhA/CQ6ca3aZK4KhLFxtA+d7mlv6uYwtcMN9QMpwSwGf77B8YGiSzu
	 dOJJEy0d42EyOyhpmNHvGsUaRR2jllOTwsjLWr3g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70AF0F805B1; Thu, 18 May 2023 12:38:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0301BF80551;
	Thu, 18 May 2023 12:38:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D238CF80551; Thu, 18 May 2023 12:38:37 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3F86FF80544
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 12:38:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F86FF80544
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mibsBq0H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684406315; x=1715942315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=692sRGlEXaIJcj6VYVlt3QasYF1QStzQntLZ66Zh5K8=;
  b=mibsBq0HYPIRJsSHgVch7345yENt3RntPk7ZGV4mnbwJGjPw6vnWn/0E
   VVp3WpjTsx8QfIBUdjlNl2LL1oPg8dSXWP3kYxYiHor7tDMeCVy3OXucn
   HL9ezHJhzXZi4U/yDpqbWMll4bgyg2qWEycc7B8mltd7yD74Y+9rKk8t8
   jqlMTxWOgTCdwJnRMxiBBRjjaZYSwGSZQbpKRue2ySbJuHAIRjnUvfKO9
   ixa+XwEpZSEESAv2sHPX+GpEOOkURXuSpA1JY6keMH6sx8g1/8A/tNeA5
   lT+odBOKXhfC+54yuJWyD/jxnCWJTLP4O8TtW4Dl0HN3uIxVrioxPlU6I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="350865513"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="350865513"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 03:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="735034785"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="735034785"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144])
 ([10.99.16.144])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 03:38:28 -0700
Message-ID: <3fa42d43-9dbd-9183-3f3a-6e2dc112682a@linux.intel.com>
Date: Thu, 18 May 2023 12:38:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/20] ASoC: soc-pcm.c: cleanup normal connection loop at
 soc_get_playback_capture() part1
Content-Language: en-US
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
References: <87353uqjiu.wl-kuninori.morimoto.gx@renesas.com>
 <87ttwap4wq.wl-kuninori.morimoto.gx@renesas.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <87ttwap4wq.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5YRCLCK5UKDMSCH6CLXJB7BJK56QPP2M
X-Message-ID-Hash: 5YRCLCK5UKDMSCH6CLXJB7BJK56QPP2M
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5YRCLCK5UKDMSCH6CLXJB7BJK56QPP2M/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 5/18/2023 7:47 AM, Kuninori Morimoto wrote:
> soc_get_playback_capture() (A) is handling both DPCM (X) / Normal (Y)
> connection.
> 
> (A)	static int soc_get_playback_capture(...)
> 	{
> 		...
>   ^		if (dai_link->dynamic || dai_link->no_pcm) {
> (X)			...
>   v
>   ^		} else {
>   |			...
>   |(@)			for_each_rtd_codec_dais(rtd, i, codec_dai) {
>   |				if (dai_link->num_cpus == 1) {
>   |(a)					cpu_dai = ...
> (Y)				} else if (dai_link->num_cpus == dai_link->num_codecs) {
>   |(b)					cpu_dai = ...
>   |				} else {
>   |(c)					dev_err(...);
>   |				}
>   |				...
>   |			}
>   |			...
>   v		}
> 		...
> 	}
> 
> In Normal connection case (Y), it is checking number of CPU / Codec.
> 	(a) is for Single CPU case
> 	(b) is for Multi  CPU case
> 	(c) is for other case (error)
> 
> Because this loop (@) is not related to dai_link->num_xxx,
> we can judge (c) before entering this loop.
> And it is needed not only for Normal connection case (Y),
> but DPCM connection case (X) too.
> 
> This patch moves (c) to top side.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

