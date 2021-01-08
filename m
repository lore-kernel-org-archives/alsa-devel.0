Return-Path: <SRS0=g0zL=GL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0C7C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 14:01:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBAAF239ED
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 14:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAAF239ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1ABF816E0;
	Fri,  8 Jan 2021 15:00:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1ABF816E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610114495;
	bh=vctnGWINkdXQPUJ+gqA8W0kMk4lvh+v6XMBGxzZijBk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GV9QvgxfxuO9cg+tew5EFo2UU0Q5sdX1QCFBNYO1/JjQTd9ZtXS9+AS5BrCtKAcdt
	 6/E4PXeW8wmCgj2Rran7Z+Om7SXVfwSYvPUHNEnwl2VsYEEKR0kDg3NpMtcbMOm4aV
	 pyW6YMguO6wU0QOY1GZospFej/P18wDkUIqg5mio=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96E3DF8027D;
	Fri,  8 Jan 2021 14:59:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE53EF8026F; Fri,  8 Jan 2021 14:59:45 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF6E2F800EE
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2021 14:59:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF6E2F800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CwbkCCR5"
Received: by mail-io1-xd35.google.com with SMTP id w18so9856729iot.0
 for <alsa-devel@alsa-project.org>; Fri, 08 Jan 2021 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C/zuslkswFYbFYSDVravjmOqNUYzx2XjLo8fR1+C5Bo=;
 b=CwbkCCR5W8VzKN8SL6brUw3/NlzhnhkQl25s3Ww8oxbHiKCxd2A7QgpL2FG7V/7/V3
 JXlBQdaZFio7AzJThTdC0RF2yURFC7RJZ55jLHTxuZxhv/Ov9t+kMP2psHPeyd6A1/uA
 8kp4knYuY8X99ri10VIy4+sIPwFzL5sDHf85XPNX4oWWYzE+YCUDDJ8CwyUcfmWxCS9Z
 VegCtV8pQvozwsQ4Jg18+5gLp4LCjxFzZhaw+y05YvtUoeMYxWDPZg6bJL+3c9b4vMPi
 fmfrTGT06s8pgwaL+KRuNQQWl7IEau9shZMCk9xoxbEDFUtRXdoN3DR3W8RifNIKlwKJ
 Xcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C/zuslkswFYbFYSDVravjmOqNUYzx2XjLo8fR1+C5Bo=;
 b=M74xCL3OEqMaWrPk7AE2YB/chem7uR8liB4zOWhJRax24uQ8HhOwLz23/wepQauJTe
 hfTMLQ2Xnz7B4vvbXXT5+AmeIkPNaExJ1oDEKx4NvIavh/WzJ/Ivjha5vxjG1P7Kw3yu
 HXHVXuyBjv6D79CX3438ahxOkDLqXkVMstcx4HGBFMugumZxGydyKfVMTl+Mwk9kuyrt
 Sj9A/N9DjbDsgCtUv7NUjF4FK+gknsYIoW+lHQBVQMVmvAzf8FF5M4hVUc4oE5pmQFwK
 Ex8XqKmZBn9JgfGC97F57eK1A+MEzQR4TNZbdX/xmQY9YAb2ZWdZgN2eFDtlxkGpUFMX
 zKkg==
X-Gm-Message-State: AOAM531bVXPD/FTD7hSxj1EFPR2peALrBXSYrF/TEy0OHb+GkjlQt0z5
 sRflWgNteF5pi2fTWj5UqmlEyPBb4YzH4Msu
X-Google-Smtp-Source: ABdhPJxAEW7Csj0IPuhsiOm4Rr0CnhSvCZDc1s+wNmgGnnSvXxljW7r+BWgqmQ7VLgSfGIJsu4ygXQ==
X-Received: by 2002:a05:6602:27af:: with SMTP id
 i15mr5415055ios.170.1610114373016; 
 Fri, 08 Jan 2021 05:59:33 -0800 (PST)
Received: from rockpro64.hsd1.md.comcast.net ([2601:153:900:7730::20])
 by smtp.gmail.com with ESMTPSA id l6sm7570063ili.78.2021.01.08.05.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 05:59:32 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sameer Pujar <spujar@nvidia.com>,
 Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v2 1/2] clk: tegra30: Add hda clock default rates to clock
 driver
Date: Fri,  8 Jan 2021 13:59:12 +0000
Message-Id: <20210108135913.2421585-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108135913.2421585-1-pgwipeout@gmail.com>
References: <20210108135913.2421585-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Ion Agorria <ion@agorria.com>, Peter Geis <pgwipeout@gmail.com>,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org
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

Current implementation defaults the hda clocks to clk_m. This causes hda
to run too slow to operate correctly. Fix this by defaulting to pll_p and
setting the frequency to the correct rate.

This matches upstream t124 and downstream t30.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/clk/tegra/clk-tegra30.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 37244a7e68c2..9cf249c344d9 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1256,6 +1256,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_I2S3_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_I2S4_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_VIMCLK_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
+	{ TEGRA30_CLK_HDA, TEGRA30_CLK_PLL_P, 102000000, 0 },
+	{ TEGRA30_CLK_HDA2CODEC_2X, TEGRA30_CLK_PLL_P, 48000000, 0 },
 	/* must be the last entry */
 	{ TEGRA30_CLK_CLK_MAX, TEGRA30_CLK_CLK_MAX, 0, 0 },
 };
-- 
2.25.1

