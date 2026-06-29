Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ABEC43458
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:16:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C753601ED;
	Mon, 29 Jun 2026 08:16:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C753601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782713771;
	bh=6g8pV5HsFV16uu1QcbkNKsU9WZvkLEX4mhCcxfmWeWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uMsNM3P/2DFSdlMCWwYKsMWedR4u/V2ntzm4qu0KbP2SKOf4e6g/+fpknX8q/8Jj5
	 EakKLqk+pTzM78D1DwDvCPNUzBCRQTM86DYpvKi/LzDan/BSmT+nmEHTzZDJfGauu8
	 /Sqita5D3+uB9/gI+bSmoXZo8MUBlzVbtoePsdt8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08229F805ED; Mon, 29 Jun 2026 08:15:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6674BF80601;
	Mon, 29 Jun 2026 08:15:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0B3FF80495; Mon, 29 Jun 2026 08:15:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782713725;
	b=ng/QxtpRJcjrSpl4ugx1i+n2i9t2uOG4NQrsoHvy4COjs7BX5YJmzuaf4KD+wfdzMb+8
	 pxv6lmkGlVg+h2leEohTpu+lh/n0TxeOo/chty9oEb9al7KqDfqRFfdg0pCQENLAGpZoS
	 jKXWSK9PSt/x6JA9aN6D7hHEeygq8+oI/ZucJHQh5MEBNpFhRemMO02tblX9Mfkuxveu0
	 s9KEzOuikAbRUz51RrBsTHOILozTLfkqbyuycNpgYKDorYSfeh6u13u/FWCTUADJkKCwf
	 pMpsRSHrbCFKwlMP/NU219J6P7MrzQOh6pA2e+b/Qn/HK+ZSIRM06otic6hIW8ovYBg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782713725;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=6g8pV5HsFV16uu1QcbkNKsU9WZvkLEX4mhCcxfmWeWk=;
	b=UVzEAZXV0GyUSgVhkSLzMjDxH5/44kOM1vFDPMapThWZrMPeP9zQQkP9JeB+d71zBkPr
	 KX/AziuLR/Bxr76tMtp2Y43MJI4l/ZpyL4DMwxLZox8ZrOGN4C0MzEgn4SwzaXI64iH28
	 O/Xtgnws/y7R5HWP1WgZbQGKIAlD0O6sz4ixABG9g5leMvvx7lyeudVGmd/1QRkHmCZGw
	 G1gLc0DiAaY19BWYy4fwn8aYJvwIGC7lgsb/ZGjIfuH6oNRcuVlGCCVzmHgUQhKrmOguu
	 iV2j3fCoAnFPiNkTjrNnTtKIF2eN/vLA2QMqG515VAXKD0yLGn3AOXCKyarFgXOvJbg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CGChKwcJ;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7ACFF80095
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2026 08:15:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7ACFF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CGChKwcJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782713725; x=1814249725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6g8pV5HsFV16uu1QcbkNKsU9WZvkLEX4mhCcxfmWeWk=;
  b=CGChKwcJzH0k9LIAKxjlxtfcd7AB/6z+LZwmqSPvVpgeZjMXnDJh7Chu
   nx6PisCSEqG20ZXYGa16N5UAegz2+QZLuH1XPrMYNWkB5+HpT8lAhL2Eu
   cy+fZPU2iEzpqp2uaoTyIwdkbX3w1OCDysjAY5pouHWRzeIHAQtztq479
   2uXcbwqWH8rs3GJBEaoARTVf/JGuNpyO3dM/WUIWhG+13P4GIFlg1Ofo8
   b8397srIva29JHldmK2Wwf4jGFdFe86+JUPZNpv7S05TEMPSeip+uipJN
   mHt5lLieo3emMd+ht2HOGiX9bZbG3IkZfJpPdt4o/HBWdJIf6W2gVKvG7
   A==;
X-CSE-ConnectionGUID: RtP9BK8pRy2h/2Q6j6FA1w==
X-CSE-MsgGUID: Z8CQ6khhRiSWYqBp9UjINw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="94544121"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600";
   d="scan'208";a="94544121"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2026 23:15:15 -0700
X-CSE-ConnectionGUID: R98MbvrYRDGrG3RP9QnoXQ==
X-CSE-MsgGUID: ka4VC1jOSFavy5yPrjxCoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600";
   d="scan'208";a="256270911"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.207])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2026 23:15:12 -0700
Date: Mon, 29 Jun 2026 09:15:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com
Subject: Re: [PATCH v1] ASoC: Intel: soc-acpi-ptl-match: add tas2783 support
Message-ID: <akINbu52R7PJA65Z@ashevche-desk.local>
References: <20260628122543.757-1-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628122543.757-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
Message-ID-Hash: B7A6ZOFOPRH4J5LW4CLCNEPUNK2ZURKD
X-Message-ID-Hash: B7A6ZOFOPRH4J5LW4CLCNEPUNK2ZURKD
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B7A6ZOFOPRH4J5LW4CLCNEPUNK2ZURKD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, Jun 28, 2026 at 08:25:43PM +0800, Baojun Xu wrote:
> Added tas2783 support in some projects.

...

> +static const struct snd_soc_acpi_adr_device tas2783_0_adr[] = {
> +	{
> +		.adr = 0x0000300102278301ull,
> +		.num_endpoints = ARRAY_SIZE(tas2783_endpoints),
> +		.endpoints = tas2783_endpoints,
> +		.name_prefix = "tas2783"

Leave trailing comma for the non-terminator entries.

> +	}
> +};

...

> +static const struct snd_soc_acpi_adr_device tas2783_2_adr[] = {
> +	{
> +		/* left */
> +		.adr = 0x0000390102000001ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_r_endpoint,
> +		.name_prefix = "tas2783-1"

Ditto.

> +	},
> +	{
> +		/* right */
> +		.adr = 0x00003c0102000001ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_r_endpoint,
> +		.name_prefix = "tas2783-2"

Ditto.

> +	},
> +};

...

...and so on for Intel case.

-- 
With Best Regards,
Andy Shevchenko


