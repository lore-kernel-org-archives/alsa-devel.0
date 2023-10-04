Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE15E7B611
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Oct 2023 13:08:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2791826;
	Wed,  4 Oct 2023 15:07:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2791826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696424923;
	bh=a2fdMuntzv5YAth2tcOATyGOhQ50h9WmHxxpzK4g3gM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WtxxTeA8vDnLMLvO1I0lv5NetfAXF6rKFmCND7yN3pj1KXWjabSimdCCcx388cI67
	 U5FmF1dPYMy0BNgZ6zfen3m8adqDtF4YgiBo2pk+Z/OXf1qHw1XrfKNDr5szYMSDWE
	 H3YzGJCf5X0bkze3BqRozAYEMo237JcMnn9IEVig=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CF0CF80557; Wed,  4 Oct 2023 15:07:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37C19F80130;
	Wed,  4 Oct 2023 15:07:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14615F8047D; Wed,  4 Oct 2023 15:07:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7C59DF80130
	for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2023 15:07:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C59DF80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Qx2//NFp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696424837; x=1727960837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a2fdMuntzv5YAth2tcOATyGOhQ50h9WmHxxpzK4g3gM=;
  b=Qx2//NFpn7pkU05DB7WtYQArSzVRZAiDwEAabOtgjfNt0xHoGjRaXYBS
   LFe3B/3+dW91UuKL3jv/lKaosMrc4pphGmAl4D5NbjZ1xqr3FqdokIwIM
   T2p35eTACJ2a1zX0Xh0/l06xaWF79MU71s4g9pc0SlFXeJ2HxLEHUoPB4
   JwDfutsYkyBnCwEM7qAPEMFnM89SVsfYHN1GNYRoGumZct8ElqRXlUA9c
   cbIL+Ot9J+P6x4VpXf9PT07T9jxZb/dRpC43b8qGEmXNhOYhudiV+ke60
   3+YF645nWhq0qsn2BPmdWaDCx5H0eRrhewakGGc0TQP7mD/nw7by54ihU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="414080588"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200";
   d="scan'208";a="414080588"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2023 06:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="744966509"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200";
   d="scan'208";a="744966509"
Received: from mfmousa-mobl1.amr.corp.intel.com (HELO [10.212.98.56])
 ([10.212.98.56])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2023 06:06:49 -0700
Message-ID: <6c249580-ccdd-453f-9051-ca2a32dc4189@linux.intel.com>
Date: Wed, 4 Oct 2023 09:06:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: soc-pcm.c: fixup validation check of multi
 CPU/Codec on soc_get_playback_capture()
Content-Language: en-US
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Jerome Brunet <jbrunet@baylibre.com>
References: <87il7mg69z.wl-kuninori.morimoto.gx@renesas.com>
 <87h6n6g69d.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <87h6n6g69d.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 2QIGAYB4VM3UK5VI6K3MHBAPYZA3L555
X-Message-ID-Hash: 2QIGAYB4VM3UK5VI6K3MHBAPYZA3L555
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2QIGAYB4VM3UK5VI6K3MHBAPYZA3L555/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Morimoto-san,

> Current soc_get_playback_capture() are checking validation of CPU/Codec
> like below
> 
> 	static int soc_get_playback_capture(...)
> 	{
> 		...
>  ^		if (dai_link->dynamic || dai_link->no_pcm) {
> (X)				...
>  v		} else {
>  ^			...
>  |			for_each_rtd_codec_dais(rtd, i, codec_dai) {
>  |				...
>  |				if (snd_soc_dai_stream_valid(codec_dai, ...) &&
>  |				    snd_soc_dai_stream_valid(cpu_dai,   ...))
> (Y)(a)					has_playback = 1;
>  |				if (snd_soc_dai_stream_valid(codec_dai, ...) &&
>  |				    snd_soc_dai_stream_valid(cpu_dai,   ..))
>  | (b)					has_capture = 1;
>  |			}
>  v		}
> 		...
> 	}
> 
> (X) is for DPCM connection, (Y) is for Normal connection.
> In Normal connection (Y), it is handling CPU/Codec, and it will set
> has_playback/capture = 1 at (a)(b), but it means today is "at least one
> of CPU/Codec pair was valid" in multi CPU/Codec case.
> 
> This is wrong, it should be handled when "all CPU/Codec are valid".
> This patch fixup it.

I knew this code looked familiar and sure enough we've been there before
in 2020. This code was introduced by

4f8721542f7b ASoC: core: use less strict tests for dailink capabilities

the initial stricter tests caused a number of regressions reported by
Jerome Brunet so we lowered the bar from "all dais" to "at least one
dai" to be backwards-compatible.

I don't think we can revisit this without hitting the same sort of issues.

Regards,
-Pierre
