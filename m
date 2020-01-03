Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C1C3276C
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 01:08:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB7321D7D
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 01:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JSHfmLTt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OSOd/eOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB7321D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DFDB1701;
	Fri,  3 Jan 2020 02:07:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DFDB1701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578013700;
	bh=BHTeZoSc5kOvyI3gKFuyk35BjWoY/pXJNE5X8FEDPuc=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=JSHfmLTtDVfDTh7wMTQ11h/AaQC9Sp1tdA3bYpEjQpEYMF3YyL428a00Xy+D3y03f
	 WbaNnlrTySoaQImZa4R3ReXa9ni6QIOLSIilb6GcOX0usUBFhuRXNmD2x5iW4+JL4F
	 m7L8lZdF/1vMOVosXQsmosgujN87PmLaU27lo+Q4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29141F80271;
	Fri,  3 Jan 2020 02:05:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 015F0F8014F; Fri,  3 Jan 2020 02:05:48 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A778F8014F
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 02:05:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A778F8014F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="OSOd/eOa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=bQk6UhNptTRNZtOX3CzbH6IJEv5R27ETcPn7R4b6Ns4=; b=OSOd/eOaoXQv
 EmX9jJsIMBWchql+tbGiJWaKWOio/4qqCIWwRWVfKEK/Mx2Mjl5TaiM94HAYTqU7lKNZo0c/a2zv0
 eSDu8Q5jMUtO+vc/wbNpCXztx+0Baalp5y8EbVOvWrFaLQS1Qknd9nsFL81hZHXLvT/oZ4UX1js1R
 96cI0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1inBPK-0003N6-3h; Fri, 03 Jan 2020 01:05:42 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 944EBD057C8; Fri,  3 Jan 2020 01:05:41 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20200102135322.1841053-1-arnd@arndb.de>
Message-Id: <applied-20200102135322.1841053-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Date: Fri,  3 Jan 2020 01:05:41 +0000 (GMT)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
 Naveen Manohar <naveen.m@intel.com>
Subject: [alsa-devel] Applied "ASoC: Intel: boards: Fix compile-testing
	RT1011/RT5682" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: Intel: boards: Fix compile-testing RT1011/RT5682

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From ff3b57417012fcc963ec281f5705bed837e4b1ac Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 2 Jan 2020 14:52:55 +0100
Subject: [PATCH] ASoC: Intel: boards: Fix compile-testing RT1011/RT5682

On non-x86, the new driver results in a build failure:

sound/soc/intel/boards/cml_rt1011_rt5682.c:14:10: fatal error: asm/cpu_device_id.h: No such file or directory

The asm/cpu_device_id.h header is not actually needed here,
so don't include it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200102135322.1841053-1-arnd@arndb.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cml_rt1011_rt5682.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
index a22f97234201..5f1bf6d3800c 100644
--- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
+++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
@@ -11,7 +11,6 @@
 #include <linux/clk.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
-#include <asm/cpu_device_id.h>
 #include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/jack.h>
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
