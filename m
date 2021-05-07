Return-Path: <SRS0=FKDJ=KC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E902C433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 14:09:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D241A61436
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 14:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D241A61436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D505847;
	Fri,  7 May 2021 16:09:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D505847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620396597;
	bh=bcTJrMyOQMKPgFGckZbPL4o1KCi12X8B/jkiEA02fOU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Di1AcHvJQYCfwAEcweq9Z+MS5Wl3MjRm9ocSBv1i2sqOqq36SKeYPyaG8XJvCtln1
	 P6lx8gNQXWVnvGsswUMNI7b3XVYgKaanx53dwHk6a63sH5IBUoyvj0aB2V0ZW+knoT
	 CXlZMZW6Y8eeGmLaF+1d9sjQONxcQlqVhtai1C6M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F16F3F8026D;
	Fri,  7 May 2021 16:05:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED4B4F80506; Fri,  7 May 2021 16:05:47 +0200 (CEST)
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com
 [64.147.123.18])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5259DF80257
 for <alsa-devel@alsa-project.org>; Fri,  7 May 2021 16:05:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5259DF80257
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="QAueQppW"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="G3r6w1NF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.west.internal (Postfix) with ESMTP id 4A3A4F9B;
 Fri,  7 May 2021 10:05:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 07 May 2021 10:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=S7H+ptOP2bhOf
 UCpUIPTZM6vAsJtn5bIwJNg3j5CAEU=; b=QAueQppW2aMrDWWRR/uxJgnbkjPYG
 tolulOIZOQ1SUlbJ+v9fiDCO0g9eTgAS5uKeBb0Sc7/nDCa8GGw+1Hnj3wH+IugL
 91SqWBY9QL3oiR2PZzf1qWx01g/icpdD7v6gZ3bNDoA2L5GcIVH4Q+x8Yb+41WqW
 lEJFKHrrv9KZHmb5eGzxKmCvEwAdgGU1ddlr+GL/A1dLJ1jYWQqzEClF+XmvwY5W
 9lVxL4unP/6fbRizEp23dLGks84y3AVrMqgIz5fG6Hy1T/sd7zoxkBeB4MzT1fuj
 RoMNnu8krNHym/EhQI7ZDdBjkfi+iTOJjihB2ab1mu067L6jSgMmQLiXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=S7H+ptOP2bhOfUCpUIPTZM6vAsJtn5bIwJNg3j5CAEU=; b=G3r6w1NF
 h1ZA1Ab2YkA0fYD51Szck/VF4OnfeGXDeM5Hr20GsIWpvCZP4vTWke5MWjDGvvSV
 9qHnVcJbTmhRlKG795xFOf6reKAQ1B4ijzjWqfUluJyVjfa5DglM5nbkWk5otxhL
 zdEoabVDO47GY2b59rf8hK3uv1epYww6GljHF0drCGYlZe/ey60pDcC4dXZDSYxG
 UnOOBDsxVv1Nv7gGAxmOVVfLeud7gmogRIMgesYNjH8eWyx4wI+11jOr66BjDVe1
 cslDlWtvYy/bOosqIXbOyufl+itfdYXGm0pJ2zfKXkTZXCK3o7wIwDeEVaKbPBS1
 QaZW6SCYezcDcA==
X-ME-Sender: <xms:M0mVYMpoqlDBPMxLWSt0D0TN_ZANLrxYbxDIfUKYxPUl50jSaKA_1Q>
 <xme:M0mVYCo24oBgEqc54uOK721_zcmQWCMSYGreTrBg3PH2GYOSkCz86QxZ1b0bTl-Fj
 eSiZcaeS3Rg1lX9Oow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegvddgjedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
 hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:M0mVYBMkE28jrtETjROqGlHyyH2xNSlkQuoHIALCh2MvmK-zohBfYw>
 <xmx:M0mVYD7a9n2Q31EKPjd4mhxU4CPl5AVmr6wa9prB5mSHJF7SJjPN0Q>
 <xmx:M0mVYL5kmps54f0ard9eSCwPrh2mC8W1oxKG18UwMGk-Wm3Fe-V_PQ>
 <xmx:NUmVYAqwBenWA2bMDqZFLnrYFmBOfYOg-zRa_yuM1euLlWU7z1ukn_SypDY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri,  7 May 2021 10:05:39 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 10/11] drm/vc4: hdmi: Remove redundant variables
Date: Fri,  7 May 2021 16:03:33 +0200
Message-Id: <20210507140334.204865-11-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507140334.204865-1-maxime@cerno.tech>
References: <20210507140334.204865-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Dom Cobley <dom@raspberrypi.com>, Tim Gover <tim.gover@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Eric Anholt <eric@anholt.net>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, Phil Elwell <phil@raspberrypi.com>,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
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

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 26 ++++++++++++--------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  2 --
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 19739b57d067..a5780da70c1c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1008,12 +1008,13 @@ static u32 vc5_hdmi_channel_map(struct vc4_hdmi *vc4_hdmi, u32 channel_mask)
 }
 
 /* HDMI audio codec callbacks */
-static void vc4_hdmi_audio_set_mai_clock(struct vc4_hdmi *vc4_hdmi)
+static void vc4_hdmi_audio_set_mai_clock(struct vc4_hdmi *vc4_hdmi,
+					 unsigned int samplerate)
 {
 	u32 hsm_clock = clk_get_rate(vc4_hdmi->audio_clock);
 	unsigned long n, m;
 
-	rational_best_approximation(hsm_clock, vc4_hdmi->audio.samplerate,
+	rational_best_approximation(hsm_clock, samplerate,
 				    VC4_HD_MAI_SMP_N_MASK >>
 				    VC4_HD_MAI_SMP_N_SHIFT,
 				    (VC4_HD_MAI_SMP_M_MASK >>
@@ -1025,12 +1026,11 @@ static void vc4_hdmi_audio_set_mai_clock(struct vc4_hdmi *vc4_hdmi)
 		   VC4_SET_FIELD(m - 1, VC4_HD_MAI_SMP_M));
 }
 
-static void vc4_hdmi_set_n_cts(struct vc4_hdmi *vc4_hdmi)
+static void vc4_hdmi_set_n_cts(struct vc4_hdmi *vc4_hdmi, unsigned int samplerate)
 {
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
 	struct drm_crtc *crtc = encoder->crtc;
 	const struct drm_display_mode *mode = &crtc->state->adjusted_mode;
-	u32 samplerate = vc4_hdmi->audio.samplerate;
 	u32 n, cts;
 	u64 tmp;
 
@@ -1164,27 +1164,25 @@ static int vc4_hdmi_audio_prepare(struct device *dev, void *data,
 {
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
+	unsigned int sample_rate = params->sample_rate;
+	unsigned int channels = params->channels;
 	u32 audio_packet_config, channel_mask;
 	u32 channel_map;
 	u32 mai_audio_format;
 	u32 mai_sample_rate;
 
 	dev_dbg(dev, "%s: %u Hz, %d bit, %d channels\n", __func__,
-		params->sample_rate, params->sample_width,
-		params->channels);
-
-	vc4_hdmi->audio.channels = params->channels;
-	vc4_hdmi->audio.samplerate = params->sample_rate;
+		sample_rate, params->sample_width, channels);
 
 	HDMI_WRITE(HDMI_MAI_CTL,
-		   VC4_SET_FIELD(params->channels, VC4_HD_MAI_CTL_CHNUM) |
+		   VC4_SET_FIELD(channels, VC4_HD_MAI_CTL_CHNUM) |
 		   VC4_HD_MAI_CTL_WHOLSMP |
 		   VC4_HD_MAI_CTL_CHALIGN |
 		   VC4_HD_MAI_CTL_ENABLE);
 
-	vc4_hdmi_audio_set_mai_clock(vc4_hdmi);
+	vc4_hdmi_audio_set_mai_clock(vc4_hdmi, sample_rate);
 
-	mai_sample_rate = sample_rate_to_mai_fmt(vc4_hdmi->audio.samplerate);
+	mai_sample_rate = sample_rate_to_mai_fmt(sample_rate);
 	if (params->iec.status[0] & IEC958_AES0_NONAUDIO &&
 	    params->channels == 8)
 		mai_audio_format = VC4_HDMI_MAI_FORMAT_HBR;
@@ -1202,7 +1200,7 @@ static int vc4_hdmi_audio_prepare(struct device *dev, void *data,
 		VC4_HDMI_AUDIO_PACKET_ZERO_DATA_ON_INACTIVE_CHANNELS |
 		VC4_SET_FIELD(0x8, VC4_HDMI_AUDIO_PACKET_B_FRAME_IDENTIFIER);
 
-	channel_mask = GENMASK(vc4_hdmi->audio.channels - 1, 0);
+	channel_mask = GENMASK(channels - 1, 0);
 	audio_packet_config |= VC4_SET_FIELD(channel_mask,
 					     VC4_HDMI_AUDIO_PACKET_CEA_MASK);
 
@@ -1221,7 +1219,7 @@ static int vc4_hdmi_audio_prepare(struct device *dev, void *data,
 	channel_map = vc4_hdmi->variant->channel_map(vc4_hdmi, channel_mask);
 	HDMI_WRITE(HDMI_MAI_CHANNEL_MAP, channel_map);
 	HDMI_WRITE(HDMI_AUDIO_PACKET_CONFIG, audio_packet_config);
-	vc4_hdmi_set_n_cts(vc4_hdmi);
+	vc4_hdmi_set_n_cts(vc4_hdmi, sample_rate);
 
 	memcpy(&vc4_hdmi->audio.infoframe, &params->cea, sizeof(params->cea));
 	vc4_hdmi_set_audio_infoframe(encoder);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index fdee27faafa3..574f379faf93 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -108,8 +108,6 @@ struct vc4_hdmi_audio {
 	struct snd_soc_dai_link_component cpu;
 	struct snd_soc_dai_link_component codec;
 	struct snd_soc_dai_link_component platform;
-	int samplerate;
-	int channels;
 	struct snd_dmaengine_dai_dma_data dma_data;
 	struct hdmi_audio_infoframe infoframe;
 	bool streaming;
-- 
2.31.1

