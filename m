Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B22C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:04:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5172073A
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tcj4prsE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kzq8l1ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5172073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17C271675;
	Tue, 21 Jul 2020 19:03:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17C271675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595351066;
	bh=ZvNtzmmv7B2fMy00Bj6NniL/ps8CeqQdJtMduJdtyCw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tcj4prsEMvjoc7HHGUWf1eJi2WDZPYAxJcti90JWIEo0v8jPCvD50lXTgGYTmGrZ4
	 HtIpw5eGBJ2i3hvyy+i6gZKlIetTf8eF7qN9WHcI7v3H6cy9buSz8P7gjLEHMZhKkK
	 R4HIvREUE7MBDOPUhnD8S+7IWTq150s9adDdDaEs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80F87F802F9;
	Tue, 21 Jul 2020 19:00:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C07E3F802DF; Tue, 21 Jul 2020 19:00:35 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BCD4F80290
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 19:00:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BCD4F80290
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Kzq8l1ru"
Received: by mail-wr1-x441.google.com with SMTP id z2so21945592wrp.2
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N5toOmofPdb0aWS/cX/qzEMNy/7jWKTdvFfToimNqFU=;
 b=Kzq8l1ruaR/AWJfmVIxoYH5oXrF5Sxh/oc8OT2Uxk1ov+20yL2zNArmg7vqcO3L5PG
 vs649aolZ4zpeUNir7Ehmv0T8LNiuU3IoP3UyjStqsLIuG8s2SDH3Qc4W1yIVCpqFv8f
 9lMcSu2l6pd9SGkOtmvjItozqFa8nS4r9xHOWoZdK0xyaM1w7ZgmbeEG6JhHfz4ZYqwi
 DCK+tA0fS3+g2RHdWiSHXWA8FAdv6pdOf+6BbpU7G3wSzjYOkPt7+shZ08MdRhvbhnVY
 HLwHWveVus3acSOh3u5DuUv9BkxsQQCOwspjfcs3cyV7SapecFjqhmIJtTxOqG1XYbxs
 ltOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N5toOmofPdb0aWS/cX/qzEMNy/7jWKTdvFfToimNqFU=;
 b=syzgJwOImq6J0H0PPiIUDG8jJvgJoW0T1MUz9BMFek65XtD5o7NxQPFGDS0GiPo/Fv
 SOiWwLoGl349blyHexpbMU8Xh7DkjQ/lsLb49JOPClgUz15bz3HjvqirOBHckVphSNzH
 qtA6H1vFQfC20hM+j5Uq3gl6Z5dEvTGPJG5vLUzSp3rhdKRmvPSSAumzofbxMQ8uCrRZ
 hrVkjHHYs368/zp106U6cvXQpYQXK1uz3k4ohD3lRqmeKcvhqeTLqu5Q7uIMGAiReffk
 724ujhFeKxPxcRhKeiGa1aGXOJXJGS2iqjwvhRtnqZ6mfFQLFv23Ip2BQxs7aN/Ld7Rj
 xdWw==
X-Gm-Message-State: AOAM530s0+titP4GzDtvBRoYvKn0wl5KmTio3Low8thzB6a+i1RlATsb
 Xjj847PAiaE67yx8Vx44xUp17g==
X-Google-Smtp-Source: ABdhPJzYS7aFCBBkC+2BxK07/ub7QVn25hX1kQwkGqFLdWhA/Y2ltFfJ8Z8GQ5+nOdxb5nnanwOPQg==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr27519445wrw.6.1595350819283; 
 Tue, 21 Jul 2020 10:00:19 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id h11sm15526327wrb.68.2020.07.21.10.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 10:00:18 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [RFC PATCH v2 5/6] ALSA: compress: bump the version
Date: Tue, 21 Jul 2020 18:00:06 +0100
Message-Id: <20200721170007.4554-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

Now that we have added support for new IOCTL and flags to
struct snd_compr_caps, bump up the version to 0,2,1
to help users find it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/uapi/sound/compress_offload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 43c78cdf492c..0d407b57a1d4 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -31,7 +31,7 @@
 #include <sound/compress_params.h>
 
 
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 2, 0)
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 2, 1)
 /**
  * struct snd_compressed_buffer - compressed buffer
  * @fragment_size: size of buffer fragment in bytes
-- 
2.21.0

