Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCFEC433E2
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:17:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09494221E3
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rbx6rEC1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RracI24P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09494221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4F2383D;
	Wed, 16 Sep 2020 20:16:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4F2383D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600280249;
	bh=5gJuwir14QZsGlfkRF27Z35Mq1yCjapg43GV4Elxzho=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rbx6rEC16WbIAfVdGuirN2JaAVwPhv4mkK9e9UviI4poUwtz9pzJFdtq32qushvu2
	 AylwaIbPq0fgHgd1rUPE91JwwBgCmIu1bBCXtWoE+77porJae+6SlCq0Ubyqw+sVTN
	 RRtd5AZFdMfPlJZKP/DYCfQvumKgXEQOZ4e0noWY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D2C5F800F1;
	Wed, 16 Sep 2020 20:16:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D652F8015A; Wed, 16 Sep 2020 20:16:36 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C60BAF800F1
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 20:16:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C60BAF800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="RracI24P"
Received: by mail-pj1-x1042.google.com with SMTP id md22so1763945pjb.0
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UiFIrPp4DQBnGtCxEmkSHjKyh1WtbAV+s1rsFBSqEIw=;
 b=RracI24PIbtqBZhGuaJPp3NPwyCDdn8AOd8rWRUPflnPHVdvry0MfFf+SKCCAu0xx2
 YAyqDtA/SxT67abUlFtL1i/GKuW1jLkErjQMQnuxtj72vPwz9IVeY1Hgom5wvFRoPpr3
 0wgMBHSnamI8JtH96vryAz1bVUm2LvoWFr+eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UiFIrPp4DQBnGtCxEmkSHjKyh1WtbAV+s1rsFBSqEIw=;
 b=pVMr5TGbdUlKpBtpWu8Y/40gFNcTcUPXFUFvHlF67aGLG624vmtyFrEAz2DZH0olQG
 OyxtciVb8mGB5aeTZPZ1Q2KksfJBnBUljzKEmCsZ0gZgG/tIjYIdxjmwcF1/8bKypsj2
 KAHpNbooZ0us5hEjkmEa8B7c8+qipi47SPPyvgLSWpkU7CQns+0T+Eeq/4vzZioP2rm8
 j/1ycXlaZFHJdZFmajh2/cApLlbSWQNbr2W4//M/mra5oVGCKkhIPsrqtDxYti5h8I8u
 AAr2tqXSrQxY2pc6kloq9NLEmF9XIVC1eSIL5okKfR7dJd51uwHbvy+AxZqPGge4+Egk
 MJ8w==
X-Gm-Message-State: AOAM531jgShXdqBoYCet+dQ8cPNMN3rk4LCeAM/dJITXPbeyFSz7gsDa
 xL2SaMgACCeYYUiWNyzu5U5d2g==
X-Google-Smtp-Source: ABdhPJxDCMtCerajjQla9DC9/rtMsEm7NoHMyC9ADXn3GWrc7JbhH40Mtb54++bGZ9palI5JY5xuIw==
X-Received: by 2002:a17:902:9697:b029:d1:e598:4001 with SMTP id
 n23-20020a1709029697b02900d1e5984001mr7574830plp.59.1600280182843; 
 Wed, 16 Sep 2020 11:16:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
 by smtp.gmail.com with ESMTPSA id e207sm19091618pfh.171.2020.09.16.11.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 11:16:22 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: qcom: lpass-sc7180: Add MODULE_DEVICE_TABLE
Date: Wed, 16 Sep 2020 11:15:55 -0700
Message-Id: <20200916111545.1.I4c3758817d94c433bafeac344a395e21ea6657e3@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Douglas Anderson <dianders@chromium.org>, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Ajit Pandey <ajitp@codeaurora.org>,
 Rohit kumar <rohitkr@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, cychiang@chromium.org
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

The lpass-sc7180 driver can be built as a module but is lacking a
MODULE_DEVICE_TABLE.  This means it won't auto-load.  Fix this
oversight.

Fixes: 24caf8d9eb10 ("ASoC: qcom: lpass-sc7180: Add platform driver for lpass audio")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 sound/soc/qcom/lpass-sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 167bf2cbc556..a8a3d8f8f567 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -200,6 +200,7 @@ static const struct of_device_id sc7180_lpass_cpu_device_id[] = {
 	{.compatible = "qcom,sc7180-lpass-cpu", .data = &sc7180_data},
 	{}
 };
+MODULE_DEVICE_TABLE(of, sc7180_lpass_cpu_device_id);
 
 static struct platform_driver sc7180_lpass_cpu_platform_driver = {
 	.driver = {
-- 
2.28.0.618.gf4bc123cb7-goog

