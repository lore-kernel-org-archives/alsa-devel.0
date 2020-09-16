Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D8BC43461
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:42:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EA722285
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A/+bJImk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgKuJgB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EA722285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51C881663;
	Wed, 16 Sep 2020 17:41:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51C881663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600270927;
	bh=NQ/CSGEQG55keJ3hDsO6xuVh4+Xe25fWYRWhdJHFF5k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A/+bJImk/Yl2o7I+Hsc34Fl/9XTZivFMi4FleKiAmsGVvgCYn4CAa6yhWtmWdl9c+
	 JY/qK19wY3V17vIjMnsjwzYDK9+Z1rs0pJtf5KVEfGhUGQBnbmCbxsqn4+i58ggKU/
	 2hwZKcRXSldId3D6ldbIbPBCYY2yKxajOXyVuBa4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0D3CF8015A;
	Wed, 16 Sep 2020 17:41:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B948CF800F1; Wed, 16 Sep 2020 17:41:15 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3493F800F1
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 17:41:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3493F800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="cgKuJgB5"
Received: by mail-wr1-x432.google.com with SMTP id m6so7465304wrn.0
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F/O4Z+E6Lm40GO/xNzCmRRf/TExfeeNhj/Pi79dfsiM=;
 b=cgKuJgB5a5Kfj4NMjhkMYKWh3kJysaDVQb3CeziIplZO8Lz5UAI3nxgaWnQCYRB0Xq
 NLFBQ4sxj13YSgWhcSHhtmbFoX07/B9N+b/LQqv7aF7MN25ySr+cSsgoWWmkzF7EMhhP
 Y8b8Df/ylshwEpAiNJgYv60/xL4mm7qTY8BSYTohmlCva8P3G9GQn8kIM0OX13h2UnAY
 2EU6uh5Do8dOhIPMd/rnLvSFMM57C4BGdMi4jfApv4NHpZhjWOENes6erFYpU+rcEZhj
 9gBhMQUpBihm9tPMe5GzxWoQkV581r2UojfJHM2orTKG7UUkv6BdCuJSbnHEcySY6ici
 Dzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F/O4Z+E6Lm40GO/xNzCmRRf/TExfeeNhj/Pi79dfsiM=;
 b=U13KltmuUH2lXcvrBZ7UXWmrkn+c7s4G/WGgzxuuWMuRsLzxkOby77CPnGGqKbGiEq
 1Z8agCAMy4E7OYhQWVzXtHblx91qyuYBjninauXOA9bbe5TexlwF5hn1P2EhjCesPq0I
 DJqSeycVXMmOC1nFJExhq11yRHyZnN/wTvoNHoGGiYeVXaoHAD4zJSsvzcVcd7kC+i0Z
 rXApXWSBbNseNLoM9Uwjq5LTHoysLfM0XgCTIxoE7KGQ4Krtz+sEBfHgrudSggHGW3vy
 tQZyiB43bvacw8EZsXA7D9bLPnLWXEFfluN1ywCgsHdcP5CnWEe7cqUGomqPp5zLjfUO
 LzAw==
X-Gm-Message-State: AOAM531vIc9TIaLEHCbDAUfweuI79yp+BfexuCnNuYCk2Dka2WdtJons
 DA5ic4ImvJg3G6/jYBczTba0qg==
X-Google-Smtp-Source: ABdhPJzFZVfyPEZx2r/fXGi8f+A9dvy8v/OxozCYuNKctqtMpJWG323EYpq2cg0o0ERzS8YpHoDa0A==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr28296845wrp.338.1600270867726; 
 Wed, 16 Sep 2020 08:41:07 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id t22sm7223901wmt.1.2020.09.16.08.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 08:41:06 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH v3 0/3] soundwire: qcom: fix IP version v1.5.1 support
Date: Wed, 16 Sep 2020 16:40:58 +0100
Message-Id: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: sanyog.r.kale@intel.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
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

While testing Qualcomm soundwire controller version 1.5.1, found two issue,
Firstly the frame shape information configured vs the bus parameters
are out of sync. secondly some ports on this ip version require
block packing mode support.

With this patchset I was able to test 2 WSA speakers!

Also I found a regression due to move to REG_FIELD, which patch 1 fixes it!

thanks,
srini

Changes since v2:
- updated to use u32_replace_bits().
- wrapped up in single lines as suggested by vkoul.

Srinivas Kandagatla (3):
  soundwire: qcom: clear BIT FIELDs before value set.
  soundwire: qcom: add support to block packing mode
  soundwire: qcom: get max rows and cols info from compatible

 drivers/soundwire/qcom.c | 70 +++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 19 deletions(-)

-- 
2.21.0

