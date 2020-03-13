Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1532DC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:23:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9628B20749
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YowKjuk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9628B20749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C273F1846;
	Fri, 13 Mar 2020 17:22:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C273F1846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584116599;
	bh=HfoZOCZWHmcu1ZWjtDS51x17byYbQ7eDnHAnKkLgcm4=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=YowKjuk6R+lIuaVDGB5yU5tWDBLRkNjYdknRhmLxcaW6t+kOG1ExQRfMo57YlUgHG
	 ERkZ95GWNDIX3aeOfLxFBEGAGUDSWsgXfRHCU7H3I5J0FqQcil7Jz1eDsFS2PW8V0b
	 9IYO3+cZdUYc+pdcX7dzqV1DDnZ6hTMtvKT2mg/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E55EDF802EB;
	Fri, 13 Mar 2020 17:18:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BED3DF802DC; Fri, 13 Mar 2020 17:17:53 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id EDC7BF8029B
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 17:17:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDC7BF8029B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4159E1045;
 Fri, 13 Mar 2020 09:17:48 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB4F33F6CF;
 Fri, 13 Mar 2020 09:17:47 -0700 (PDT)
Date: Fri, 13 Mar 2020 16:17:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Applied "ASoC: codecs: hdac_hdmi: (cosmetic) remove redundant
 variable initialisations" to the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
Message-ID: <20200313161746.p0hFd3UEEKy79DR2GTFdZNeVf0fZULiNAZaIqIDBL-I@z>

The patch

   ASoC: codecs: hdac_hdmi: (cosmetic) remove redundant variable initialisations

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From c4aafb337d311556d4448f8de857ca2683f5ca5b Mon Sep 17 00:00:00 2001
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Date: Thu, 12 Mar 2020 14:48:54 -0500
Subject: [PATCH] ASoC: codecs: hdac_hdmi: (cosmetic) remove redundant variable
 initialisations

Remove several redundant variable initialisations.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200312194859.4051-6-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e6558475e006..fba9b749839d 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1998,11 +1998,11 @@ static struct hdac_hdmi_drv_data intel_drv_data  = {
 
 static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
 {
-	struct hdac_hdmi_priv *hdmi_priv = NULL;
+	struct hdac_hdmi_priv *hdmi_priv;
 	struct snd_soc_dai_driver *hdmi_dais = NULL;
-	struct hdac_ext_link *hlink = NULL;
+	struct hdac_ext_link *hlink;
 	int num_dais = 0;
-	int ret = 0;
+	int ret;
 	struct hdac_driver *hdrv = drv_to_hdac_driver(hdev->dev.driver);
 	const struct hda_device_id *hdac_id = hdac_get_device_id(hdev, hdrv);
 
-- 
2.20.1

