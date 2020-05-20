Return-Path: <SRS0=qDfi=7C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E168C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 07:24:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD85205CB
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 07:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gGzdHIFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD85205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=2n.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5254917D1;
	Wed, 20 May 2020 09:23:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5254917D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589959487;
	bh=t/qN7rC/V5A6fp76upYwWxkzsb7MrGIG0WlutHj7ZvI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gGzdHIFgWxqbInik8CxhwR0jgX5TManSa6qegVbt2dyplbib8sLGCuxH8dUeqP3Tw
	 Ch/ha3IFL90hPHtXk7s4xTApLXHC/U9nVCzXiIKCooKl+3lAKqxYR2DD9zSGrtHrYU
	 +TuGD2XuZhSdj8qeoRMa3JzR8W4rMBvmArRnf9xA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C4AB8F80299;
	Wed, 20 May 2020 09:21:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49EA3F80213; Wed, 20 May 2020 09:21:28 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5ECCF80111
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 09:21:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5ECCF80111
IronPort-SDR: 898YfkX2l4X0uebA11ToCGzoEdI2ESksNW5TAIHHRdtO6+hjtYznCdISY3EdY9U7mwGwWJraoa
 QVziYgV8vNs6LyVRHyzmEvFzXceSJ7e02d32cOmyWzgYFAtbET9m6aSLCBY/wHvTEljfHZDQxH
 EMBucnBnftn6c2U+zR8gVdmo/xOqRm64R7744oDlT3OuNtV8JpJCUHRhQc5pw2vmHV25KhSQr+
 Jxy3EEfqs3MoDzYYn5Y4rvHIO23cLv2JC+9SfcUyLBqucoJoKsyc2Cr+hb5AvUVHOo6JYEF411
 0s8=
X-IronPort-AV: E=Sophos;i="5.73,413,1583190000"; 
   d="scan'208";a="8662020"
From: Pavel Dobias <dobias@2n.cz>
To: <alsa-devel@alsa-project.org>
Subject: [PATCH 4/6] ASoC: max9867: keep ADCs and DACs always on
Date: Wed, 20 May 2020 09:19:02 +0200
Message-ID: <20200520071904.15801-4-dobias@2n.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520071904.15801-1-dobias@2n.cz>
References: <20200520071904.15801-1-dobias@2n.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX04.axis.com (10.0.5.18) To XBOX04.axis.com (10.0.5.18)
Cc: broonie@kernel.org, ladis@linux-mips.org, Pavel Dobias <dobias@2n.cz>
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

Codec requires enabling of left and right ADCs in the same I2C write
operation which isn't fullfilled when controlled from DAPM and
causes unexpected behaviour of codec. The similar applies to DACs.
Enable ADCs and DACs once at startup and never switch them off
to solve the issue.

Citation from MAX9867 datasheet:
(DALEN - Left DAC Enable, ADLEN - Left ADC Enable)
- Enabling the right DAC must be done in the same I2C write operation
that enables the left DAC. Right DAC operation requires DALEN = 1.
- Enabling the right ADC must be done in the same I2C write operation
that enables the left ADC. The right ADC can be enabled while the left
ADC is running if used for DC measurements. SHDN must be toggled
to disable the right ADC in this case. Right ADC operation requires
ADLEN = 1.

Signed-off-by: Pavel Dobias <dobias@2n.cz>
---
 sound/soc/codecs/max9867.c | 14 ++++++++------
 sound/soc/codecs/max9867.h |  2 ++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 535cfea6bcde..9fa2acc73e18 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -115,8 +115,8 @@ static const struct snd_soc_dapm_widget max9867_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER_NAMED_CTL("Input Mixer", SND_SOC_NOPM, 0, 0,
 				     max9867_input_mixer_controls,
 				     ARRAY_SIZE(max9867_input_mixer_controls)),
-	SND_SOC_DAPM_ADC("ADCL", "HiFi Capture", MAX9867_PWRMAN, 1, 0),
-	SND_SOC_DAPM_ADC("ADCR", "HiFi Capture", MAX9867_PWRMAN, 0, 0),
+	SND_SOC_DAPM_ADC("ADCL", "HiFi Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADCR", "HiFi Capture", SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_MIXER("Digital", SND_SOC_NOPM, 0, 0,
 			   max9867_sidetone_mixer_controls,
@@ -124,8 +124,8 @@ static const struct snd_soc_dapm_widget max9867_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER_NAMED_CTL("Output Mixer", SND_SOC_NOPM, 0, 0,
 				     max9867_output_mixer_controls,
 				     ARRAY_SIZE(max9867_output_mixer_controls)),
-	SND_SOC_DAPM_DAC("DACL", "HiFi Playback", MAX9867_PWRMAN, 3, 0),
-	SND_SOC_DAPM_DAC("DACR", "HiFi Playback", MAX9867_PWRMAN, 2, 0),
+	SND_SOC_DAPM_DAC("DACL", "HiFi Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DACR", "HiFi Playback", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_SWITCH("Master Playback", SND_SOC_NOPM, 0, 0,
 			    &max9867_line_out_control),
 	SND_SOC_DAPM_OUTPUT("LOUT"),
@@ -429,14 +429,16 @@ static int max9867_set_bias_level(struct snd_soc_component *component,
 				return err;
 
 			err = regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-						 MAX9867_SHTDOWN, MAX9867_SHTDOWN);
+				MAX9867_SHTDOWN | MAX9867_ADCEN | MAX9867_DACEN,
+				MAX9867_SHTDOWN | MAX9867_ADCEN | MAX9867_DACEN
+				);
 			if (err)
 				return err;
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		err = regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-					 MAX9867_SHTDOWN, 0);
+			MAX9867_SHTDOWN | MAX9867_ADCEN | MAX9867_DACEN, 0);
 		if (err)
 			return err;
 
diff --git a/sound/soc/codecs/max9867.h b/sound/soc/codecs/max9867.h
index d459d49449cb..a6051200455b 100644
--- a/sound/soc/codecs/max9867.h
+++ b/sound/soc/codecs/max9867.h
@@ -59,6 +59,8 @@
 #define MAX9867_MODECONFIG   0x16
 #define MAX9867_PWRMAN       0x17
 #define MAX9867_SHTDOWN      0x80
+#define MAX9867_ADCEN        0x03
+#define MAX9867_DACEN        0x0c
 #define MAX9867_REVISION     0xff
 
 #define MAX9867_CACHEREGNUM 10
-- 
2.20.1

