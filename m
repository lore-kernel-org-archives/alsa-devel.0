Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C61C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jun 2022 06:12:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 662221F19;
	Wed, 22 Jun 2022 08:11:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 662221F19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655878359;
	bh=ilYie5gTxnc1nv55px9DUExoqqKClS3mkpMvbi1r2JA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c/NKju3UtW27KANNC3x5dPASUeefWWl4Nse4qs0Zo5Q+AiZgzticXjk1DtCxHi72Z
	 psldTpbG5EQvhSEaMuELZknub2YEYpLMmT2xxGOyI/2S92/PmoVFszxfsH1S0rrY/7
	 y7MLJcnXIB6fDm9UCeOH6njWF+C9Gfwz4DIseUhA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7871F80118;
	Wed, 22 Jun 2022 08:11:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED6A5F802D2; Wed, 22 Jun 2022 08:11:46 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A3E8F80118
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2022 08:11:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A3E8F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZhQS152J"
Received: by mail-ej1-x629.google.com with SMTP id lw20so9599520ejb.4
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2022 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UW2Ck9w89+CRbSGkJklsBtZoHdtGh6tH/2JzcL/UeIs=;
 b=ZhQS152JxW4cErBWVBT/CBqcn1OxR/7hxNTSEg1QnWtG8/VvBfQccC520UTUyfmBQl
 bxYshbZgmA7AGe0bykq+WAp8mod1GR0FJfTijbSGs4deievvk46aFAlYykIsWRGKX1En
 SFhJf1RMW7JpBS/ewTG8bRBl0K94+rQ2GbM/aNPv2634wQGkf38vQETVKzWAMpBTKOB1
 9hGzK4xrA8gnowqlcfXDWZaLwUzAjJ3EnDYdC10AHzx9H5tyocH5tiWZkMQrNr249B3g
 T3il3m9MnxyE7yKuK1iZ+oMsem/QFLiPBHxcaNa225lCVvxoi0QHaYwigh/k3RQfhPXM
 WxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UW2Ck9w89+CRbSGkJklsBtZoHdtGh6tH/2JzcL/UeIs=;
 b=emgW5RcfdmOURVqbvXwLrSbbU25y8u8pgC/6mGVa1hdZE6P1z5F7CuBy/aUuoIXdw6
 0Li/Xa71Qh9HgY/Vrbo0wWYsTjfNeCgdIFftHF0hGslcjwbBn4VMEMq1wpwHl7J1sW0w
 7ocAZ87FSbRQgdbtYG1E+EJ6GmQ/K5ngp+abkFaBuLRvxZzmK1hXB5zdHp7egaSegqI5
 O+YOtwr3aJ3mwNmogtqHRB2MCSlGvp1XrnSnx1Iq/gzkwra5Zixb44r8wQ9JAEi7+ubO
 Q73Zbm0Prq11a3h00rnVsCsyz0ge9EEfKm/6jlu28xS1NWaxLCVOhib3l0twLJn2iT34
 df8A==
X-Gm-Message-State: AJIora+X1Fz6tNKZoi30E0ALkX33mK4F8S6eyuPzPSp/ZdgdNCrRgoJt
 8JS9t/SHzF1o0o9Vn4GNT/w=
X-Google-Smtp-Source: AGRyM1urqCYHq44g/9jk0TQ1Yx4JIHQbieaeZQTZRxKAqzdghsklsf4K1NPbXPEYAM750UzhGcDDeA==
X-Received: by 2002:a17:906:7a56:b0:722:df69:3bd5 with SMTP id
 i22-20020a1709067a5600b00722df693bd5mr1482293ejo.581.1655878298528; 
 Tue, 21 Jun 2022 23:11:38 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a05640210c100b004357dca07cdsm7347566edu.88.2022.06.21.23.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jun 2022 23:11:37 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: qcom: apq8096: set driver name correctly
Date: Wed, 22 Jun 2022 10:11:06 +0400
Message-Id: <20220622061106.35071-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Set driver name to allow matching different UCM2 configurations
for the multiple devices sharing the same APQ8096 ASoC.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 sound/soc/qcom/apq8096.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index c7b7d0864d1a..5d07b38f6d72 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -113,6 +113,7 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
+	card->driver_name = "apq8096";
 	card->dev = dev;
 	card->owner = THIS_MODULE;
 	dev_set_drvdata(dev, card);
-- 
2.36.1

