Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3516C388F9
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:58:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C3621D43
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SZjWx8Xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C3621D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 137201801;
	Fri, 23 Oct 2020 12:58:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 137201801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603450730;
	bh=+Pi9fChmAcmEqwy/tv0fX5VuQtl3b7KrD+7lwKR150Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SZjWx8XlBRryBhqXUXI3BiOUuK2LjgWFprPS/hImapbkks2AP6LLOyspk7phmFw7N
	 Ocatd/VDjCrmAzkauCQUtanwvNQpQ9Y8lbQ3y1od//R9i2P0+F2uKSUQosYe/o0o1m
	 h6YvlRYuKbKqIyFwOpU+6Mza1ydUI+ZPRN6GOrfQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D53EF80253;
	Fri, 23 Oct 2020 12:57:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CC72F8025A; Fri, 23 Oct 2020 12:57:58 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDD88F80245;
 Fri, 23 Oct 2020 12:57:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDD88F80245
IronPort-SDR: AYb3M8KV/3vEqSyPJHpRysPBmm2OVHBJC7tYBZH6ZidrbUpe9tfhWVtuEwogExMqkuugxmy4vw
 mnZWNWDLYtXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167779969"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; d="scan'208";a="167779969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 03:57:44 -0700
IronPort-SDR: fjiX/IZI0pDaYJqgqxDePo74oO5QM7bADcADjSFJmUhpn1+XrCXE37bigX0C7IMu0mMN5du/68
 DJTupSfEddHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; d="scan'208";a="523466596"
Received: from glewandosky.igk.intel.com ([10.237.149.85])
 by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2020 03:57:42 -0700
From: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: Enable coredump in kconfig
Date: Fri, 23 Oct 2020 12:57:27 +0200
Message-Id: <20201023105727.21008-1-gustaw.lewandowski@linux.intel.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, patch@alsa-project.org, tiwai@suse.de,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>, broonie@kernel.org,
 Piotr Maziarz <piotrx.maziarz@linux.intel.com>
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

From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>

WANT_DEV_COREDUMP flag is needed here if this driver is only one
using dev_coredump feature.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>
---
 sound/soc/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a5b446d5af19..c215156e2e18 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -4,6 +4,7 @@ config SND_SOC_INTEL_SST_TOPLEVEL
 	default y
 	depends on X86 || COMPILE_TEST
 	select SND_SOC_INTEL_MACH
+	select WANT_DEV_COREDUMP
 	help
 	  Intel ASoC SST Platform Drivers. If you have a Intel machine that
 	  has an audio controller with a DSP and I2S or DMIC port, then
-- 
2.29.0

