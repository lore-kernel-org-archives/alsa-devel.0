Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D45C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:39:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5097720771
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Td779pUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5097720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A64F71612;
	Tue, 11 Aug 2020 15:38:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A64F71612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597153166;
	bh=m0DlxNC8ouk3js/uWTM3x0FqgPEFEFBhBpbgLwrJ2xo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Td779pUQ9ofld9zM+sfrpq4I7Vn8PS/EgWbQOXX9MOrcXOknMnM2gu0d/zALwaNLv
	 IDhOip7jU4jlPD79utQLJ4eOKtfyGSKjZzYBtan4UOaL9qVX9tYobIzJS10iQMC5pP
	 PkBTnQO4w9CW0p/a9XsZg7fmekTUmtvNJ+Ydf17w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38EC8F8014C;
	Tue, 11 Aug 2020 15:38:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B65CBF8015B; Tue, 11 Aug 2020 15:38:34 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A2CFF800BC
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 15:38:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A2CFF800BC
IronPort-SDR: OmK8nsVTOR0vKNA1qd07NaEjT0yVtlqWvx/h7EprAnXiddj1PsFmRkEZq4hV//QQBha40mwIRr
 tFoIqnRzKQUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="141340778"
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; d="scan'208";a="141340778"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2020 06:38:20 -0700
IronPort-SDR: mLY4dxyUQuI4yO21opqL8wZjzWsoWYWLrpvIvIBGv7MR8db+Z1zecz40SUsSpkfQHmjj4m8IFH
 9v9ngSJTWWzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; d="scan'208";a="324761477"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 11 Aug 2020 06:38:17 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@intel.com>)
 id 1k5UTo-007zbV-A9; Tue, 11 Aug 2020 16:38:16 +0300
Date: Tue, 11 Aug 2020 16:38:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 09/13] ASoC: Intel: Select catpt and deprecate haswell
Message-ID: <20200811133816.GD1891694@smile.fi.intel.com>
References: <20200811100034.6875-10-cezary.rojewski@intel.com>
 <202008112152.WcqIiwSM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008112152.WcqIiwSM%lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, kbuild-all@lists.01.org,
 filip.kaczmarski@intel.com, harshapriya.n@intel.com, lgirdwood@gmail.com,
 marcin.barlik@intel.com, zwisler@google.com, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com
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

On Tue, Aug 11, 2020 at 09:08:43PM +0800, kernel test robot wrote:
> Hi Cezary,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on asoc/for-next]
> [also build test WARNING on sound/for-next v5.8 next-20200811]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Cezary-Rojewski/ASoC-Intel-Catpt-Lynx-and-Wildcat-point/20200811-181319
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):

To fix all these, please use %pR or %pr (I believe you want former rather than
latter).

-- 
With Best Regards,
Andy Shevchenko


