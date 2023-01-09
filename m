Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F40C54EBD
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Jan 2023 10:57:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1D1A9F02;
	Mon,  9 Jan 2023 11:56:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1D1A9F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673261823;
	bh=432/GTUDWbVLE2I1BF6A2bekIYJZUgz/xcsj/jl86LE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=KSGBBNFLk5B6YOz6Pvx+tonB7vTrCjo3vfyk/eYCb/R5sIYgs4AqZxXvQSIP55zH/
	 Z0BTC0HjtVfuiTv6JCxo9fHvdGvgGpyo+dzu7tZHCxmhQVWqTzOX+X//N2WEZH7Vix
	 bT+6bTVBuyZ/P681+DgwNPRtzjYE7Ebsajg2Nx7E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81C78F802BE;
	Mon,  9 Jan 2023 11:56:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8B7DF80245; Mon,  9 Jan 2023 11:56:11 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAAE4F80245
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2023 11:56:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAAE4F80245
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OqM3hz5J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673261771; x=1704797771;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=432/GTUDWbVLE2I1BF6A2bekIYJZUgz/xcsj/jl86LE=;
 b=OqM3hz5JxEzSNvxMjB4cRc8cg0YJHkpUffhKd49f+orNjTpPfF0lTOcZ
 hKndt7lqfEN2Azek1dOa46TiR9q4I3vPD0v2HCZaJlTfQLwHa678m77ns
 q5lfejc9ynTai28gj6Ys2PWNmHMY9dhoiRb5V0qfs1vu85gqEyfev338h
 a9SbjTCwclBNx97dE+VpFUQUJ3q4APr+XJvVBYHeiPoieTR0dlq3gwjRw
 XA/0jVGv+UrRaenYF09H2Spqp+PN+VKA9WCuM8qynQxhWT+5wJKq6P7o7
 Nfwb19+0LC8NFFeZssAg4usGKHzIDHAmjq0r9w024hKBpZaSBt9tyw8s3 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="320547438"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; d="scan'208";a="320547438"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2023 02:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="901958882"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; d="scan'208";a="901958882"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2023 02:56:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1pEpou-006M1y-0C; Mon, 09 Jan 2023 12:56:00 +0200
Date: Mon, 9 Jan 2023 12:55:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Message-ID: <Y7vyv7mEmvCSA0eM@smile.fi.intel.com>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
 <731b2d59-22f1-a456-bcfc-040a1adccce0@linux.intel.com>
 <Y7VVCc7TjY3YsJoV@smile.fi.intel.com>
 <151a05a5-fc56-e005-e572-d031e6de0bb1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151a05a5-fc56-e005-e572-d031e6de0bb1@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Jan 04, 2023 at 08:15:27AM -0600, Pierre-Louis Bossart wrote:
> On 1/4/23 04:29, Andy Shevchenko wrote:
> > On Tue, Jan 03, 2023 at 09:08:20AM -0600, Pierre-Louis Bossart wrote:
> >> On 1/2/23 14:30, Andy Shevchenko wrote:

...

> >> I see at least four cases that were missed
> >>
> >> bytcr_rt5640.c:         put_device(&adev->dev);
> >> bytcr_rt5651.c:         put_device(&adev->dev);
> >> bytcr_wm5102.c: put_device(&adev->dev);
> >> sof_es8336.c:           put_device(&adev->dev);
> > 
> > Aren't they (they all problematic, btw) covered by the fixes series
> > https://lore.kernel.org/r/20230102203014.16041-1-andriy.shevchenko@linux.intel.com?
> 
> They are indeed, but if you group AMD-related patches with Intel ones,
> it's only human for reviewers to skip the thread entirely, even more so
> when catching up with email on January 3 :-)

I'm not sure what should I do about that series. Shall I split AMD and Intel
parts? (Assuming Intel will go as a series with cover letter.)

-- 
With Best Regards,
Andy Shevchenko


