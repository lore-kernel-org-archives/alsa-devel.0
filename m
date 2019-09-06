Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC487C43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:52:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6410A20838
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lyiuSUW/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XKzI8t6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6410A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAE1C1671;
	Fri,  6 Sep 2019 21:52:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAE1C1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567799572;
	bh=7+iA4bm+nxOnHMRnA6YQx4x4tuJrfec+4MCPDcKK+wI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lyiuSUW/hB5F73RPVYj7RMMocUq3Kn8LEh1PMA4y0CFmZUQycVzJt4RXcpU6aw3te
	 D3ZPsNP26wv/07rKSKnrg4KnRrhEVCF11U7JfGVhYBttnUtY/uKLaT6EeItV5g/ps5
	 lHLxFoHmLY6KyX9q9FUi33eor4s8j4zvzokRSzo8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB742F80673;
	Fri,  6 Sep 2019 21:48:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09469F80639; Fri,  6 Sep 2019 21:48:06 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50AE8F80639
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 21:48:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50AE8F80639
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="XKzI8t6p"
Received: by mail-pf1-x444.google.com with SMTP id w22so5208423pfi.9
 for <alsa-devel@alsa-project.org>; Fri, 06 Sep 2019 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n/0NVdzNWICBGegkM7LroKepQhiV/8r77ExOHngHUuI=;
 b=XKzI8t6p2bfJm4IRrEjlmupWX2xoEuL3WkdZ0Q8Q/KA6G7EQXsfW743EdcCJ9j32dV
 DcKMV+p9Y9go3gwdK/X/xLRBChiONU4/a1bZwdhjsNmFglp2O0XK/Yia6EsxDkUsMdJj
 WWGOZQyL5ln2sK5IPVFyNcBZhxR256icbDTQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n/0NVdzNWICBGegkM7LroKepQhiV/8r77ExOHngHUuI=;
 b=YdDZ+o/kQ4XoKuYeUYC/kBWCIGuvfE4AdS5T8oZ5vxSlF7xImzmVawN+RajLEBkdQP
 ke9ydzoDG3kM92kvh393MGIAbkIU1Bf0f1M+aWORltpjJ24YEzjn7EfoKZ40/91XA6Xi
 GUcI9b8d+BS4Yd3p+VuT1ICkNPTUVS8JRYuNXtJbe8CG+HHrIRJCsZai6qF8FpwWzu5Q
 I9kBvA8+HbeiltMAw0sYS7nmlToA+VdrLLCuafVET2/fy+qBfUV7UZ/qVawwwn/AbfbJ
 Y0MwMhD4FkJ8YNnZnyV9+0KnalntosFqp8IeYZ46X7GOSa1ileUk7YWngZqIoykTb403
 /D1w==
X-Gm-Message-State: APjAAAVkFgYdUslWRko7S60zK3T0IReQH+ylElBn+Eva6pQ0SoMTgWS7
 yGxkMzm8eTZI84/AS9XdJ+6XpK32FQ==
X-Google-Smtp-Source: APXvYqy3bPjuLD6bPHfRpcXX/a0WQG9hLr+QL+drr+KgpZDfXH+9HyJXq+VVyfPkXP9AZToU+Bnyug==
X-Received: by 2002:a63:3203:: with SMTP id y3mr9586994pgy.191.1567799280467; 
 Fri, 06 Sep 2019 12:48:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
 by smtp.gmail.com with ESMTPSA id o129sm7174895pfg.1.2019.09.06.12.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2019 12:48:00 -0700 (PDT)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Date: Fri,  6 Sep 2019 12:46:28 -0700
Message-Id: <20190906194636.217881-7-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906194636.217881-1-cujomalainey@chromium.org>
References: <20190906194636.217881-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>,
 Steve Winslow <swinslow@gmail.com>,
 Curtis Malainey <cujomalainey@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
Subject: [alsa-devel] [RFC 06/15] ASoC: bdw-rt5677: Add a DAI link for
	rt5677 SPI PCM device
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

From: Ben Zhang <benzh@chromium.org>

This link is needed for the RT5677 DSP to do hotwording

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/intel/boards/bdw-rt5677.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 4a4d3353e26d..a02622fae035 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -74,6 +74,7 @@ static const struct snd_soc_dapm_route bdw_rt5677_map[] = {
 	/* CODEC BE connections */
 	{"SSP0 CODEC IN", NULL, "AIF1 Capture"},
 	{"AIF1 Playback", NULL, "SSP0 CODEC OUT"},
+	{"DSP Capture", NULL, "DSP Buffer"},
 };
 
 static const struct snd_kcontrol_new bdw_rt5677_controls[] = {
@@ -258,6 +259,16 @@ SND_SOC_DAILINK_DEF(platform,
 SND_SOC_DAILINK_DEF(be,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-RT5677CE:00", "rt5677-aif1")));
 
+/* Wake on voice interface */
+SND_SOC_DAILINK_DEF(fe_dsp,
+	DAILINK_COMP_ARRAY(COMP_CPU("spi-RT5677AA:00")));
+
+SND_SOC_DAILINK_DEF(platform_dsp,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("spi-RT5677AA:00")));
+
+SND_SOC_DAILINK_DEF(be_dsp,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-RT5677CE:00", "rt5677-dspbuffer")));
+
 static struct snd_soc_dai_link bdw_rt5677_dais[] = {
 	/* Front End DAI links */
 	{
@@ -276,6 +287,13 @@ static struct snd_soc_dai_link bdw_rt5677_dais[] = {
 		SND_SOC_DAILINK_REG(fe, dummy, platform),
 	},
 
+	/* Non-DPCM links */
+	{
+		.name = "Codec DSP",
+		.stream_name = "Wake on Voice",
+		SND_SOC_DAILINK_REG(fe_dsp, be_dsp, platform_dsp),
+	},
+
 	/* Back End DAI links */
 	{
 		/* SSP0 - Codec */
-- 
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
