Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A41C10F27
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:20:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9462B21D56
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QLfWJzht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9462B21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB7351668;
	Tue, 10 Mar 2020 19:19:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB7351668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583864411;
	bh=Y6aUNGtSOmGdhizdZ7bBqYenZuLn2oUesLGQJA+J64U=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=QLfWJzhtfJ0ca0urSGZneGx5xDtYAUcj7Qzq1+zEfPXuKqRFID+iIerA6cGiM51UU
	 681Z4wMp7DUWtc7a9c/ylnYzU0/x3NYwbBbW58eFOw0jBBB7VrGOae1Ry/K1O1Sf6i
	 tiRmJAJIeu2muIfhGBW0xlPJLoiyeEM2P/M7HAqQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D292F800BC;
	Tue, 10 Mar 2020 19:19:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A73E8F80217; Tue, 10 Mar 2020 19:19:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id CA7FBF80123
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 19:19:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA7FBF80123
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71AB430E;
 Tue, 10 Mar 2020 11:19:14 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5E243F534;
 Tue, 10 Mar 2020 11:19:13 -0700 (PDT)
Date: Tue, 10 Mar 2020 18:19:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Applied "ASoC: pcm: Fix (again) possible buffer overflow in dpcm
 state sysfs output" to the asoc tree
In-Reply-To: <20200310163625.10838-1-tiwai@suse.de>
Message-Id: <applied-20200310163625.10838-1-tiwai@suse.de>
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

The patch

   ASoC: pcm: Fix (again) possible buffer overflow in dpcm state sysfs output

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

From d0c9abb8339dfdb5c5fcdfab5aefcba578a4d50d Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Mar 2020 17:36:25 +0100
Subject: [PATCH] ASoC: pcm: Fix (again) possible buffer overflow in dpcm state
 sysfs output

This is re-applying the fix that went into 5.6 (commit 6c89ffea60aa)
as the changes were wiped out after merging the other code
refactoring.  Basically the same changes, just replacing the
suspicious calls of snprintf() with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200310163625.10838-1-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index fbea005043de..733d7e8a0e55 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -66,16 +66,16 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 	unsigned long flags;
 
 	/* FE state */
-	offset += snprintf(buf + offset, size - offset,
+	offset += scnprintf(buf + offset, size - offset,
 			   "[%s - %s]\n", fe->dai_link->name,
 			   stream ? "Capture" : "Playback");
 
-	offset += snprintf(buf + offset, size - offset, "State: %s\n",
+	offset += scnprintf(buf + offset, size - offset, "State: %s\n",
 			   dpcm_state_string(fe->dpcm[stream].state));
 
 	if ((fe->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
 	    (fe->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
-		offset += snprintf(buf + offset, size - offset,
+		offset += scnprintf(buf + offset, size - offset,
 				   "Hardware Params: "
 				   "Format = %s, Channels = %d, Rate = %d\n",
 				   snd_pcm_format_name(params_format(params)),
@@ -83,10 +83,10 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 				   params_rate(params));
 
 	/* BEs state */
-	offset += snprintf(buf + offset, size - offset, "Backends:\n");
+	offset += scnprintf(buf + offset, size - offset, "Backends:\n");
 
 	if (list_empty(&fe->dpcm[stream].be_clients)) {
-		offset += snprintf(buf + offset, size - offset,
+		offset += scnprintf(buf + offset, size - offset,
 				   " No active DSP links\n");
 		goto out;
 	}
@@ -96,16 +96,16 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		params = &dpcm->hw_params;
 
-		offset += snprintf(buf + offset, size - offset,
+		offset += scnprintf(buf + offset, size - offset,
 				   "- %s\n", be->dai_link->name);
 
-		offset += snprintf(buf + offset, size - offset,
+		offset += scnprintf(buf + offset, size - offset,
 				   "   State: %s\n",
 				   dpcm_state_string(be->dpcm[stream].state));
 
 		if ((be->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
-			offset += snprintf(buf + offset, size - offset,
+			offset += scnprintf(buf + offset, size - offset,
 					   "   Hardware Params: "
 					   "Format = %s, Channels = %d, Rate = %d\n",
 					   snd_pcm_format_name(params_format(params)),
-- 
2.20.1

