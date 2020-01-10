Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020DC33CA3
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:40:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2102077C
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o5qTkito"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2102077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34E591730;
	Fri, 10 Jan 2020 14:39:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34E591730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578663618;
	bh=5/4VKszxRgGOvbHa/Hpf08eKHUXRjYUJwkRiA57he1U=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=o5qTkitog2ugnrRx2SKPA8GJ5PIng9PkshR6uNTCJBoDwucL4fR6nfX/trvgKmRUF
	 776+n6QJzF2NjgqtJ0xdX7W+E4urK53ZvTAjFPDXU+GlFkbO65tV8QFR49KdsoaShU
	 Ln/O/PSvJeCAFPqj4idhetGJAk6sSW9Tq3Mfaya4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3EF2F80246;
	Fri, 10 Jan 2020 14:37:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1142F801F4; Fri, 10 Jan 2020 14:37:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 961E5F80130
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 14:37:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 961E5F80130
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D377DA7;
 Fri, 10 Jan 2020 05:37:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA0203F534;
 Fri, 10 Jan 2020 05:37:45 -0800 (PST)
Date: Fri, 10 Jan 2020 13:37:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874kx4t4v6.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-874kx4t4v6.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-core: do pinctrl_pm_select_xxx() as
	component" to the asoc tree
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

   ASoC: soc-core: do pinctrl_pm_select_xxx() as component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 76c39e867cba338d8982f6372b2c4e3189f6439b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 10 Jan 2020 11:36:13 +0900
Subject: [PATCH] ASoC: soc-core: do pinctrl_pm_select_xxx() as component

ALSA SoC need to care pinctrl_pm_select_xxx().
It is called at soc-core and soc-pcm.
soc-pcm  is controlling it for activate DAI.
soc-core is controlling it for whole system
(= suspend/resume/probe/poweroff).

If we focus to soc-core side, it need to care about BIAS level.
Then, snd_soc_suspend() only is controlling it by Component base (a).
Other functions are DAI base (b).

(a)	pinctrl_pm_select_xxx(component->dev, xxx);
(b)	pinctrl_pm_select_xxx(dai->dev, xxx);

Because of these unbalance, the code is confusable.
Here, dai->dev and component->dev are same pointer.
Thus, we can replace it component base.

One note here is that it cared DAI (= CPU/Codec) pin before this patch,
after this patch, it cares Component (= CPU/Codec/Platform) pin.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-By: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/874kx4t4v6.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 46 +++++++++++---------------------------------
 sound/soc/soc-pcm.c  | 23 ++++++++--------------
 2 files changed, 19 insertions(+), 50 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 191b68732e56..3c729eaf0bbf 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -727,25 +727,16 @@ int snd_soc_resume(struct device *dev)
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	bool bus_control = false;
 	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_dai *codec_dai;
-	int i;
+	struct snd_soc_component *component;
 
 	/* If the card is not initialized yet there is nothing to do */
 	if (!card->instantiated)
 		return 0;
 
 	/* activate pins from sleep state */
-	for_each_card_rtds(card, rtd) {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-
-		if (cpu_dai->active)
-			pinctrl_pm_select_default_state(cpu_dai->dev);
-
-		for_each_rtd_codec_dai(rtd, i, codec_dai) {
-			if (codec_dai->active)
-				pinctrl_pm_select_default_state(codec_dai->dev);
-		}
-	}
+	for_each_card_components(card, component)
+		if (component->active)
+			pinctrl_pm_select_default_state(component->dev);
 
 	/*
 	 * DAIs that also act as the control bus master might have other drivers
@@ -1885,6 +1876,7 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 static int snd_soc_bind_card(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_component *component;
 	struct snd_soc_dai_link *dai_link;
 	int ret, i, card_probed = 0;
 
@@ -2036,17 +2028,9 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 	snd_soc_dapm_sync(&card->dapm);
 
 	/* deactivate pins to sleep state */
-	for_each_card_rtds(card, rtd) {
-		struct snd_soc_dai *dai;
-
-		for_each_rtd_codec_dai(rtd, i, dai) {
-			if (!dai->active)
-				pinctrl_pm_select_sleep_state(dai->dev);
-		}
-
-		if (!rtd->cpu_dai->active)
-			pinctrl_pm_select_sleep_state(rtd->cpu_dai->dev);
-	}
+	for_each_card_components(card, component)
+		if (!component->active)
+			pinctrl_pm_select_sleep_state(component->dev);
 
 probe_end:
 	if (ret < 0)
@@ -2092,7 +2076,7 @@ static int soc_remove(struct platform_device *pdev)
 int snd_soc_poweroff(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
-	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_component *component;
 
 	if (!card->instantiated)
 		return 0;
@@ -2106,16 +2090,8 @@ int snd_soc_poweroff(struct device *dev)
 	snd_soc_dapm_shutdown(card);
 
 	/* deactivate pins to sleep state */
-	for_each_card_rtds(card, rtd) {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-		struct snd_soc_dai *codec_dai;
-		int i;
-
-		pinctrl_pm_select_sleep_state(cpu_dai->dev);
-		for_each_rtd_codec_dai(rtd, i, codec_dai) {
-			pinctrl_pm_select_sleep_state(codec_dai->dev);
-		}
-	}
+	for_each_card_components(card, component)
+		pinctrl_pm_select_sleep_state(component->dev);
 
 	return 0;
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 9c6c7533a508..68f72051f8e3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -487,9 +487,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	const char *codec_dai_name = "multicodec";
 	int i, ret = 0;
 
-	pinctrl_pm_select_default_state(cpu_dai->dev);
-	for_each_rtd_codec_dai(rtd, i, codec_dai)
-		pinctrl_pm_select_default_state(codec_dai->dev);
+	for_each_rtd_components(rtd, i, component)
+		pinctrl_pm_select_default_state(component->dev);
 
 	for_each_rtd_components(rtd, i, component)
 		pm_runtime_get_sync(component->dev);
@@ -618,12 +617,9 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		pm_runtime_put_autosuspend(component->dev);
 	}
 
-	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		if (!codec_dai->active)
-			pinctrl_pm_select_sleep_state(codec_dai->dev);
-	}
-	if (!cpu_dai->active)
-		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+	for_each_rtd_components(rtd, i, component)
+		if (!component->active)
+			pinctrl_pm_select_sleep_state(component->dev);
 
 	return ret;
 }
@@ -728,12 +724,9 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 		pm_runtime_put_autosuspend(component->dev);
 	}
 
-	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		if (!codec_dai->active)
-			pinctrl_pm_select_sleep_state(codec_dai->dev);
-	}
-	if (!cpu_dai->active)
-		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+	for_each_rtd_components(rtd, i, component)
+		if (!component->active)
+			pinctrl_pm_select_sleep_state(component->dev);
 
 	return 0;
 }
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
