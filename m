Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ECDC2B9F8
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 13:29:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEC160200
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 13:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEC160200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A0511743;
	Tue, 25 May 2021 15:28:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A0511743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621949385;
	bh=s1pY2N4JRpsqNnJLCg3mZG+dv9RYLIGvvN4JZok5LZc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JIdEp3a3zOq9nC/N8xT86NwR7W1OYKUf+Cn6nUIi5qI/ReiMf03IMmACNLT12Redx
	 MQ+gYRUMugu4zPbrUhkQrqGDzswvug2YQQF9Yd+9LSXWaSPCCIKo1D3wv2jpN9bvFV
	 q/LV8QY7/qj53Pkm1NuJgvcWSEYMK1D30hdcIW8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13C73F804FA;
	Tue, 25 May 2021 15:24:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE5B0F80516; Tue, 25 May 2021 15:24:34 +0200 (CEST)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B28DBF804FA
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 15:24:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B28DBF804FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="O92I/IA3"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="M6E+fmfF"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id EE408580726;
 Tue, 25 May 2021 09:24:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 25 May 2021 09:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=H4G+6d4HafTxP
 4ftH57AjUaxdyuIr+5y2Zm0x2UVvSQ=; b=O92I/IA3JS/7yem6uxUKF73p+uiJk
 h7crnvGyJqBYzmRNjlsGhw9ebEkyQgApc4dU2fF9X7NQC/FViBJTk7LH8+JbKbUf
 PdPIon8mYqTV94ma6KDju3zvrmoHCVfBVJ6XoXKSUSgi3L4c33zVPs/j7MYpSXVw
 G4eNko7sGYF4Bnz/0JH1WvdcFxowfwYieuMjUGbCT7jSn9MrlyMRyU7RLfkty0c1
 eHmnygTtpnD5LZBx8v6cpxrdPp8hY9ex9yzao9jzLP3A5sLUSErzhFSlHLaaUbTx
 6C0adUZ/3/C6k9lFPhuEDsLq8LkronwaVxxIGqIKd/JtzqNT4W/IYwv9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=H4G+6d4HafTxP4ftH57AjUaxdyuIr+5y2Zm0x2UVvSQ=; b=M6E+fmfF
 XWl6rJsuQNnfFbcdFM8EcgDCImeyw4D6yKEKG0FnRA5+tZadzwC+qOjt5nMKdrQ4
 KujN4zeLYzoSS9IgNNgiPiaYATV1ZBLvEuQlHQtPSx8iOMeEbyBKcyMc50yLnuDO
 JD8VfBjas8Yr3WctBxSb6m0y2CBMzGKNDKtPRuVHM0RZc4XiLrZnUIh3N5K1HB9n
 xvmAGeu+A/o68hHG9v+WA9a+eEl6En+emwqBkEGhd5a2x1176Rcns8AysW1GmnLc
 /HRS76vltPnvwVzIT0mk4W7YkbVpFYw4cqzMd+WFXkozCuJnSMhfN96crL02Zxgs
 wRAfwUU7uy1srQ==
X-ME-Sender: <xms:i_qsYJG6vYRxGpqa7s48ojVVg2X-waSVsPEdib4kUW35XX5W4v5KjA>
 <xme:i_qsYOXRCP5hu0vtnWOninf9YYD0xlECXCxI-BRjJk4EfWie46amPmhlD9mM2ugzu
 waTP1Uo1kCejr0YN0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgieeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
 hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:i_qsYLJ00SKTDVENyPtIuAtmbkleAmYHiDA1pYSVpA-AGWUkXBJJZA>
 <xmx:i_qsYPEHAjdf2qF0FRBryt0DRjdUqnUr86iO4uRJ0HSdc-E-9oWwnA>
 <xmx:i_qsYPWrb8v46o2XNmLtte6PTJY-ez26qTsfaQEBnCcUme980YkbJQ>
 <xmx:i_qsYF9aIZM6PD6Q3SsjTn6lU2x6Jk9WO8i3tLStG0E9fQ0JxIB3Iw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Tue, 25 May 2021 09:24:27 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <maxime@cerno.tech>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 11/12] drm/vc4: hdmi: Remove redundant variables
Date: Tue, 25 May 2021 15:23:53 +0200
Message-Id: <20210525132354.297468-12-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525132354.297468-1-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Dom Cobley <dom@raspberrypi.com>,
 Tim Gover <tim.gover@raspberrypi.com>, linux-doc@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Eric Anholt <eric@anholt.net>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Phil Elwell <phil@raspberrypi.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-rpi-kernel@lists.infradead.org
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
index 0ecfcf54b70a..c6dafeab4378 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1064,12 +1064,13 @@ static u32 vc5_hdmi_channel_map(struct vc4_hdmi *vc4_hdmi, u32 channel_mask)
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
@@ -1081,12 +1082,11 @@ static void vc4_hdmi_audio_set_mai_clock(struct vc4_hdmi *vc4_hdmi)
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
 
@@ -1220,27 +1220,25 @@ static int vc4_hdmi_audio_prepare(struct device *dev, void *data,
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
@@ -1258,7 +1256,7 @@ static int vc4_hdmi_audio_prepare(struct device *dev, void *data,
 		VC4_HDMI_AUDIO_PACKET_ZERO_DATA_ON_INACTIVE_CHANNELS |
 		VC4_SET_FIELD(0x8, VC4_HDMI_AUDIO_PACKET_B_FRAME_IDENTIFIER);
 
-	channel_mask = GENMASK(vc4_hdmi->audio.channels - 1, 0);
+	channel_mask = GENMASK(channels - 1, 0);
 	audio_packet_config |= VC4_SET_FIELD(channel_mask,
 					     VC4_HDMI_AUDIO_PACKET_CEA_MASK);
 
@@ -1277,7 +1275,7 @@ static int vc4_hdmi_audio_prepare(struct device *dev, void *data,
 	channel_map = vc4_hdmi->variant->channel_map(vc4_hdmi, channel_mask);
 	HDMI_WRITE(HDMI_MAI_CHANNEL_MAP, channel_map);
 	HDMI_WRITE(HDMI_AUDIO_PACKET_CONFIG, audio_packet_config);
-	vc4_hdmi_set_n_cts(vc4_hdmi);
+	vc4_hdmi_set_n_cts(vc4_hdmi, sample_rate);
 
 	memcpy(&vc4_hdmi->audio.infoframe, &params->cea, sizeof(params->cea));
 	vc4_hdmi_set_audio_infoframe(encoder);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 055aa64a47a2..511673cda341 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -111,8 +111,6 @@ struct vc4_hdmi_audio {
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

