Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BCCC433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Feb 2022 12:00:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86020175F;
	Tue, 22 Feb 2022 12:59:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86020175F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645531249;
	bh=iZnLVqPhEdCoeqFRLaS0iaEnLO4STijD7zpqt3gEDfM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oW3MYdYiXp/JlH3F8/gO+Ce2f8GaISAIocwiUQqaDyIo1infpIuDLgqWRwDKgfJo7
	 DGF2AC56BF6q0C2GQJl+Dk9W+22ZyAMNHPRO4Z3kkZ71YFbzx5llbe/TU/GcR0LYBF
	 E/3obV+wQ6432giwlX/VaDIwEg+cfCtoVxRawmas=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59578F80238;
	Tue, 22 Feb 2022 12:59:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A041DF804FD; Tue, 22 Feb 2022 12:59:55 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAD1EF8012C
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 12:59:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAD1EF8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="UIYqOQ5C"
Received: by mail-wr1-x42f.google.com with SMTP id j17so6035464wrc.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 03:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=86hxaHzF3RhEyMf0w7EdDLKHhFRcTnHl9QY4411LC24=;
 b=UIYqOQ5C+72BzCNoV0Ugv17YE9b5pOJ8j4O4j8v5N3W3spxXNFGYmh+JuMT6dyBZKb
 LgYLALuS0ZRyW1ETyfWUoXYOnHNSlESqQGOuAtDPwGhyqehPgnuqkf2MRw35c5ojGyet
 d+GFubJ4UQzpFdkmNknnaqkjCTknZYI4L01jiQ1kDjKNVKmkGPek9fNkR3DS4A6SKxqp
 KwEdE9xqccsnhLTHECBq0N2JJMy7Z6sLOgz4asz9ckKRmkYEIkjNtX7EhALiFDUSxUlI
 cnSrdT75XERF/adspig2vL09edaCtVQF3noFXpLboD2IJ1N2tuACnHavad6EqLbiVA5w
 +DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=86hxaHzF3RhEyMf0w7EdDLKHhFRcTnHl9QY4411LC24=;
 b=5rdgx6Dj1LhL15QgDAiD8/AAKv6cpkgPCb5ePJlQuHMrWgj7/NyaaXS+4nvHpvssRg
 0gj+AUw5tlxvfRVwfS6B5/um6mCdKnNG153FCZCIUwZqsdUTtjfPt4ExmZ8gQ1EsIHsB
 VVHq7uLvrVlzj2nrKA8NCU2BRfC03aResuEW+zM07/TPry6QdXlZD56Emp1RZhc20alN
 ItmPWO8/NMalcDkQFZNDilJaNpRgBDgM0F7Y1RIKhaqSH8w5nFW5Huy8YA6smtCZKW5c
 iMHP7RKkDgzkprsVdBPO3qIMpsrc6DbdPLgYkOMQX9yT+NyfMo6UyP94/rQTIEH7M+Zi
 /QXw==
X-Gm-Message-State: AOAM530TQPF+KPu2Xzk7FSHwC+dhJfadJ+TE5nKQQu9qKfliEGRTRoy+
 g7bBiR1Xrj+fGGY0frDBnFI8GA==
X-Google-Smtp-Source: ABdhPJzmGXWQa2fjf4E5qRANCuTFxziwaIr5wdxaoMdvMBH8nLxjraz5vVllu62TnUTDy9y72pbn3Q==
X-Received: by 2002:a5d:5185:0:b0:1e5:78a3:7747 with SMTP id
 k5-20020a5d5185000000b001e578a37747mr19520727wrv.470.1645531189570; 
 Tue, 22 Feb 2022 03:59:49 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 03:59:49 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 02/16] ASoC: codecs: rx-macro: fix accessing array out of
 bounds for enum type
Date: Tue, 22 Feb 2022 11:59:19 +0000
Message-Id: <20220222115933.9114-3-srinivas.kandagatla@linaro.org>
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

Fixes: 4f692926f562 ("ASoC: codecs: lpass-rx-macro: add dapm widgets and route")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index a7f86b094a4f..058d8634ce40 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2273,7 +2273,7 @@ static int rx_macro_mux_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] =
+	ucontrol->value.enumerated.item[0] =
 			rx->rx_port_value[widget->shift];
 	return 0;
 }
@@ -2285,7 +2285,7 @@ static int rx_macro_mux_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update *update = NULL;
-	u32 rx_port_value = ucontrol->value.integer.value[0];
+	u32 rx_port_value = ucontrol->value.enumerated.item[0];
 	u32 aif_rst;
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
@@ -2397,7 +2397,7 @@ static int rx_macro_get_hph_pwr_mode(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = rx->hph_pwr_mode;
+	ucontrol->value.enumerated.item[0] = rx->hph_pwr_mode;
 	return 0;
 }
 
@@ -2407,7 +2407,7 @@ static int rx_macro_put_hph_pwr_mode(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
-	rx->hph_pwr_mode = ucontrol->value.integer.value[0];
+	rx->hph_pwr_mode = ucontrol->value.enumerated.item[0];
 	return 0;
 }
 
-- 
2.21.0

