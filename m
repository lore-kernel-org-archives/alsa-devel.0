Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CF4C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Feb 2022 12:04:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ADDF180D;
	Tue, 22 Feb 2022 13:03:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ADDF180D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645531489;
	bh=CiFVsUsoB1r1VbTvGd0g0XbirCUbZDzp7G/oBXX1TrM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EyY+FG1byl+gm5ONwave+1TnqQLsOtxIFmIBq7D5Liyck6P4KIl9TdLmOe2M/5Jkn
	 RjkdKIVj6fKGp2R1QUcighyS4dVAW6rSriOmQuAbni4t8HBMyXo8Ok52z/KAYDCXCE
	 3jJ2svjWyemcS6Ve5Zr9waJfsv4hiLY6tRiNIuwU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0C61F80567;
	Tue, 22 Feb 2022 13:00:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8680AF80533; Tue, 22 Feb 2022 13:00:12 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BCF9F8051F
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 13:00:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BCF9F8051F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Rpb2UzY+"
Received: by mail-wr1-x435.google.com with SMTP id s1so6314291wrg.10
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 04:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pmndN/v1gfV2GMDQd7C0kB+ah/Uk4LJSxeSRIEDOEZE=;
 b=Rpb2UzY+Gi6K58Fex63hU24KXZBDztbcykj7Zq4FXVoEsMWWI4+I5fZMp1UeRoKQVz
 MuvlZJ1KqmhQU2HS2raT4pjapl7iq4W2yWte+IPxqy8sTvcX20BqHEO7xqvj79qJilnL
 nAUEJ5Uh8vFXtKSbnstYctwUSXeafnXBn5izOdGlATMHpQ4NYIYw9HK2xtnvAXMIGHrS
 H423otBZ7ZMfeqEX7eJ+uF+0BcNFQfO+MYceerE3Ov0rFdYaWKIEixon+efn11ncEhwO
 DlNHJy3rhGllfXwnys1ZGQj5B2mf2B71Sdc8RA1gRZdYCfY+BogP3X48NHTINHHpBPkJ
 xMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pmndN/v1gfV2GMDQd7C0kB+ah/Uk4LJSxeSRIEDOEZE=;
 b=1SiDfyJQ6lAlpds9UMqKTwV+R0jdcj9PZxSttXRlk+EGwoXu8reIzqixGTHhHdv7XJ
 jLWvVQhyTukY295tQwcTYb1jOOHY44wvVTPvcZVYqkcSnmenFcm2fEj58FlPvlOLHh+C
 JNCcPe0epm0QkvVX8UdY473R/JEZMsyZNAZNx4gyPKtxN3Rh6doCA1UIep6aFGpZb+3b
 hGkwRTyx1XoYSMrspR0vMOk20lSf/KOhFvSMPI9lX9URBLvI973y5CurHCWwpbxAHnXL
 NtAd3vjRl9KydiEUCNLjjhwmCnZ77SqqZYsBiByaUgfpBD08iWeTbNmEZpQ6McmwltSD
 wxHQ==
X-Gm-Message-State: AOAM5313hqNcWa5Swcc85o6e2BKf3/TFUbG4L6CWniTJycavl1dPjH0e
 yFYAT3Av/ZkTgHo4jOysSWazbg==
X-Google-Smtp-Source: ABdhPJztxT8/JwToFdxyy+VpFZDnnFcGv3rSeV10jPNkhYPb2XbdgZ4Ib8t1Dfd+5cG7E3O7BCeHjA==
X-Received: by 2002:a5d:64af:0:b0:1df:3cb8:3f42 with SMTP id
 m15-20020a5d64af000000b001df3cb83f42mr18912558wrp.24.1645531204162; 
 Tue, 22 Feb 2022 04:00:04 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.04.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 04:00:03 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 16/16] ASoC: codecs: msm8916-wcd-digital: fix tlv min max range
Date: Tue, 22 Feb 2022 11:59:33 +0000
Message-Id: <20220222115933.9114-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 quic_srivasam@quicinc.com
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

on Qualcomm codecs gain tlv control specifies min max range as both
negative to positive numbers like

SOC_SINGLE_SX_TLV("... Volume", ..,  -84, 40, gain)

However with recent boundary checks added in commit 817f7c9335ec0
("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw())
setting a value above 40 gain will fail.

So fix this min max range correctly to
SOC_SINGLE_SX_TLV("... Volume", ..,  0, 124, gain)
so that users can now set gain correctly

Fixes: ef8a4757a6db ("ASoC: msm8916-wcd-digital: Add sidetone support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index fcc10c8bc625..b32803bf6f63 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -554,21 +554,21 @@ static const struct snd_kcontrol_new msm8916_wcd_digital_snd_controls[] = {
 	WCD_IIR_FILTER_CTL("IIR2 Band4", IIR2, BAND4),
 	WCD_IIR_FILTER_CTL("IIR2 Band5", IIR2, BAND5),
 	SOC_SINGLE_SX_TLV("IIR1 INP1 Volume", LPASS_CDC_IIR1_GAIN_B1_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR1 INP2 Volume", LPASS_CDC_IIR1_GAIN_B2_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR1 INP3 Volume", LPASS_CDC_IIR1_GAIN_B3_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR1 INP4 Volume", LPASS_CDC_IIR1_GAIN_B4_CTL,
 			0,  -84,	40, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR2 INP1 Volume", LPASS_CDC_IIR2_GAIN_B1_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR2 INP2 Volume", LPASS_CDC_IIR2_GAIN_B2_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR2 INP3 Volume", LPASS_CDC_IIR2_GAIN_B3_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 	SOC_SINGLE_SX_TLV("IIR2 INP4 Volume", LPASS_CDC_IIR2_GAIN_B4_CTL,
-			0,  -84, 40, digital_gain),
+			0,  0, 124, digital_gain),
 
 };
 
-- 
2.21.0

