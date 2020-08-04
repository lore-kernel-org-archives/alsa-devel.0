Return-Path: <SRS0=lfZM=BO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4A3C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:07:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0202076E
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vr1bglKM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZaf1RAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0202076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE5661661;
	Tue,  4 Aug 2020 02:06:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE5661661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596499649;
	bh=D0M/qCg2Yy16ggfpzadQVtLegqQZVy2AwMS0Mt7hEAo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vr1bglKMXVVDrrqKFDsz/9akzRzDyLuUF7YW1Gk/tPqr8tfq8VeQPwIRA5GY/pC/t
	 /O6FzBhjvDA1dzdu6kcwDwtJGlWvBtwlz+GOwmqBDCYKiv/yvD+Fj3U9uIPhgMseUx
	 IjRm+EOwo2+r2hu4K6ZzCDJLqDmnrTW9XHZXpdMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4584F80279;
	Tue,  4 Aug 2020 02:05:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAC0FF8023E; Tue,  4 Aug 2020 02:05:44 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF8E3F800BD
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2020 02:05:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF8E3F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="YZaf1RAu"
Received: by mail-pj1-x1043.google.com with SMTP id t6so1033047pjr.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2020 17:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NP1mgUkCmlEZxcd7waSmwn0TKmHAK/DFyxCzxl17dtI=;
 b=YZaf1RAu7uAS0CnsRF0GsZAGSJPQlK4R+8/5vwzXjt3h9My+wgCZZSipHeMi/z/cey
 ItYGsRbndsWiE0k8aqjqGnSglsRd8b98so9+IV3KOiuJF0BS+FDFLQRjru0QTFqL//ry
 n4Q8js9xnrNgOZYBiyHsVrEHV3felhZs/hTf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NP1mgUkCmlEZxcd7waSmwn0TKmHAK/DFyxCzxl17dtI=;
 b=HDo7IFTXRiaplZNcGdadZIJAs+RVzv064VsWoSXjKHu1m2GGbPH2cj6ZL6dISi5BGY
 LS0u42Igi1MtqBaX48VsqsBadO7xno/CCCsxA5cRawXBDw1tYZuP4FsAU05jGk3fOWdd
 8c4GtLozV1mqHWjvWA++IG8gWbj1/W9uFoFvXFA7sIPY04cqildCDMrqOVVfqwKMIhae
 2zFGS94HUNvEAUD049WsZ0xrW/QCnR6Wd3e6dFAsuSsGgil7fVZLiGRVh1x2B/MbJmFs
 EFlAX1qXDlNWuNwvfr400NFeTppY9azrefXExzFTBG7lGerYp/YPjXXukPv4EQGFdU1T
 MgZA==
X-Gm-Message-State: AOAM5322HvsAZx4KSoFZTZO6DjrRZq8lPk+JWzAcmpY58wet77W9O8x4
 GQJ5+e4rK3WzZEuglz++XqRguA==
X-Google-Smtp-Source: ABdhPJxWUF1KaauDaSDNI7jTshdinvkTVNWLw257sbIlPVblmq9Q5WtQduokmKxsaXs2OtizM5yjWQ==
X-Received: by 2002:a17:90a:3226:: with SMTP id
 k35mr1610311pjb.114.1596499532554; 
 Mon, 03 Aug 2020 17:05:32 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
 by smtp.gmail.com with ESMTPSA id e28sm12332756pfl.124.2020.08.03.17.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 17:05:31 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 0/3] ASoC: rt5682: Use clk APIs better
Date: Mon,  3 Aug 2020 17:05:28 -0700
Message-Id: <20200804000531.920688-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Shuming Fan <shumingf@realtek.com>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

This patch series drops a printk message down to dev_dbg() because it
was noisy and then migrates this driver to use clk_hw based APIs instead
of clk based APIs because this device is a clk provider, not a clk
consumer. I've only lightly tested the last two patches but I don't have
all combinations of clks for this device.

Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Shuming Fan <shumingf@realtek.com>

Stephen Boyd (3):
  ASoC: rt5682: Use dev_dbg() in rt5682_clk_check()
  ASoC: rt5682: Drop usage of __clk_get_name()
  ASoC: rt5682: Use clk_hw based APIs for registration

 sound/soc/codecs/rt5682.c | 73 ++++++++++++---------------------------
 sound/soc/codecs/rt5682.h |  2 --
 2 files changed, 23 insertions(+), 52 deletions(-)

Based on the last patch to this driver in linux-next.

base-commit: 6301adf942a31bed65e026a554e5bd55d9e731e1
-- 
Sent by a computer, using git, on the internet

