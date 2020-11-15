Return-Path: <SRS0=iGAb=EV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB2C55ABD
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 12:23:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351E1223BF
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 12:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TmHKIdtu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.com header.i=@birdec.com header.b="ZvPNc9KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351E1223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A280017E7;
	Sun, 15 Nov 2020 13:22:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A280017E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605443018;
	bh=ZEULA+/4wtkzn4v1j/BFK5LMulYoZApkiDKFtZ/qSXE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TmHKIdturaukELhAVxzeSJA+kZcn0QvLgTSZxHOEwy9bPO5IX12kYrgzDdtuAitgQ
	 ftKPQ7YKJDEkAmnjFKW8u/mLpYiCahzx2J7hv6Vwkg6X7gnQVQ1l+T2YfSrBscB5ze
	 4V41nZzRsxDbGr6spJR/IpFiWL3txwcb3pozSBps=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95C49F804CB;
	Sun, 15 Nov 2020 13:21:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75D3DF804CB; Sun, 15 Nov 2020 13:21:18 +0100 (CET)
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 119E5F804BD
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2020 13:21:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 119E5F804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=birdec.com header.i=@birdec.com
 header.b="ZvPNc9KZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.com; 
 s=default;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4oo0hbU3ekJrFD+VdnDUAiKmeIwqAfw/S+FCziusOw8=; b=ZvPNc9KZ1E2+p70iK6KumfJCD0
 NQLvMh+pnmK/PaZXKvk1PKKwazky/Y/AyRhUkUj+Cir9b93pkkMwj5zmXbx0vxH5x77NkiimzQFJd
 /ntmNkYvI4zTaquKFJFDtnfXJCFIHmFWMvgmx2MuwYYusMSsCzO2KiKgKXEYNoSmtHKlUnI+hMySu
 PgSSV+E8DFxVR2JRNpzk48XfDQmO9XC9U/tabduNK6kMhCkJfhRPiblQrFGS/adjM6OmMixhJ3QMz
 r8cXfzA07wuDdGkEsf+Orp2Ke1Z90T/hve02Rhl2SpqX1YOcwp8QNCIjefLgFxqVGBhiLdNVZKJeO
 f1uIGFOg==;
Received: from dynamic-078-054-118-130.78.54.pool.telefonica.de
 ([78.54.118.130]:55232 helo=gentoo0.localdomain)
 by host.euro-space.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kmarinushkin@birdec.com>)
 id 1keH1u-000338-Qb; Sun, 15 Nov 2020 12:21:14 +0000
From: Kirill Marinushkin <kmarinushkin@birdec.com>
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 4/4] ASoC: pcm512x: Add support for more data formats
Date: Sun, 15 Nov 2020 13:23:06 +0100
Message-Id: <20201115122306.18164-5-kmarinushkin@birdec.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20201115122306.18164-1-kmarinushkin@birdec.com>
References: <20201115122306.18164-1-kmarinushkin@birdec.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.com
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id:
 kmarinushkin@birdec.com
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: Matthias Reichl <hias@horus.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kirill Marinushkin <kmarinushkin@birdec.com>
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

Currently, pcm512x driver supports only I2S data format.
This commit adds RJ, LJ, DSP_A and DSP_B as well.

I don't expect regression WRT existing sound cards, because:

* default value in corresponding register of pcm512x codec is 0 ==  I2S
* existing in-tree sound cards with pcm512x codec are configured for I2S
* i don't see how existing off-tree sound cards with pcm512x codec could be
  configured differently - it would not work
* tested explicitly, that there is no regression with Raspberry Pi +
  sound card `sound/soc/bcm/hifiberry_dacplus.c`

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Matthias Reichl <hias@horus.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/codecs/pcm512x.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 22ef77955a28..4dc844f3c1fc 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1335,6 +1335,8 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+	int afmt;
+	int offset = 0;
 	int clock_output;
 	int master_mode;
 	int ret;
@@ -1372,6 +1374,42 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return ret;
 	}
 
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		afmt = PCM512x_AFMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		afmt = PCM512x_AFMT_RTJ;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		afmt = PCM512x_AFMT_LTJ;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		offset = 1;
+		fallthrough;
+	case SND_SOC_DAIFMT_DSP_B:
+		afmt = PCM512x_AFMT_DSP;
+		break;
+	default:
+		dev_err(component->dev, "unsupported DAI format: 0x%x\n",
+			pcm512x->fmt);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_1,
+				 PCM512x_AFMT, afmt);
+	if (ret != 0) {
+		dev_err(component->dev, "Failed to set data format: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_2,
+				 0xFF, offset);
+	if (ret != 0) {
+		dev_err(component->dev, "Failed to set data offset: %d\n", ret);
+		return ret;
+	}
+
 	pcm512x->fmt = fmt;
 
 	return 0;
-- 
2.13.6

