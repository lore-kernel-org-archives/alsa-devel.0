Return-Path: <SRS0=PVpb=XA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B98C3A5A5
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 04:04:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5B420674
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2019 04:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KZUSCAHl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlWHaWw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5B420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C44DA165D;
	Thu,  5 Sep 2019 06:03:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C44DA165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567656251;
	bh=twVyJkFZ9dNb6AQxOIo+4TOh9Ueq3ZHxKfOBmtQMujY=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KZUSCAHlntC6o4D8T+ndgfnqVMlxstRyRgZOXPONiRSdCIcnGL2mpGbWg/MBDvD33
	 +7VeMEGDgmJb1KKiJ9Of1NMki1cKKI7uZGVdpJIqntQNc/l0keYEdTPFNeiEElv4uF
	 cmyeXH0kyrlab5U2xO5nQZteQ9A7d6WYQ0Q1oQjc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FCECF803D1;
	Thu,  5 Sep 2019 06:03:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E933F80448; Thu,  5 Sep 2019 06:03:19 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DD32F802DF
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2019 06:03:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DD32F802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="UlWHaWw3"
Received: by mail-pg1-x544.google.com with SMTP id i18so606305pgl.11
 for <alsa-devel@alsa-project.org>; Wed, 04 Sep 2019 21:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=gzTkO0Rbhbc6qGDT4uIsvz+/20vaG5J88mBFRCtZ1I0=;
 b=UlWHaWw3ysvzZNAgX+b35OI9+m0ei8mMYZmwfZkhVK967RNE5uj2MIBkIHRATZ5esw
 qb2hPWTAVy6dFfKt9um30IWo4TxlIZ53AIWY/28YO0JO4StEDkqmHg80vf+RH6jcQLEz
 ZWb0ozANSR8EuLNR2PzNS6phOTLdfV9S/Q/P/YNrtoXg45wfaFcNPw+0BI/TIMwWp3WN
 kbyD3hUtDym4qEsogP3jw/HeyECxPiimveggDTcLyrotnFzwHZ7I9jVvypxJyOSQsYAS
 vX2rANBi1fBc+TFWVqqG5PhXk53W73VDFlESbnWLTqIV3+vpAm33Y01DXzE4l1o+yOkh
 G2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gzTkO0Rbhbc6qGDT4uIsvz+/20vaG5J88mBFRCtZ1I0=;
 b=UcHXIt8HMSQI4vRECMoO/mjVOaHwrxRdJENcRML7Ijy0U9vF/ZqB3TFofKDCpUQNGw
 zsst0ZHuaRXDFyPCLWIOGTrYHg/7OiD2UdtW/Frn+L0qPoiC0zLsyK4dphjy8n9tcazj
 NzkMnLnUThFNOLUVlbgus5SEr0SQj6Z/Ry2irAIAPKcjJdjo5oUobN57mGReb5RPEDNN
 DI3+PJzXDz2SOBKuO1UGgmCABP98hAMHiPROeJQBCQwHSEHhnNG57FjMgFvD6uJV+WF8
 xi4v/rikbNTRAw1G2TqGxRMGwu3OdqSnLVoBeFJGiRGGzUbZWGZrtgCgSh/7i76/9j6d
 kxKQ==
X-Gm-Message-State: APjAAAUyCsvfwtD9PqJSN6XnmqG5PxRyq1/eBL+s1YaEwxGar8JQT46a
 4c2lghUIwHDCkHY7S6LjWjpeWA==
X-Google-Smtp-Source: APXvYqyzIkvz0yA2lrEI0RaVsZGYFyE3s0khoYRmNK/psHtkaYkobCO80VWq1O/SIMOTnPn49zIaiQ==
X-Received: by 2002:aa7:8a13:: with SMTP id m19mr1324958pfa.228.1567656190065; 
 Wed, 04 Sep 2019 21:03:10 -0700 (PDT)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id u9sm498058pjb.4.2019.09.04.21.03.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Sep 2019 21:03:09 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Patrick Lai <plai@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date: Wed,  4 Sep 2019 21:03:06 -0700
Message-Id: <20190905040306.21399-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ASoC: qcom: common: Include link-name in error
	messages
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Reading out the link-name earlier and including it in the various error
messages makes it much more convenient to figure out what links have
unmet dependencies.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 sound/soc/qcom/common.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 2c7348ddbbb3..6c20bdd850f3 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -53,12 +53,18 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		link->num_cpus		= 1;
 		link->num_platforms	= 1;
 
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			goto err;
+		}
+
 		cpu = of_get_child_by_name(np, "cpu");
 		platform = of_get_child_by_name(np, "platform");
 		codec = of_get_child_by_name(np, "codec");
 
 		if (!cpu) {
-			dev_err(dev, "Can't find cpu DT node\n");
+			dev_err(dev, "%s: Can't find cpu DT node\n", link->name);
 			ret = -EINVAL;
 			goto err;
 		}
@@ -66,7 +72,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		ret = of_parse_phandle_with_args(cpu, "sound-dai",
 					"#sound-dai-cells", 0, &args);
 		if (ret) {
-			dev_err(card->dev, "error getting cpu phandle\n");
+			dev_err(card->dev, "%s: error getting cpu phandle\n", link->name);
 			goto err;
 		}
 		link->cpus->of_node = args.np;
@@ -74,7 +80,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpus->dai_name);
 		if (ret) {
-			dev_err(card->dev, "error getting cpu dai name\n");
+			dev_err(card->dev, "%s: error getting cpu dai name\n", link->name);
 			goto err;
 		}
 
@@ -83,14 +89,14 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 					"sound-dai",
 					0);
 			if (!link->platforms->of_node) {
-				dev_err(card->dev, "platform dai not found\n");
+				dev_err(card->dev, "%s: platform dai not found\n", link->name);
 				ret = -EINVAL;
 				goto err;
 			}
 
 			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
 			if (ret < 0) {
-				dev_err(card->dev, "codec dai not found\n");
+				dev_err(card->dev, "%s: codec dai not found\n", link->name);
 				goto err;
 			}
 			link->no_pcm = 1;
@@ -110,12 +116,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		}
 
 		link->ignore_suspend = 1;
-		ret = of_property_read_string(np, "link-name", &link->name);
-		if (ret) {
-			dev_err(card->dev, "error getting codec dai_link name\n");
-			goto err;
-		}
-
 		link->nonatomic = 1;
 		link->dpcm_playback = 1;
 		link->dpcm_capture = 1;
-- 
2.18.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
