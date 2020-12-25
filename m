Return-Path: <SRS0=e5Na=F5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1E1C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Dec 2020 01:22:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB76207FF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Dec 2020 01:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB76207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F96E182B;
	Fri, 25 Dec 2020 02:22:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F96E182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608859373;
	bh=wWeDxOf20cTo0T4VOPmXagFd4IAjj8gi9OfNm1MK0VQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=flDLEa5gNclTMgtHhHofI8OFsiHq2SCrPDUHhzht+9sYwjHqz2nKbnMH0Tl5IRJTJ
	 2zyEvdtiGEkcPOFuotiWgL1nC1zr9h/SSqTASnrVN2H+0e0A3HOWzTF6fMbzNru4q5
	 d6H2qBcKP4SuBlR3TyVdB5JUB79Cnfsmb3RnPUOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9666F8021D;
	Fri, 25 Dec 2020 02:21:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 314D2F802BE; Fri, 25 Dec 2020 02:21:09 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59D99F8021D
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2020 02:21:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59D99F8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="E9N6HIFl"
Received: by mail-qk1-x72e.google.com with SMTP id h4so3287850qkk.4
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 17:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pP0KV/2+7GkTRIp32tbGx/ReBjy/Twn2d1xplbAtnNc=;
 b=E9N6HIFlusnXfDWBBoInTFQmW5rVueWZKRVRyLbZnyvd1nlUfKa74nPFgUhY1Ij019
 qk2cIMnRCEj4hBfQLrZmJuXueXB+B8+rRLkfL5fib7v/vxccfbLkUmz8Ptsa8mAUR+4p
 vctiSInbUMjQ7Kq2voTPQP6EASFJLuulWdwCus3NL8D1cqay6nwaDCQktJDxE7NgRV76
 gAEW+lxorTpIYAd7n3mDoTfkrbMpP0CIGhV3gQ0WJu3OOEbb7r9NfK3ssKyGaLvzeUqG
 q5Pe7DMaYkwWtm+SzQcdgOVeKzXBH3URFXHfk2fysV4N9VV6pXzcHw1109Vs0jFIWdkQ
 ww7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pP0KV/2+7GkTRIp32tbGx/ReBjy/Twn2d1xplbAtnNc=;
 b=CkBjbeAcXxxfTG1iiOT1OQdJUrD2r6WJ33o/nwKoCx7T84qDfDwMLNeYU51M4H+D59
 bwY5A6zv57Q6GwrUZP4JbPCvMXLOexWvvaj+Xx28mGywjM88uMzEwEGdl7OAv7/vA6dV
 ISTihds3rfNg5/9WHTryDync5TgC/dSJemStUaMflPwuiRgxPxDarwQ7eDbwPmapTwsU
 kKNjkzHLS55T8pXr/+p73/o934EAl2NgnofdcLqmm7MEDZiZvWBCg4SxMj6NJJMs0Ejt
 87Jc4Jt/tRujj823+oioZlCkbwbX5sUqr6QPPLrTeeallq0lh8ArIft9GgckhVFP9JIQ
 9n7g==
X-Gm-Message-State: AOAM5334KDmF1LukWVW/KWzSvt6+89yYXeddQE3F2gr0cGXf+5Pc3tnT
 WWVLkNaEB0CEi94Y8DwSSbADhvS08BJTgqeQ
X-Google-Smtp-Source: ABdhPJyzXSk0ny8cZkeOBtow3I428lF9SfG+izFkxFIAPzhmbIliAXfI+zzTi9/kM+w7JecEW9RJOg==
X-Received: by 2002:a37:478f:: with SMTP id u137mr32609154qka.16.1608859258313; 
 Thu, 24 Dec 2020 17:20:58 -0800 (PST)
Received: from rockpro64.hsd1.md.comcast.net ([2601:153:900:7730::20])
 by smtp.gmail.com with ESMTPSA id x47sm17583505qtb.86.2020.12.24.17.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Dec 2020 17:20:57 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sameer Pujar <spujar@nvidia.com>,
 Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH 1/2] clk: tegra30: Add hda clock default rates to clock driver
Date: Fri, 25 Dec 2020 01:20:25 +0000
Message-Id: <20201225012025.507803-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201225012025.507803-1-pgwipeout@gmail.com>
References: <20201225012025.507803-1-pgwipeout@gmail.com>
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

Current implementation defaults the hda clocks to clk_m.
This causes hda to run too slow to operate correctly.
Fix this by defaulting to pll_p and setting the frequency to the correct rate.

This matches upstream t124 and downstream t30.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Ion Agorria <ion@agorria.com>
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

