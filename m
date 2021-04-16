Return-Path: <SRS0=6+tk=JN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07FBC433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 07:13:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEEA61090
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 07:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEEA61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB72D1684;
	Fri, 16 Apr 2021 09:12:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB72D1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618557184;
	bh=lnbmXGKio9qYHCDm0c/IR4TWttlCDZBDAZ8Oq8iv04c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uSDZTc96irq45hMnx6LaPyMfmBYMJrzc82EGwsnq07qy0G2O9AtLJ+Z8fwi07Zj9z
	 Zk8EQCVq6RlEJb8n7ND7+z6fNweCQRjBnczypH4JLmPW2Xp+HNu3XcnSSF2PZ9scCZ
	 eQmqc2JGOc36T1+5OEXDbq77QEAcP44JSePByepk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B64FF80271;
	Fri, 16 Apr 2021 09:11:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 181B0F8025B; Fri, 16 Apr 2021 09:11:23 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3979F80128
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 09:11:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3979F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bREnFIiY"
Received: by mail-ej1-x632.google.com with SMTP id x12so19840576ejc.1
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 00:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W1nsXVYbKk4iy5sxLt7TvvDcW4X+AnalxkH0tuZSNic=;
 b=bREnFIiYl9coe4uVnwp50tyb2JBKqIQ3oFgPk/ztIofEQcCzle7w851NBHvnLMtCB0
 LU4xW1le5Put/IhkoNY/wWolFg5xiFzbE9J1giTtYLvTv5NiFKsOjHp3W+uCdI1bg2Xl
 MpzOKKA547jTAR4WUH7s5cNcb/Fz98Pby8/eMGz3Migv8+ORMJo4VDS21wPCjGKpJhGx
 VV32lkTk0drV8fAnrTftSPad16fyIykcxphAtRRhU9x4Sa4JEwMDyLanLZyEmYXiod8o
 BO4IjRLGjp4a7p99F4uoy6IdlppfEh+E3Iurris75rqwesOlq9hPpdSJKK57UoRcX3rJ
 coFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W1nsXVYbKk4iy5sxLt7TvvDcW4X+AnalxkH0tuZSNic=;
 b=kC3u4C5uc9uEKadyFfYc1Zo/FBWB+NQGZkjpOaGrSwiCv+JpzsfY0QrtmRY/ApwQJA
 VbQwdLQCcF0oK321zleFczlluJ0yClfo72FPK49qVuBUhfUa2vn01nJ17AOQmdIpWQZP
 ONxaKv9r95hEbgQMrcc5LJEv8t+rW4FnQXx6gtiP0BmkNijWZIZzdaeLV/E+aOVUo4j4
 v351PjTp01IJ2I3bp+zKnxlb/650D5AD88qwv3SATXVr/iBo2Kj+hIgfR9qfoEfCrWxA
 a4TbGG7OQZbohTihciB/In7qWdPNSiFh77/LDtJjK9M0zBq1FQcHebS7B7aXxWuibsqS
 FYWw==
X-Gm-Message-State: AOAM531rHKy7lUVPKRjY4+BLAUZ7nh68KEsl4kHnD2XhxDaUiydV9K7l
 SlcAA4Cwtowba9KbvZZCSSsVPqarY7Q=
X-Google-Smtp-Source: ABdhPJyhfSMgTGGbG8vxZg7h36lO/yDWjzG2dTHF139BfidXiHusKF2aX/1ruMZo/gMmhTNuQCJbAw==
X-Received: by 2002:a17:907:2662:: with SMTP id
 ci2mr6894506ejc.467.1618557074856; 
 Fri, 16 Apr 2021 00:11:14 -0700 (PDT)
Received: from localhost (p2e5be10e.dip0.t-ipconnect.de. [46.91.225.14])
 by smtp.gmail.com with ESMTPSA id c19sm4382715edu.20.2021.04.16.00.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 00:11:13 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 2/2] ASoC: simple-card-utils: Increase maximum number of links
 to 128
Date: Fri, 16 Apr 2021 09:11:47 +0200
Message-Id: <20210416071147.2149109-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416071147.2149109-1-thierry.reding@gmail.com>
References: <20210416071147.2149109-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Jon Hunter <jonathanh@nvidia.com>,
 linux-tegra@vger.kernel.org
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

From: Thierry Reding <treding@nvidia.com>

On Tegra186 and later, the number of links can go up to 72, so bump the
maximum number of links to the next power of two (128).

Fixes: f2138aed231c ("ASoC: simple-card-utils: enable flexible CPU/Codec/Platform")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/sound/simple_card_utils.h    | 4 +++-
 sound/soc/generic/audio-graph-card.c | 4 ++--
 sound/soc/generic/simple-card.c      | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index fac3b832d982..e318a2d4ac44 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -115,10 +115,12 @@ struct asoc_simple_priv {
 		     ((codec) = simple_props_to_dai_codec(props, i));	\
 	     (i)++)
 
+#define SNDRV_MAX_LINKS 128
+
 struct link_info {
 	int link; /* number of link */
 	int cpu;  /* turn for CPU / Codec */
-	struct prop_nums num[SNDRV_MINOR_DEVICES];
+	struct prop_nums num[SNDRV_MAX_LINKS];
 };
 
 int asoc_simple_parse_daifmt(struct device *dev,
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 2401212281c2..d6d90285967c 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -616,7 +616,7 @@ static int graph_count_noml(struct asoc_simple_priv *priv,
 {
 	struct device *dev = simple_priv_to_dev(priv);
 
-	if (li->link >= SNDRV_MINOR_DEVICES) {
+	if (li->link >= SNDRV_MAX_LINKS) {
 		dev_err(dev, "too many links\n");
 		return -EINVAL;
 	}
@@ -639,7 +639,7 @@ static int graph_count_dpcm(struct asoc_simple_priv *priv,
 {
 	struct device *dev = simple_priv_to_dev(priv);
 
-	if (li->link >= SNDRV_MINOR_DEVICES) {
+	if (li->link >= SNDRV_MAX_LINKS) {
 		dev_err(dev, "too many links\n");
 		return -EINVAL;
 	}
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 1d1c4309b582..59b41019c65f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -484,7 +484,7 @@ static int simple_count_noml(struct asoc_simple_priv *priv,
 			     struct device_node *codec,
 			     struct link_info *li, bool is_top)
 {
-	if (li->link >= SNDRV_MINOR_DEVICES) {
+	if (li->link >= SNDRV_MAX_LINKS) {
 		struct device *dev = simple_priv_to_dev(priv);
 
 		dev_err(dev, "too many links\n");
@@ -505,7 +505,7 @@ static int simple_count_dpcm(struct asoc_simple_priv *priv,
 			     struct device_node *codec,
 			     struct link_info *li, bool is_top)
 {
-	if (li->link >= SNDRV_MINOR_DEVICES) {
+	if (li->link >= SNDRV_MAX_LINKS) {
 		struct device *dev = simple_priv_to_dev(priv);
 
 		dev_err(dev, "too many links\n");
-- 
2.30.2

