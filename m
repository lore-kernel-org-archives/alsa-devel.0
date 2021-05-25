Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1448EC47086
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 13:25:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4A16142D
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 13:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4A16142D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41BA31737;
	Tue, 25 May 2021 15:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41BA31737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621949150;
	bh=+UUEvhyk6o7vTg7k60rLF/OvSxYr8IArH1lLlxlRcpA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d8jpr0fV3TjhrMjNV2+epg48SvfnosOCTvvZr99sIdrMujdrsvJCJdeu96Gsumy7S
	 FUY4vlC1ibkGA1uZOsb33bvQTWI31GEtTytbT05NtKMKR+Jb8Mb7Ir8u0AEgC2fVNO
	 Vjs3DmfLJvkUPFvi5csEwV+5OwKP4zNmPeSq7Mzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1B53F801EB;
	Tue, 25 May 2021 15:24:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74C18F802CA; Tue, 25 May 2021 15:24:11 +0200 (CEST)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E661F8026B
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 15:24:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E661F8026B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="qwievrlU"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="r/M5ZpxE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id C54BF580706;
 Tue, 25 May 2021 09:24:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 25 May 2021 09:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=wbZxITDCe0XGb
 MeBmFn7GYofbIW9DMDPBBXtnyxF65U=; b=qwievrlUa22NexRwqfDPQvwWjif1D
 XXbHHObmkvADyL04L807xvftlaFsHb0DGJWudwXb4c3MpidZgd1rbA+f+zWOdqZq
 wjhfqyBi2+SKujXCg2ATJQWAIlH6Rn/FaAde8gotMrFBg7/bPO6Dp/dYUj+437VQ
 UbmuSoclCzKJrCbvgnBY98T4eZZWojE4EX0G9dtjw+n6T/2PPziPZ5gpl3yLHRoh
 ycx9mbW0Edv0KPSfSuK4C7+5ewIPLsI1HHrMVVJu/Wb0Vik/R0XihpOZqy+cVMzq
 D/niTSbXCXeTzoN+AzX9BVgcX9rrPgnlLOaIVVa8+qC56wRrFXarrsicw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=wbZxITDCe0XGbMeBmFn7GYofbIW9DMDPBBXtnyxF65U=; b=r/M5ZpxE
 ojJdIBpVZiU7xsU7taCs0BcXl/dHDU7xx92mn0mXKg1RzjAwXLzLkYG91bUJGBM/
 ++bBbJ+HUbDpwWftgErJ3i8Q1kO/ke2irvMnSdthoUGPNrQAcRRSaPRWscOMqUJh
 1DaAVWwHfJc4w4OUafv1c+uStKnbRjal2knRv5wGI6N0TaBRJEn9n6LR1RstDBvL
 BKJ08hpI3d9l3w9I6ddDYKgIKCYMWHubyYsS+hIXNt9AQSNl7JFsKoXvTol1T8kt
 lqvMEL4W2vGqrdvOUF33N0WRueIGwdaRgwE9g4XaI2WFDwK6sPYVGBvzZKUgefJB
 evLnoi9gZ0I4Yw==
X-ME-Sender: <xms:dvqsYBZK0TIcZQWjghhf5N_kyAbop78bcaKb0VjxOmH9UQjoSzmbjw>
 <xme:dvqsYIZr6lMelO-2LYKdfvK1smpDyBUI8pJxnmTYtCgHh39rG0uzd-9P6y4bFVLZy
 BoY2wIjdSR62cbjKFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgieeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
 hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:dvqsYD-EUqIMJ_yOvtZ1_JAeU2f8P4pLnTAFANuuGwsJPombUpieOw>
 <xmx:dvqsYPpU6hBA9AOfkTniVRUAmBxmTWgD8Aj9kavkRjUB09QfR2_fgw>
 <xmx:dvqsYMqO2hoF6IO4n02KBKOof6Hgu8Dr1ONrdtnrmyaQYS1sNF08nQ>
 <xmx:dvqsYOjfifIucF1ia8Oh0F6I9C2MTnDHuez7l_tcIzoPxG0kDWXyhw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Tue, 25 May 2021 09:24:06 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <maxime@cerno.tech>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 03/12] ASoC: hdmi-codec: Rework to support more controls
Date: Tue, 25 May 2021 15:23:45 +0200
Message-Id: <20210525132354.297468-4-maxime@cerno.tech>
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

We're going to add more controls to support the IEC958 output, so let's
rework the control registration a bit to support more of them.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 sound/soc/codecs/hdmi-codec.c | 43 ++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 1567ba196ab9..65bde6f0ea1c 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -620,21 +620,23 @@ static const struct snd_soc_dai_ops hdmi_codec_spdif_dai_ops = {
 			 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |\
 			 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
-static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
-			      struct snd_soc_dai *dai)
-{
-	struct snd_soc_dai_driver *drv = dai->driver;
-	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
-	struct snd_kcontrol *kctl;
-	struct snd_kcontrol_new hdmi_eld_ctl = {
-		.access	= SNDRV_CTL_ELEM_ACCESS_READ |
-			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+struct snd_kcontrol_new hdmi_codec_controls[] = {
+	{
+		.access	= (SNDRV_CTL_ELEM_ACCESS_READ |
+			   SNDRV_CTL_ELEM_ACCESS_VOLATILE),
 		.iface	= SNDRV_CTL_ELEM_IFACE_PCM,
 		.name	= "ELD",
 		.info	= hdmi_eld_ctl_info,
 		.get	= hdmi_eld_ctl_get,
-		.device	= rtd->pcm->device,
-	};
+	},
+};
+
+static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_dai_driver *drv = dai->driver;
+	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
+	unsigned int i;
 	int ret;
 
 	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
@@ -651,12 +653,21 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	hcp->chmap_info->chmap = hdmi_codec_stereo_chmaps;
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 
-	/* add ELD ctl with the device number corresponding to the PCM stream */
-	kctl = snd_ctl_new1(&hdmi_eld_ctl, dai->component);
-	if (!kctl)
-		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(hdmi_codec_controls); i++) {
+		struct snd_kcontrol *kctl;
 
-	return snd_ctl_add(rtd->card->snd_card, kctl);
+		/* add ELD ctl with the device number corresponding to the PCM stream */
+		kctl = snd_ctl_new1(&hdmi_codec_controls[i], dai->component);
+		if (!kctl)
+			return -ENOMEM;
+
+		kctl->id.device = rtd->pcm->device;
+		ret = snd_ctl_add(rtd->card->snd_card, kctl);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int hdmi_dai_probe(struct snd_soc_dai *dai)
-- 
2.31.1

