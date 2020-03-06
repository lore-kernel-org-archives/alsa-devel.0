Return-Path: <SRS0=YoTX=4X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82192C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:09:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF2A20848
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rXJNyntb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF2A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4786E1660;
	Fri,  6 Mar 2020 16:09:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4786E1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583507391;
	bh=acbdV+2xxwfLH/wGaAvIqeMAKuOWGpr4zToR0ps/WqA=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=rXJNyntbcFbSlK4mV4CfLkoUFZKU9FtqSCvVNhUWvNa/VMqsEuXmUcmHh32QqzmT4
	 mCPq1bBiVz1VnDLEv6St16xsD7vnCWkXLZpHykWAOe2FOF7iOy8dJVNUQ9Tsu+XgVI
	 jZGwArvN16IzDP+W90BZD0RIbCceC6baEq6RqCzo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A77D7F802F7;
	Fri,  6 Mar 2020 16:03:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03943F802F9; Fri,  6 Mar 2020 16:03:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 77A78F802F7
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2020 16:03:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77A78F802F7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F7864B2;
 Fri,  6 Mar 2020 07:03:43 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22EDD3F237;
 Fri,  6 Mar 2020 07:03:42 -0800 (PST)
Date: Fri, 06 Mar 2020 15:03:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Samuel Holland <samuel@sholland.org>
Subject: Applied "ALSA: pcm: Add a standalone version of
 snd_pcm_limit_hw_rates" to the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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
Message-ID: <20200306150341.PN9dhdXbnaMQJZUnssQNN3CTpsCZTxVCRIJIBtajwvw@z>

The patch

   ALSA: pcm: Add a standalone version of snd_pcm_limit_hw_rates

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

From 4769bfb9dada678b31a2ec275372624dbfeed9d1 Mon Sep 17 00:00:00 2001
From: Samuel Holland <samuel@sholland.org>
Date: Wed, 4 Mar 2020 23:11:41 -0600
Subject: [PATCH] ALSA: pcm: Add a standalone version of snd_pcm_limit_hw_rates

It can be useful to derive min/max rates of a snd_pcm_hardware without
having a snd_pcm_runtime, such as before constructing an ASoC DAI link.

Create a new helper that takes a pointer to a snd_pcm_hardware directly,
and refactor the original function as a wrapper around it, to avoid
needing to update any call sites.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200305051143.60691-2-samuel@sholland.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/pcm.h   |  9 ++++++++-
 sound/core/pcm_misc.c | 18 +++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2628246b76fa..f7a95b711100 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1127,7 +1127,14 @@ snd_pcm_kernel_readv(struct snd_pcm_substream *substream,
 	return __snd_pcm_lib_xfer(substream, bufs, false, frames, true);
 }
 
-int snd_pcm_limit_hw_rates(struct snd_pcm_runtime *runtime);
+int snd_pcm_hw_limit_rates(struct snd_pcm_hardware *hw);
+
+static inline int
+snd_pcm_limit_hw_rates(struct snd_pcm_runtime *runtime)
+{
+	return snd_pcm_hw_limit_rates(&runtime->hw);
+}
+
 unsigned int snd_pcm_rate_to_rate_bit(unsigned int rate);
 unsigned int snd_pcm_rate_bit_to_rate(unsigned int rate_bit);
 unsigned int snd_pcm_rate_mask_intersect(unsigned int rates_a,
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index a6a541511534..5dd2e5335900 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -474,32 +474,32 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 EXPORT_SYMBOL(snd_pcm_format_set_silence);
 
 /**
- * snd_pcm_limit_hw_rates - determine rate_min/rate_max fields
- * @runtime: the runtime instance
+ * snd_pcm_hw_limit_rates - determine rate_min/rate_max fields
+ * @hw: the pcm hw instance
  *
  * Determines the rate_min and rate_max fields from the rates bits of
- * the given runtime->hw.
+ * the given hw.
  *
  * Return: Zero if successful.
  */
-int snd_pcm_limit_hw_rates(struct snd_pcm_runtime *runtime)
+int snd_pcm_hw_limit_rates(struct snd_pcm_hardware *hw)
 {
 	int i;
 	for (i = 0; i < (int)snd_pcm_known_rates.count; i++) {
-		if (runtime->hw.rates & (1 << i)) {
-			runtime->hw.rate_min = snd_pcm_known_rates.list[i];
+		if (hw->rates & (1 << i)) {
+			hw->rate_min = snd_pcm_known_rates.list[i];
 			break;
 		}
 	}
 	for (i = (int)snd_pcm_known_rates.count - 1; i >= 0; i--) {
-		if (runtime->hw.rates & (1 << i)) {
-			runtime->hw.rate_max = snd_pcm_known_rates.list[i];
+		if (hw->rates & (1 << i)) {
+			hw->rate_max = snd_pcm_known_rates.list[i];
 			break;
 		}
 	}
 	return 0;
 }
-EXPORT_SYMBOL(snd_pcm_limit_hw_rates);
+EXPORT_SYMBOL(snd_pcm_hw_limit_rates);
 
 /**
  * snd_pcm_rate_to_rate_bit - converts sample rate to SNDRV_PCM_RATE_xxx bit
-- 
2.20.1

