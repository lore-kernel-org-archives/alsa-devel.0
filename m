Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B849EC4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:50:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D39621775
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cC3HWipk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJ8JC/kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D39621775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F5101838;
	Fri, 25 Sep 2020 10:50:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F5101838
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601023850;
	bh=1SMTnsbF5GcW6Yuyphd6Q6kAt6KJNG0yPJ1lMnGJXaI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cC3HWipkjh5GNuH8XM6U6/7DaJ2K/aC45R+zCheEs65vqchuPFJtjop6kQRhlv0bn
	 /yauKJr4M1c+q8EC9o6F/91hALGDfoxpdJZwPHCj8gR5TRCiU4Ltw6FoME5N415yh4
	 zB1u6FpCqh4wNNWGIowd6l0+PD5CUZe+1d2PpAps=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 608FEF8028F;
	Fri, 25 Sep 2020 10:49:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34F81F8021C; Fri, 25 Sep 2020 10:49:45 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0313F800F6
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 10:49:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0313F800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="uJ8JC/kh"
Received: by mail-wr1-x443.google.com with SMTP id c18so2647006wrm.9
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IlWOGu61caSeoYRT7WyG/oLloBIbjO1N4nhvVBC7mNE=;
 b=uJ8JC/khJYZPpFxv5ckTXKeMcBaXe67num4gM4qocSOZJr1l6lyrJdnN5xPM0E1YVB
 8u0H9mFmMG07ZUX++hiwv5A9N9764MgcQQNEZjegt/nP5rPGsdaXo/jqfmlJOUFO/5hJ
 AWzweshbWZydtJ63TJ/BDinSkgEGEHedDFfa4dHL9pwHmhO+Gnpphsxz3QlAjDL8u6hO
 VkoJHGT7C1YtQHho9yeGBcDxmGr2KomsLO8UvyqqVNwznMWn9ubK8mChkH9E/qKpRc+9
 Cn3GlguZw1iBlI4jYc6e2xcKqRRcR4tevUJfNPxaV3NGaJTdsaB0Jlkjk3+tJHj2QqEK
 eu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IlWOGu61caSeoYRT7WyG/oLloBIbjO1N4nhvVBC7mNE=;
 b=FWdKHZedV+G23l9AXjT1Cn+5xi9899oPZmdgsjH2GhRvdvLUtoT7z2D2Tk3idaRu3N
 HNZtd8DUeRykdGfwg+0gK8PWZ1dQuXRC0gGsNyXV8zTXnhujL6z7xvQSCVYwJBjntHFW
 W9fTIkisIyi0mXilDRyLBXjveScAwRoCqqV+MhM4U9P135zhnp8rZPjjj0tqVegCd4sy
 beffVYTtR4tH/LTYIsciD7T0W2q46+1KZfRwFgctf9x+5HS5pjMoFwN1iqdBsIZblZev
 sFfLO7g+GAU5OpwzOHwrQ8iHQiH2RGknCmy+ERD3Rf/tbehSpvZjWj/P/vjVu9rGGprX
 MRpg==
X-Gm-Message-State: AOAM533HJafiQlYujEN8Q4vmN0vOw+ljycpedZ6XD8/AUEFbLsYPsZeQ
 Bt6154qw0XYXYl3XTZghS+taqg==
X-Google-Smtp-Source: ABdhPJy9cN1jYFXrH8+KJsNFEddslJbdRN4gvdwpyB2/teUN3+XBdSj3ie3i7CfO7egVTT31ol9wrA==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr3164899wrp.332.1601023774243; 
 Fri, 25 Sep 2020 01:49:34 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id u66sm2048623wme.12.2020.09.25.01.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 01:49:33 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 0/2] ASoC: qdsp6: fix some warnings when build without
 CONFIG_OF
Date: Fri, 25 Sep 2020 09:49:23 +0100
Message-Id: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, tiwai@suse.com
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

Here are fixes for two warnings types discovered while building qdsp6 drivers
without CONFIG_OF and with W=1

One of them was reported by Intel kernel test robot on q6afe-clocks patch, which
equally applies to rest of the qdsp6 drivers.

Srinivas Kandagatla (2):
  ASoC: qdsp6: Drop of_match_ptr to fix -Wunused-const-variable
  ASoC: q6asm: fix kernel doc warnings

 sound/soc/qcom/qdsp6/q6adm.c        | 2 +-
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c    | 2 +-
 sound/soc/qcom/qdsp6/q6afe.c        | 2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c    | 2 +-
 sound/soc/qcom/qdsp6/q6asm.c        | 5 ++++-
 sound/soc/qcom/qdsp6/q6core.c       | 2 +-
 sound/soc/qcom/qdsp6/q6routing.c    | 2 +-
 8 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.21.0

