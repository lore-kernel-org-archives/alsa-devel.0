Return-Path: <SRS0=5JY3=NG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ECAC4338F
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Aug 2021 07:33:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C3B60F4B
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Aug 2021 07:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96C3B60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 381311781;
	Sun, 15 Aug 2021 09:32:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 381311781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629012825;
	bh=RWabs4shqERX3lf7rQpv0a7N7wRbwZ/btfR7pqiCchg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nizTa4ayUI6KgDFHRwWyXlKDSsVEodyQkRfdJRWYw3HJmv9ikpmq/4V4vKSkw2PLu
	 lzHD3Q7OW+87tTECZ/56GY/jsicOABkuMbCoVmc8elXwkZ4y+KCfQbWsilKP2M38bu
	 rt+HH6ElwLvVPnzqm7xBjvZgoCw0RuXU+EE9qix0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CF1DF804FB;
	Sun, 15 Aug 2021 09:30:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4179EF80245; Sat, 14 Aug 2021 22:20:05 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05DB6F80245
 for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2021 22:19:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05DB6F80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bS0bw4Nb"
Received: by mail-pj1-x102f.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so26057641pjr.1
 for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2021 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mAtgpgJZGh5qZDIf6I2YBn2p3wmsbATJ34UD7KVweM4=;
 b=bS0bw4Nb73a6l7jcuM2wSDV4P0TeaiKE/QC1+0xoOtIlTgDbjac5q6rtGwB8Euyw7j
 9TGQP0A3Ykl4gyK2Hy5wyX72Mzwl8zazjXZ6dgUU4Psy9B3RpjDOT5kl+kLV6ffVbX5C
 2CDUqQqXEXJhCapE+J4G2939goYOMgEtYgX2LgCysAELwLyqR0PYiy11PWVlmxvbtaKx
 RBiXADztgCXYZibRjY3NkraMFQxVhK0ncsWN47nuDpnSAv8RdIBZUONo/GSU34hKclSx
 JQfrCmli4QVEh7fKwXZmpCI/SzZ4k+jl/A7WrLy8mfOLF1joLAqYH5dMZrsBJjbc5xI8
 ty+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mAtgpgJZGh5qZDIf6I2YBn2p3wmsbATJ34UD7KVweM4=;
 b=kLMhPdmoVEDob2YovgBT0rxc/AbG4hRNreKcwOej3FVTvHeT3wpWNJRR6rAgiCtOta
 P1T2mtj4+9hlcbcNBEwKsIek5wB4hDp8p3uV8ENig7mXhEUJNRrN6S/n1VWPjCE0yfcE
 NCOeDLlpmFXYQRdzd5VGy+vUJNUt85zNMuN9rBVewvS08davquQa4Zrtot9CSbZGh91D
 +65d0FAv++swQDhHP/Ky+am7RNEGSP/G4eQpJNDENLf16taI2RT91n645dKvwdET2Mcv
 /xvwlAWkJsbTmEjrScHLozwjckGf+TCkPmyKdt3qy4McQw65Hu5kc5/P+RJDF/0O3frB
 Kmyw==
X-Gm-Message-State: AOAM533fTKW9LkdGTi9iVdrGXKGxsQH66SkCArvJijYADh/5zfe47cUN
 EJ1MxAtRJIuuQCU9bbwjhR0=
X-Google-Smtp-Source: ABdhPJxhPvqKjOaL6Gm/B7DK5CcgcrHKajWNwm/TbgU99bhnT1KC0ts35LjRkITbB9hyun/unyGbeg==
X-Received: by 2002:a17:90a:2802:: with SMTP id
 e2mr8871836pjd.215.1628972390593; 
 Sat, 14 Aug 2021 13:19:50 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
 by smtp.gmail.com with ESMTPSA id u13sm6413121pfi.51.2021.08.14.13.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Aug 2021 13:19:50 -0700 (PDT)
From: Aakash Hemadri <aakashhemadri123@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 0/3] ASoC: ti: Use of_device_get_match_data
Date: Sun, 15 Aug 2021 01:49:38 +0530
Message-Id: <cover.1628972198.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 15 Aug 2021 09:30:27 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Bjorn Helgaas <bjorn@helgaas.com>
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

Hi,
	This patch series will apply cleanly on for-next
Prefer `of_device_get_match_data` over `of_match_device`.

Aakash Hemadri (3):
  ASoC: ti: davinci-mcasp: Use of_device_get_match_data
  ASoC: ti: omap-mcbsp: Use of_device_get_match_data
  ASoC: ti: davinci-evm: Use of_device_get_match_data

 sound/soc/ti/davinci-evm.c   | 2 +-
 sound/soc/ti/davinci-mcasp.c | 2 +-
 sound/soc/ti/omap-mcbsp.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.32.0

