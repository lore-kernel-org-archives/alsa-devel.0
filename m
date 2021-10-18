Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADAFC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 10:35:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B1F6103B
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 10:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91B1F6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBD9918F0;
	Mon, 18 Oct 2021 12:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBD9918F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634553313;
	bh=1sWq4aAgzXQf8P3b/TDVqyUzLPWBFMg6cSJgAe2GFz4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H1BB/xYtZII9emb28fxkSpSPtBsU9sXAM27U793rrFzCIT7Nfs6POO+f21J/L8Sj+
	 OMk4jpVsYL45DlBIAsqpcD0YvqQvyUSO93JSaLMo3aRssUUg1YOQIC4EmCPWXVn2JX
	 94PI3xUhXZJJWydcbvJxjWJVqtXEy7N0XaLJ+6bw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9604FF80159;
	Mon, 18 Oct 2021 12:33:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FFB1F80224; Mon, 18 Oct 2021 12:33:39 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8231F801DB
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 12:33:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8231F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="GxmpyZ8a"
Received: by mail-wr1-x429.google.com with SMTP id r18so40440068wrg.6
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 03:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cGn43/LGWV9yHPcjMkf3TCrUECrY0/XNXt2QNLZSx3Y=;
 b=GxmpyZ8aS8/cSgSoLniK7/q4OxJ45GEcM3HKfOdecelTtSYraAqBZd1BCaT5wBDswF
 8Y9fMfDIUWaLh6fkzpv2NfyNjA1J5SnrK5NkMFpdBiy2QeEf/jl7d68d+ZXeO1fLXDYz
 4AotQeZLj/fs4ihw36rPE3iloDRcfW9V8Py+IFWetqX6Uc3g3JgT/NKJDGBJzjXCQleP
 YyCcrvRyaGLnPGtyinYwTr2cxJdSmqUIXTc414vSuqRaggTskG3iIZjOmfhVsODPwXO3
 I/gAvBIIn1Y+c4Xnp9l5sodFMCvwn9Lkd2KYov1RANmRVCR6pKUJCmM23xwvvOu1+54U
 VXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cGn43/LGWV9yHPcjMkf3TCrUECrY0/XNXt2QNLZSx3Y=;
 b=OTjR1eIQ4FcetADMl2kSFhV88eHg5ZUmUZmihdZa0MUm3qwzgQnyW/C/tDO/RClbUt
 d7tZEEdv5s35m5CDHXmNUDPmb26dhCCPa0Y+f0HOoZXu0BfGXX4DP4n9UIADzelmmsaE
 4gq65C3pdfu+QI+xjzW1ugOvdO8CZvldkfu/QonamOA97g7yYjtzO9KJz8qyE3h/osw3
 fu6nrMtkSYxop3YCwC/DyVFKonRIGwYLgIZ9cAn8mVx6/wovk4gyfvDbaElTpiPBbXZB
 5eO/fo2AaVIwVD4qtKE11ZLNWvo44DP/FOyaNsKzjh9H2gAo7Mnb8G7wfqvwYBkZffNP
 HqBg==
X-Gm-Message-State: AOAM530wxgDZu2pC2vzjSfeKuzkR8wmhbpOZg8O1XXZzd7xxSdda83qC
 pwpptNesR6LEAfgLpmUWGZU=
X-Google-Smtp-Source: ABdhPJxBlzTAQpkU3yiExmcuxDUQHvrCikPJsCPEIqWTQoJ+xLeFEuRno453UyTdReHeyeOmlTGrtw==
X-Received: by 2002:a5d:64c5:: with SMTP id f5mr33763933wri.321.1634553213568; 
 Mon, 18 Oct 2021 03:33:33 -0700 (PDT)
Received: from localhost.localdomain ([195.245.16.219])
 by smtp.gmail.com with ESMTPSA id o8sm19062252wme.38.2021.10.18.03.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 03:33:33 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
List-Id: <soc.lore.kernel.org>
To: soc@kernel.org
Subject: [PATCH v3 1/2] ASoC: cirrus: i2s: Prepare clock before using it
Date: Mon, 18 Oct 2021 12:31:04 +0200
Message-Id: <20211018103105.146380-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018103105.146380-1-alexander.sverdlin@gmail.com>
References: <20211018103105.146380-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Nikita Shubin <nikita.shubin@maquefel.me>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
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

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 97 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared mclk
...
Hardware name: Cirrus Logic EDB9302 Evaluation Board
...
clk_core_enable
clk_core_enable_lock
ep93xx_i2s_hw_params
snd_soc_dai_hw_params
soc_pcm_hw_params
snd_pcm_hw_params
snd_pcm_ioctl
...

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/ep93xx-i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 0d26550d0df8..4d3179f03202 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -111,9 +111,9 @@ static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
 	if ((ep93xx_i2s_read_reg(info, EP93XX_I2S_TX0EN) & 0x1) == 0 &&
 	    (ep93xx_i2s_read_reg(info, EP93XX_I2S_RX0EN) & 0x1) == 0) {
 		/* Enable clocks */
-		clk_enable(info->mclk);
-		clk_enable(info->sclk);
-		clk_enable(info->lrclk);
+		clk_prepare_enable(info->mclk);
+		clk_prepare_enable(info->sclk);
+		clk_prepare_enable(info->lrclk);
 
 		/* Enable i2s */
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 1);
@@ -156,9 +156,9 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 0);
 
 		/* Disable clocks */
-		clk_disable(info->lrclk);
-		clk_disable(info->sclk);
-		clk_disable(info->mclk);
+		clk_disable_unprepare(info->lrclk);
+		clk_disable_unprepare(info->sclk);
+		clk_disable_unprepare(info->mclk);
 	}
 }
 
-- 
2.33.0

