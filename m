Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D0C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 21:21:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EFA64F03
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 21:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EFA64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 051981678;
	Wed, 24 Feb 2021 22:20:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 051981678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614201674;
	bh=SD9+T49hD4SPwHocwKOaLmrs/yb/96450bW1bQrwNds=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G1r5DgT4cfcGDoRtLLaGPkYxx/GYSrNHVV986/UCU7QVqABYhU2NkOUim7qq4n/qU
	 GFlSNpSxSUZTboPKxKy5ZPdLN2L0NGSAf/HmpUvE5JZ2t3DNwP6OfQ7DpSF9EKstt2
	 o0QcsWhK6WzNaFaD/uOfoLI1viLzf05EV9Yb+OB0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96A44F80161;
	Wed, 24 Feb 2021 22:19:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35B5FF8022B; Wed, 24 Feb 2021 22:19:32 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74860F80159
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 22:19:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74860F80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Mf/dFfVr"
Received: by mail-lf1-x12a.google.com with SMTP id f1so5282921lfu.3
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WjXyN2YZhZ2XF11j3DNqBy4PmqPHJZAyQHRBelDop8I=;
 b=Mf/dFfVrOfzHj93+e4gTrMtBgfAmwGs5R4wmdk9ygWQAh19ZpM73kAfxio4mvv1ftS
 AKvPy2YUDn9u/Y1Ty/Zk1jr7LSXu2mXgfOfIrd5rTla1xn0lx829CZ7Hs9xL6/kTFaqy
 sdyauTkVwGWIYqyKxHwJsr1DxaIy/Iy33Zyb/v0VXnZF9NP5QrrSmpKgN3ZuWOywnQPL
 eUNvQoAFWYNlOPODjIGyu95OcnP6BSXIor8s+u31eoDo1GzrakUm7m5RRonIdTfsFGdR
 O9WB85Va7RvaD0g/MqBJFcyuusmAnxuCXXICStv3DN79GiSwaPc2mu93FLdTbkp1fBWH
 sgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WjXyN2YZhZ2XF11j3DNqBy4PmqPHJZAyQHRBelDop8I=;
 b=DhX1dLp7EmPdJ/iwhA3FJyzCl1qHbv7ZSxNzbwCg/buYyZQT9enEdHy1uSUYsv5va3
 C6MhTmRwm67ogR/c9E2/qa4OTkk5TVf3/uKCQGqYC2iNVXBNxn0eL5ksHGHceJgu737N
 flsA8Wuggf53eDDe8E1HRPBgSUMM+mc8bhpfobIgaVM0FN8uQGVRDeWgHiVOB/s4IYas
 4wSmtOMGiWJ0Z1+vrQgOeKmAq6Jc4tsYK23vl7Em49ZSJ+ImdcLM/XggXcaOgf0UAlw5
 +yjYkO4832qfoIUTKAdoVQnvEKsS09btl9iiRfTofa1PfrBmnyHjtzUOiFWgMdkRyB07
 SWTA==
X-Gm-Message-State: AOAM530frFHy3yq4EgwF0KOzPw4ORYZppaqXSLklIbkLIoMBH/M6SNYX
 fFJsGoxFSDsYNxPWbTryuCY=
X-Google-Smtp-Source: ABdhPJy8+vyE96eTWkPeG29uK18NtTKl+8CUKxn5wfqxakdR1h2RLFaBiSIC5eXBefHN7fY1NPiI4Q==
X-Received: by 2002:a19:5505:: with SMTP id n5mr19598230lfe.401.1614201568154; 
 Wed, 24 Feb 2021 13:19:28 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se.
 [98.128.229.129])
 by smtp.gmail.com with ESMTPSA id w26sm717116lfr.186.2021.02.24.13.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 13:19:27 -0800 (PST)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 3/4] ASoC: rt*: Constify static struct acpi_device_id
Date: Wed, 24 Feb 2021 22:19:17 +0100
Message-Id: <20210224211918.39109-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
References: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, linux-kernel@vger.kernel.org
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

These are never modified, so make them const to allow the compiler to
put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/codecs/rt1011.c | 2 +-
 sound/soc/codecs/rt1015.c | 2 +-
 sound/soc/codecs/rt1016.c | 2 +-
 sound/soc/codecs/rt1305.c | 2 +-
 sound/soc/codecs/rt1308.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 098ecf13814d..6877be5f36b9 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -2151,7 +2151,7 @@ MODULE_DEVICE_TABLE(of, rt1011_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1011_acpi_match[] = {
+static const struct acpi_device_id rt1011_acpi_match[] = {
 	{"10EC1011", 0,},
 	{},
 };
diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 501cc45240b4..3cd967ae999d 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -1121,7 +1121,7 @@ MODULE_DEVICE_TABLE(of, rt1015_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1015_acpi_match[] = {
+static const struct acpi_device_id rt1015_acpi_match[] = {
 	{"10EC1015", 0,},
 	{},
 };
diff --git a/sound/soc/codecs/rt1016.c b/sound/soc/codecs/rt1016.c
index 483375fc16ca..c14a809da52b 100644
--- a/sound/soc/codecs/rt1016.c
+++ b/sound/soc/codecs/rt1016.c
@@ -623,7 +623,7 @@ MODULE_DEVICE_TABLE(of, rt1016_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1016_acpi_match[] = {
+static const struct acpi_device_id rt1016_acpi_match[] = {
 	{"10EC1016", 0,},
 	{},
 };
diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index 4e9dfd235e59..16aa405fb8f0 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -975,7 +975,7 @@ MODULE_DEVICE_TABLE(of, rt1305_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1305_acpi_match[] = {
+static const struct acpi_device_id rt1305_acpi_match[] = {
 	{"10EC1305", 0,},
 	{"10EC1306", 0,},
 	{},
diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index b75931a69a1c..76e65844543d 100644
--- a/sound/soc/codecs/rt1308.c
+++ b/sound/soc/codecs/rt1308.c
@@ -790,7 +790,7 @@ MODULE_DEVICE_TABLE(of, rt1308_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1308_acpi_match[] = {
+static const struct acpi_device_id rt1308_acpi_match[] = {
 	{ "10EC1308", 0, },
 	{ },
 };
-- 
2.30.1

