Return-Path: <SRS0=uPGH=3Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374AC33CAC
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Feb 2020 03:05:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6093C21582
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Feb 2020 03:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GeHO77PP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AMZGi+pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6093C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AE401662;
	Tue,  4 Feb 2020 04:04:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AE401662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580785517;
	bh=8RdklSQX029wSxS+u6DtSavlr0g1wgMD/IW1VanD9T8=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GeHO77PPS2yKGpCzCNLvqGS5TeUFBAiFy/E5B87wKQD2GywXkTdpst+RmYclHlLHZ
	 mQPLeYXk16JHuzEt6VKCwbi/lOHCoCX87H0IL0NsIKBysp8Cm8s6IdddZAU135MqN0
	 Xh5JrI0b4NFF1iDjryulh8WOseWvLQZNNhLayRd4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE09CF8015B;
	Tue,  4 Feb 2020 04:04:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED947F80162; Tue,  4 Feb 2020 04:04:24 +0100 (CET)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89903F800F4
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2020 04:04:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89903F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="AMZGi+pg"
Received: by mail-pj1-x1049.google.com with SMTP id z12so990737pju.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Feb 2020 19:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=pjoVMI4UL3mw7HTSPvFNKw/yaHKC0iepvwwrCPVHdV0=;
 b=AMZGi+pg32HR63+0CvYfp2+hF7vLNE2rvXFXw8ZQqvIzei8o1A6tZqXkbPv7zoFTp5
 IspTPem07MET9NHlsqV1/4kBJZiFC6brk2jjnyRLOP2jBtElA7+VFDygTjDWJWQyQkqO
 2Oxkj+BXJCLrkoP7Rhezv9EQWCQnoPOnEw86cO+xH44ehSetSp6MLHGCHSQcGb+OLxPy
 WLaMC83HfA4AG/bYUXzOLIcsVCTBnwYJFA3Q4jgD9P4HDdNmyXw2/0Dk0FV89BpnJXjg
 HNmqU4dIJp32LdtdgmR5Xg6662/+AEos1X1YwsJViU+msSEgqEj4y4f3NjUR6yWmjfKk
 gM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=pjoVMI4UL3mw7HTSPvFNKw/yaHKC0iepvwwrCPVHdV0=;
 b=SDXYLKM1/ODsbVSToy72VpoubtaM8L8Sfr/09DS/BYOnJ/OMFpmQhxEmxSG5Dz25La
 tEr30G7bHa8VArz7hG1SM8KKTscr1IK0aR+9lZTPoYyjlN+J69OuuOKYP6IIa6zOgPmu
 yvOSU5Dk3zItaz71hdWVkqimldruznyvRtRmOvrRVYuQhY/w5+YMa926QvCareQLWBmJ
 36srJluJqnmARmZ9K+qW234wKpBCnJH/3pllqYL5Q+MxmyMvKPCx12oasVbBfUd4GtHQ
 2blayH0p0bjLBmpKxCo/riuU4plnbnKQ/TDENnqgcsXwdYY2R2OH+x0b/V7Cs5vJFDLE
 9Jxw==
X-Gm-Message-State: APjAAAXgWvLypDc2kDOiOMt0ijGBU8GwDF9dn/fc4yA4y6W8WCaoS36R
 2yBT9Ry7byw1VXbxA86OV5e4JfC6jN29
X-Google-Smtp-Source: APXvYqw8leoO2gNLGmM63FpYBHV0IN5W6HyPYjN9wVbnCT6WzG4lbvYl/O3CkBRgGsmpGo2AktyTOPrscZL8
X-Received: by 2002:a65:43cb:: with SMTP id n11mr4683909pgp.65.1580785456784; 
 Mon, 03 Feb 2020 19:04:16 -0800 (PST)
Date: Tue,  4 Feb 2020 11:04:06 +0800
Message-Id: <20200204102016.I73b26b5e319de173d05823e79f5861bf1826261c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com, jiaxin.yu@mediatek.com
Subject: [alsa-devel] [PATCH] ASoC: max98357a: add speaker switch
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

Some machine may share the same I2S lines for multiple codecs. For
example, mediatek/mt8183/mt8183-da7219-max98357 shares the same lines
between max98357a and da7219.  When writing audio data through the I2S
lines, all codecs on the lines would try to generate sound if they
accepts DO line.  As a result, multiple codecs generate sound at a
time.

Adds a separate switch to max98357a.  Userspace program has choices to
turn on or off the switch.  Note that, userspace program should change
the switch before opening the stream.  The switch won't take effects if
the stream is already there.

Default value of the switch is on to not break existing driver usages
(who are unlikely aware of existence of the switch).

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/max98357a.c | 39 +++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 16313b973eaa..a2c3be69a0ee 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -22,6 +22,7 @@
 struct max98357a_priv {
 	struct gpio_desc *sdmode;
 	unsigned int sdmode_delay;
+	int spk_switch;
 };
 
 static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
@@ -29,7 +30,7 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 {
 	struct max98357a_priv *max98357a = snd_soc_dai_get_drvdata(dai);
 
-	if (!max98357a->sdmode)
+	if (!max98357a->sdmode || !max98357a->spk_switch)
 		return 0;
 
 	switch (cmd) {
@@ -49,6 +50,37 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int max98357a_get_spk_switch(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct max98357a_priv *max98357a =
+		snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = max98357a->spk_switch;
+	return 0;
+}
+
+static int max98357a_put_spk_switch(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct max98357a_priv *max98357a =
+		snd_soc_component_get_drvdata(component);
+
+	max98357a->spk_switch = ucontrol->value.integer.value[0];
+	dev_info(component->dev,
+		 "put speaker switch: %d\n", max98357a->spk_switch);
+	return 0;
+}
+
+static const struct snd_kcontrol_new max98357a_snd_controls[] = {
+	SOC_SINGLE_BOOL_EXT("Speaker Switch", 0,
+		max98357a_get_spk_switch, max98357a_put_spk_switch),
+};
+
 static const struct snd_soc_dapm_widget max98357a_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("Speaker"),
 };
@@ -58,6 +90,8 @@ static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 };
 
 static const struct snd_soc_component_driver max98357a_component_driver = {
+	.controls		= max98357a_snd_controls,
+	.num_controls		= ARRAY_SIZE(max98357a_snd_controls),
 	.dapm_widgets		= max98357a_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
 	.dapm_routes		= max98357a_dapm_routes,
@@ -117,6 +151,9 @@ static int max98357a_platform_probe(struct platform_device *pdev)
 			"default: no delay\n");
 	}
 
+	/* For drivers who are not aware of the switch, default set to on. */
+	max98357a->spk_switch = 1;
+
 	dev_set_drvdata(&pdev->dev, max98357a);
 
 	return devm_snd_soc_register_component(&pdev->dev,
-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
