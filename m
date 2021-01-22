Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA0DC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 00:59:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AE522CAE
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 00:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AE522CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6968B1A93;
	Fri, 22 Jan 2021 01:58:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6968B1A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611277181;
	bh=Q+B0qrTbv1IwQ3bcAu7DN91+QWyGJHe3L6xITcHksCc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xt5MCjNmYGhyLWeJP8IKSWKrFb4E0c4VLQQDytNh/5bPd7aJYVsqYgy2TrlhE6p/o
	 7hsWzC+lMMqBp3FGXP2JKRMvJo5kLZalf6SwvbD1Xn9TBo6nsMCGVzEwwTYsEKPnRt
	 WcYa3sqTFtzDdjEkh8hA0LHRFQhvpO7Kr7tBVLfc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E4CEF804B2;
	Fri, 22 Jan 2021 01:57:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D25CDF80272; Fri, 22 Jan 2021 01:57:54 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33252F80162
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 01:57:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33252F80162
IronPort-SDR: Vo/6unjVFht7g2hXi6ToCWxBwnrD2DDDuJWOavoTciogyew8jj0u/vD993e7nZw14zX3aNhaDO
 H1Vzjxcil7LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264190804"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; d="scan'208";a="264190804"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 16:57:41 -0800
IronPort-SDR: f4of66wyfUTa0ziZLciE0QiVvISvv5P3dY66h9UfDiivgoyKMfOaRQxaBrbV5Izl5AyrfF7/MD
 JgoT46GjCfgQ==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; d="scan'208";a="367126953"
Received: from seleedom-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.133.150])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 16:57:40 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: SOF: Intel: soundwire: fix select/depend unmet
 dependencies
Date: Thu, 21 Jan 2021 18:57:24 -0600
Message-Id: <20210122005725.94163-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122005725.94163-1-pierre-louis.bossart@linux.intel.com>
References: <20210122005725.94163-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Arnd Bergmann <arnd@kernel.org>, kernel test robot <lkp@intel.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org, broonie@kernel.org
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

The LKP bot reports the following issue:

WARNING: unmet direct dependencies detected for SOUNDWIRE_INTEL
  Depends on [m]: SOUNDWIRE [=m] && ACPI [=y] && SND_SOC [=y]
  Selected by [y]:
  - SND_SOC_SOF_INTEL_SOUNDWIRE [=y] && SOUND [=y] && !UML &&
  SND [=y] && SND_SOC [=y] && SND_SOC_SOF_TOPLEVEL [=y] &&
  SND_SOC_SOF_INTEL_TOPLEVEL [=y] && SND_SOC_SOF_INTEL_PCI [=y]

This comes from having tristates being configured independently, when
in practice the CONFIG_SOUNDWIRE needs to be aligned with the SOF
choices: when the SOF code is compiled as built-in, the
CONFIG_SOUNDWIRE also needs to be 'y'.

The easiest fix is to replace the 'depends' with a 'select' and have a
single user selection to activate SoundWire on Intel platforms. This
still allows regmap to be compiled independently as a module.

This is just a temporary fix, the select/depend usage will be
revisited and the SOF Kconfig re-organized, as suggested by Arnd
Bergman.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: a115ab9b8b93e ('ASoC: SOF: Intel: add build support for SoundWire')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index d306c370e5d1..4797a1cf8c80 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -355,7 +355,7 @@ config SND_SOC_SOF_HDA
 
 config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
 	bool "SOF support for SoundWire"
-	depends on SOUNDWIRE && ACPI
+	depends on ACPI
 	help
 	  This adds support for SoundWire with Sound Open Firmware
 	  for Intel(R) platforms.
@@ -371,6 +371,7 @@ config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 
 config SND_SOC_SOF_INTEL_SOUNDWIRE
 	tristate
+	select SOUNDWIRE
 	select SOUNDWIRE_INTEL
 	help
 	  This option is not user-selectable but automagically handled by
-- 
2.25.1

