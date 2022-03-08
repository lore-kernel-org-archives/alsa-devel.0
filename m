Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAB3C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 01:41:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95D261751;
	Tue,  8 Mar 2022 02:40:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95D261751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646703687;
	bh=i5/8W6P0KQvpDq7ttaGTvsmVn8Fa376zv+isnKt/73A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PU25lDsjw6rQo0J7nbtK0BLfkDB62akNrNRXxpSqsX2tgcBpbl2TdCsRV0hGa/qSq
	 wlhLeR58wzNyXfWToN9+WaOyPl/QV6uo+C/HAifY3WPSyjV6c2KcFS23k9sMHjAdg2
	 xAak/tDVGPQkQ+ewqNzmyNz+MnJDsfZdR5Qj4JwA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CEB0F80132;
	Tue,  8 Mar 2022 02:40:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEC34F8013F; Tue,  8 Mar 2022 02:40:33 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FA7FF800D1
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 02:40:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FA7FF800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BqC3IovN"
Received: by mail-pj1-x102b.google.com with SMTP id b8so15725243pjb.4
 for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2022 17:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2oZHqNig67lQrBY101pOAHHtLLvXMV3c8bnYL4oUFgs=;
 b=BqC3IovNxG0EX5R6eBwELil4WePyK5xpcSbZKRaGDvvWQv34opW72yKZwwI0ZERwOy
 +q3qkTj8qt2V2lOoPUQusa1YS2V2olRuJFZ4SBpb8q1CVMrRLUdR9981BNODggbtVCme
 dE/RoJ4lXkgCw592blfxLHs1wuvI7YBy+YUdQ6cvp5VtrmI5IBtsaWat8+olN5zakUjC
 7dolRIi314WCbw8yMDCVQ8eyH0JLtoPmwWweeGUHBeui/Y+MmyOMZQ/KAFbsolZcm7fa
 HVxTYqIyWcebbu0sqMVq6Wx5S32fyUmQzMNEqbKDyV1n0YXiZ77VTcOj6jOvPTKgBMSh
 dmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2oZHqNig67lQrBY101pOAHHtLLvXMV3c8bnYL4oUFgs=;
 b=AfatNpVu0zWxpTRhY9sBwCCuNjggNLOLED2e5x9KdocfLotn1t+qRGuL1vMACOTLdl
 7ihj5y5RXrPKIxFSeyryKIBm7/5DBmUtWVp+xlsyJLB6SOnUY2aSF9SITPEMY6PqsX+L
 czQjcglPppm3Rj145BBEHWPjSZx1fdUJVhsfa6LybrNlnX0X57yXfgdVovbK8PuOHqjt
 gIl9RTk6Ze1MCpvq18dXqzkwRkLXnuKv3qGCWD1bDmO9RljbvJmkng6xaRx2kVqXDXX8
 nlN8gwXyOjTbHywrTxD9Ehia8q5vCdgCiTIR0Z6VmOEj0TY/r6v1EFSOJBtiZKuHXBmX
 Mb2g==
X-Gm-Message-State: AOAM532AiuU+KfgfUGicu+d3zbHUF2dhnTcMvqU0+gekrXY74wko0QkO
 pgd0mfdC4RKPYBW1ZfD/57Y=
X-Google-Smtp-Source: ABdhPJxEA3atALbfBSMj03rRMPNFxv4vBrK8TkDMyB2LCuJkL3ERSbUrRspo08Cewso0/CaU3sS9Og==
X-Received: by 2002:a17:90a:7e95:b0:1bc:5d56:8d4c with SMTP id
 j21-20020a17090a7e9500b001bc5d568d4cmr1989175pjl.93.1646703623972; 
 Mon, 07 Mar 2022 17:40:23 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
 by smtp.googlemail.com with ESMTPSA id
 e14-20020a056a001a8e00b004e136d54a15sm17858175pfv.105.2022.03.07.17.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 17:40:23 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Florian Meier <florian.meier@koalo.de>, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: atmel: Fix error handling in snd_proto_probe
Date: Tue,  8 Mar 2022 01:39:48 +0000
Message-Id: <20220308013949.20323-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <582c39ac-3099-d54f-5de3-d54a4ace0a04@microchip.com>
References: <582c39ac-3099-d54f-5de3-d54a4ace0a04@microchip.com>
Cc: linmq006@gmail.com
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

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

This function only calls of_node_put() in the regular path.
And it will cause refcount leak in error paths.
Fix this by calling of_node_put() in error handling too.

Fixes: a45f8853a5f9 ("ASoC: Add driver for PROTO Audio CODEC (with a WM8731)")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
changes in v2:
- remove extra line.
---
 sound/soc/atmel/mikroe-proto.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/mikroe-proto.c b/sound/soc/atmel/mikroe-proto.c
index 627564c18c27..ce46d8a0b7e4 100644
--- a/sound/soc/atmel/mikroe-proto.c
+++ b/sound/soc/atmel/mikroe-proto.c
@@ -115,7 +115,8 @@ static int snd_proto_probe(struct platform_device *pdev)
 	cpu_np = of_parse_phandle(np, "i2s-controller", 0);
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "i2s-controller missing\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_codec_node;
 	}
 	dai->cpus->of_node = cpu_np;
 	dai->platforms->of_node = cpu_np;
@@ -125,7 +126,8 @@ static int snd_proto_probe(struct platform_device *pdev)
 						       &bitclkmaster, &framemaster);
 	if (bitclkmaster != framemaster) {
 		dev_err(&pdev->dev, "Must be the same bitclock and frame master\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_cpu_node;
 	}
 	if (bitclkmaster) {
 		if (codec_np == bitclkmaster)
@@ -136,18 +138,20 @@ static int snd_proto_probe(struct platform_device *pdev)
 		dai_fmt |= snd_soc_daifmt_parse_clock_provider_as_flag(np, NULL);
 	}
 
-	of_node_put(bitclkmaster);
-	of_node_put(framemaster);
-	dai->dai_fmt = dai_fmt;
-
-	of_node_put(codec_np);
-	of_node_put(cpu_np);
 
+	dai->dai_fmt = dai_fmt;
 	ret = snd_soc_register_card(&snd_proto);
 	if (ret)
 		dev_err_probe(&pdev->dev, ret,
 			"snd_soc_register_card() failed\n");
 
+
+put_cpu_node:
+	of_node_put(bitclkmaster);
+	of_node_put(framemaster);
+	of_node_put(cpu_np);
+put_codec_node:
+	of_node_put(codec_np);
 	return ret;
 }
 
-- 
2.17.1

