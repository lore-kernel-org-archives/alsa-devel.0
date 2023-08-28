Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5440EC83F11
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Aug 2023 11:14:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7A78A4D;
	Mon, 28 Aug 2023 13:13:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7A78A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693221241;
	bh=VwTnlYWKzRUsbpO7VF3ElRn4ag5+R4zmWxVaLMqTchI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YYjNPtM5YKREGAUz2VfENCYUljlkuILd1W/Q59bG3pcKAZoL6xd5+8lz6efvsv9F/
	 dB8BJWBGwctjGa6KsRX80vg3p7yScpTLTci3slqN9bvvNSlgrEC8/zurb/EhGz5uWq
	 H0DbJP/cTl0YV6QwyurdbB086YDCfiApsjJ7foGA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6CE4F8023B; Mon, 28 Aug 2023 13:12:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DFCCF80158;
	Mon, 28 Aug 2023 13:12:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 95408F80158; Mon, 28 Aug 2023 13:12:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DB792F800F5
	for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2023 13:12:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB792F800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Boy968x2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693221151; x=1724757151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VwTnlYWKzRUsbpO7VF3ElRn4ag5+R4zmWxVaLMqTchI=;
  b=Boy968x2tThGLY0DY23OzBFV5ZSUDa00ygO8zcnxciEbw8eb19/9RPf8
   0xanH9TkiRie75DRMQaddVQfoVmm7HVdBUDKUYPvoW4W9PVZf9J/Bb2ga
   Yq215Rvgpll/t3N3+Cbrdb87JyQVhtuUyAcozKnIgjJEmQrz9jYQkQFFr
   TxKtXUXO9Fck/mzM2u28TE2DHClqsF8ZuqjWneNGK3pDRdeUkSTLjgWiM
   mACe+qafPyEMOc/Fc5pVVHAee/bVKZQPhXms+rZ0CG8CHJIJWHkC1faOW
   ITvzy8Au/HZAS46uPNA4yNwN9s8EGDWFZWGQ7kbHnwV5Pm8tIIB73fv5s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="360071759"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000";
   d="scan'208";a="360071759"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2023 04:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="1068999723"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000";
   d="scan'208";a="1068999723"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2023 04:12:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qaaAN-00FedS-2D;
	Mon, 28 Aug 2023 14:12:19 +0300
Date: Mon, 28 Aug 2023 14:12:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm8580: Simplify probe()
Message-ID: <ZOyBE7znVJNjLB3z@smile.fi.intel.com>
References: <20230827102114.55863-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827102114.55863-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: XS2RL6DHIKIOBEXMFYSDKMAHV23OC5HL
X-Message-ID-Hash: XS2RL6DHIKIOBEXMFYSDKMAHV23OC5HL
X-MailFrom: andriy.shevchenko@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XS2RL6DHIKIOBEXMFYSDKMAHV23OC5HL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, Aug 27, 2023 at 11:21:14AM +0100, Biju Das wrote:
> Simplify probe() by replacing of_match_device->i2c_get_match_data() and
> extend matching support for ID table.

...

> -		return -EINVAL;

> +		return dev_err_probe(-ENODEV);

Commit message doesn't explain this change.

...

> +static const struct of_device_id wm8580_of_match[] = {
> +	{ .compatible = "wlf,wm8580", .data = &wm8580_data },
> +	{ .compatible = "wlf,wm8581", .data = &wm8581_data },

> +	{ },

Do not put comma in the terminator entry. It's illogical.

> +};

-- 
With Best Regards,
Andy Shevchenko


