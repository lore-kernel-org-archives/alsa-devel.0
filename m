Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD224FA3728
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 02:51:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3325F21928
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 02:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cMxVipaL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWe3W8J0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3325F21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46070857;
	Thu, 17 Oct 2019 04:51:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46070857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571280715;
	bh=kETRciSGEfyjpMEF18e7t7inOsdiW5/uFFJXqjoAgC4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cMxVipaLGV5YHIURfsW7M4cjYNLI4WmIkxUpx4E1jPucinW+whP4qPgpgu4ELu63a
	 nIlqtsUT9LoV/Ac/E799nqMeSJGPyiMD8B/pVoNK/dijcX3aIuW4SLN7RCOV/zmFan
	 FeYV4m5Pd07nog34Y9Izixj3DyyjgPvKhsrCCPX0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51246F804A9;
	Thu, 17 Oct 2019 04:51:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F003F804AA; Thu, 17 Oct 2019 04:51:02 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43496F80322
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 04:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43496F80322
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WWe3W8J0"
Received: by mail-pl1-x643.google.com with SMTP id q15so364138pll.11
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 19:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZBH7etPDsYjgS5BhMdpaKPc/Crn0//m1aMzm71ODCNQ=;
 b=WWe3W8J0p2jYm3Jgp8uyqXVx2DXPc5xEMRUw5652KX5FUo9zGfgs/FhgucBzo3mxth
 EL8GDPepsOkB/9w5yAg6FkZ3r3NnQNhMOFAMDu6HMehgah4+nhktKEw5nJiqhzLR4BzV
 I2mCIKX3mYS2SySi65+P6T9dYe2NombsqUncLakU2mU+mqYN7hDBwWCkiLgrnvadeGM1
 mMPKElo8K4+u6uxzM3cCnL9mNuTR3tQzZ9A//viv/TRZXnexdjG3CiA58RhpLnxJFK7d
 6baBx9RdOcV269dv9B+x5nqdY2/aUMJU/yTOUNfjtIDbtQ98FWAKJZb4MiFXoZFbKxdx
 BTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZBH7etPDsYjgS5BhMdpaKPc/Crn0//m1aMzm71ODCNQ=;
 b=Vy4YJdz07eex1NXMwWM90/Dl8crX+AvV246bYN23t0UbNqjuWuDDpUF6z7EUEdZq02
 FnUnKCdu3yaaqX7qTvOCTKwCWnCZVPIt3R2pZvWrAPA5g4aRVdACu32fxpzJfNmGHCdg
 U9CHv9tVqG+IDdccgjvCvbvx67GRaiGS2yoJ7+UxzJUtZ7bBGXF5TbJyqYYpAg25RTXb
 ChSBS7HaMS6zgFh/93Ir3buGD/fp/i2+onxYd5SNgR7Z5vfTOxh+2yNPZkWeCis4ZwGx
 JqQYXbDA3vsv27a+GekWdLOBv9NoOwkrUSM5O3JG3cXzjyykrjQNB+oQz5QhLQ+aQ9GV
 J5lg==
X-Gm-Message-State: APjAAAXcPgOATOwQg7iFJDD+hqHQJi/HBd9kZRNp5jSym+vo4Eq3NjAx
 u77iV6R27ks27PoKMuzsuKk=
X-Google-Smtp-Source: APXvYqyDe3E19e8X61V/mZ1VQbFs6VrITm5+ugiO4YwKQ5l7WNcqzD/ArSWMhPEL2ky6Z6hjtQDL+Q==
X-Received: by 2002:a17:902:8f83:: with SMTP id
 z3mr341484plo.190.1571280657315; 
 Wed, 16 Oct 2019 19:50:57 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
 by smtp.gmail.com with ESMTPSA id m4sm530714pjs.8.2019.10.16.19.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 19:50:56 -0700 (PDT)
From: Chuhong Yuan <hslester96@gmail.com>
To: 
Date: Thu, 17 Oct 2019 10:50:44 +0800
Message-Id: <20191017025044.31474-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Chuhong Yuan <hslester96@gmail.com>
Subject: [alsa-devel] [PATCH] ASoC: Intel: sof-rt5682: add a check for
	devm_clk_get
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

sof_audio_probe misses a check for devm_clk_get and may cause problems.
Add a check for it to fix the bug.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index a437567b8cee..6d15c7ff66bf 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -576,6 +576,15 @@ static int sof_audio_probe(struct platform_device *pdev)
 	/* need to get main clock from pmc */
 	if (sof_rt5682_quirk & SOF_RT5682_MCLK_BYTCHT_EN) {
 		ctx->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+		if (IS_ERR(ctx->mclk)) {
+			ret = PTR_ERR(ctx->mclk);
+
+			dev_err(&pdev->dev,
+				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
+				ret);
+			return ret;
+		}
+
 		ret = clk_prepare_enable(ctx->mclk);
 		if (ret < 0) {
 			dev_err(&pdev->dev,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
