Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49082C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Oct 2022 13:31:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B0FE4D18;
	Wed, 12 Oct 2022 15:30:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B0FE4D18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665581479;
	bh=tV/ZvJGYw4mf000OleNKwCzv+JZQjAKj+4wcxHqkOco=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pt7eSlav3bkaQBs3k9uUZ+OoM6BriRAURg07K7nE8vvnD9FMqPrO/8/eNbdKgJ2Lk
	 +KfnhRiqLX6R5pF6PGU8gk9p/AVcrxGvtoh1S4h4w1xtQk3Lu789pY4NBYPnwweAEH
	 IkJJRUtd809xjY5FbZe8DX3yP0PT5GP+6QOM0Krs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0840CF80132;
	Wed, 12 Oct 2022 15:30:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E050CF80246; Wed, 12 Oct 2022 15:30:26 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FD34F800F4
 for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2022 15:30:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FD34F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="IJ+InLyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665581420; x=1697117420;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tV/ZvJGYw4mf000OleNKwCzv+JZQjAKj+4wcxHqkOco=;
 b=IJ+InLyStKN4w8qyDMq78EVJWAL0cajWckDOhdCHIsNirNLSvHfjTwTU
 OlQOuFVgl+KLWXPc2uAN/RhDlAAS8gAaPGaXmBzCq4nytPrJITgjifWJu
 Uzkcwq8G4Gy2W32E0I9BXmkmm+clQLklQSWjLcCmnBimSio6A+muSK9Gj
 l5aOCNZSOEgCxVQpHVd79da8aneU/Zy1Lnx4KxB7YurocAtmWBtHAG88P
 NBSbzL3rBmwrUBCa8ADT7YcIVpq24JMsNuEZccC8tuaTxbcv/v3j7czb9
 J0n2cobfBiuoCq8DT90UfGUAua5idjfyoMWmjmVNEqJVf1Mz2Rb9oRK8y A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="302404006"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; d="scan'208";a="302404006"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2022 06:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="626766256"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; d="scan'208";a="626766256"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga002.jf.intel.com with ESMTP; 12 Oct 2022 06:30:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1oiboD-005qlS-1e; Wed, 12 Oct 2022 16:30:05 +0300
Date: Wed, 12 Oct 2022 16:30:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
Message-ID: <Y0bBXSHyxpdTGxoU@smile.fi.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
 <Y0SyVwjDl7NGfTPn@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0SyVwjDl7NGfTPn@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, patches@opensource.cirrus.com,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-gpio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-omap@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

On Tue, Oct 11, 2022 at 08:01:27AM +0800, Kent Gibson wrote:
> On Mon, Oct 10, 2022 at 11:14:18PM +0300, Andy Shevchenko wrote:

...

> > -#include <linux/gpio.h>
> >  #include <linux/gpio/driver.h>
> > +#include <linux/gpio.h>

> But moving the gpio subsystem header after the gpio/driver is not
> alphabetical ('.' precedes '/') and it read better and made more sense
> to me the way it was.

Okay, I will move it back.

...

> > +#include <linux/seq_file.h>
> 
> I wasn't aware that we use anything from seq_file.
> What am I missing?


Eventually I can answer to your question: the commit 0ae3109a8391
("gpiolib: cdev: add fdinfo output for line request file descriptors")
is what you are missing.

That said, we need this patch.

-- 
With Best Regards,
Andy Shevchenko


