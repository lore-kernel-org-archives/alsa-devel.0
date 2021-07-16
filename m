Return-Path: <SRS0=MRBS=MI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7033EC07E95
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 10:58:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B71613EB
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 10:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B71613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5DB8167A;
	Fri, 16 Jul 2021 12:57:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5DB8167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626433104;
	bh=2r4BMFvLRbdQE910ZRsYrfJFWrGRC+kEoFb/2TIY0j0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g6KQlpawa2SA6nodbllKT89HnvJY/WUv8hhgEJJ7LU6r9WFb6adFyQGqGdvCrgKy7
	 p9pHM68tvb0QDToSjw1WIqX7FwxOYIo9REL4XafWRyVAhSOJYlRFqJ4ilVemwqxsXI
	 Pq9QKtVEL0mFTin89IJalNUKUlftYktOKEuoV724=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56B4BF80253;
	Fri, 16 Jul 2021 12:57:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A963F800FE; Fri, 16 Jul 2021 12:57:32 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8924F80253
 for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2021 12:57:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8924F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="IMpi2Q4y"
Received: by mail-wr1-x434.google.com with SMTP id v5so11617345wrt.3
 for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2021 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KAhUCNsXSWfZRDY3ZqSKN/6QYUwLLIaCYrx90t45ADU=;
 b=IMpi2Q4ymqicNLeTDCRsArSTOQVqHhq01OkQ6W0l/RotBsxhCY40XXshW156HkHQ+h
 57saFGhRuA46UULo4Lz6TWMX3T1o7FX7BCmTMZuNt/8V0Whwk8uX5rH4kIIhSG6dY4Gc
 mlu4t5inig4r+W4fY6L/qIQbQnSq6JJBfn+snTUYrvOkdQKOvc6IhcT90OJ2IYBD4vC/
 PPpYrqNjw2Vepqiz3IgExKGjd/O2GdGmwHO+MXGj+xUElwJcfkAf9wfKJD4oaugocTGv
 EfXJVECThcbIchFE93a3yhPrIQ2kKayShQkRx1I10m29rZqNj5XZsygE6KorXdRoWZnB
 0G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KAhUCNsXSWfZRDY3ZqSKN/6QYUwLLIaCYrx90t45ADU=;
 b=fqflK8HhjwWyZeo+qv0+dI1/Fr+6o2zAfvBtAOlWhRIFuaikB7rZrqckA1ifNVJPG+
 CtVxLjfmGGUA+XAjlTPBg6YiM5MTbAY4LH1A9Jl41ylK/dq594FHPyhn73E9amda3gZ9
 MeVC5G7fDZ4mp3bA4JDjDDzBENmh7tZoAb1pGjlezvPa2xsTodWn4ubUSQN/cCyJ7ZmD
 BRUIQUbYPqhFbRzmnTS1w2vR8VR5AcbGxzdX13xf9gs1AFEd4jbed9J49wScwSLgi9+M
 U1vWgikcMlCvyPq++qYJCV8xZDZpo6+zoEslUCiwffq+Aasogk/sp+WVFx6klw1LbA3J
 oUyw==
X-Gm-Message-State: AOAM531xUiPJiL7Xk60SpEjE9YqV8KJrAGBE+YnsizDb8o0Vp2EjdonI
 mkWchceDxKvyQny9MnfFb7Yv7g==
X-Google-Smtp-Source: ABdhPJwYvCNuMOmUchd5HMGjwpesSEbSYa09zjLxtV/ThlZI7pel1TfR45CN7tGvT9Q3CnEvQmUoCg==
X-Received: by 2002:a5d:5141:: with SMTP id u1mr11580456wrt.193.1626433041099; 
 Fri, 16 Jul 2021 03:57:21 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id q7sm7815782wmq.33.2021.07.16.03.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jul 2021 03:57:20 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH] ASoC: codecs: wcd938x: remove unused port-map reference
Date: Fri, 16 Jul 2021 11:56:12 +0100
Message-Id: <20210716105612.5284-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com
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

port_map field was added prior to adding static port map support in soundwire.
This makes port_map array in struct wcd938x_sdw_priv redundant and unused,
so remove this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 5 +----
 sound/soc/codecs/wcd938x.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index baa3ba99a48f..e32810902383 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1360,7 +1360,6 @@ static int wcd938x_io_init(struct wcd938x_priv *wcd938x)
 
 static int wcd938x_sdw_connect_port(struct wcd938x_sdw_ch_info *ch_info,
 				    struct sdw_port_config *port_config,
-				    u32 mstr_port_num,
 				    u8 enable)
 {
 	u8 ch_mask, port_num;
@@ -1380,14 +1379,12 @@ static int wcd938x_sdw_connect_port(struct wcd938x_sdw_ch_info *ch_info,
 
 static int wcd938x_connect_port(struct wcd938x_sdw_priv *wcd, u8 ch_id, u8 enable)
 {
-	u8 port_num, mstr_port_num;
+	u8 port_num;
 
 	port_num = wcd->ch_info[ch_id].port_num;
-	mstr_port_num = wcd->port_map[port_num - 1];
 
 	return wcd938x_sdw_connect_port(&wcd->ch_info[ch_id],
 					&wcd->port_config[port_num],
-					mstr_port_num,
 					enable);
 }
 
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index 07b08de4cebf..ea82039e7843 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -658,7 +658,6 @@ struct wcd938x_sdw_priv {
 	struct sdw_port_config port_config[WCD938X_MAX_SWR_PORTS];
 	struct wcd938x_sdw_ch_info *ch_info;
 	bool port_enable[WCD938X_MAX_SWR_CH_IDS];
-	int port_map[WCD938X_MAX_SWR_PORTS];
 	int active_ports;
 	int num_ports;
 	bool is_tx;
-- 
2.21.0

