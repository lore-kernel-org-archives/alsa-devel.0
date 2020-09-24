Return-Path: <SRS0=rARa=DB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EF2C4363D
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:26:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D56A2220C
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ph/gcsh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D56A2220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6762017DB;
	Thu, 24 Sep 2020 16:25:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6762017DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600957575;
	bh=mSpQJ92j/FzH1IPdzOxmWybeJVw1t4fwtdmqe6enQXQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ph/gcsh0XQrk1cO9pMZ5hHlIT7mdQbk+QKAHQoomBV28zEqACwMknynnxGOZcb/nV
	 hNL+xZDrL74VaqIsdhiEfHtPvzPpFwAwXuWN8LIL872lqxS2P7Np7/CzJMKlN+fKcY
	 IW8mpUrSB6N4MLkWvzlT1NXUHVpcQsRiVBqFaO2Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 682B4F8023E;
	Thu, 24 Sep 2020 16:25:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C3ABF80256; Thu, 24 Sep 2020 16:25:07 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5DE4F8015F
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2020 16:24:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5DE4F8015F
IronPort-SDR: bI7NNlp9JRzzmjzH94weo3SEZ/gYCRY0XBHcvWLMah1XsWNMPOWrBhuoSRsDB8qiI+NqLd6M3i
 1x362PmyCvQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="148971935"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="148971935"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 07:24:56 -0700
IronPort-SDR: FAudWwqG+iPapBX+A4pkbJUG1cndI62BZvQWq+sok+Z+PxX27XYXgMr3kHU+FE1Y80PLK20dlI
 8P5Udma4rGxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="339064838"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 24 Sep 2020 07:24:52 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1kLSAy-001gkZ-7F; Thu, 24 Sep 2020 17:24:48 +0300
Date: Thu, 24 Sep 2020 17:24:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rojewski, Cezary" <cezary.rojewski@intel.com>
Subject: Re: [PATCH v8 09/14] ASoC: Intel: catpt: Simple sysfs attributes
Message-ID: <20200924142448.GV3956970@smile.fi.intel.com>
References: <20200923122508.3360-1-cezary.rojewski@intel.com>
 <20200923122508.3360-10-cezary.rojewski@intel.com>
 <20200923133427.GL3956970@smile.fi.intel.com>
 <4e590f061dec474195a10482b1a9bc22@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e590f061dec474195a10482b1a9bc22@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kaczmarski,
 Filip" <filip.kaczmarski@intel.com>, "N,
 Harshapriya" <harshapriya.n@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Barlik,
 Marcin" <marcin.barlik@intel.com>, "zwisler@google.com" <zwisler@google.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "Proborszcz, Filip" <filip.proborszcz@intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "amadeuszx.slawinski@linux.intel.com" <amadeuszx.slawinski@linux.intel.com>,
 "Wasko, Michal" <michal.wasko@intel.com>,
 "cujomalainey@chromium.org" <cujomalainey@chromium.org>, "Hejmowski,
 Krzysztof" <krzysztof.hejmowski@intel.com>,
 "ppapierkowski@habana.ai" <ppapierkowski@habana.ai>, "Gopal,
 Vamshi Krishna" <vamshi.krishna.gopal@intel.com>
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

On Wed, Sep 23, 2020 at 06:31:08PM +0000, Rojewski, Cezary wrote:
> On 2020-09-23 3:34 PM, Andy Shevchenko wrote:
> > On Wed, Sep 23, 2020 at 02:25:03PM +0200, Cezary Rojewski wrote:

...

> >> +	pm_runtime_get_sync(cdev->dev);
> >> +
> >> +	ret = catpt_ipc_get_fw_version(cdev, &version);
> >> +
> >> +	pm_runtime_mark_last_busy(cdev->dev);
> >> +	pm_runtime_put_autosuspend(cdev->dev);
> > 
> > Is it subject to change at run-time?
> 
> No it does not. However, I do not intent to have the fw_version occupy
> memory for device's drvdata (i.e. send the IPC internally and store it
> inside struct catpt_dev). So, I'd rather wake the device, dump the
> version and leave the bytes alone.
> 
> One could think about statics but then again, how many times this sysfs
> file is going to get read anyway?
> It's more readable and simple this way, losing nothing in return TBH.

For regular user perhaps few times or from time to time, but for dump syzkaller
type of fuzzers it may be thousands per second...

Greg is happy anyway, so choose yourself the best one you think of.

-- 
With Best Regards,
Andy Shevchenko


