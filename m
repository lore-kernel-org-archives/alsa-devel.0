Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA57C3DA41
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:50:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68594FAA;
	Tue,  9 Jul 2024 17:50:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68594FAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720540226;
	bh=wWw29OtvmtrGUfN54CyphDq2f7EZzv4CB36kBIg/V9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pANqt7gUo0v1P3YvdInhJHYrfRTKxrWaOPVqHhBtf5580I9XWFYxiG+G4zsAniJ9D
	 5ZmBPq5RWM1ZMo/v1QJWyu9iyoOP/jkHsJYWmMYa0oO8Ls0oq337DPPvfXe7scWgVZ
	 4DOiB6mzSRs3BRjgknE6g3yNf3zqTEQZ1yU2Iclc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E1B8F805E2; Tue,  9 Jul 2024 17:48:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A5949F805CA;
	Tue,  9 Jul 2024 17:48:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41D28F8013D; Wed,  3 Jul 2024 18:21:17 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8828CF8013D
	for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2024 18:21:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8828CF8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=dm16fdMV
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a72517e6225so655980966b.0
        for <alsa-devel@alsa-project.org>;
 Wed, 03 Jul 2024 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720023674; x=1720628474;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwodvvh/HkWOmrsQs4/edOtdukbP3CJ9J4qzQghO6GU=;
        b=dm16fdMVD3KGtRFV9dtpA4gdrvd8ioTczz73HQb210k9CJx3UkA9XuZUQsAjE3mjYc
         PhVaC3CohIUczC0BFFrwSDT629A3LDfOPb7s7BZDLqDKj+mSMBr6j982NHM8nDQamGc/
         8K+S1mbD8HTaI6EPEBzqLYH6a8SAwUpLpcZgn8rFHgpv3eahxowxBvE6GCKdo9tXiS+y
         6CNswSmGUs4FJxSJ+F3CCF/oAJTjvba7EzRA8xNvlj8fBp7J8ae/U6aWAILFFJGjtm7g
         HMtjmReppBbRhxWuEtaMvtfG8bSVMcnKjg1k2kWdBkBAVo1H0psQOsnMLgVAFnqeyPdK
         7cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023674; x=1720628474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwodvvh/HkWOmrsQs4/edOtdukbP3CJ9J4qzQghO6GU=;
        b=URqfMlu+CF1qIC4StAIIFWwHiu8Tm9LcQo5Yz3pZ76m7d9W6ekkyLD+lk0Qh7D0vPk
         xjeu+f8BBJuMXgJMD8g7V2f6z239ZUsrA5Q39WFPtkAOJBWvJMEsR2N0KwTwrYXH/3Fe
         FawRk/GTxF5HTga8TNvInkyf3K4I1TAZOb2FRpeR8C0dAzfpBOZ2VkOg6LtoA2NOne2f
         KzQeBjS/5dE9aWN3EFeisHQAD5HNl8OdD0RYiTtYMCWlr+SgX+p9bewaFn6GXGlXejDX
         30iPJGzKbe3MKByD19BiKCNt2w/UXniZiV7BMc8avTyd5Fuiof1mO8YcjJqv9kgnSjmP
         KayQ==
X-Gm-Message-State: AOJu0Ywve3x6YPf7HclFt4vWXTcuM4rdvyrjry/QdWMwkrgj62gwXnYD
	m8gb0Lif34kCnosFl5N5Xi1zBAgGikK5nb+GMIecXzojEFrOryct
X-Google-Smtp-Source: 
 AGHT+IHZgM3bWbhlAUMEeCiCQOK2JuYz8183C2SO08iuwK8/gvUGlFPUko6OaORXVGEjRIaT4kSWxw==
X-Received: by 2002:a17:907:988:b0:a6f:4fc8:2658 with SMTP id
 a640c23a62f3a-a751440b8eamr867471466b.14.1720023673759;
        Wed, 03 Jul 2024 09:21:13 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at.
 [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72b5abddaesm473075166b.140.2024.07.03.09.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:21:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 18:20:57 +0200
Subject: [PATCH 1/9] ASoC: cs35l34: Constify struct regmap_config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-sound-const-regmap_config-v1-1-2e379b0446a7@gmail.com>
References: <20240703-sound-const-regmap_config-v1-0-2e379b0446a7@gmail.com>
In-Reply-To: <20240703-sound-const-regmap_config-v1-0-2e379b0446a7@gmail.com>
To: David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Paul Cercueil <paul@crapouillou.net>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720023669; l=725;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=wWw29OtvmtrGUfN54CyphDq2f7EZzv4CB36kBIg/V9w=;
 b=dEdb0+rv67nGozH1LMpVrMHNNCAfY9i3pohpSZx11pxDJSu5DC06RTAYQiL2lHIhckxs0DcTk
 ImmrF22ZRNBATNS3dWN+xlOxzoswRH9gXSdryprPDOSQeQsMkpgclNq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=
X-MailFrom: javier.carrasco.cruz@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: R24RLY2Z4WMXJBB7XZ6ESYJWZYPZYTY6
X-Message-ID-Hash: R24RLY2Z4WMXJBB7XZ6ESYJWZYPZYTY6
X-Mailman-Approved-At: Tue, 09 Jul 2024 15:48:28 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R24RLY2Z4WMXJBB7XZ6ESYJWZYPZYTY6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

`cs35l34_regmap` is not modified and can be declared as const to move
its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 sound/soc/codecs/cs35l34.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 4c517231d765..e63a518e3b8e 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -787,7 +787,7 @@ static const struct snd_soc_component_driver soc_component_dev_cs35l34 = {
 	.endianness		= 1,
 };
 
-static struct regmap_config cs35l34_regmap = {
+static const struct regmap_config cs35l34_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 

-- 
2.40.1

