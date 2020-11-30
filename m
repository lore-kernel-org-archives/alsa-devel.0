Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B900C63777
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 02:34:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78FC20809
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 02:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RcoKNOx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78FC20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15CE3171A;
	Tue,  1 Dec 2020 03:33:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15CE3171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606790036;
	bh=q0PYRFLRB9Tf+TK1quLsMxWPzvAa57V6KpKPB1ahVxQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RcoKNOx0Bbqj7IphNXZW0Ojf6Wsj4/loaFeCxtocKV4SAz8BYFQ/QrlNWDm1YnUy7
	 EK9vVf4ZqGfonKCcKS1Fx6rVJaYM2Yhusrd9gUyEGa7IwXfqQs1hr1oY+1h75M3wPj
	 TrcU/aKR69T1IEvZznJjtWorxb7HrKzRZSxyvL70=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79E8EF8016C;
	Tue,  1 Dec 2020 03:33:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E331F8026D; Tue,  1 Dec 2020 03:33:04 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7931FF80158
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 03:32:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7931FF80158
IronPort-SDR: cNaxLUUFgb7kI/qoedZGLGE9/8dptc/PWH/AfNv8GVaseWkOBsKjHh9hBUsfOHcqwmcArSHPZm
 sYKnDR1/wpcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="190942196"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="190942196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 18:32:54 -0800
IronPort-SDR: zjycBvJ7amChalpwbgn5ejVA6Qhg39YGx/7EKkksRLe1TxIGHUNQYnflNBzeJNh8tb8jDzJwZ/
 7Guk3wTf8hlQ==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="549360073"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 18:32:50 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 0/5] regmap/SoundWire/ASoC: Add SoundWire SDCA support
Date: Mon, 30 Nov 2020 22:40:15 +0800
Message-Id: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

The MIPI SoundWire Device Class standard will define audio functionality
beyond the scope of the existing SoundWire 1.2 standard, which is limited
to the bus and interface.

The description is inspired by the USB Audio Class, with "functions",
"entities", "control selectors", "audio clusters". The main difference
with the USB Audio class is that the devices are typically on a motherboard
and descriptors stored in platform firmware instead of being retrieved
from the device.

The current set of devices managed in this patchset are conformant with the
SDCA 0.6 specification and require dedicated drivers since the descriptors
and platform firmware specification is not complete at this time. They do
however rely on the hierarchical addressing required by the SDCA standard.
Future devices conformant with SDCA 1.0 should rely on a class driver.

This series adds support for the hierarchical SDCA addressing and extends
regmap. It then provides 3 codecs for RT711-sdca headset codec, RT1316
amplifier and RT715-scda microphone codec.

Note that the release of this code before the formal adoption of the
SDCA 1.0 specification was formally endorsed by the MIPI Board to make
sure there is no delay for Linux-based support of this specification.

v2:
- rt715-sdca: Use rt715_sdca prefix to avoid compiling issue.
- rt715-sdca: Merge multiple mute/volume operation into single mute/volume
  operation
- rt711-sdca: Initial ret = 0 as it could be used uninitialized.

Jack Yu (1):
  ASoC/SoundWire: rt715-sdca: First version of rt715 sdw sdca codec
    driver

Pierre-Louis Bossart (2):
  soundwire: SDCA: add helper macro to access controls
  regmap/SoundWire: sdw: add support for SoundWire 1.2 MBQ

Shuming Fan (2):
  ASoC/SoundWire: rt1316: Add RT1316 SDCA vendor-specific driver
  ASoC/SoundWire: rt711-sdca: Add RT711 SDCA vendor-specific driver

 drivers/base/regmap/Kconfig             |    6 +-
 drivers/base/regmap/Makefile            |    1 +
 drivers/base/regmap/regmap-sdw-mbq.c    |  101 ++
 include/linux/regmap.h                  |   35 +
 include/linux/soundwire/sdw_registers.h |   32 +
 sound/soc/codecs/Kconfig                |   20 +
 sound/soc/codecs/Makefile               |    6 +
 sound/soc/codecs/rt1316-sdw.c           |  756 ++++++++++++
 sound/soc/codecs/rt1316-sdw.h           |  115 ++
 sound/soc/codecs/rt711-sdca-sdw.c       |  424 +++++++
 sound/soc/codecs/rt711-sdca-sdw.h       |  101 ++
 sound/soc/codecs/rt711-sdca.c           | 1482 +++++++++++++++++++++++
 sound/soc/codecs/rt711-sdca.h           |  246 ++++
 sound/soc/codecs/rt715-sdca-sdw.c       |  278 +++++
 sound/soc/codecs/rt715-sdca-sdw.h       |  170 +++
 sound/soc/codecs/rt715-sdca.c           |  947 +++++++++++++++
 sound/soc/codecs/rt715-sdca.h           |  124 ++
 17 files changed, 4843 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-sdw-mbq.c
 create mode 100644 sound/soc/codecs/rt1316-sdw.c
 create mode 100644 sound/soc/codecs/rt1316-sdw.h
 create mode 100644 sound/soc/codecs/rt711-sdca-sdw.c
 create mode 100644 sound/soc/codecs/rt711-sdca-sdw.h
 create mode 100644 sound/soc/codecs/rt711-sdca.c
 create mode 100644 sound/soc/codecs/rt711-sdca.h
 create mode 100644 sound/soc/codecs/rt715-sdca-sdw.c
 create mode 100644 sound/soc/codecs/rt715-sdca-sdw.h
 create mode 100644 sound/soc/codecs/rt715-sdca.c
 create mode 100644 sound/soc/codecs/rt715-sdca.h

-- 
2.17.1

