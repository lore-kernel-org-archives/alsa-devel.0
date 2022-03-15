Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB15C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Mar 2022 02:33:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46127172B;
	Tue, 15 Mar 2022 03:32:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46127172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647311613;
	bh=aJOgWWRKRdGSiRaesIVdtKAzy9xp+9fF3CNlBCi3so0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U1eOZLTNazfZEUBQ+uzevBoWtij4WHhjMJ3sKan3x8EnzSdAJ5g6m5eb9kJ1GxygK
	 n4zl6Hrryfb+2Mx7dRa/miHef4NXSxjdRaL2ojf9rXH727w4t5pGwB59Bco/68wPwk
	 svSoplapQLnQ8u6a7nE9p834O+xkpZcLvkFe/NIw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A64AF8012C;
	Tue, 15 Mar 2022 03:32:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECEC0F800FF; Tue, 15 Mar 2022 03:32:39 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97236F800FF
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2022 03:32:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97236F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="GTEc8J50"
Received: by mail-pj1-x1032.google.com with SMTP id
 kx6-20020a17090b228600b001bf859159bfso1069597pjb.1
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2022 19:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UisOO7Q5sWcTyT6YGXIaBwA+2hXKA5zA0oioUT8I7D0=;
 b=GTEc8J50ZYn6y/baRDpqB9hxBgnQuXZskdpa3JoDVSVvdYYM7wfVnFY6S8hnEPVohx
 joDYJjS8jnXWq6nqY6ttRVmX2LHgIYLaT0HVT6ZyLyovJgWdinXFX9gfM43cLZwU4vl+
 ePUXEltdKnI5iR8jDAR8LU32uFlP5/BDB/O+jyHrv/iFythb3WNV1aFD2r4YbSgeDsYi
 VdioSeQvK9Vw22hcNhyJGyNTzHRMsvgeAfgHRW2/xW+YGq9/j0F7ZGZ/74wGMX6y+7Te
 Equf0m6AuMHCLgK1Xtoutq4yc3JtaOLGRFvo1y69+8pST22viSiCmVy9nUzZUzmXomh6
 eI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UisOO7Q5sWcTyT6YGXIaBwA+2hXKA5zA0oioUT8I7D0=;
 b=Gdw5vuqh/NAwSHK2s5o+HqDijEYcddcrddrn2nI3GBVEHfEDYk2D/aTVJ6Uop67WSX
 dAFFztA+IFZwLn6nrqqezFgToIy0+2vZgKUEXYOIWa2HTfJmbuFHpX17NWZHbTXIMtl1
 0Uxq09DhCS1FchgpBMKT2Y2aslfZyinAp07ehL+sG5slnL+LcW6hfDvnvvGlbNyem2zl
 ar5zWaLSz1tNXfbgthfOFeltQ50DZP3AqY3fCNAnIjMf+VAXa0yTVv+p5Sj93qcOiLSC
 SI9yblZwxdWXmk242NAD851jK/KNuJS9Ena45rLPLUzZfgTa48ibRYbG3x0lZ0C4RaCv
 UiLA==
X-Gm-Message-State: AOAM533xvfs6UrQbnU5kpUagpjl/abRcAMAKNvu/YuJo87hMJcWmfUFn
 WlswGJ2H6wDoNmk2RgjzobXF3e3v5ik=
X-Google-Smtp-Source: ABdhPJzUWiTgcfMjzsN+iQA9b8xgnqGDJdPduixz6F8CAvVouD8nSKSZmWCti0JMDhaZ5GQA5KNzvQ==
X-Received: by 2002:a17:90a:8595:b0:1bf:4592:a819 with SMTP id
 m21-20020a17090a859500b001bf4592a819mr2084621pjn.183.1647311550493; 
 Mon, 14 Mar 2022 19:32:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id
 l188-20020a6225c5000000b004f715e38283sm21291197pfl.63.2022.03.14.19.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 19:32:30 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To: broonie@kernel.org
Subject: [PATCH] ASoC: ak4642: Use of_device_get_match_data()
Date: Tue, 15 Mar 2022 02:32:26 +0000
Message-Id: <20220315023226.2118354-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Zeal Robot <zealci@zte.com.cn>,
 lgirdwood@gmail.com, Minghao Chi <chi.minghao@zte.com.cn>,
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/codecs/ak4613.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 4d2e78101f28..e4c643724dd9 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -653,15 +653,10 @@ static int ak4613_i2c_probe(struct i2c_client *i2c,
 	struct ak4613_priv *priv;
 
 	regmap_cfg = NULL;
-	if (np) {
-		const struct of_device_id *of_id;
-
-		of_id = of_match_device(ak4613_of_match, dev);
-		if (of_id)
-			regmap_cfg = of_id->data;
-	} else {
+	if (np)
+		regmap_cfg = of_device_get_match_data(dev);
+	else
 		regmap_cfg = (const struct regmap_config *)id->driver_data;
-	}
 
 	if (!regmap_cfg)
 		return -EINVAL;
-- 
2.25.1

