Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FCDC433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Feb 2022 12:02:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B53CC17A3;
	Tue, 22 Feb 2022 13:01:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B53CC17A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645531367;
	bh=7L0MaZUFtVhaDRMQtwSZV3TbXZZYsB14bS5A8nzpVoQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ponmEGLsGlU74jIScwkKPoVwPWnp91EgvBIwnlgrzRqz6F1I2d7CQmHwOPxSUeqMx
	 9xFhTSx4CLa0qwvFlmeAvF8Lri9yaUYqNvsc98Bw4hdp+/NSEeeKXFf6gArIhLcMLN
	 OtxvSv+Tw3MPAHN/E2vUK/MBbgu2fuH02iOxb9bM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BDDBF80529;
	Tue, 22 Feb 2022 13:00:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65B2DF80518; Tue, 22 Feb 2022 13:00:02 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7719EF80224
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 12:59:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7719EF80224
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="CQqzgB9y"
Received: by mail-wm1-x32f.google.com with SMTP id
 x3-20020a05600c21c300b0037c01ad715bso1621002wmj.2
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 03:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qAYVw6f87nBCDJGUCPz374Y+GRm8ih0aIXd7jYiegYk=;
 b=CQqzgB9yPbuTyePAU9nroBloxL1ZgVMRzSIxuE5V8cp8RnsAAmLD/DG4Y/U4+52JtP
 l0i4vxh63W11kE4hkrTnjovKpOEVgEa1OuzczjQflVozla893MxHxmTRZ5RSpbgYPPpu
 WWWCPTDJC6Ah2yvXr1BXpsOLIK8iBQlC1cLaVJyOHRuFnvHI0iZWvmwHpjWP3WmThslC
 Az2U5BLZUkpfGspnqVwzfcBt+TqzwaTTQGEBq8/AjQs0gqSr+1LZOL29qIt0ZY/0QuqW
 Hb/khWTEL9bGjL6XLp9XcEClJHUQYc66qWhLG2pBq4leI/6VB9v52SoFzyqpLgYHk4tN
 oqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qAYVw6f87nBCDJGUCPz374Y+GRm8ih0aIXd7jYiegYk=;
 b=wcl21FKbGxyDwYKa8TK01XABuYtLEknjzQX3k0GAJbN2S+oJMiWf3NE0E9gdL68uMk
 eevMpuKGVkaiT8pfgjWfVqNXUe3Y2FhUolAqvugEJ1/03fd4VRCwma/SiacX7IMraEno
 QuOZZtQlBjSfd8EzrdCdk3fSumiPtZ/lb9h/ATBUGpaJuCmtzb6zP22ank/XIvuX9Qd5
 bz8na4u7qNHKlCWoLFzXXEudDCqrVZbMvNaHJ7nyf1IUHNnurZCT0z9keSSZhiwLokOz
 PalWIa4rIdqaVpDMXAOohOs9PsMkCrU8RARlkxKika3O9+EmVGYUssskt0KpvchmIwq6
 f4Zg==
X-Gm-Message-State: AOAM530iGOPwJZqcRzgrHU8ZfFMke2HH8qK1iw9pNhrTvjPTomev4CuG
 BelqdfkNGjMSdKIXGSpLA2ygmg==
X-Google-Smtp-Source: ABdhPJwhpijOE/o2mCXCiE9KnjdyQ6TxkwxS7wznSwBFTO06MlhP+grm26A3hMPj6+GwbD3L+uTUQg==
X-Received: by 2002:a05:600c:3650:b0:37b:dd89:2f01 with SMTP id
 y16-20020a05600c365000b0037bdd892f01mr3086611wmq.43.1645531190597; 
 Tue, 22 Feb 2022 03:59:50 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 03:59:50 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 03/16] ASoC: codecs: tx-macro: fix accessing array out of
 bounds for enum type
Date: Tue, 22 Feb 2022 11:59:20 +0000
Message-Id: <20220222115933.9114-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 quic_srivasam@quicinc.com
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

Accessing enums using integer would result in array out of bounds access
on platforms like aarch64 where sizeof(long) is 8 compared to enum size
which is 4 bytes.

Also few return value of put functions, so that change notifications are
sent correctly.

Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass tx macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 094756544eed..f90786100d1a 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -998,7 +998,7 @@ static int tx_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = tx->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = tx->dec_mode[path];
 
 	return 0;
 }
@@ -1007,14 +1007,14 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
 
 	tx->dec_mode[path] = value;
 
-	return 0;
+	return 1;
 }
 
 static int tx_macro_get_bcs(struct snd_kcontrol *kcontrol,
@@ -1037,7 +1037,7 @@ static int tx_macro_set_bcs(struct snd_kcontrol *kcontrol,
 
 	tx->bcs_enable = value;
 
-	return 0;
+	return 1;
 }
 
 static int tx_macro_hw_params(struct snd_pcm_substream *substream,
-- 
2.21.0

