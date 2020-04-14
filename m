Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FDBC3815B
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629FA2074D
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hPXY32ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629FA2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8CFE823;
	Tue, 14 Apr 2020 18:50:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8CFE823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586883098;
	bh=i1/QdVXhnkkVTQUW8zATFthdFjbHQ4hOmU/APjNSKSk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hPXY32eaPQlIYJ+2BxlrLXoc7O9c3ITKRoe0fgxKzPeEXwkBchpLmFeaku3bBIdlc
	 uNfHzXkoKOpfzh4vKUWXHXrCibmwGTpmO7mWTt3VOLvfdcU1rVwPTtdpEtInyMo2ro
	 RG71cod3Sty/xL9L7Ih1hL1kBRhxyuxWXUG1l7LM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05E38F80126;
	Tue, 14 Apr 2020 18:50:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60511F8013D; Tue, 14 Apr 2020 18:50:40 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 295E6F800F5
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 18:50:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 295E6F800F5
IronPort-SDR: +mVdbMPqPT7Y1s3ArIsSD9+0xmmb3jxPlLVvWRtkYQIU9r4rBkfvt4+r4xf6Ssvzu6s9v4DizC
 LyeYMT1TLqqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 09:50:23 -0700
IronPort-SDR: bWxEDQjuFDrDT9MygE7f1IjUi3D1Um86kZB5pVVrNCCWMQigtPOGBvd0wxbGDA6tjHzE9R1fNv
 aENPuNPRmLAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; d="scan'208";a="245461959"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2020 09:50:19 -0700
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1jOOlS-000ZWr-5E; Tue, 14 Apr 2020 19:50:22 +0300
Date: Tue, 14 Apr 2020 19:50:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 00/16] ASoC/SOF/clk/gpio/dt: add Hifiberry DAC+ PRO
 support
Message-ID: <20200414165022.GZ34613@smile.fi.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
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

On Thu, Apr 09, 2020 at 02:58:25PM -0500, Pierre-Louis Bossart wrote:
> The Hifiberry DAC+ / DAC+ PRO is supported in the Raspberry PI tree
> but until now not in the mainline and not for ACPI platforms.
> 
> This patchset implements the recommendations suggested by Mark Brown
> back in 2018: first add a gpiochip in the PCM512x codec driver, then
> use these gpios from a clock driver and the machine driver.
> 
> Since this patchset relies on different subsystems, sending as RFC for
> now. I chose to import the original code from the Raspberry PI tree as
> is,

I don't see briefly what they are, any pointers like patch numbers in the
series?

>	and add my changes on top. If there is a preference to squash the
> changes that'd be fine.

I guess it would be good to have.

> I also don't know if I should split this
> series in two, one for ASoC and one for clk changes?
> 
> This patchset does not add changes to the sound/soc/bcm machine
> drivers, but that should be trivial once all the gpio/clock is
> available.
> 
> Thanks to Andy Shevchenko for his help navigating the gpio subsystem
> and flagging mistakes in the use of lookup tables, and to Rob Herring
> for pointers on the DT bindings verification tools.

You are welcome!
I'm going to review them (where I understand something) as they are presented.

> Daniel Matuschek (1):
>   clk: hifiberry-dacpro: initial import
> 
> Pierre-Louis Bossart (15):
>   ASoC: pcm512x: expose 6 GPIOs
>   ASoC: pcm512x: use "sclk" string to retrieve clock
>   ASoC: Intel: sof-pcm512x: use gpiod for LED
>   ASoC: Intel: sof-pcm512x: detect Hifiberry DAC+ PRO
>   ASoC: Intel: sof-pcm512x: reconfigure sclk in hw_params if needed
>   ASoC: Intel: sof-pcm512x: select HIFIBERRY_DACPRO clk
>   clk: hifiberry-dacpro: update SDPX/copyright
>   clk: hifiberry-dacpro: style cleanups, use devm_
>   clk: hifiberry-dacpro: add OF dependency
>   clk: hifiberry-dacpro: transition to _hw functions
>   clk: hifiberry-dacpro: add ACPI support
>   clk: hifiberry-dacpro: add "sclk" lookup
>   clk: hifiberry-dacpro: toggle GPIOs on prepare/unprepare
>   clk: hifiberry-dacpro: add delay on clock prepare/deprepare
>   ASoC: dt-bindings: add document for Hifiberry DAC+ PRO clock
> 
>  .../bindings/sound/hifiberry-dacpro.yaml      |  38 +++
>  drivers/clk/Kconfig                           |   4 +
>  drivers/clk/Makefile                          |   1 +
>  drivers/clk/clk-hifiberry-dacpro.c            | 284 ++++++++++++++++++
>  sound/soc/codecs/pcm512x.c                    | 134 ++++++++-
>  sound/soc/intel/boards/Kconfig                |   2 +
>  sound/soc/intel/boards/sof_pcm512x.c          | 190 +++++++++++-
>  7 files changed, 635 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/hifiberry-dacpro.yaml
>  create mode 100644 drivers/clk/clk-hifiberry-dacpro.c
> 
> 
> base-commit: dd8e871d4e560eeb8d22af82dde91457ad835a63
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


