Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D7C35280
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 22:04:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3EA20725
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 22:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Nai9BDU0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="jjnN0Drm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3EA20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9698F1823;
	Fri,  8 May 2020 00:03:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9698F1823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588889087;
	bh=IVcCT69rtJnizGhyHC4tg8FJEC0dbteTHQhZd2x4LwA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Nai9BDU00fDmeuH+D/1H6017p/Yn18MQ9BT0bgnnqzVayqbwnsv+FidYSneY5zIev
	 +NqctMrlHXGL/+fPYCWmfjFNTzGBWrHTQddajK3Z1E9YDlDXCBwlfXtrIhNZbdHP04
	 kZvs8l4Rz5chh8kWN3QAeX+2oSakicZ7MGqxK8M4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 184C5F8015B;
	Fri,  8 May 2020 00:03:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 198C3F8011C; Fri,  8 May 2020 00:03:55 +0200 (CEST)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D044EF8011C
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2020 00:03:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D044EF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com
 header.i=@semihalf-com.20150623.gappssmtp.com header.b="jjnN0Drm"
Received: by mail-lj1-x244.google.com with SMTP id f18so8002978lja.13
 for <alsa-devel@alsa-project.org>; Thu, 07 May 2020 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=wUuNuaJIglL+Kx5ApW0YvQ2BpX31cdZYGLJ2BUr4Tvs=;
 b=jjnN0DrmtBzX5eCaj5CLxE3x/6tX8xc+xUqp7+sjt26xKKaixfXPpZTbSSbc/kGCDL
 1GmTHBJ23lXZm2Bx5sy4NBd+9MNy1KyQ6SBfhIiQ9N8Elg3BVT12iXakMMVFe/tYlwmo
 8AdCHMohcZt6/OugywymC2rIyNOEKrf3kvNa4HJz+7POopF+wtHjrR43HRO0nhKX6Os3
 o9j0Wpw6JVwng7qk1MTXH/+YTIcQH9CmQTxD0O8LlEgLqagzAqwDrcWWed7/6cdeY9fh
 tnMczF33SvTguEIfSP8JMHvpxfzyfebE6iN8oOmq7RaLTfMJqFSDEjcoaPafnbzoc1yN
 8/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wUuNuaJIglL+Kx5ApW0YvQ2BpX31cdZYGLJ2BUr4Tvs=;
 b=FpiWsbjkYb4LWXsF6EqR6zpiCLOEkjGRfQsifpBphEoi4TV7w1fm3jPaxJWXb6IZ2k
 HpVChphGqgqS7CASS+HZ3JThlJo+vIjCa+xT6aB4iNCPHGiL0WG0qE8dlDzf7MBC2vSD
 yiM6VsdP2hJJGV/iwFrT0YHX0986gOXCCPDovU7GgSMUkdQzzYqRGbHL9r0rCoBlj17D
 qjB0mwhIMXZjytLoE+dX30AftG86uKjU/qJlml3Z7WDzX3FDhKX+HTcNdxoIgHZvlB/9
 +U63AMF1vJBRhhI9PF2Gux++Vk6gvNMjdg/xAzjVfKUwvE0GvRtETpP8yBLnlVhRC8sm
 syKA==
X-Gm-Message-State: AGi0PuahgFAb/utIHD1XMaCM9ipMOa2qftb0RhwkU5kQDTIEAPmuUgCv
 a9WYJ7GuxuKqkB+FdUrpVJAHoA==
X-Google-Smtp-Source: APiQypLfjpW+TsQ8WZmwmd/fpl1/0cAj9W9AWHktmin9enHLmhIo3KDk1ZXJ6X2Heb2MyqGmrKXyfg==
X-Received: by 2002:a2e:9691:: with SMTP id q17mr9599037lji.116.1588889025769; 
 Thu, 07 May 2020 15:03:45 -0700 (PDT)
Received: from rad-H81M-S1.semihalf.local
 (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
 by smtp.gmail.com with ESMTPSA id a13sm4095267ljm.25.2020.05.07.15.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 15:03:44 -0700 (PDT)
From: Radoslaw Biernacki <rad@semihalf.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: Intel: Boards: Support headset button function for
 nau88l25max and nau88l25ssm
Date: Fri,  8 May 2020 00:03:32 +0200
Message-Id: <20200507220332.24686-1-rad@semihalf.com>
X-Mailer: git-send-email 2.17.1
Cc: Chinyue Chen <chinyue@chromium.org>, alsa-devel@alsa-project.org,
 Radoslaw Biernacki <rad@semihalf.com>, linux-kernel@vger.kernel.org,
 Ben Zhang <benzh@chromium.org>, Marcin Wojtas <mw@semihalf.com>,
 Benson Leung <bleung@chromium.org>, Alex Levin <levinale@google.com>
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

Map the buttons from the Android reference headset to
KEY_PLAYPAUSE, KEY_VOICECOMMAND, KEY_VOLUMEUP, and KEY_VOLUMEDOWN.
KEY_PLAYPAUSE is used instead of KEY_MEDIA for BTN_0 as it is more
logical and have much broader userspace support. Like Chrome OS
use it to play/pause of video and audio. KEY_PLAYPAUSE is also
supported by Android (USB headset spec requires KEY_PLAYPAUSE
for BTN_0.)
https://source.android.com/devices/accessories/headset/usb-headset-spec

Signed-off-by: Chinyue Chen <chinyue@chromium.org>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 7 +++++++
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index d7b8154c43a4..103ea94c3bd1 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2015, Intel Corporation. All rights reserved.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
@@ -158,6 +159,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+	struct snd_soc_jack *jack;
 
 	/*
 	 * Headset buttons map to the google Reference headset.
@@ -172,6 +174,11 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	jack = &skylake_headset;
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 	nau8825_enable_jack_detect(component, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 4b317bcf6ea0..1528e72c3a11 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -10,6 +10,7 @@
  *   Copyright (C) 2015, Intel Corporation. All rights reserved.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
@@ -177,6 +178,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+	struct snd_soc_jack *jack;
 
 	/*
 	 * 4 buttons here map to the google Reference headset
@@ -191,6 +193,11 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	jack = &skylake_headset;
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 	nau8825_enable_jack_detect(component, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");

base-commit: f8729a41aa17f5eb5291a0e78926154e948bb4ad
-- 
2.17.1

