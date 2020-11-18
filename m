Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C3BC2D0E4
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 01:01:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D3A241A7
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 01:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PQEEAfz+";
	dkim=temperror (0-bit key) header.d=huaqin-corp-partner-google-com.20150623.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20150623.gappssmtp.com header.b="Na5izE9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D3A241A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6EE717AC;
	Wed, 18 Nov 2020 02:00:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6EE717AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605661256;
	bh=0j8n27bSAnls096Y3fffiM2vO4Jlez5F+nfYONEVXlg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PQEEAfz+M4Vb4ZC6ZJXvTNLaGlHzf7kqHA74R0Vi37X8XEg3sK60EIfioIbQfqm3N
	 6bi50PJtuFnFfioJGXhacKFZMV923DRIxR39Y3yL8ThKV73g7oqIEDE+29EsRlsSWd
	 Ys7esBroIdIGJG2ar3yOQyb1t9NjagTn1Cx/2VDA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D20AF8020B;
	Wed, 18 Nov 2020 01:59:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57CDFF80247; Wed, 18 Nov 2020 01:59:31 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CC1EF801F9
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 01:59:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CC1EF801F9
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key)
 header.d=huaqin-corp-partner-google-com.20150623.gappssmtp.com
 header.i=@huaqin-corp-partner-google-com.20150623.gappssmtp.com
 header.b="Na5izE9N"
Received: by mail-pj1-x1044.google.com with SMTP id r6so153946pjd.1
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 16:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7AO2qORKT4+avCz7hMT+yBOcTnb5ezlHHC8XeW/HDXs=;
 b=Na5izE9NISYqPS/DYWEhhhQAU/OJDp0XUz15N/sihLzwQbwz1N5Fe32ZH7ZJg7kE2X
 gdLwB9GcswgsirTidgqvC3JJBVJ5EwHbXyhAxfStMej3lWAtzk0efqzh5SYir0QvLQyU
 /Y+W8l3361QsyPDAxMrIK5qVPI9ZcxcEEZdCxtl2f5htbJrYa2qVQ/Jf5s5+p1LFUSsO
 My7k/TexcJuQaVZOpEwx239BkYTSXa6ZPTk50FIv4ir31K3PjBtZ8lCKaONHMBNKLKkD
 IbyNn7ocmeTm/5DMS+8kiEf6aBvFYu87bQtcEpWO5QabrztHGLRYPED4WcN+UNK0Y9oV
 ZfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7AO2qORKT4+avCz7hMT+yBOcTnb5ezlHHC8XeW/HDXs=;
 b=Wg7QCwVFSd72c0xRq0HS3c2rOJoMMEEmQM/jDo62GXNYmvRV+k2hPdf+fawYpTwtLr
 fqm61wZPqQ2Ok5nNnKUZrCJVbnT09orl+f1Mr8jCtfQmYgZ9iNC4udOEFne/jJ/sKGNI
 aDBHoKuYCA3Rq2kHMMuZDFIicywLPjRlhey+Sxif7Z7BsY1bS+ibTmXy1ZLrKDp2qsrO
 i4oV6pICf56MT70NxXvcl/Gz1cLl1Kgkw5IsbJ5IzpSwEqOgV38Zl/xV9717wIH5A1LS
 lGU1PEVv/V4Dx0Pe+VjvkWZsBfcPPpqmXZRcUNxmIdOOFRRL6g9UUh5N5ZyErRU0I1Zs
 Rtlg==
X-Gm-Message-State: AOAM532HGdj3x5BvJGKDLW5H8x7ogYS/BHUw/fm/K6VNS878+lrn0tPX
 i+K6hfIJZ+3vOtqp+E8dllm5
X-Google-Smtp-Source: ABdhPJwDch/fiHGH5MBIh+IEocm1RhT1h6NVz+y7GYF61GBmS6tnBmDqOPaWEwmIxwLqfXs+vKuCOw==
X-Received: by 2002:a17:902:b410:b029:d6:b42c:7af9 with SMTP id
 x16-20020a170902b410b02900d6b42c7af9mr2165162plr.21.1605661165303; 
 Tue, 17 Nov 2020 16:59:25 -0800 (PST)
Received: from xuyuqing-ZenBook-UX425JA-UX425JA.huaqin.com ([101.78.151.194])
 by smtp.gmail.com with ESMTPSA id
 y10sm307159pjm.34.2020.11.17.16.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 16:59:24 -0800 (PST)
From: xuyuqing <xuyuqing@huaqin.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] ASoC: qcom: sc7180: fix 32 bit format for adau7002
Date: Wed, 18 Nov 2020 08:58:58 +0800
Message-Id: <20201118005858.123013-2-xuyuqing@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118005858.123013-1-xuyuqing@huaqin.corp-partner.google.com>
References: <20201118005858.123013-1-xuyuqing@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Taniya Das <tdas@codeaurora.org>, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rohit kumar <rohitkr@codeaurora.org>, cychiang@chromium.org,
 Patrick Lai <plai@codeaurora.org>, Andy Gross <agross@kernel.org>,
 dgreid@chromium.org, zhouguohui@huaqin.corp-partner.google.com,
 devicetree@vger.kernel.org, tzungbi@chromium.org,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
 Takashi Iwai <tiwai@suse.com>, xuyuqing@huaqin.corp-partner.google.com,
 Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, judyhsiao@chromium.org
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

the microphone is attached to external codec(adau7002)
instead of rt5682.We need to always use 32 bit format on sc7180
to meet the clock requirement of adau7002:
The ADAU7002 requires a BCLK rate 
that is a minimum of 64× the LRCLK sample rate

Signed-off-by: xuyuqing <xuyuqing@huaqin.corp-partner.google.com>
---
 sound/soc/qcom/sc7180.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index de70fa792aea..768566bb57a5 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -245,6 +245,7 @@ static int sc7180_adau7002_snd_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
@@ -252,6 +253,8 @@ static int sc7180_adau7002_snd_startup(struct snd_pcm_substream *substream)
 				    SND_SOC_DAIFMT_CBS_CFS |
 				    SND_SOC_DAIFMT_NB_NF |
 				    SND_SOC_DAIFMT_I2S);
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S32_LE;
+		snd_pcm_hw_constraint_msbits(runtime, 0, 32, 32);
 
 		break;
 	case MI2S_SECONDARY:
-- 
2.25.1

