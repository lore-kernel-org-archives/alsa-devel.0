Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F46C388F7
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 14:51:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E864206B2
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 14:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Kgnh7N/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E864206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95BA41718;
	Tue, 10 Nov 2020 15:50:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95BA41718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605019869;
	bh=6Hw30x5vTJqHhfNxDmcW3x9uRrdpcSG58csaBdrRA9g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Kgnh7N/QrWSW9lNX+73FHre8rA/dbhUkTkZoZYffkHaUj66bcpnQtt2BRedI277RZ
	 tKBH7J7lnUQ0J1V1cGQ+IGUd3NDQfhp4sF8043W4vilijEXBjosWYR7Y/9PlHGeLVw
	 reBeqALHxYlTkQsvSqMMvhur3cpbbtgF2jHdR+bU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A35DF800AE;
	Tue, 10 Nov 2020 15:50:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F153F801D5; Tue, 10 Nov 2020 15:50:18 +0100 (CET)
Received: from albert.telenet-ops.be (albert.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:1a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70FA6F800AE
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 15:50:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70FA6F800AE
Received: from ramsan.of.borg ([84.195.186.194])
 by albert.telenet-ops.be with bizsmtp
 id qeq52300F4C55Sk06eq5dC; Tue, 10 Nov 2020 15:50:08 +0100
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kcUyD-001CZB-3h; Tue, 10 Nov 2020 15:50:05 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kcUyC-00DlPq-Fd; Tue, 10 Nov 2020 15:50:04 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Sia Jee Heng <jee.heng.sia@intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Subject: [PATCH] ASoC: intel: SND_SOC_INTEL_KEEMBAY should depend on
 ARCH_KEEMBAY
Date: Tue, 10 Nov 2020 15:50:01 +0100
Message-Id: <20201110145001.3280479-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

The Intel Keem Bay audio module is only present on Intel Keem Bay SoCs.
Hence add a dependency on ARCH_KEEMBAY, to prevent asking the user about
this driver when configuring a kernel without Intel Keem Bay platform
support.

Fixes: c544912bcc2dc806 ("ASoC: Intel: Add makefiles and kconfig changes for KeemBay")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a5b446d5af19fc2d..c1bf69a0bcfe18c3 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -198,7 +198,7 @@ endif ## SND_SOC_INTEL_SST_TOPLEVEL || SND_SOC_SOF_INTEL_TOPLEVEL
 
 config SND_SOC_INTEL_KEEMBAY
 	tristate "Keembay Platforms"
-	depends on ARM64 || COMPILE_TEST
+	depends on ARCH_KEEMBAY || COMPILE_TEST
 	depends on COMMON_CLK
 	help
 	  If you have a Intel Keembay platform then enable this option
-- 
2.25.1

