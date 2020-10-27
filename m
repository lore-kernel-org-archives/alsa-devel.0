Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1141C4363A
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:17:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B280F22264
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p8J371/w";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jd+cEYOK";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="laAL9aja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B280F22264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C348316A5;
	Tue, 27 Oct 2020 11:16:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C348316A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603793824;
	bh=Hz/ZqzyQbvhm3jd/GvO2s8ggfwR61Kq04SdHhRi9wDQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p8J371/wqRAqiwYMTcTC90iVOQtVMnfU7OIgR9vqYt3G4N6zekt54crUZUtGoCJsp
	 BWW2qA99su7I4c8ajybwT9a+Ol4bTyWPIK2EuLccYOL6TWgnOuEqxsWkpH6NRfK+BQ
	 uVo1E+ravRYKW3rep+DyXXamfzwYX9CIkVnZzN6Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 514FDF801D8;
	Tue, 27 Oct 2020 11:16:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AACF4F8021D; Tue, 27 Oct 2020 11:16:12 +0100 (CET)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96C16F800FF
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 11:16:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96C16F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="jd+cEYOK"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="laAL9aja"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5E29658026C;
 Tue, 27 Oct 2020 06:16:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 27 Oct 2020 06:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=6ek8BSXlWORnKgWBP5B1QQSoz7
 NyffqGB/miVQHie5s=; b=jd+cEYOKyqBI6Z4flqJkU0nSnJreKbFG7FEZ94JcLj
 I4fpqUTlV6+QPT1SXZ1D9ox1NltkhHmJICAMw0TchWZ8onD/Gt8y+wgZ6sqkURP0
 dVuo3wgTLcNNj0Zjz0u5xS/Iq25XjpOhsTVawGGHWE9P+v4ZemmM0dJyJtQF4NPO
 e4R3pml9xa4VsMe29g8T1apsKmMG4BYw7UIDIlL6C6CRBm0i0X2kWxXhty2ZzlZD
 RZuUyDkx7ZxoTeCWzYbaf7X+zFacisfjD3KogNMa+8AOLlGu/BkP2vaHDFSKZRjN
 H/dYKrg0gYYvX5fRWMcpI+p10Lv73aobZx/o0arBrVhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6ek8BSXlWORnKgWBP
 5B1QQSoz7NyffqGB/miVQHie5s=; b=laAL9ajaUvSvn+d2qPIfsh7b+l9hhC87+
 dtA1GPLq9YjglxPYJR1ewC4lVdkZyxuyxig7rcVSsLyXnqAJfBBXS2dGM7V0kK3b
 5o7n01bXo3YBf/ai7L/ayv6aBg0orgNVbMPSBbCFxJoplJf6DzCCydhjr6MjokdP
 2xzNK5bQk1vd/3lnFUP2J4YNbldo4VP/j8FdGAwI+UICdisFVulO9O8fGT742RpA
 sIhcUeFKdwlBtd7cus3yG22WFQaKfhuOnYYsE0lIWwWnNM0VyP/ZHq05JxtTPEj8
 0P2rEoWgXkyONIbEdvgk8dQxBE12Cf4HIj9pt2CK1JOqdhdVdjm9A==
X-ME-Sender: <xms:YfOXXyudBtTFTDcaWmwGap3SIvxqV7hshZJ_GphIwSsMKoMSESDwMQ>
 <xme:YfOXX3epn63wLpbySvXh8mgbMC7WJUCQkwtzqH2QuHMygrkpkL8DE9RqC88MhJmjJ
 QA2ImQCIvnzSNtAfcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucft
 ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
 hnpeejffehuddvvddvlefhgeelleffgfeijedvhefgieejtdeiueetjeetfeeukeejgeen
 ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:YfOXX9xpUMKgAByl8QlIGHPUmhXjt1RKTO99sh0xR6QvpyE5MO_rxQ>
 <xmx:YfOXX9MmDJ-qm7r5w91mt6-qYk5PLxAHZmcKIxyXaaZ_zh8VMREf_w>
 <xmx:YfOXXy_e1aOcFCJs-PnpJYvc2ILdBNNF4f_qFFXyL-WIyURGEPXMpA>
 <xmx:YvOXX1VC_02m04r_d-yiwhKt8TwnE5Jd8f6uIuEp0ffn5IQ1HJS0DQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id B861D328005D;
 Tue, 27 Oct 2020 06:16:00 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] drm/vc4: hdmi: Avoid sleeping in atomic context
Date: Tue, 27 Oct 2020 11:15:58 +0100
Message-Id: <20201027101558.427256-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Dom Cobley <dom@raspberrypi.com>,
 Tim Gover <tim.gover@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Maxime Ripard <maxime@cerno.tech>, Thomas Zimmermann <tzimmermann@suse.de>,
 Phil Elwell <phil@raspberrypi.com>
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

When running the trigger hook, ALSA by default will take a spinlock, and
thus will run the trigger hook in atomic context.

However, our HDMI driver will send the infoframes as part of the trigger
hook, and part of that process is to wait for a bit to be cleared for up to
100ms. To be nicer to the system, that wait has some usleep_range that
interact poorly with the atomic context.

There's several ways we can fix this, but the more obvious one is to make
ALSA take a mutex instead by setting the nonatomic flag on the DAI link.
That doesn't work though, since now the cyclic callback installed by the
dmaengine helpers in ALSA will take a mutex, while that callback is run by
dmaengine's virt-chan code in a tasklet where sleeping is not allowed
either.

Given the delay we need to poll the bit for, changing the usleep_range for
a udelay and keep running it from a context where interrupts are disabled
is not really a good option either.

However, we can move the infoframe setup code in the hw_params hook, like
is usually done in other HDMI controllers, that isn't protected by a
spinlock and thus where we can sleep. Infoframes will be sent on a regular
basis anyway, and since hw_params is where the audio parameters that end up
in the infoframes are setup, this also makes a bit more sense.

Fixes: bb7d78568814 ("drm/vc4: Add HDMI audio support")
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 74da7c00ecd0..ec3ba3ecd32a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1077,6 +1077,7 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai)
 {
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
+	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	u32 audio_packet_config, channel_mask;
 	u32 channel_map;
@@ -1136,6 +1137,8 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	HDMI_WRITE(HDMI_AUDIO_PACKET_CONFIG, audio_packet_config);
 	vc4_hdmi_set_n_cts(vc4_hdmi);
 
+	vc4_hdmi_set_audio_infoframe(encoder);
+
 	return 0;
 }
 
@@ -1143,11 +1146,9 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 				  struct snd_soc_dai *dai)
 {
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
-	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		vc4_hdmi_set_audio_infoframe(encoder);
 		vc4_hdmi->audio.streaming = true;
 
 		if (vc4_hdmi->variant->phy_rng_enable)
-- 
2.26.2

