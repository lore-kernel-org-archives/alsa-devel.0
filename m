Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F638C56202
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:18:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF9C20789
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SvFfUmoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF9C20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49CEF173D;
	Wed, 25 Nov 2020 17:17:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49CEF173D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606321089;
	bh=5tj9d2+Mw+O77Gy9ar6oI3rn0PILx0cLmPgMvhk5BIQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SvFfUmoWibqZKeIi/0UzW9qhGTkGzw1DfFtrFLj/O6clamIDWnlpbu3cPmbJCGdCM
	 EvNc7BIrxZpipMMGtxIL8mvh6U0m9EkHDYSd5Oo6CHuE6KCI85PaLH9xSOIQ6O+e+5
	 ZrN7zKpJvYtGBdavgQX1qjV+Of2wjZ3h76RQ+Vfg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE62DF8015F;
	Wed, 25 Nov 2020 17:17:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34693F8019D; Wed, 25 Nov 2020 17:17:17 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8923F80128
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 17:17:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8923F80128
IronPort-SDR: 02MwBJgh3AtHoWj3mAMQTieP7Pj4WZOr3c5AFSks2CixmHfuc8pCrQh5UiALytls2nwqKioMAp
 crmW75Imw2qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="190299284"
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; d="scan'208";a="190299284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 08:17:07 -0800
IronPort-SDR: y0htdTTEiWEL1dF38nmNwqMIo1hmafs4TD+tkZ1/2xIrJeX3ndNqwj3tp5HFH0UqonoMR2anXZ
 8gx8kF0O7p6g==
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; d="scan'208";a="478984679"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 08:17:05 -0800
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1khxUc-009fFc-Pd; Wed, 25 Nov 2020 18:18:06 +0200
Date: Wed, 25 Nov 2020 18:18:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of
 resource_intersection()
Message-ID: <20201125161806.GY4077@smile.fi.intel.com>
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
 <f33b4381ea3a4cf4b8e7f27676cd90ed@intel.com>
 <CAJZ5v0hxqydcoqTCDzR7O7Y4d71Qutx+k4sOmdvOY24f2-OWgg@mail.gmail.com>
 <20201125161028.GW4077@smile.fi.intel.com>
 <CAJZ5v0huXtSDtQEmUHx4NmjJhFNOVUMktD_eJ06=fsmZB40ayw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0huXtSDtQEmUHx4NmjJhFNOVUMktD_eJ06=fsmZB40ayw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "Rojewski, Cezary" <cezary.rojewski@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Nov 25, 2020 at 05:10:50PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 25, 2020 at 5:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Nov 25, 2020 at 04:49:39PM +0100, Rafael J. Wysocki wrote:

...

> > There is one fix to the series [1]. But now I realized that I forgot to Cc
> > linux-acpi@. Do you want me resend it?
> 
> Yes, please!

Done! Sent as v2.

-- 
With Best Regards,
Andy Shevchenko


