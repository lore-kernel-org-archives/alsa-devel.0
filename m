Return-Path: <SRS0=lMNw=7A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA8C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 02:31:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86F220758
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 02:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mEca6mZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86F220758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DF82167F;
	Mon, 18 May 2020 04:30:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DF82167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589769078;
	bh=pb9OiqTXRWzAZUsTLMc20YQ27Gegcbh6vGUX92ziMkQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mEca6mZBbQr4YaKNyseljBP9C9ng9cQbzYvXhvstdTqAAmHkjZO5zab4GvA1SNYH2
	 y6reaWSGGootV5Ibb4qw8NGw2JTj2YO8cjVRoB21KPy57BQUVquiEnpjA9w6kU1bZB
	 hC7Wj5K+b2wDxqgZQf97sdC3HSeVcs2xqEloKXjA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A46B4F80213;
	Mon, 18 May 2020 04:30:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B6C3F80273; Mon, 18 May 2020 04:30:25 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0166F800B6
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2020 04:30:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0166F800B6
IronPort-SDR: DOCk5TySxB3jnVXKpfFnLb7/2w60tuhowpbyEZie9x6ljhe0MT2fPMNDnzfiDoJxfJU5k+2b5V
 nLTLdnrRkHvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2020 19:30:09 -0700
IronPort-SDR: GBO8vF7MfHWjeFiGyZkm5gp3emYHPo8vaHvB6iTQS8oG8WF1v//Dt4JFUh9x7mgXk4nml+jnxj
 dn0nekS8zjfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,405,1583222400"; d="scan'208";a="307972062"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com)
 ([10.221.118.135])
 by FMSMGA003.fm.intel.com with ESMTP; 17 May 2020 19:30:07 -0700
From: Sia Jee Heng <jee.heng.sia@intel.com>
To: <alsa-devel@alsa-project.org>
Subject: [PATCH v2 0/4] ASoC: Intel: Add KeemBay ASoC driver
Date: Mon, 18 May 2020 10:17:18 +0800
Message-Id: <1589768242-4594-1-git-send-email-jee.heng.sia@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: liam.r.girdwood@linux.intel.com, broonie@kernel.org, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com
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

The below series of patches support the KeemBay ASoC driver.
It enabled the tlv320aic3204 machine driver and the platform driver initialize
the i2s to capture and playback the pcm data on the ARM. The i2s is running
in polling mode.

There is no DSP in the KeemBay SoC. Users are rely on the Gstreamer plugin
to perform some Audio preprocessing.

Change History:
v2:
- Corrected I2S naming for DT binding.
  
v1:
- Initial version.

Sia Jee Heng (4):
  ASoC: Intel: Add KeemBay platform driver
  ASoC: Intel: Boards: Add KeemBay machine driver
  ASoC: Intel: Add makefiles and kconfig changes for KeemBay
  dt-bindings: sound: Add documentation for KeemBay sound card and i2s

 .../bindings/sound/intel,keembay-i2s.yaml          |  57 ++
 .../bindings/sound/intel,keembay-sound-card.yaml   |  30 +
 sound/soc/intel/Kconfig                            |   7 +
 sound/soc/intel/Makefile                           |   1 +
 sound/soc/intel/boards/Kconfig                     |  15 +
 sound/soc/intel/boards/Makefile                    |   4 +
 sound/soc/intel/boards/kmb_tlv3204.c               | 144 ++++
 sound/soc/intel/keembay/Makefile                   |   4 +
 sound/soc/intel/keembay/kmb_platform.c             | 746 +++++++++++++++++++++
 sound/soc/intel/keembay/kmb_platform.h             | 145 ++++
 10 files changed, 1153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/intel,keembay-sound-card.yaml
 create mode 100644 sound/soc/intel/boards/kmb_tlv3204.c
 create mode 100644 sound/soc/intel/keembay/Makefile
 create mode 100644 sound/soc/intel/keembay/kmb_platform.c
 create mode 100644 sound/soc/intel/keembay/kmb_platform.h

-- 
1.9.1

