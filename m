Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCE4CA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:18:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5074E21744
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Oj0B9NJQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XJVUT1V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5074E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 989222067;
	Mon, 28 Oct 2019 16:17:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 989222067
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572275908;
	bh=iAuUrsUgBZF0cczQFMQxyrh3TkQYXZa7htuJCFbHRuk=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Oj0B9NJQ8L3+BTBT1dC3nGHfXexWSR9zRmXQjjXcsqx5AWfdK5zJl2AoJ9BLwFoX8
	 S8o1AA4b069wmhxfeoWuNV0RhHtRl5BN/A7AbKnYhpXWk2tyb+HjSmuQ3UKxF5/c6T
	 bP8I+J45r8z5JZ5Y5XWNz2aoS0s6eBmc3/hjPGI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 020EAF80CB4;
	Mon, 28 Oct 2019 15:57:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BA55F80642; Mon, 28 Oct 2019 15:57:16 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DE6DF80649
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 15:56:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DE6DF80649
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="XJVUT1V5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=nwOx8or51i7UJOhgD9RXRX9uRN63VexuC0lVIBwn7g4=; b=XJVUT1V5BODM
 tl3gfowqFWhMLIRawbAJxleQhWfrzw42r+KRKCCw5XG9g6SHPC/7PVGYdRlYEpWj7oUu+JwrWhls1
 d+aHI3yXX0LD5M87kptYw7d5sLu4dX9UxvwrQ6dzm+EKPkGgs1Nqa+HMpnhTaruf8ox4REyS5YMYh
 mM/8I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iP6Rj-0008Rw-Uc; Mon, 28 Oct 2019 14:56:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 986372741532; Mon, 28 Oct 2019 14:56:38 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Keyon Jie <yang.jie@linux.intel.com>
In-Reply-To: <20191025221538.6668-1-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191028145638.986372741532@ypsilon.sirena.org.uk>
Date: Mon, 28 Oct 2019 14:56:38 +0000 (GMT)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: Intel: hda-stream: fix the CONFIG_
	prefix missing" to the asoc tree
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

   ASoC: SOF: Intel: hda-stream: fix the CONFIG_ prefix missing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From f792bd173a6fd51d1a4dde04263085ce67486aa3 Mon Sep 17 00:00:00 2001
From: Keyon Jie <yang.jie@linux.intel.com>
Date: Fri, 25 Oct 2019 17:15:38 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda-stream: fix the CONFIG_ prefix missing

We are missing the 'CONFIG_' prefix when using the kernel configure item
SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1, here correct them.

Fixes: 43b2ab9009b13b ('ASoC: SOF: Intel: hda: Disable DMI L1 entry during capture')
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191025221538.6668-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 2c7447188402..0c11fceb28a7 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -190,7 +190,7 @@ hda_dsp_stream_get(struct snd_sof_dev *sdev, int direction)
 	 * Workaround to address a known issue with host DMA that results
 	 * in xruns during pause/release in capture scenarios.
 	 */
-	if (!IS_ENABLED(SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1))
+	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1))
 		if (stream && direction == SNDRV_PCM_STREAM_CAPTURE)
 			snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
 						HDA_VS_INTEL_EM2,
@@ -228,7 +228,7 @@ int hda_dsp_stream_put(struct snd_sof_dev *sdev, int direction, int stream_tag)
 	spin_unlock_irq(&bus->reg_lock);
 
 	/* Enable DMI L1 entry if there are no capture streams open */
-	if (!IS_ENABLED(SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1))
+	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1))
 		if (!active_capture_stream)
 			snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
 						HDA_VS_INTEL_EM2,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
