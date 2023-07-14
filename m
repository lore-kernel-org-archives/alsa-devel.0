Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87393EB64DC
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Jul 2023 11:17:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6E2FDEB;
	Fri, 14 Jul 2023 13:17:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6E2FDEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689333477;
	bh=GYXdmFtvQT38yb1qGuS4fihiMa4mlOiHOLM9SwIpk9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HAN0eSHE13HYRcE/osZL6He/rPzc/fXDXXwMvlg3sZm4jcozwgXnUk6GHCAbJ98D2
	 ZD3/ZR/eRsaJSMVIDJGEcJGxHUFbfQHTe1T+Lw8+DwROyQI59J70JaGFmMkH7SqfHa
	 vPIEMUC6oOiKmLZ5Iz3dnc55tWud0cH/kEie4g+Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB955F8024E; Fri, 14 Jul 2023 13:16:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E15B1F800D2;
	Fri, 14 Jul 2023 13:16:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 197FCF80249; Fri, 14 Jul 2023 13:16:33 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E7AA7F800E4
	for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2023 13:16:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7AA7F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Fj8CRBOg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689333389; x=1720869389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GYXdmFtvQT38yb1qGuS4fihiMa4mlOiHOLM9SwIpk9M=;
  b=Fj8CRBOgZscjHcHZezIUBlHCZdgW8DibwRDyY9lfctZ+ol/6+ED8I1CQ
   CacJXGYUyQRQ0ic9VpjB9zcz+qtNwahDUi1w5FWfq275WMgR4lJMlimC6
   NMy3VWF4gW1QqBStKYjRBCsuWJ8tmRepz+KUmYBJ/jqvsx7e2r8O5dvSc
   sJgokCdxdzANEBuDowqQ/ldugPVAowowJwVsMhHi1RzTd3PAiVoucxVKV
   37k47yqFN62CwI9wxxmI5sSTQTYo/BDLngLe0Cd17nuYGMPrQFOum3Jrv
   Hw9e8QjvaQ5153ZfG+HvhAFXOFKN/z6ZHq7FvvgROhTMFdoVLcUnKFOk8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368088712"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200";
   d="scan'208";a="368088712"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2023 04:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716305148"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200";
   d="scan'208";a="716305148"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2023 04:16:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qKGma-002dtm-13;
	Fri, 14 Jul 2023 14:16:20 +0300
Date: Fri, 14 Jul 2023 14:16:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 02/15] PCI: Add Intel Audio DSP devices to pci_ids.h
Message-ID: <ZLEuhComcqmTu/hK@smile.fi.intel.com>
References: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
 <20230714185615.370597-3-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714185615.370597-3-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: XW76STQSD6ZTXTE2S5FTWD4PXYVG65BF
X-Message-ID-Hash: XW76STQSD6ZTXTE2S5FTWD4PXYVG65BF
X-MailFrom: andriy.shevchenko@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XW76STQSD6ZTXTE2S5FTWD4PXYVG65BF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Jul 14, 2023 at 08:56:02PM +0200, Amadeusz Sławiński wrote:
> Those IDs are mostly sprinkled between HDA, Skylake, SOF and avs drivers.
> Almost every use contains additional comments to identify to which
> platform those IDs refer to. Add those IDs to pci_ids.h header, so that
> there is one place which defines those names.

...

> +#define PCI_DEVICE_ID_INTEL_HDA_BSW	0x2284
> +#define PCI_DEVICE_ID_INTEL_SST_CHV	0x22a8

In case you need to send a new version for the sake of consistency
either use CHV (CHT) or BSW for both. Basically these are code names
for the same (very similar) platforms/SoCs:
Braswell (BSW),  Cherry View (CHV), Cherry Trail (CHT)

-- 
With Best Regards,
Andy Shevchenko


