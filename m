Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E22C64990
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Aug 2022 14:05:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BAB11651;
	Thu, 25 Aug 2022 16:04:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BAB11651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661436320;
	bh=2eWtxR6h5cKcaATkGjTf95IBUyrKongIpP1qnmxVxa8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cC22XTCmyMkuOQWsKYqT8iPWAOBtY2cqyoa4rqNsPfmdegvd8jwx38VyEPlm3s/el
	 sGgFSTNfkGhk6EntOX9qt56qhfPUMP0SJx0L/UcWzzBXkLCehvGteBft35XgO/NDOQ
	 y8rI9VhkvxXgWnljENuipzNjziVFz2syv8WYSDJI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B574FF80557;
	Thu, 25 Aug 2022 16:03:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F64AF800C8; Thu, 25 Aug 2022 16:03:02 +0200 (CEST)
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9D2DF8027C
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2022 16:02:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9D2DF8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="r31WAVO2"
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1661436172; bh=PsCam++xDona5BVDShW7mfj5kX/puOVnGoX+XMGkuc8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=r31WAVO2XWASiv4N/KJcm/d/M9XAJsD7XFnrJl5o758Se1fe0WQIwxSkjIsVOH5ON
 e8LgKJb+uuhADj085h44Fm4WYlFXHOwzPYJ2e2IAOiehHONsugUmqaPGVO5q9VzE8v
 pGpVTLB8SLg0x9dZdNsml/t7IVBivF031WRMC044=
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/5] ASoC: tas2764: Fix mute/unmute
Date: Thu, 25 Aug 2022 16:02:39 +0200
Message-Id: <20220825140241.53963-4-povik+lin@cutebit.org>
In-Reply-To: <20220825140241.53963-1-povik+lin@cutebit.org>
References: <20220825140241.53963-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 navada@ti.com, asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
 asyrus@ti.com, shenghao-ding@ti.com, raphael-xu@ti.com,
 =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Stephen Kitt <steve@sk2.org>, Dan Murphy <dmurphy@ti.com>
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

Because the PWR_CTRL field is modeled as the power state of the DAC
widget, and at the same time it is used to implement mute/unmute, we
need some additional book-keeping to have the right end result no matter
the sequence of calls. Without this fix, one permanently mutes an
ongoing stream by toggling the associated speaker pin control.

(This mirrors commit 1e5907bcb3a3 ("ASoC: tas2770: Fix handling of
mute/unmute") which was a fix to the tas2770 driver.)

Fixes: 827ed8a0fa50 ("ASoC: tas2764: Add the driver for the TAS2764")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2764.c | 57 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index f4ac6edefdc0..39902f77a2e0 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -34,6 +34,9 @@ struct tas2764_priv {
 	
 	int v_sense_slot;
 	int i_sense_slot;
+
+	bool dac_powered;
+	bool unmuted;
 };
 
 static void tas2764_reset(struct tas2764_priv *tas2764)
@@ -50,6 +53,26 @@ static void tas2764_reset(struct tas2764_priv *tas2764)
 	usleep_range(1000, 2000);
 }
 
+static int tas2764_update_pwr_ctrl(struct tas2764_priv *tas2764)
+{
+	struct snd_soc_component *component = tas2764->component;
+	unsigned int val;
+	int ret;
+
+	if (tas2764->dac_powered)
+		val = tas2764->unmuted ?
+			TAS2764_PWR_CTRL_ACTIVE : TAS2764_PWR_CTRL_MUTE;
+	else
+		val = TAS2764_PWR_CTRL_SHUTDOWN;
+
+	ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
+					    TAS2764_PWR_CTRL_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int tas2764_codec_suspend(struct snd_soc_component *component)
 {
@@ -82,9 +105,7 @@ static int tas2764_codec_resume(struct snd_soc_component *component)
 		usleep_range(1000, 2000);
 	}
 
-	ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-					    TAS2764_PWR_CTRL_MASK,
-					    TAS2764_PWR_CTRL_ACTIVE);
+	ret = tas2764_update_pwr_ctrl(tas2764);
 
 	if (ret < 0)
 		return ret;
@@ -118,14 +139,12 @@ static int tas2764_dac_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-						    TAS2764_PWR_CTRL_MASK,
-						    TAS2764_PWR_CTRL_MUTE);
+		tas2764->dac_powered = true;
+		ret = tas2764_update_pwr_ctrl(tas2764);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-						    TAS2764_PWR_CTRL_MASK,
-						    TAS2764_PWR_CTRL_SHUTDOWN);
+		tas2764->dac_powered = false;
+		ret = tas2764_update_pwr_ctrl(tas2764);
 		break;
 	default:
 		dev_err(tas2764->dev, "Unsupported event\n");
@@ -170,17 +189,11 @@ static const struct snd_soc_dapm_route tas2764_audio_map[] = {
 
 static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
-	struct snd_soc_component *component = dai->component;
-	int ret;
-
-	ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-					    TAS2764_PWR_CTRL_MASK,
-					    mute ? TAS2764_PWR_CTRL_MUTE : 0);
+	struct tas2764_priv *tas2764 =
+			snd_soc_component_get_drvdata(dai->component);
 
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	tas2764->unmuted = !mute;
+	return tas2764_update_pwr_ctrl(tas2764);
 }
 
 static int tas2764_set_bitwidth(struct tas2764_priv *tas2764, int bitwidth)
@@ -494,12 +507,6 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
-					    TAS2764_PWR_CTRL_MASK,
-					    TAS2764_PWR_CTRL_MUTE);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
-- 
2.33.0

