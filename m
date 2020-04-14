Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5F1C38A29
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 15:13:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074A42076D
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 15:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gL2KYDnx";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaRLRd/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074A42076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC6D616F3;
	Tue, 14 Apr 2020 17:04:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC6D616F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586876703;
	bh=t6HhPthXOeudzf4EoTUu9Wb5jBRGgu3IJn0173Tyybs=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=gL2KYDnxthDfCzz0C29fjC7SkXOv7R2KinoGtwhWtyd8ywlqZURLVzUgTdcxQC9Na
	 oilFaQ/IrxqvjqAQx5v0JBpdbw2Y3KkThGg79+LY4jmzJcQnKbLIscRCAaDQa/IjMo
	 UOl4xgX7JbznRDSsMeWHJ71oylQodNjDd0Gs4zMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E8FEF803CB;
	Tue, 14 Apr 2020 16:48:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C944CF803CB; Tue, 14 Apr 2020 16:48:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5EE00F80394
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 16:48:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EE00F80394
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PaRLRd/q"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2585A20578;
 Tue, 14 Apr 2020 14:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586875713;
 bh=t6HhPthXOeudzf4EoTUu9Wb5jBRGgu3IJn0173Tyybs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=PaRLRd/qZETZhLKej5zTVhEMkM1d3Xv0zol/25ulqj+w3MpotOWPpExsZhwuEFs2I
 6hwXkazTMAM7lV/MqVpUSR9QIK7c96m3HyHP2DAY9heT8qqGDpYrXfj2iTHfR+lCLM
 RYkktkFfCH7NySLNBM2/U2Vd+8ygJibVkTeECOqk=
Date: Tue, 14 Apr 2020 15:48:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-core: remove
 cpu_dai/codec_dai/cpu_dais/codec_dais" to the asoc tree
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
Message-ID: <20200414144831.2FVEVpG7cmX1hBSGoywbsPuZwgU-3si8fYMCg0cXb_w@z>

The patch

   ASoC: soc-core: remove cpu_dai/codec_dai/cpu_dais/codec_dais

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

From 1729025b04b9f242dca37f50dba8dd3705eb1ea1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Mar 2020 10:48:27 +0900
Subject: [PATCH] ASoC: soc-core: remove cpu_dai/codec_dai/cpu_dais/codec_dais

No-one is using cpu_dai/codec_dai/cpu_dais/codec_dais.
Let's remove these from snd_soc_pcm_runtime

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/87eetabok4.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 14 ++++++++------
 sound/soc/soc-core.c | 11 +++--------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4dff6745b067..a904086b8ef6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1143,14 +1143,16 @@ struct snd_soc_pcm_runtime {
 	/* runtime devices */
 	struct snd_pcm *pcm;
 	struct snd_compr *compr;
-	struct snd_soc_dai *codec_dai;
-	struct snd_soc_dai *cpu_dai;
-	struct snd_soc_dai **dais;
 
-	struct snd_soc_dai **codec_dais;
+	/*
+	 * dais = cpu_dai + codec_dai
+	 * see
+	 *	soc_new_pcm_runtime()
+	 *	asoc_rtd_to_cpu()
+	 *	asoc_rtd_to_codec()
+	 */
+	struct snd_soc_dai **dais;
 	unsigned int num_codecs;
-
-	struct snd_soc_dai **cpu_dais;
 	unsigned int num_cpus;
 
 	struct delayed_work delayed_work;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4d617c495864..7ea9725e33b3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -487,9 +487,10 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 	 * dais = [][][][][][][][][][][][][][][][][][]
 	 *	  ^cpu_dais         ^codec_dais
 	 *	  |--- num_cpus ---|--- num_codecs --|
+	 * see
+	 *	asoc_rtd_to_cpu()
+	 *	asoc_rtd_to_codec()
 	 */
-	rtd->cpu_dais	= &rtd->dais[0];
-	rtd->codec_dais	= &rtd->dais[dai_link->num_cpus];
 	rtd->num_cpus	= dai_link->num_cpus;
 	rtd->num_codecs	= dai_link->num_codecs;
 	rtd->card	= card;
@@ -996,9 +997,6 @@ int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
 		snd_soc_rtd_add_component(rtd, asoc_rtd_to_cpu(rtd, i)->component);
 	}
 
-	/* Single cpu links expect cpu and cpu_dai in runtime data */
-	rtd->cpu_dai = rtd->cpu_dais[0];
-
 	/* Find CODEC from registered CODECs */
 	for_each_link_codecs(dai_link, i, codec) {
 		asoc_rtd_to_codec(rtd, i) = snd_soc_find_dai(codec);
@@ -1011,9 +1009,6 @@ int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
 		snd_soc_rtd_add_component(rtd, asoc_rtd_to_codec(rtd, i)->component);
 	}
 
-	/* Single codec links expect codec and codec_dai in runtime data */
-	rtd->codec_dai = rtd->codec_dais[0];
-
 	/* Find PLATFORM from registered PLATFORMs */
 	for_each_link_platforms(dai_link, i, platform) {
 		for_each_component(component) {
-- 
2.20.1

