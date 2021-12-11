Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7878C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Dec 2021 08:25:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3A7C1AD1;
	Sun, 12 Dec 2021 09:24:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3A7C1AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639297548;
	bh=MpCiupqf4g3I4Tpbb9v2jzSDy+n3yoHkMXZzk6fTfME=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XDu5Xu45Lr4aUHXt8TTO791LfDDTrbxfHRgqy966sgttxfcPyeqwihetqhSTtB0Nz
	 ri+4KrTgSNzujdHNq6Es8TgcOzEo5GYZj0IbTzsH+isNDcyBgYNKEA52x1KzaB2aLs
	 T73VuI8KEgEs1+Iqd50erECfhYZd6dM6UnsBdrlU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79F59F80518;
	Sun, 12 Dec 2021 09:23:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD98AF804AE; Sat, 11 Dec 2021 07:58:54 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4028F804AE
 for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2021 07:58:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4028F804AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="NNYzx9Ya"
Received: by mail-pj1-x1036.google.com with SMTP id
 j6-20020a17090a588600b001a78a5ce46aso11041499pji.0
 for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2021 22:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=gS0rNDUvVIV9tNkl78h/S/h2hs4kimVtUAJ2UWN3E+I=;
 b=NNYzx9YaTUXGdPZvdUWZZKbrKM7rpyQVzQdjL/zTHVNkYubyxUE8eERPewh37g9oPE
 rJ6rTeMwgVELYujyJp+qIQWy2dFhKI4pYrlGt48ehzqlqHY9f5sj6I2ctyd5ZDjGaNnH
 TtgCG1j/oxxaFU/eY8aeGcI3cTrLLi2ZHDLOcqGkdsGzndJR/3qzFgLE162tFnDw/Eg8
 Fx/Rjm3N+KW3n2I1WSjEQ0O1G2xyCWcuOdGgCttGU+Maa3oheDilUYmKkDONXc/qejD0
 /1HpZZsJEQNDZsyW0Q+WgcBPirgEnsqXJDNWw3xNP2J6BrXXNCo/GnveZFG5sHwuEAdq
 DNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gS0rNDUvVIV9tNkl78h/S/h2hs4kimVtUAJ2UWN3E+I=;
 b=Ku7sTsBiIhGaO7kAfzFOilUaNPbcJm1GyKqzyKTZYoHjtRRbzkF4CguRSc316vrqbV
 bWfWlvlAaKlfTP2TcwcrSl+gQIQAayTtN1ECQIJq1EddWHgevAny18QXs9BXVgyq5XeJ
 wOgwpfbDm/7FwPWLzIgCEJKpDKfNiPtIz/SLflDm7HbZmEREfFeyQ2WOoF6PUyJlD4+O
 XiLPob2F0hhYaaXAriNdnqavOjGx1w6bl5JhecKilyt6m09NYQO5Jp45rBMVPCFS9O9b
 g/O4nYXx/Mkz0QveI7Jhr8DTT1WUMF21wwzbkp0VddVIYXgJwzFWi2oxxnRtwPBMNohO
 Na+Q==
X-Gm-Message-State: AOAM531mwLjmf07WnPVGEsoacec/H3cB10MYO+1KswDoVgu9kdvriOoQ
 T5bt7mz02V183yjLzvirpYs=
X-Google-Smtp-Source: ABdhPJzdsTpQuL+Is7ao51DxNCu52hYshuHKkA0nKX1SfEk7j0Jo5ur3We8Xv3msiHDMMidBexkiUg==
X-Received: by 2002:a17:90a:909:: with SMTP id n9mr29696435pjn.1.1639205926893; 
 Fri, 10 Dec 2021 22:58:46 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
 by smtp.googlemail.com with ESMTPSA id k11sm5006681pff.6.2021.12.10.22.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Dec 2021 22:58:46 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: 
Subject: [PATCH] ASoC: qdsp6: Fix an IS_ERR() vs NULL bug
Date: Sat, 11 Dec 2021 06:58:29 +0000
Message-Id: <20211211065840.1221-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Sun, 12 Dec 2021 09:23:26 +0100
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linmq006@gmail.com, Banajit Goswami <bgoswami@codeaurora.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

The function gpr_alloc_port return ERR_PTR on errors, it doesn't return
null.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 13598ef5bacb..3e007d609a9b 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -630,9 +630,9 @@ struct q6apm_graph *q6apm_graph_open(struct device *dev, q6apm_cb cb,
 	init_waitqueue_head(&graph->cmd_wait);
 
 	graph->port = gpr_alloc_port(apm->gdev, dev, graph_callback, graph);
-	if (!graph->port) {
+	if (IS_ERR(graph->port)) {
 		kfree(graph);
-		ret = -ENOMEM;
+		ret = PTR_ERR(graph->port);
 		goto err;
 	}
 
-- 
2.17.1

