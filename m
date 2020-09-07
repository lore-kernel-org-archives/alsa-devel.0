Return-Path: <SRS0=BS+q=CQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C49C43461
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:53:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4768C206B8
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="neSPdXpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4768C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5A511775;
	Mon,  7 Sep 2020 17:52:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5A511775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599494013;
	bh=JjXqEja2yEDKBEUYybzZESAWAswsKBsH88WkjuxvFWs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=neSPdXpzta+tPbUlQvxtIDxw3JqyCymZWbXrD91GaZI66KCdfi1XQz3DeYM7bgIZN
	 do/8lRXYtJq16c5NaV6LiDIWsejW9PR9brnlOEzWvvE1wVZKY40BkfGjb/kz70YwZT
	 Jb+E5SLxX6gIzSuAFHBlwTjdC/TbvoByMhGMDctQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBDC0F8021C;
	Mon,  7 Sep 2020 17:52:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E89FF80227; Mon,  7 Sep 2020 17:52:41 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B0A0F800B9
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2020 17:52:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B0A0F800B9
IronPort-SDR: SlvAzTaym1Vtpajxc1o2ACwOFHDB/m6WuySRL9tslkeaQil0gUYyo1fmoB5KjHOTbQAIGnEtNB
 U+7LSERWdJGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="137532877"
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; d="scan'208";a="137532877"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2020 08:52:29 -0700
IronPort-SDR: OKawkKFMoTnSGMbguXThLtl8NtjcwhxLsewqqLKPYgFmHyfSdylAm5yyICdAjMpdfR2/DEblnQ
 njoVBfvoFnZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; d="scan'208";a="333197015"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 08:52:26 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1kFJNC-00EzvH-KL; Mon, 07 Sep 2020 18:48:02 +0300
Date: Mon, 7 Sep 2020 18:48:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 03/11] USB: core: message.c: use
 usb_control_msg_send() in a few places
Message-ID: <20200907154802.GO1891694@smile.fi.intel.com>
References: <20200907145108.3766613-1-gregkh@linuxfoundation.org>
 <20200907145108.3766613-4-gregkh@linuxfoundation.org>
 <20200907145644.GA3767938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907145644.GA3767938@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, johan.hedberg@gmail.com,
 linux-kernel@vger.kernel.org, marcel@holtmann.org, linux-usb@vger.kernel.org,
 tiwai@suse.com, stern@rowland.harvard.ed, linux-bluetooth@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>, dvyukov@google.com,
 himadrispandya@gmail.com
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

On Mon, Sep 07, 2020 at 04:56:44PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 07, 2020 at 04:51:00PM +0200, Greg Kroah-Hartman wrote:
> > There are a few calls to usb_control_msg() that can be converted to use
> > usb_control_msg_send() instead, so do that in order to make the error
> > checking a bit simpler.
> > 
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Oops, Andy, sorry, you gave me a Reviewed-by: Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> on the previous version of this,
> I'll add it next round, or when it's queued up.

NP! Whatever works better for you.

-- 
With Best Regards,
Andy Shevchenko


