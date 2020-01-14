Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C0AC33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:16:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE4924658
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qmAvt2Bs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="enHZH/HW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE4924658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0D261803;
	Tue, 14 Jan 2020 19:15:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0D261803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579025784;
	bh=klXb/nsJqzgOQ2lUnjZ5UWq4mLPH88OsG4HN3DWSjNU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qmAvt2BsTtDwX5YX+FEKjxYqvLAoj9R8BhfIf+1w+Joecww4jZEDsjKGe/t/ggua1
	 e6LtYUvdgj4MroDVLPHfA+2MdCZdPXrhnCnbzokLn595JAD5+VkiC9gEWdpUhBep9Q
	 s7jXnSGte3I9te5o+gVU6NPw5kq0X+M6Rj07MBLI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD550F8022B;
	Tue, 14 Jan 2020 19:14:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82C91F8014E; Tue, 14 Jan 2020 19:14:38 +0100 (CET)
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2028F800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2020 19:14:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2028F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="enHZH/HW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579025670;
 s=strato-dkim-0002; d=gerhold.net;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=2WZLu8zAPzDrBYaL0asn9QkusN+sU+zL8FgYrVs5Efo=;
 b=enHZH/HW/ic6kUjxug3J+tgbfdObOua85k3iBoy711q8K8UcBP9clE4yejK3Ws13pU
 59HB4oAb09O1476ChhkwpBwyC3X+H2D0T8jPHyzmQa6q9EKum6g+IpCQw2yiLYDcGxcS
 awOnSLw/hfOUAC+528Atpsrvm2jXF206Pk8eNdaqMY5zjIEjlEahPwyUi33iAibvrdS0
 TiSd4fuYUF//v7zFLqMjTCZFuxicK2dVY6CRxMzM1Hfm/aALP6O5Uqlyp8MR9Pj8DM2r
 Lm+LnDZYm1DrSPvHLnuLoaGOtttUBiIhuI/9ftkqf7WjJqPFu4BgXBxrrHdWXp1BHBPt
 4r1w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7IOGU5qzCB3a93viaVr"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain by smtp.strato.de (RZmta 46.1.4 AUTH)
 with ESMTPSA id h048a6w0EIEQXnI
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 14 Jan 2020 19:14:26 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Jan 2020 19:12:29 +0100
Message-Id: <20200114181229.42302-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114181229.42302-1-stephan@gerhold.net>
References: <20200114181229.42302-1-stephan@gerhold.net>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, Nikita Travkin <nikitos.tr@gmail.com>
Subject: [alsa-devel] [PATCH v2 2/2] ASoC: msm8916-wcd-analog: Add MIC BIAS
	Internal3
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

PM8916 has three TX inputs that each have an (optional) internal
RBIAS resistor. MIC BIAS Internal1/2 (for TX1/2) are already supported.
TX3 does not have its own MIC BIAS supply, instead it is also supplied
from MIC_BIAS1.

Now that we have simplified the MIC BIAS Internal* implementation
we can easily add support for it:

Add a MIC BIAS Internal3 supply that enables the internal RBIAS
resistor on TX3, and make sure to also enable the MIC_BIAS1 supply.

Tested-by: Nikita Travkin <nikitos.tr@gmail.com> # longcheer-l8150
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
v1: https://lore.kernel.org/alsa-devel/20200111164006.43074-5-stephan@gerhold.net/
Changes in v2:
  - Update for changes in previous patch
    (Use new "MIC_BIAS1" supply instead of "MIC BIAS External1")
---
 sound/soc/codecs/msm8916-wcd-analog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index d6d727f5bae5..85bc7ae4d267 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -856,6 +856,7 @@ static const struct snd_soc_dapm_route pm8916_wcd_analog_audio_map[] = {
 	{"MIC BIAS Internal1", NULL, "MIC_BIAS1"},
 	{"MIC BIAS External2", NULL, "MIC_BIAS2"},
 	{"MIC BIAS Internal2", NULL, "MIC_BIAS2"},
+	{"MIC BIAS Internal3", NULL, "MIC_BIAS1"},
 };
 
 static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
@@ -924,6 +925,9 @@ static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
 			    pm8916_wcd_analog_enable_micbias_int2,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal3", CDC_A_MICB_1_INT_RBIAS, 1, 0,
+			    pm8916_wcd_analog_enable_micbias_int,
+			    SND_SOC_DAPM_PRE_PMU),
 
 	SND_SOC_DAPM_ADC_E("ADC1", NULL, CDC_A_TX_1_EN, 7, 0,
 			   pm8916_wcd_analog_enable_adc,
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
