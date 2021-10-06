Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24053C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A47960F94
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A47960F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0492E836;
	Wed,  6 Oct 2021 18:34:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0492E836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633538133;
	bh=QXQGt7gm0zVHmEj35AxTdfo87LllZML/x62U4A99vds=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRImoK7Nl9+Nti2R7s2eERURTMyAlNtcjvEusMZ4NcswqARRWOI5MTdGkt96oDD70
	 d8v4Gvgb+2+r7vPt8037KvVjCJBp++Ud4YVrgLIuMl8NfRh14HgpLFWaBM45ZDDuqq
	 3opBJSkJhWaj6nop4g84drDrQj5GR2fc4FtrHlRY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84299F80229;
	Wed,  6 Oct 2021 18:34:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 712FCF80240; Wed,  6 Oct 2021 18:34:41 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDD9AF8010B
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 18:34:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDD9AF8010B
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="225986757"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="225986757"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 09:34:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="439957347"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 09:34:18 -0700
Received: from andy by smile with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1mY9ry-009FyW-JQ; Wed, 06 Oct 2021 19:34:14 +0300
Date: Wed, 6 Oct 2021 19:34:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/4] ASoC: Intel: bytcr_rt5640: Use temporary variable
 for struct device
Message-ID: <YV3QBsj2gLzmePWE@smile.fi.intel.com>
References: <20211006150442.16503-1-andriy.shevchenko@linux.intel.com>
 <20211006150442.16503-2-andriy.shevchenko@linux.intel.com>
 <4b81a10dca78e286a9f806464b97111b5a15a91e.camel@perches.com>
 <YV3ER4uIL4aRWBjz@smile.fi.intel.com>
 <YV3FaZ+afuZZSIth@sirena.org.uk>
 <YV3JWzNgGInZ1Bt5@smile.fi.intel.com>
 <YV3MtOrpziyKqkxA@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV3MtOrpziyKqkxA@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Joe Perches <joe@perches.com>
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

On Wed, Oct 06, 2021 at 05:20:04PM +0100, Mark Brown wrote:
> On Wed, Oct 06, 2021 at 07:05:47PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 06, 2021 at 04:48:57PM +0100, Mark Brown wrote:
> > > On Wed, Oct 06, 2021 at 06:44:07PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Oct 06, 2021 at 08:21:01AM -0700, Joe Perches wrote:
> 
> > > > > Some will complain about a lack of commit message.
> 
> > > > Yeah, sorry for that, it wasn't deliberate. I forgot to run `git msg-filter`
> > > > on these three patches to add it.
> 
> > > > Mark, do you want me resend entire bunch(es) or just starting from these
> > > > patches? Or...?
> 
> > > If you're adding a commit message with automation it's probably not
> > > adding any value.
> 
> > What do you mean? I add it exceptionally for the same (by nature) patches.
> > What do you expect to be altered in these three, if the idea behind the change
> > is very well the same?
> 
> I really don't care if there's a separate changelog for trivial patches
> like this, it adds nothing of value.

I see. In any case I'll add something meaningful here.

-- 
With Best Regards,
Andy Shevchenko


