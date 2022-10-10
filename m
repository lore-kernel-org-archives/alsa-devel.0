Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5728AC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Oct 2022 06:05:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84A8636C2;
	Tue, 11 Oct 2022 08:05:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84A8636C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665468351;
	bh=xMWR5+J01xpRRN/VYdoVF9ZJ1/tLH1hznGXJwjP4VQI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d9lhIzkRgjJU5RUAH6ZMUiHwuw92Y7Y7jA2LDlZ3PQsBwH+kJjUQMXPFnGZQ9F0a1
	 OPYzgiy/Mujn8XlDIJ89FfM9t9yx1d0bZiY/fAdsdpTvvFvkaMUoTpTUxnacbH0Bmk
	 pPGqdl+7X5QL8SzAdxbWARnDL5PwUzX8TRcLKxQs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E65D1F8057E;
	Tue, 11 Oct 2022 08:02:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1608F8032B; Mon, 10 Oct 2022 20:54:56 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69C36F80256
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 20:54:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69C36F80256
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="M2lcS4W4"
Received: by mail-wm1-x32f.google.com with SMTP id
 n16-20020a05600c4f9000b003c17bf8ddecso4556wmq.0
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQsANxIEHACjEO789UfrDxMr8VcVkScq/x+QZ4UQMEA=;
 b=M2lcS4W4Ayc82LkYpVaSwvYZAZi4M6rTJJir8n6eoqpzupOocFLYVDUD1+L0ZNjzoL
 3RaYcedtmQWxAw3etNibpFWoaJAfni9QKplGvxrNSU54eNMWhNH5/Hk00IMZrH11PiVx
 Ma+cwMrvKB17NMjncuJAS41vALYCHn1tNFZv/OiRZEQZOOscv+emg2zdVSaoX7aP8fh7
 rCifucpvsvhVDmj2NiTDS3almzXQjtL1+/0KwMK3HNggsor/nI91u9ox13yXi0BDNkyM
 fXKmKprd1vU2mGDt6aT0mC+G5743ZVnChUpcnWN8I4iKt+ObhOQKO3p7rr6lA0qF1euF
 mqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQsANxIEHACjEO789UfrDxMr8VcVkScq/x+QZ4UQMEA=;
 b=fz17NZqgNw6kfMq8DhXD1tdLty/TB0inQEhfk1v5Nh/wx0KQ/Sno4yO00fjGouFpgY
 nWpMrS1EfM3DH0RQt8bTLQGkvI9R61eGURQcsClgmYHAjj7OcbktuV/iewCUKTKo0OyI
 +Hnbz3ZQH1U178laoj+4tPuXU1sdAZ4DS7DPMk0Qi7fH+K2W7u6fqMgZcuSXPY8e0oHR
 Sp8YbODKnhB9y2/axHLM1jZ8cmBgH91SwhWMs9cSh0zBBVFuw8gGesAnHBIg0Wp3ONEZ
 eu+hq8m4PpvIPdAPCkTuMjhctN+txCdsDGidIC0ijyqY/v94WPMaIfCv6VnRgWm2Clrt
 Oj7A==
X-Gm-Message-State: ACrzQf1ZRoMQlejarCnde6yZDyYzh623qFzo+h+JiAno5YuIr/m32FN1
 d7cElDmPoxk9Wz54h1oNziw=
X-Google-Smtp-Source: AMsMyM4Eg+rIBg02ermXJ7veLFiSgPsQEYs79TtnhGmlvLP0QxQURlSFQ0aB1Mc26GrwiCcF8pcuIA==
X-Received: by 2002:a05:600c:a18b:b0:3c5:22c0:d0bd with SMTP id
 id11-20020a05600ca18b00b003c522c0d0bdmr8226941wmb.74.1665428092537; 
 Mon, 10 Oct 2022 11:54:52 -0700 (PDT)
Received: from hp-power-15.localdomain
 (mm-126-34-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.34.126])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a5d6142000000b00230c9d427f9sm2082272wrt.53.2022.10.10.11.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Oct 2022 11:54:52 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: 
Subject: [PATCH v2 2/6] ASoC: codecs: jz4725b: fix reported volume for Master
 ctl
Date: Mon, 10 Oct 2022 21:54:19 +0300
Message-Id: <20221010185423.3167208-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221010185423.3167208-1-lis8215@gmail.com>
References: <Y0P/u4pJT8rup8Za@sirena.org.uk>
 <20221010185423.3167208-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Oct 2022 08:02:21 +0200
Cc: alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Paul Cercueil <paul@crapouillou.net>, Siarhei Volkau <lis8215@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

DAC volume control is the Master Playback Volume at the moment
and it reports wrong levels in alsamixer and other alsa apps.

The patch fixes that, as stated in manual on the jz4725b SoC
(16.6.3.4 Programmable attenuation: GOD) the ctl range varies
from -22.5dB to 0dB with 1.5dB step.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index cc7a48c96..72549ee2e 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -142,8 +142,8 @@ struct jz_icdc {
 	struct clk *clk;
 };
 
-static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_dac_tlv, -2250, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_line_tlv, -1500, 600);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(jz4725b_dac_tlv, -2250, 150, 0);
 
 static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_DOUBLE_TLV("Master Playback Volume",
-- 
2.36.1

