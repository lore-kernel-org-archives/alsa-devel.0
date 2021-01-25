Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF6EC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 06:16:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8305022C9F
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 06:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8305022C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E26E8183E;
	Mon, 25 Jan 2021 07:15:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E26E8183E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611555364;
	bh=TcEyiWWvZc5i1wOW5wVA5vc+Kau+xZXdexUXQYpvOmA=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W/0YFMY00ggw1K2gXMKxKQaPaYUfVoP4GTy6/lE/GY7XiKJdaIDBhDjYL+1JWAimb
	 RibUfx9uvukn6bunwD/gEM0rinuo7nvuf88PcN/v9Vn4BBy9Zfy+vF+IRoZdYNw/x2
	 CNeOmdszsr2Kbbi9W50RsWiszYf9JhNMi8hxyeek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68855F80218;
	Mon, 25 Jan 2021 07:15:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51949F80259; Mon, 25 Jan 2021 07:15:05 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C7D2F8014D
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 07:15:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C7D2F8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="md6wWUNd"
Received: by mail-yb1-xb49.google.com with SMTP id t18so2437624ybb.22
 for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2021 22:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=tPbEKr0qHj4nC8vVml7/3p2on+oiuBEMjkA44UyfV1Q=;
 b=md6wWUNdTZAfNwb6oqX/gMe6oC/prf2SfB8Ep1k+0Z3cK2C0fWJk9dhGjkPenT42PX
 L7yKnfw9kNKJmnr92DCp8nG2poz2k++/+Uv09r5CaoiP+Caf4SMZliTsXZ2t8BtPiByO
 toLBatsNcRJxEz5nIrzy9GGeLPw0w++Ea3o6gJ3PJgxHr+4ZuDiTW0nFR2J7I0JfcGbx
 /S1nnuNBG3jzg0KBJkGCjImWuU5HrQ0mq1lnW4ZMRGBtADXVyI0Y6cgladFyvH6ZTaK7
 uxKZEkIW9M/CY9PxiDCc2NYa/G1i7KCwS5Ov0c0JBKDU4tw+90JP1h3g5c7HrKsm8AhQ
 u7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=tPbEKr0qHj4nC8vVml7/3p2on+oiuBEMjkA44UyfV1Q=;
 b=KCs9ko16agN81cLcz3QdsD5hB5qlm+SlNOXeJzuPEgM68W/6Z23ZE/6XXJHasUsxUm
 h1T4sI8DH4DVgGZ208j5GXQwGoQjMMRIbb+eIwHvjoyomerZ06SOb+3tixBA0nQgMKlH
 cP0+1dyTyhKVyiVK3tQOVV3gZD669R2Q4E/sstVPOMsQjpRhRjVcK+EsOrYemzHE5/BP
 4XjyGa7dTWScfI4wPTgeYzkj4wITV93k965Aq3HN8ecBZPRLK1jHEyCAiRwEGhKG/yRV
 ZFCfPEr/e19EJth6qEq/TaTBoV2DKqinyStTWp0visx729e64Pew35aykLrxxfKaog31
 PI8w==
X-Gm-Message-State: AOAM531WV+44Xr1pbyN/bNDm/CWGGo0p0L5nkBRCrd1GVtaX+QLIDUu4
 PRSTiTfy9OtRWBL1TA5L+4xCiZDs4WUi
X-Google-Smtp-Source: ABdhPJykXSUupNvaD0taMFRNU3fAF8KWPoOoyoSuzG2Bm06NL9k0LgFo+3UreObBVpzP+7hFb12UfirxZPkR
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:b870:8946:4704:f6a0])
 (user=tzungbi job=sendgmr) by 2002:a25:73c7:: with SMTP id
 o190mr22327446ybc.482.1611555298217; Sun, 24 Jan 2021 22:14:58 -0800 (PST)
Date: Mon, 25 Jan 2021 14:14:53 +0800
Message-Id: <20210125061453.1056535-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2] ASoC: mediatek: mt8192-mt6359: add format constraints for
 RT5682
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

MT8192 determines the I2S clock rates according to the sampling rates.

There is only 1 set of I2S in between MT8192 and RT5682.  If playing and
capturing via RT5682 in different sampling rates, the I2S data will be
corrupted.

Adds format constraints to the corresponding DAI links to make sure the
sampling rates are symmetric.

Fixes: 18b13ff23fab ("ASoC: mediatek: mt8192: add machine driver with mt6359, rt1015 and rt5682")
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from previous version:
- Separated from the series [1] per [2].
- Updated commit message for more details.

[1]: https://patchwork.kernel.org/project/alsa-devel/list/?series=419769
[2]: https://patchwork.kernel.org/project/alsa-devel/patch/20210122100742.3699128-2-tzungbi@google.com/#23919795

 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index cc0fc72305d2..c368236d8a3a 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -410,6 +410,53 @@ static const struct snd_soc_ops mt8192_mt6359_rt1015_rt5682_capture1_ops = {
 	.startup = mt8192_mt6359_rt1015_rt5682_cap1_startup,
 };
 
+static int
+mt8192_mt6359_rt5682_startup(struct snd_pcm_substream *substream)
+{
+	static const unsigned int channels[] = {
+		1, 2
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_channels = {
+		.count = ARRAY_SIZE(channels),
+		.list = channels,
+		.mask = 0,
+	};
+	static const unsigned int rates[] = {
+		48000
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list  = rates,
+		.mask = 0,
+	};
+
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_CHANNELS,
+					 &constraints_channels);
+	if (ret < 0) {
+		dev_err(rtd->dev, "hw_constraint_list channels failed\n");
+		return ret;
+	}
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 &constraints_rates);
+	if (ret < 0) {
+		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_ops mt8192_mt6359_rt5682_ops = {
+	.startup = mt8192_mt6359_rt5682_startup,
+};
+
 /* FE */
 SND_SOC_DAILINK_DEFS(playback1,
 		     DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
@@ -657,6 +704,7 @@ static struct snd_soc_dai_link mt8192_mt6359_dai_links[] = {
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		.ops = &mt8192_mt6359_rt5682_ops,
 		SND_SOC_DAILINK_REG(playback3),
 	},
 	{
@@ -730,6 +778,7 @@ static struct snd_soc_dai_link mt8192_mt6359_dai_links[] = {
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		.ops = &mt8192_mt6359_rt5682_ops,
 		SND_SOC_DAILINK_REG(capture2),
 	},
 	{
-- 
2.30.0.280.ga3ce27912f-goog

