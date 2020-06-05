Return-Path: <SRS0=S+eB=7S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C4CC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 05:26:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1DD207ED
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 05:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WVQny90x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1DD207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D7B2165F;
	Fri,  5 Jun 2020 07:26:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D7B2165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591334812;
	bh=Ka+X4XHpYnnlaPe3yIR4CZc0kjxe6zv0zHKMN4fYeYw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WVQny90xuExL83PPmq/90M5JfwkYeWfL4qaCIlmYqJ+dfiJHnfiS+31uRkgnWIEnn
	 XPf1hOvho/MsmG8mWJbeCXrFqUralYO4HhQOPba7Wt6GOKafmJMwICh00g1L0lJmBK
	 zAY0VjxaapbkHsppfny7TR5eAd+4Sa19YBLJjljE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4274F801EC;
	Fri,  5 Jun 2020 07:26:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50CB9F80279; Fri,  5 Jun 2020 07:23:18 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB2DCF80140
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2020 07:22:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB2DCF80140
IronPort-SDR: /DA0sgTRvHsFvjDopngiUxD6ccezK2WzuxqNw5WrO2aRU3d3AzEFJNEb8cB3QGxpej1W3R14jw
 uHmPUPfMoi/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 22:22:06 -0700
IronPort-SDR: B5QqP5qmVw74d9jdE0JG+Y8HEn5QQ5cNbZx5hIrDkq/2OzuEveyB5dI2xJ/l8DAITSweIi5QUo
 oOhbQV+KOOsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,475,1583222400"; d="scan'208";a="259091128"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com)
 ([10.221.118.135])
 by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2020 22:22:05 -0700
From: Sia Jee Heng <jee.heng.sia@intel.com>
To: <alsa-devel@alsa-project.org>
Subject: [PATCH v4 0/3] ASoC: Intel: Add KeemBay ASoC platform driver
Date: Fri,  5 Jun 2020 13:08:54 +0800
Message-Id: <1591333737-3231-1-git-send-email-jee.heng.sia@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: cezary.rojewski@intel.com, andriy.shevchenko@intel.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org
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

The below series of patches support the KeemBay ASoC platform driver.
The platform driver initialize the i2s to capture and playback the
pcm data on the ARM. The i2s is running in polling mode.

There is no DSP in the KeemBay SoC. Users are rely on the Gstreamer plugin
to perform Audio preprocessing.

Audio graph card is used to connect the platform driver with the
tlv320aic3204 codec.

Change History:
v4:
- Reduce if-otology at the tx/rx function.
- Fix indentation.
- specify .rate directly
 
v3:
- Adjusted header format.
- Use Audio graph card instead of custom sound card.
- Use if-else instead of conditional operator.
- Enabled .set_fmt to configure master clock.

v2:
- Corrected I2S naming for DT binding.

v1:
- Initial version.

Sia Jee Heng (3):
  ASoC: Intel: Add KeemBay platform driver
  ASoC: Intel: Add makefiles and kconfig changes for KeemBay
  dt-bindings: sound: Add documentation for KeemBay i2s

 .../bindings/sound/intel,keembay-i2s.yaml          |  68 +++
 sound/soc/intel/Kconfig                            |   7 +
 sound/soc/intel/Makefile                           |   1 +
 sound/soc/intel/keembay/Makefile                   |   4 +
 sound/soc/intel/keembay/kmb_platform.c             | 654 +++++++++++++++++++++
 sound/soc/intel/keembay/kmb_platform.h             | 145 +++++
 6 files changed, 879 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
 create mode 100644 sound/soc/intel/keembay/Makefile
 create mode 100644 sound/soc/intel/keembay/kmb_platform.c
 create mode 100644 sound/soc/intel/keembay/kmb_platform.h

-- 
1.9.1

