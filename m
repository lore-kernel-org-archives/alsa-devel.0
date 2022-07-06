Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33500C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jul 2022 21:13:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B48C11636;
	Wed,  6 Jul 2022 23:12:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B48C11636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657142013;
	bh=fA/iTayk12F34QntoY80bzJW259+3V4ErLNp7P6oi4w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fW8ZRhKl1YEeH/aGX2xv2IeNC6jq10CWQoPgNO9liwZNZc9l3+dwSErSI5KvKG7/r
	 dlyVnKTPYOUgucRi9XjD5az5+F4sDC1jcOLMzb6YCQKqcC0sNSna6XFpCleN+F2C15
	 tlGAJzSUCI5gdj5FF6PNqS08XgCDWgAzvUSFEUIE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44FA8F8016B;
	Wed,  6 Jul 2022 23:12:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39090F8023A; Wed,  6 Jul 2022 23:12:42 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC3DDF8012A
 for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2022 23:12:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC3DDF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qb9e6xSi"
Received: by mail-ej1-x62d.google.com with SMTP id f23so4903245ejc.4
 for <alsa-devel@alsa-project.org>; Wed, 06 Jul 2022 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QlRWy02zusIsUjy51IfsD8EFF9idJBdnV6TtlGLlG7w=;
 b=qb9e6xSi4YGj99hCl0LmSEu/pPb9/2huufM19YOqbwjGovUNz/nkedAAuYTdgVbEe4
 3r4ZLOnNmk+33MNs2qmv+ah1Zn/uCM9RRIT02m0bWFpP06MrYg3g13O5gTUtWIEgLhl/
 NbGNEIBmDTuUuGM3YfG8uZ0F12LgtMQcX/q1O3LyiSsyt8X/EhlTLHJf4c5X96f4ggWb
 ic1Cg88PumAbnvwpv3xml4Bue+3hLaI4Db2ObHNt64UUJOadcLTtqo1cmekhLvvt5MFi
 m1oUiT0j5Fm85+3I1byfRfoIX4kaGmok55tHrJOpd+wt24tYej40KeVjG6xmElpjDQo1
 L+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QlRWy02zusIsUjy51IfsD8EFF9idJBdnV6TtlGLlG7w=;
 b=RrSQjqA14vXM9lRxZYloumv9t+AWJ964DN/mUv4xNkFxczbg+DlvDwEZhQ5oRzNDW9
 n3CWLb9JKL0W4gDsawHotiQ5V8ZIBJsm74ovbMGIz0s9mo1Qr+M4tnR0no+WMZOHQmHM
 viPt3fkm8T8U5We5Jb/PWk39qncxNSukMKQeal3wdWSlHIrW2Ov2nSwFhoRUZYrre/yV
 xW7wscjHfn/XW4ojZhUVAz52mK18F9ujIUfa68mqFzNa6hm6Y4NuTYe+b+XVpLZUcmpQ
 OD+GylpSakvR3UnqFuM8ghpndfAx4XwBs+PcRr8D4pmB8OsDTNTDd4HbrkFxl0J8nOGU
 kLTQ==
X-Gm-Message-State: AJIora9wNRNBGSpR3gm+hnM3xXG3/sUmP6TCOU6cixZSi4ISD0WX2FVQ
 DbUnQi8WMqBH+saUCZWKJu0=
X-Google-Smtp-Source: AGRyM1tEqj+EobmWuQAZP9TOvfu4OSdAJ6ycBMd+DooaOHHdPJh4Pa2wJeAu7SqQ7bPcc/fUaulPbg==
X-Received: by 2002:a17:907:1b1c:b0:6fe:f1a9:ef5a with SMTP id
 mp28-20020a1709071b1c00b006fef1a9ef5amr42622029ejc.233.1657141957227; 
 Wed, 06 Jul 2022 14:12:37 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
 by smtp.gmail.com with ESMTPSA id
 q21-20020aa7cc15000000b0042617ba638esm26409412edt.24.2022.07.06.14.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 14:12:36 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH 00/11] ASoC: cleanups and improvements for jz4740-i2s
Date: Wed,  6 Jul 2022 22:13:19 +0100
Message-Id: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

This series is a preparatory cleanup of the jz4740-i2s driver before
adding support for a new SoC. The last two patches lift unnecessary
restrictions on sample rates and formats -- the existing ones appear
to be derived from the limitations of the JZ4740's internal codec and
don't reflect the actual capabilities of the I2S controller.

I'm unable to test the series on any JZ47xx SoCs, but I have tested
on an X1000 (which is the SoC I'll be adding in a followup series).

Aidan MacDonald (11):
  ASoC: jz4740-i2s: Remove Open Firmware dependency
  ASoC: jz4740-i2s: Refactor DMA channel setup
  ASoC: jz4740-i2s: Convert to regmap API
  ASoC: jz4740-i2s: Simplify using regmap fields
  ASoC: jz4740-i2s: Remove unused SoC version IDs
  ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
  ASoC: jz4740-i2s: Remove some unused macros
  ASoC: jz4740-i2s: Align macro values and sort includes
  ASoC: jz4740-i2s: Make the PLL clock name SoC-specific
  ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
  ASoC: jz4740-i2s: Support continuous sample rate

 sound/soc/jz4740/Kconfig      |   3 +-
 sound/soc/jz4740/jz4740-i2s.c | 351 +++++++++++++++++-----------------
 2 files changed, 177 insertions(+), 177 deletions(-)

-- 
2.35.1

