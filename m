Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D46C77B7D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 10:39:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9C2474C;
	Thu, 18 May 2023 12:38:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9C2474C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684406368;
	bh=HtxTmpVhBleR8pSU1GMJWJLoJvDVvl9f1VyIqr8yPWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=J+2AXN9UO1rMj2nwvLHhVGPeCFOdp5dMA4MzL5GWcYxWZXfavweGsp55yZZ2v2vZP
	 2j9GFHUglkK+wFTvy2CVVFFkvEm8ukksuRwmGwVw6oD/BgKTcgzLg108dq7J2iWlh0
	 d39fLphLHncUq7SPMXfCcvx7sH42BIakF75sXTsc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7487CF80570; Thu, 18 May 2023 12:38:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FE6BF8055C;
	Thu, 18 May 2023 12:38:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24520F80272; Thu, 18 May 2023 12:38:01 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 76EEDF8016D
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 12:37:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76EEDF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bjLceFUR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684406279; x=1715942279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HtxTmpVhBleR8pSU1GMJWJLoJvDVvl9f1VyIqr8yPWk=;
  b=bjLceFURjX0ZOQW73NyJU+XRtA+G1YoRAD8mQudVRM/dmYj6IpPnyLTg
   ssMpWgRi5kMhOiM7wanMFXYEb9jNoLKDD8rRkgDhnVo7HtEPhP43y9l7j
   MN1WzKOG1kCCjh6QP2RSUxBkgoOLX0+hRJrvIpEeh6yfiVMo/q2YHwAt7
   v1qYQ7jL62bGo2fDss7x/BbFQeuOH/VrVHrQZaAm0DRUT6mGqjqw910Fo
   J6koKaClPfnm6+Q1ZtAo1C1tjdjSnKlU1dVmomjT5zsyo1ASo51wFHk2V
   Fe5yZko047hYl7qpHcr+dJqlu6RvozCwBSFZLUl0f//Qu+a2Mv9dlcAmB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349544854"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="349544854"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 03:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="791929470"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="791929470"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144])
 ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 03:37:56 -0700
Message-ID: <1a46a8a6-6822-5fce-3d7b-3944b1a31aad@linux.intel.com>
Date: Thu, 18 May 2023 12:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/20] ASoC: soc-pcm.c: use dai_link on
 soc_get_playback_capture()
Content-Language: en-US
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
References: <87353uqjiu.wl-kuninori.morimoto.gx@renesas.com>
 <87zg62p4xi.wl-kuninori.morimoto.gx@renesas.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <87zg62p4xi.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TEUPBXEFU7LPKZTENTEOJ3YGHGD7LVTW
X-Message-ID-Hash: TEUPBXEFU7LPKZTENTEOJ3YGHGD7LVTW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TEUPBXEFU7LPKZTENTEOJ3YGHGD7LVTW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 5/18/2023 7:46 AM, Kuninori Morimoto wrote:
> soc_get_playback_capture() (A) is using rtd->dai_link->xxx everywhere.
> Because of that, 1 line is unnecessarily long and not readable.
> 
> (A)	static int soc_get_playback_capture(...)
> 	{
> 		if (rtd->dai_link->dynamic ...) {
> 		    ^^^^^^^^^^^^^
> 			...
> 		} else {
> 			int cpu_capture = rtd->dai_link->c2c_params ?
> 					  ^^^^^^^^^^^^^
> 			...
> 		}
> 
> 		if (rtd->dai_link->playback_only) {
> 		    ^^^^^^^^^^^^^
> 			...
> 		}
> 		...
> 	}
> 
> This patch uses variable "dai_link" to be clear code.
> Nothing changes the meanings.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
