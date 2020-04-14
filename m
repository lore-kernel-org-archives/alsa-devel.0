Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6387CC2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:28:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF2D20678
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PoSiBCFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF2D20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2920116A5;
	Tue, 14 Apr 2020 19:28:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2920116A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586885336;
	bh=V6ZZEc9DNRgABSa687msmHhd0FBKHztve+Nr2kHm424=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PoSiBCFf9ki1xbaVyHYjON3LIMq/TFJ31mnqRQA3GD4Khvny6d+RYE85Gk8Q2W14i
	 0jEaWrxnOGs8jZt6Tg21BghOpkNcyA0K8UmBtXuvCV2ULzJQ5bMeH+ou9x3FreI2O+
	 4VBm07MULP++nKi+9BceCW3TJwQADudc85eXch9A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08FD7F800B9;
	Tue, 14 Apr 2020 19:27:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96820F8028D; Tue, 14 Apr 2020 19:27:52 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 589E3F8028A
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 19:27:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 589E3F8028A
IronPort-SDR: 7hKrUiYzXDcezBSKP+Vl7EcBX4FE9RdDFBCTBM6XRuQCeRuv3IpXS1USqVN7v3f+++dw3AwNvd
 dOjFO6FD7lcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 10:27:42 -0700
IronPort-SDR: ECrF0e0oImZU1rOVCW4NKcfhsj9UHihE7OBCHemlO+xxKPUPWatkoWu2dnLX7yugWcec4aGcJc
 t83n+5tkeWxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; d="scan'208";a="253259400"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 10:27:39 -0700
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1jOPLZ-000Zv7-M9; Tue, 14 Apr 2020 20:27:41 +0300
Date: Tue, 14 Apr 2020 20:27:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 16/16] ASoC: dt-bindings: add document for Hifiberry
 DAC+ PRO clock
Message-ID: <20200414172741.GF34613@smile.fi.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-17-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409195841.18901-17-pierre-louis.bossart@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
 linux-gpio@vger.kernel.org, tiwai@suse.de,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Daniel Matuschek <daniel@hifiberry.com>, Hui Wang <hui.wang@canonical.com>,
 Matthias Reichl <hias@horus.com>, broonie@kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
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

On Thu, Apr 09, 2020 at 02:58:41PM -0500, Pierre-Louis Bossart wrote:
> The Hifiberry DAC+ PRO relies on two local audio oscillators exposed
> with the clock framework.

> +# SPDX-License-Identifier: GPL-2.0

Dual license requirement nowadays.

-- 
With Best Regards,
Andy Shevchenko


