Return-Path: <SRS0=u2Q7=AV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C34DC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:27:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0411720720
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hxXKIPRI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BKscopTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0411720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBF2E1658;
	Fri, 10 Jul 2020 07:26:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBF2E1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594358837;
	bh=2UqRbmC/xGW5fDKLDLFVu+Z5aurK6jXm2JakoKJIyEM=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hxXKIPRI8gqmYsIid8iLyCafckBADgJyYnOzf3Kpj4JOSL3EHu1Gn9bGJlfbrTBH1
	 kr+QkpWDCLRaH4OS36DmAmCz/RROfraf+3HxvfBSrwMOXE3x3lfPU2r/YTtyflTw+r
	 V5bf2j0o8q0KOdRFqzh2ha1c0t+thbq/kLVB7QOQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40434F80258;
	Fri, 10 Jul 2020 07:25:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D49BBF8015C; Fri, 10 Jul 2020 07:25:30 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B37E3F80112
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2020 07:25:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B37E3F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="BKscopTz"
Received: by mail-yb1-xb49.google.com with SMTP id w35so5781327ybi.16
 for <alsa-devel@alsa-project.org>; Thu, 09 Jul 2020 22:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=waFmwNjvn8zrzF+MflfsEtX07GKV6zTcqXH2BQIDo6I=;
 b=BKscopTznRI/6PlxNEk0SE0fxVRhoo+fn7dYCuemGdOZIADZEwhPo+ULx0QJjgfT+7
 +PpgH+n/5j3YZS63+Z1hnzoLJIPmPncek9CugDTRvHQ23oS3U5GCn6/elW1K2CnAzUtE
 Ud4kLm8bieJUsuWXMAKjtzaRMe2DKNe6dkj/hIPYueVn74t5rH+wd0V5VmrhoO4SCVQ7
 TveVFJ9J1ykqLXcMNWycZAYCDgE07/HDR0qsBhiwTJPekKdVw+aiiIfFimfAzgA4TUwp
 cNS3YrzX1BVIz4dqspdVMhiPFxB5jkBoDBDQ3BBS01WiPB/1O5eds/f/ZGZMOar1Tz+4
 W6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=waFmwNjvn8zrzF+MflfsEtX07GKV6zTcqXH2BQIDo6I=;
 b=JGsxDPuwxSE3HGWoW/amltp3wMfk5PAOYeb7/5enHufujlRR3hLBTFn5le5Hs+1T42
 HKZcna58rzCDDcg0ZGpZzpfMFy78Gey9KNUKl5OdFOsjtQZm+Td4awB15/kN8/N0YLgJ
 DGNr8NSHcD2Av49Zdtm5ohCp0C5JMY61ic/c3kIXob+pESZ+ngTkWamh+y6zk8/KbjF5
 MSaZBWGv9z/Wgz9w9xZuTgccl1qkRGAE0p7kTsIPafs1Yk260xs7nZaCRRouXurEQwfe
 uCyddO4EXI13+AoElWVR4urB/0L73qGrHsr5+gT56yh6M64rBDP42Dax/UsVaS2f90rC
 SMyA==
X-Gm-Message-State: AOAM531tPeuPOl9BnKeFclxgp9yzqiflA+XTITqkFsCOBStep39sfpXu
 qelF7315A5QEIdegm+PCm99hnZKuQuoj
X-Google-Smtp-Source: ABdhPJwP7e8k+tjpxgJCNtpdCpHvOKoiQ2NdP3VBQyiLvLA0NAeFA8ZUuQe5WMXbfnvgbYoF7V2Yrys14mtZ
X-Received: by 2002:a25:abd0:: with SMTP id v74mr23431860ybi.222.1594358721171; 
 Thu, 09 Jul 2020 22:25:21 -0700 (PDT)
Date: Fri, 10 Jul 2020 13:25:01 +0800
In-Reply-To: <20200710052505.3664118-1-tzungbi@google.com>
Message-Id: <20200710052505.3664118-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20200710052505.3664118-1-tzungbi@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 2/6] ASoC: mediatek: mt8183: use hdmi-codec
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tzungbi@google.com
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

Adds DAI link to use hdmi-codec.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 964f2f821782..c375e9f91a34 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -258,7 +258,7 @@ SND_SOC_DAILINK_DEFS(i2s5,
 
 SND_SOC_DAILINK_DEFS(tdm,
 	DAILINK_COMP_ARRAY(COMP_CPU("TDM")),
-	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "i2s-hifi")),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 static int mt8183_mt6358_tdm_startup(struct snd_pcm_substream *substream)
@@ -562,7 +562,7 @@ static int
 mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
-	struct device_node *platform_node, *ec_codec;
+	struct device_node *platform_node, *ec_codec, *hdmi_codec;
 	struct snd_soc_dai_link *dai_link;
 	struct mt8183_mt6358_ts3a227_max98357_priv *priv;
 	const struct of_device_id *match;
@@ -583,6 +583,8 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 
 	ec_codec = of_parse_phandle(pdev->dev.of_node, "mediatek,ec-codec", 0);
+	hdmi_codec = of_parse_phandle(pdev->dev.of_node,
+				      "mediatek,hdmi-codec", 0);
 
 	for_each_card_prelinks(card, i, dai_link) {
 		if (ec_codec && strcmp(dai_link->name, "Wake on Voice") == 0) {
@@ -626,6 +628,9 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 			}
 		}
 
+		if (hdmi_codec && strcmp(dai_link->name, "TDM") == 0)
+			dai_link->codecs->of_node = hdmi_codec;
+
 		if (!dai_link->platforms->name)
 			dai_link->platforms->of_node = platform_node;
 	}
-- 
2.27.0.383.g050319c2ae-goog

