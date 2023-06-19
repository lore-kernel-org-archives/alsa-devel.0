Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F143EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 12:01:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8A6383E;
	Wed, 21 Jun 2023 14:00:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8A6383E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687348894;
	bh=Raf6d4YDeCuVQvMgHB8ag7mU4deMf3dpmNTuxvP53fs=;
	h=Date:Subject:From:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=tZQRroFF57Yn7o3fEXDr6dpeiPIPfKFTGUN1vwWzS3n+M4v6j454h+0luvxkn6t91
	 RNg7SXrc8HlwLW2VS5UnxNc+bYcX0j3q8+663x3+gj6UT0O+Tuj/qWGzwRrJywFElx
	 AbOOHc5Vbp7BN+NfyksNFNNmIxX6k//SIuMyxwrc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80872F805B5; Wed, 21 Jun 2023 13:59:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 32CE8F805A1;
	Wed, 21 Jun 2023 13:59:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67643F800BA; Mon, 19 Jun 2023 05:31:57 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 45D5CF800BA
	for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2023 05:31:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45D5CF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20221208 header.b=lxtOJckE
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-57008cbc58aso42664177b3.1
        for <alsa-devel@alsa-project.org>;
 Sun, 18 Jun 2023 20:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687145503; x=1689737503;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G10eF1L2n5B4Mwr5kacZKLWRTzWH55DNVZ3Rtlm7H5k=;
        b=lxtOJckE4YUvJj9N1FywwvKDMF0kL0qmMXCzWYZtlqsbP4VKvnRtOcC88yp+ai5905
         8WtttVVqWPhm6wCduDHkZZidMFxQU5ZgOVT3vP7gRczBDFAsUNfOF2YepyQVy8O6MgEO
         ORcEBPGWS62KHyngl3nasgPtEdnH/5B0wGROWu3eVCXnSuM5PF2p2fBD0FXwbIe6SNzN
         HiJH0A+FOXAghnI0Nnzo7UKrsRz+mLPzxOJUmnlq30gmLkFipiUOI83oNn5+JW1OHLUv
         7ogch49xBgMRndIZ9rvKL97TZk0FVCWTjgLfEbWB54PALXOVyBlLKYiq1bbu3zR3lQBU
         sCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687145503; x=1689737503;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G10eF1L2n5B4Mwr5kacZKLWRTzWH55DNVZ3Rtlm7H5k=;
        b=eObXanFxxuVS/Toj+esKhG1OriAHtfSEcYfTJVUoumvFvfL/6wM2yAJVqIHhpGAbqc
         TS6lOTH2UdFiitXb/CzRCSafP/WKoR+5UwD9Vr8TxC4tqvGWJqjBKXY5MJFMgX4qcO6z
         TgNGSjUI2+VAGXZae5VQD0sRX9DQYjfK+Ez50qxOqroLUfEt4UpXJuMEHy12u8oYpiL/
         rYYPV7S6UFWAYG0aZwjkNI0AdktdSOCOwEc5BI+wWl+/gNlkPKbJmuvmhYWlKQ8xA1T8
         8ehIFNL6F5Oaf2gOxSYHz0KJbDaIn4OwDjoRXIS97FBybY9irPBXKadyBYExw35x7tZk
         DnjQ==
X-Gm-Message-State: AC+VfDy5xIlFYFvOrT88rYaDFwtuaTZt4Wx9CBABxPXOlirvNT+dRwhk
	elyxmvhg3t7hSgTGgLlHJqjgVe9e1ohUbVUjbw==
X-Google-Smtp-Source: 
 ACHHUZ5Gm/dYiTDDMVyEOTutSI8nrCztJr4EgqlmkEjTqkZ1dWV/80rsN8Urd+WaQtK8tTcUDpCOH1q+ZSHDXeFmBg==
X-Received: from yixuanjiang.ntc.corp.google.com
 ([2401:fa00:fc:202:845a:7b17:7f6e:785b])
 (user=yixuanjiang job=sendgmr) by 2002:a05:6902:91:b0:ba8:6dc0:cacf with SMTP
 id h17-20020a056902009100b00ba86dc0cacfmr881612ybs.12.1687145503578; Sun, 18
 Jun 2023 20:31:43 -0700 (PDT)
Date: Mon, 19 Jun 2023 11:31:27 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230619033127.2522477-1-yixuanjiang@google.com>
Subject: [PATCH] ASoC: soc-compress: Fix deadlock in soc_compr_open_fe
From: yixuanjiang <yixuanjiang@google.com>
To: vkoul@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	yixuanjiang <yixuanjiang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3H8yPZAsKCiIWGVS8LHG8LEEMMEJC.AMK8JQ8-BCTCJ8JQ8-NPMHCAR.MPE@flex--yixuanjiang.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: IUY27R2SP7TEYH6BM2WHXSBYUY4GRX5J
X-Message-ID-Hash: IUY27R2SP7TEYH6BM2WHXSBYUY4GRX5J
X-Mailman-Approved-At: Wed, 21 Jun 2023 11:59:38 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IUY27R2SP7TEYH6BM2WHXSBYUY4GRX5J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Modify the error handling flow by release lock.
The require mutex will keep holding if open fail.

Fixes: aa9ff6a4955f ("ASoC: soc-compress: Reposition and add pcm_mutex")
Signed-off-by: yixuanjiang <yixuanjiang@google.com>
---
 sound/soc/soc-compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index d8715db5e415..2117fd61cf8f 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -194,6 +194,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	snd_soc_dai_compr_shutdown(cpu_dai, cstream, 1);
 out:
 	dpcm_path_put(&list);
+	snd_soc_dpcm_mutex_unlock(fe);
 be_err:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 	snd_soc_card_mutex_unlock(fe->card);
-- 
2.41.0.162.gfafddb0af9-goog

