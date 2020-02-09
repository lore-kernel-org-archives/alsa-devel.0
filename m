Return-Path: <SRS0=eYvk=35=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25116C35250
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Feb 2020 15:52:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A373E20715
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Feb 2020 15:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IGBidBiK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=serbinski.com header.i=@serbinski.com header.b="CO5cB3WH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A373E20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=serbinski.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 088E31677;
	Sun,  9 Feb 2020 16:51:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 088E31677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581263518;
	bh=e48uISHWhV0pG9e51WoVyC062iFT9RRAhDV8FoV2RQY=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IGBidBiKFHQ4H0DSTx2YZ1C50Cq5KG+Zy7KSGwdPzi5HvMNtVDafgaEZk3gXHoaNs
	 wXGKgZvy9qOMTN6WKehLAG3mL7+DbvOoZOvg+SuPkmaffaVowmHb8tdccSi9i6E85B
	 IZrjy4OJo+1EZ1eV3IFyKRGWRuPSe3RBNJrxFaUM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 860D8F8028F;
	Sun,  9 Feb 2020 16:48:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31A27F8028C; Sun,  9 Feb 2020 16:48:34 +0100 (CET)
Received: from mail.serbinski.com (mail.serbinski.com [162.218.126.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2FBEF8012F
 for <alsa-devel@alsa-project.org>; Sun,  9 Feb 2020 16:48:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2FBEF8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=serbinski.com header.i=@serbinski.com
 header.b="CO5cB3WH"
Received: from localhost (unknown [127.0.0.1])
 by mail.serbinski.com (Postfix) with ESMTP id 736DED00715;
 Sun,  9 Feb 2020 15:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
 by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2qxmFt82Ywya; Sun,  9 Feb 2020 10:48:16 -0500 (EST)
Received: from anet (23-233-80-73.cpe.pppoe.ca [23.233.80.73])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.serbinski.com (Postfix) with ESMTPSA id 80767D00700;
 Sun,  9 Feb 2020 10:48:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com 80767D00700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
 s=default; t=1581263288;
 bh=K2MdRRtZpB4Txo2PfziKzlrlKIrsC2ebzByAwXpZmVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CO5cB3WHc9+nP6Wj0W45h/kXv+PJjc/3sKHp5SyuMtHj7GTYIyL2aVOCkM0rZpJMr
 Zlh2D0NYLDI+np53AUba84qEmojBH1jqjg/Ozt4EFB79IFSuJtkiYr2sLsgP8AUS58
 y2RyyimWKPgErBh5n+khAHj5TFgVDiJLc41qdX+0=
From: Adam Serbinski <adam@serbinski.com>
To: Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Sun,  9 Feb 2020 10:47:48 -0500
Message-Id: <20200209154748.3015-9-adam@serbinski.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200209154748.3015-1-adam@serbinski.com>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Andy Gross <agross@kernel.org>, Adam Serbinski <adam@serbinski.com>,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH v2 8/8] ASoC: qcom: apq8096: add kcontrols to
	set PCM rate
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This makes it possible for the backend sample rate to be
set to 8000 or 16000 Hz, depending on the needs of the HFP
call being set up.

Signed-off-by: Adam Serbinski <adam@serbinski.com>
CC: Andy Gross <agross@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Patrick Lai <plai@codeaurora.org>
CC: Banajit Goswami <bgoswami@codeaurora.org>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: alsa-devel@alsa-project.org
CC: linux-arm-msm@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 sound/soc/qcom/apq8096.c | 92 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 1edcaa15234f..882f2c456321 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -16,6 +16,9 @@
 #define MI2S_BCLK_RATE			1536000
 #define PCM_BCLK_RATE			1024000
 
+static int pri_pcm_sample_rate = 16000;
+static int quat_pcm_sample_rate = 16000;
+
 static int msm_snd_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
@@ -33,10 +36,15 @@ static int msm_snd_hw_params(struct snd_pcm_substream *substream,
 	switch (cpu_dai->id) {
 	case PRIMARY_PCM_RX:
 	case PRIMARY_PCM_TX:
+		rate->min = pri_pcm_sample_rate;
+		rate->max = pri_pcm_sample_rate;
+		channels->min = 1;
+		channels->max = 1;
+		break;
 	case QUATERNARY_PCM_RX:
 	case QUATERNARY_PCM_TX:
-		rate->min = 16000;
-		rate->max = 16000;
+		rate->min = quat_pcm_sample_rate;
+		rate->max = quat_pcm_sample_rate;
 		channels->min = 1;
 		channels->max = 1;
 		break;
@@ -121,6 +129,83 @@ static struct snd_soc_ops apq8096_ops = {
 	.startup = msm_snd_startup,
 };
 
+static char const *pcm_sample_rate_text[] = {"8 kHz", "16 kHz"};
+static const struct soc_enum pcm_snd_enum =
+		SOC_ENUM_SINGLE_EXT(2, pcm_sample_rate_text);
+
+static int get_sample_rate_idx(int sample_rate)
+{
+	int sample_rate_idx = 0;
+
+	switch (sample_rate) {
+	case 8000:
+		sample_rate_idx = 0;
+		break;
+	case 16000:
+	default:
+		sample_rate_idx = 1;
+		break;
+	}
+
+	return sample_rate_idx;
+}
+
+static int pri_pcm_sample_rate_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] =
+		get_sample_rate_idx(pri_pcm_sample_rate);
+	return 0;
+}
+
+static int quat_pcm_sample_rate_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] =
+		get_sample_rate_idx(quat_pcm_sample_rate);
+	return 0;
+}
+
+static int get_sample_rate(int idx)
+{
+	int sample_rate_val = 0;
+
+	switch (idx) {
+	case 0:
+		sample_rate_val = 8000;
+		break;
+	case 1:
+	default:
+		sample_rate_val = 16000;
+		break;
+	}
+
+	return sample_rate_val;
+}
+
+static int pri_pcm_sample_rate_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	pri_pcm_sample_rate =
+		get_sample_rate(ucontrol->value.integer.value[0]);
+	return 0;
+}
+
+static int quat_pcm_sample_rate_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	quat_pcm_sample_rate =
+		get_sample_rate(ucontrol->value.integer.value[0]);
+	return 0;
+}
+
+static const struct snd_kcontrol_new card_controls[] = {
+	SOC_ENUM_EXT("PRI_PCM SampleRate", pcm_snd_enum,
+		     pri_pcm_sample_rate_get, pri_pcm_sample_rate_put),
+	SOC_ENUM_EXT("QUAT_PCM SampleRate", pcm_snd_enum,
+		     quat_pcm_sample_rate_get, quat_pcm_sample_rate_put),
+};
+
 static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
@@ -182,6 +267,9 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_card_register;
 
+	snd_soc_add_card_controls(card, card_controls,
+				  ARRAY_SIZE(card_controls));
+
 	return 0;
 
 err_card_register:
-- 
2.21.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
