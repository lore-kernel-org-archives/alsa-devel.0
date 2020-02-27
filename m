Return-Path: <SRS0=k5Qg=4P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF54DC3F2C6
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 23:24:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DBC2469C
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 23:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ON0nfs55";
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="InN3ZcMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DBC2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mind.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B724516D1;
	Fri, 28 Feb 2020 00:23:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B724516D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582845871;
	bh=hx+GX+Iy7IL553B73dRW6/Gg4CzPnCuLPJ7xvYTq1W0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ON0nfs55DsC3b0Eg5CzxClVRSOBFXpAA9r5/gJti//NaNZ3YnCATz9F9TyqTqTNKs
	 lqe4RlJv5uTAtl+W/ceIYySE3UV7LzJjz3rE6QzzlKZoYRUOPa2LKZ/SIL5Ei+is+M
	 3VFxJYbIQymmz3GkahtrJlkzi3U66yQSkET3R07o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EF86F8013E;
	Fri, 28 Feb 2020 00:23:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E3A4F80142; Fri, 28 Feb 2020 00:23:40 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 524B2F80125
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 00:23:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 524B2F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be
 header.b="InN3ZcMi"
Received: by mail-ed1-x543.google.com with SMTP id dc19so1080555edb.10
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2020 15:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mind.be; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aiZUjj45ZkIbFbmPHkA0Gr3MtdfUJB7Jll6EsdrLawE=;
 b=InN3ZcMixv5JSf2ze1xJER+NWQJStsea1eZ1itx4hKWB8xCEWWdFZ7o/Pf2yoXskE6
 mE0Erltzw+2exUg6te3udEJ50EWBXY5P+i7kCJ2YiBYeFirVOC26m7uOPdjv1Gjjg0Nw
 kcfLbBO1wpcujlvegNhyYCzLgNj51gGcK/nw4x6xg/Xfoe7sXsxgIUt5dTBJPPW+6VZ4
 Tw1vLCYdBcLm3b4d1imxLZWTVUdcoTcwiMrHnWD7QnIcUogRCqKm0fLUWWiriKckDRHN
 X0xK8lv1aT/Y/8S/E4XWujl97Pj6ACCt9dUqHJgIu3VrOaku2uYar0SSA8Ypz0tosUKw
 gOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aiZUjj45ZkIbFbmPHkA0Gr3MtdfUJB7Jll6EsdrLawE=;
 b=YSC9Reh8bbgKdnHpuuJfMSeh7NeAH7GNDFtMsN915aoycKIlGKAeZQtXY4N9DJdWAU
 WnE5glcKB4WkwAfcCcuBP333UXvZ6tk+4AWrSMBEDKdaLGI4eWPEwPqmX1KdSpFDTWfv
 HHQEodVHMx4d1Kp64jls3bgFmqvVyKD++boLoHS1MRgpgQnzoAZVVYI1Qkij5CREXLpS
 RsZtgeuK1G2LDzwCpBEdy4W+s2OuhdV7m3VQN8yM3mk8Sz19FkZOuEFiMq2upZPHaVRN
 iyyP261oB4j30zZj5u9Y+Ir21F1nLx1HLM5FL8q6e12Fjx9DHJTrI9vqwjHs8FXXxRFl
 4k0A==
X-Gm-Message-State: APjAAAWqxXWF0i6APdQZoxVpJI5SSphhKZkA/9Hp2bNrmAZ7Z5fB36IK
 OjkmIR6MTsC6Z96bYhuY5e9flbb7cq8=
X-Google-Smtp-Source: APXvYqxhciytHaoE6SfFb/60x74C9ArENhzNWJSFtaVEYN2/EbQxCAUg7ho52F4XB7AuGk7C23mGzQ==
X-Received: by 2002:a17:906:2653:: with SMTP id
 i19mr1230626ejc.287.1582845815870; 
 Thu, 27 Feb 2020 15:23:35 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a03f:44b4:9700:886c:841d:dea2:ee2a])
 by smtp.googlemail.com with ESMTPSA id d16sm468117eds.18.2020.02.27.15.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 15:23:35 -0800 (PST)
From: Charles-Antoine Couret <charles-antoine.couret@mind.be>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2 V2] TAS5756M codec driver
Date: Fri, 28 Feb 2020 00:23:25 +0100
Message-Id: <20200227232327.46309-1-charles-antoine.couret@mind.be>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Charles-Antoine Couret <charles-antoine.couret@mind.be>
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

V2 changes:
 * Fix bug in driver itself
 * Change device tree attribute names
 * Convert device tree documentation from txt to YAML format

Charles-Antoine Couret (2):
  ASoC: add TAS5756m driver
  ASoC: tas5756m: Add DT binding document

 .../devicetree/bindings/sound/tas5756m.yaml   |   64 +
 sound/soc/codecs/Kconfig                      |    8 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/tas5756m.c                   | 2161 ++++++++
 sound/soc/codecs/tas5756m.h                   |  351 ++
 sound/soc/codecs/tas5756m_hf3_cfg.h           | 4508 ++++++++++++++++
 sound/soc/codecs/tas5756m_hf4_cfg.h           | 4510 +++++++++++++++++
 sound/soc/codecs/tas5756m_hf6_cfg.h           | 4510 +++++++++++++++++
 sound/soc/codecs/tas5756m_hf7_cfg.h           | 4510 +++++++++++++++++
 9 files changed, 20624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas5756m.yaml
 create mode 100644 sound/soc/codecs/tas5756m.c
 create mode 100644 sound/soc/codecs/tas5756m.h
 create mode 100644 sound/soc/codecs/tas5756m_hf3_cfg.h
 create mode 100644 sound/soc/codecs/tas5756m_hf4_cfg.h
 create mode 100644 sound/soc/codecs/tas5756m_hf6_cfg.h
 create mode 100644 sound/soc/codecs/tas5756m_hf7_cfg.h

-- 
2.24.1

