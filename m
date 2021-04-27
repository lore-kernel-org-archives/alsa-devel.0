Return-Path: <SRS0=XYKd=JY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F44DC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 14:54:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C5061131
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 14:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C5061131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A4EE16D7;
	Tue, 27 Apr 2021 16:53:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A4EE16D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619535280;
	bh=8TBu/va74GzmknXGMomymxTG0Bh0adbOo2AUcqVUrsQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jVud/HBtNGuWY+ooVY5JolP4J1tMwdmsr61KbU/A3Ix893ozwn98X3jrJjEypTqrc
	 G/MWj3d/IciZ43vcVCFOoMnG5F6FIPM6lyIwImtlXaOncxiL4TEdz/BKIBYJBQE34G
	 fTmi9nMyhJ3G2Wl9AhDSk2367DkE2n33u2ueNIpE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 580C3F801D8;
	Tue, 27 Apr 2021 16:53:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F19F3F801EC; Tue, 27 Apr 2021 16:53:45 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11319F8012A
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 16:53:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11319F8012A
IronPort-SDR: Jm5jY3wZLpUafd+Dsi+ir4Nrb5Ybjpjl73bPnJz9dS89sGO1AwYUYIGgBXPpw7caGLY33DkHCv
 BADk13WN/xbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="184003509"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; d="scan'208";a="184003509"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2021 07:53:19 -0700
IronPort-SDR: mDYm9swO0IuEFDarQ/vqe6eBdCFtg+yA2WeYwo8epkvNzMg6f5HVuDg4J34X3OQrNE0Uz52loI
 SzLtBCPIyjhA==
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; d="scan'208";a="457673982"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2021 07:53:17 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andy.shevchenko@gmail.com>)
 id 1lbP5O-007f4P-1b; Tue, 27 Apr 2021 17:53:14 +0300
Date: Tue, 27 Apr 2021 17:53:14 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Message-ID: <YIglWpz8lSidXmDd@smile.fi.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
 <20210427143457.GI4605@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427143457.GI4605@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
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

On Tue, Apr 27, 2021 at 03:34:57PM +0100, Mark Brown wrote:
> On Tue, Apr 27, 2021 at 02:46:02PM +0300, Andy Shevchenko wrote:
> 
> > Mark, are you accepting patches for v5.14 now, or should I resend
> > after v5.13-rc1 is out?
> 
> > (I have few more in my queue :-)
> 
> Send them now if you like.

Got it!

I think I prefer to produce a less noise in case this series for some reason
needs to be changed / amended. I'll wait till this series lands in your queue.

P.S. basically my question was about this series.


-- 
With Best Regards,
Andy Shevchenko


