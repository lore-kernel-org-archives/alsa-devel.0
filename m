Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F4FC38BF9
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:28:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48ED21744
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HLeQjlQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48ED21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29A46167B;
	Mon, 24 Feb 2020 23:27:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29A46167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582583298;
	bh=iAPNrnMGLwPoNCksVT579tqAJi4cqayIB4p/n91ObcE=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=HLeQjlQZR5a57YSVJIt/AJMwnkNB2yZgig7Qnz9L8Xyz+YRJhYIcYxaU7Vp8Uepgx
	 YFlTScLYOqBRW05D0BZAhZbchn7nx8CfZuxNGMoC/0w5GJ4litj7OsUH59Pq3Ob9Tk
	 ewlS26QtWFxd4fOIjMJYeOJAwM+6AGUSkhLQbSNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6D61F802EC;
	Mon, 24 Feb 2020 23:22:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 152ABF802F7; Mon, 24 Feb 2020 23:22:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 239EBF802E9
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 23:22:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 239EBF802E9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20C4B30E;
 Mon, 24 Feb 2020 14:22:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8113F534;
 Mon, 24 Feb 2020 14:22:14 -0800 (PST)
Date: Mon, 24 Feb 2020 22:22:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-pcm/soc-compress: don't use
 snd_soc_dapm_stream_stop()" to the asoc tree
In-Reply-To: <87lfowspeb.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-87lfowspeb.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Chris Gorman <chrisjohgorman@gmail.com>
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

   ASoC: soc-pcm/soc-compress: don't use snd_soc_dapm_stream_stop()

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

From 1c5312308c96556ae209e8eb1423c38d4a113759 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 21 Feb 2020 10:25:18 +0900
Subject: [PATCH] ASoC: soc-pcm/soc-compress: don't use
 snd_soc_dapm_stream_stop()

commit b0edff42360ab4 ("ASoC: soc-pcm/soc-compress: use
snd_soc_dapm_stream_stop() for SND_SOC_DAPM_STREAM_STOP")
uses snd_soc_dapm_stream_stop() for soc_compr_free_fe()
and dpcm_fe_dai_shutdown() because it didn't care about pmdown_time.
But, it didn't need to care.
This patch rollback to original code.
Some system will wait unneeded timed-out without this patch.
Special Thanks for reporting to Chris Gorman.
	...
	intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
	intel_sst_acpi 808622A8:00: fw returned err -16
	sst-mfld-platform sst-mfld-platform: ASoC: PRE_PMD: pcm0_in event failed: -16
	...

Fixes: commit b0edff42360ab4 ("ASoC: soc-pcm/soc-compress: use snd_soc_dapm_stream_stop() for SND_SOC_DAPM_STREAM_STOP")
Reported-by: Chris Gorman <chrisjohgorman@gmail.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87lfowspeb.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 2 +-
 sound/soc/soc-pcm.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 223cd045719e..392a1c5b15d3 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -299,7 +299,7 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 	for_each_dpcm_be(fe, stream, dpcm)
 		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 
-	snd_soc_dapm_stream_stop(fe, stream);
+	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
 
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 42fb03a99cb1..6d400bf02ca1 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2006,7 +2006,7 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
 	soc_pcm_close(substream);
 
 	/* run the stream event for each BE */
-	snd_soc_dapm_stream_stop(fe, stream);
+	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
 
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
-- 
2.20.1

