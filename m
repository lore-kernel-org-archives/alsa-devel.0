Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB9AEB64DA
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 15:55:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4F90DEC;
	Wed, 12 Jul 2023 17:54:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4F90DEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689177341;
	bh=Ntin9ux60UydRjUjJN52xacdzkihb/yAwVR8rFD8U60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i/iD/GeaSoPZOzpyDIboBZ2rCNrWQSH+6KPN6JG8Z4z+jzyDgjPzMlbeKS9xaa52S
	 RlHi/STTeWaiOE4TIFEYu/1z1X9rhXpD51VZKIWhg3gm8rANS6vIyLWUpBBObxXk70
	 MRZHue9xAxej/4S0zG31af4J7F70wGWcrqTP0E1U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54401F8027B; Wed, 12 Jul 2023 17:54:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9D69F8027B;
	Wed, 12 Jul 2023 17:54:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46763F80551; Wed, 12 Jul 2023 17:54:28 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 47E62F80290
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 17:54:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47E62F80290
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K2pKjRIb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689177265; x=1720713265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ntin9ux60UydRjUjJN52xacdzkihb/yAwVR8rFD8U60=;
  b=K2pKjRIbu0EwNmmeCbTxlxSXIYXZDndMFZ06CvMY9H3+dOpMZ1Jv0GzL
   8Y/OHFbaRtaIvA/TNxH5Kelv7CHvsyFXr0s0SbrI5NsXOn+bthw707wb4
   s3a/+MOjUNLJ9u7qc4Y0zXflLSRydmPw6oxbXnxAzZdWsUbUVYDJBqtch
   DswY1xPzVC4fU22h/HuXMq5T3N1ybK3qAGb+XiVb6Wv1GJp7w3hOtWsAy
   /Se2n0INN3+gw9yYRY8ZClJNMEGLpp6nVs/D4LJJhQ6q4h5t/C2JLFrEq
   s2/LvnOYUZlmYrg/18qYk0JklMrptI57Cp12IYdzY9vzYcNW/XmaY8Nk8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="395725084"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200";
   d="scan'208";a="395725084"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 08:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866174784"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200";
   d="scan'208";a="866174784"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2023 08:54:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qJcAS-002AZo-2J;
	Wed, 12 Jul 2023 18:54:16 +0300
Date: Wed, 12 Jul 2023 18:54:16 +0300
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
Subject: Re: [PATCH 13/13] ASoC: Intel: sst: Convert to PCI device IDs defines
Message-ID: <ZK7MqGyGYJ9eMlH1@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-14-amadeuszx.slawinski@linux.intel.com>
 <ZK1oKYW0rro4FnNO@smile.fi.intel.com>
 <958f3638-f68a-ebec-29cc-816f823b017f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <958f3638-f68a-ebec-29cc-816f823b017f@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: 7GB4DYVZERQHPSXTZBU5ZGVIXRFW5TXW
X-Message-ID-Hash: 7GB4DYVZERQHPSXTZBU5ZGVIXRFW5TXW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7GB4DYVZERQHPSXTZBU5ZGVIXRFW5TXW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jul 12, 2023 at 02:19:47PM +0200, Amadeusz Sławiński wrote:
> On 7/11/2023 4:33 PM, Andy Shevchenko wrote:
> > On Tue, Jul 11, 2023 at 02:57:26PM +0200, Amadeusz Sławiński wrote:
> > > Use PCI device IDs from pci_ids.h header.

...

> > >   	switch (sst->dev_id) {
> > > -	case SST_MRFLD_PCI_ID:
> > > +	case PCI_DEVICE_ID_INTEL_ADSP_TNG:
> > >   	case SST_BYT_ACPI_ID:
> > >   	case SST_CHV_ACPI_ID:
> > 
> > I think this needs a bit more, i.e. replacing the rest with respective PCI IDs.
> > 
> > All three will be defined with SST prefix, which makes sense to me.
> > 
> > ACPI here is a bit misleading, but correct. The ACPI specification assumes that
> > respective part of the ID space covers 100% of PCI ID space.
> > 
> > I have briefly checked the code and it seems that ID is used externally only
> > for PCI case, so we may simply use the lower 16 bits of the ACPI _HID for the
> > context.
> 
> Do I understand correctly that I should just do:
> #define PCI_DEVICE_ID_INTEL_SST_BYT	0x0F28
> #define PCI_DEVICE_ID_INTEL_SST_CHV	0x22A8
> and use those IDs instead?

Correct!

-- 
With Best Regards,
Andy Shevchenko


