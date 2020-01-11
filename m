Return-Path: <SRS0=uq2S=3A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B84C282DD
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jan 2020 16:43:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F5420866
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jan 2020 16:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dsFtbYqA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="PIKddwFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F5420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66B7616C8;
	Sat, 11 Jan 2020 17:42:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66B7616C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578761008;
	bh=1F8CnGGVaMRAM14xSbDRDIchCMX/vTlyp8+BL5NeCFo=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dsFtbYqApDgDe+Ko4OtTD2SpA3zTbAdyKjaKAoQGV9+c7Vspl8ulg+uZkEFl4/uYi
	 22FNpN5UDVZJaNNc5kHBicOKQ/UolSEyBwjXCUOrBJ4c2VT3Rg0inyVE1NR70qwprH
	 Zf+izQdCCN1PucRMbvXZ+npMyt4+uos6ZjtoO2Uc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 160ACF80271;
	Sat, 11 Jan 2020 17:41:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 352D2F80214; Sat, 11 Jan 2020 17:40:56 +0100 (CET)
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B062F80172
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2020 17:40:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B062F80172
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="PIKddwFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578760852;
 s=strato-dkim-0002; d=gerhold.net;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=Bv0UwbPPX3PdL2BbwUM1WioaUUkX2TTCKG3AOyhSfXQ=;
 b=PIKddwFjC5laVF6s09EGPZ51TgzQAKfBJ7WdvwXs+jT/zf0aLh+5AfwcVyAbNKnkv+
 Jtut9A5xm+13fQJDWTtqq2R18k50YXc9saT8NVvjxpc4SzKRMQuhmCGz19DTL+gpxnli
 rLWsyIHrHjFD27VCN7HQYCJCYAN9vhHHMf5L9Z/ME9Irq0CgeKgiGL1ET6xb2lg/H+zj
 lZcMfFzab30osOcKTvoXi0HNYCsZzGzQFxDH1n/1KBpNpcEzIKzPWusFCY2yZ00cEQ/G
 900rpoOGY5rXsYTv5+ebX0QF2nW3No0HZHDdo1Zowkgy5QYSDEOIE32dH5AOi9WyVHtm
 duRg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMv5qxJRCe0="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain by smtp.strato.de (RZmta 46.1.4 AUTH)
 with ESMTPSA id h048a6w0BGeoFq9
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 11 Jan 2020 17:40:50 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Date: Sat, 11 Jan 2020 17:40:04 +0100
Message-Id: <20200111164006.43074-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111164006.43074-1-stephan@gerhold.net>
References: <20200111164006.43074-1-stephan@gerhold.net>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: [alsa-devel] [PATCH 2/4] ASoC: msm8916-wcd-analog: Fix MIC BIAS
	Internal1
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

MIC BIAS Internal1 is broken at the moment because we always
enable the internal rbias resistor to the TX2 line (connected to
the headset microphone), rather than enabling the resistor connected
to TX1.

Move the RBIAS code to pm8916_wcd_analog_enable_micbias_int1/2()
to fix this.

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 30b19f12fabc..1f7964beb20c 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -396,9 +396,6 @@ static int pm8916_wcd_analog_enable_micbias_int(struct snd_soc_component
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
-				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
-				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
 		snd_soc_component_update_bits(component, reg, MICB_1_EN_PULL_DOWN_EN_MASK, 0);
 		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
 				    MICB_1_EN_OPA_STG2_TAIL_CURR_MASK,
@@ -448,6 +445,14 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
+				    MICB_1_INT_TX1_INT_RBIAS_EN_MASK,
+				    MICB_1_INT_TX1_INT_RBIAS_EN_ENABLE);
+		break;
+	}
+
 	return pm8916_wcd_analog_enable_micbias_int(component, event, w->reg,
 						     wcd->micbias1_cap_mode);
 }
@@ -558,6 +563,11 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
 	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
+				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
+				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
+		break;
 	case SND_SOC_DAPM_POST_PMU:
 		pm8916_mbhc_configure_bias(wcd, true);
 		break;
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
