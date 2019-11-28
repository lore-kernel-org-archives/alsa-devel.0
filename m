Return-Path: <SRS0=87PQ=ZU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B0EC432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:23:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF84208E4
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ASj82vcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF84208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F2D516F3;
	Thu, 28 Nov 2019 14:22:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F2D516F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574947379;
	bh=sF2u8/PEQDSB1BssuWHQdetyoTdfDBm1Ru/IOYCzl+E=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ASj82vcN5GSpo6ivrFzl14yz0L+D+rZkiEAwIlwdY8f5e6upJkvsF2j1rvCoQgrnC
	 AsZDmL/dOqegWapEfOPWlGNt0RRDn69nHuEB/eUIuH6VfsJKhl7Am0nqngJO3Orjmk
	 j849W/HTiot309dUlW3VeqXBFSIVGxl6y39HS7bY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 432A0F80240;
	Thu, 28 Nov 2019 14:18:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38F45F80233; Thu, 28 Nov 2019 14:18:39 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 52B31F80217
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2019 14:18:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52B31F80217
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C5A71045;
 Thu, 28 Nov 2019 05:18:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0ACC3F52E;
 Thu, 28 Nov 2019 05:18:34 -0800 (PST)
Date: Thu, 28 Nov 2019 13:18:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20191126141606.21650-1-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191126141606.21650-1-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: topology: Fix unload for SAI/ESAI"
	to the asoc tree
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

   ASoC: SOF: topology: Fix unload for SAI/ESAI

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

From 469b3ad672e27b28c5865c804426f65e69c5e41a Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 26 Nov 2019 08:16:06 -0600
Subject: [PATCH] ASoC: SOF: topology: Fix unload for SAI/ESAI

Link unload now fails for ESAI/SAI DAIs with:

"error: invalid DAI type 6" because DAI type is not
properly handled.

Fix this by correctly handling cases where type is ESAI or SAI.

Fixes: a4eff5f86c9c5e7 ("ASoC: SOF: imx: Read ESAI parameters and send them to DSP")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191126141606.21650-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index d82ab981e840..e20b806ec80f 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -3132,7 +3132,9 @@ static int sof_link_unload(struct snd_soc_component *scomp,
 	case SOF_DAI_INTEL_SSP:
 	case SOF_DAI_INTEL_DMIC:
 	case SOF_DAI_INTEL_ALH:
-		/* no resource needs to be released for SSP, DMIC and ALH */
+	case SOF_DAI_IMX_SAI:
+	case SOF_DAI_IMX_ESAI:
+		/* no resource needs to be released for all cases above */
 		break;
 	case SOF_DAI_INTEL_HDA:
 		ret = sof_link_hda_unload(sdev, link);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
