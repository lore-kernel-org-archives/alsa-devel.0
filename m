Return-Path: <SRS0=e+ka=QF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04979C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 01:01:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6632561B42
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 01:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6632561B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8903418F4;
	Thu, 18 Nov 2021 02:00:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8903418F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637197303;
	bh=uWIVWduoC59xm6kI1Ln78GWraAbFGWQD56bKlRdnowQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P/nijSFhpJjKM2JCq3BUQVdl8XiRllqi+y+d1BtemvvlEZE9DkhGqz5tkn/Iokeeo
	 mx2aHVQiSkV15xmqLvvP/BSlNgdqVOUMkdEgtYOnr7mYerFhlJpwG6b+h2Q67CsFbr
	 2MNDAdg4LA1idLBofgDw0hXM0i819jxIoBa4CAAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FE6EF802A0;
	Thu, 18 Nov 2021 02:00:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DA60F8020D; Thu, 18 Nov 2021 02:00:05 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29E9AF8020D
 for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2021 01:59:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29E9AF8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="gwNtRhwF"
Received: by mail-pj1-x1033.google.com with SMTP id
 gb13-20020a17090b060d00b001a674e2c4a8so4096603pjb.4
 for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2021 16:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G4BTv//+2MDg63que21d0SOH04kYLO0+v6GBYWMab9k=;
 b=gwNtRhwFgUmqSdP/igrE0GsKWzxnQtjoGMphrPIHgteDlFwghXonsmctZ5p4Ni4vXK
 obNJyliP69uarrXKPfqCVc+RodWPMi98iJFjJyCA/6OauQHX3O/xbMy5uby2H8LgDjIU
 rnATDpCE2JxB4HyTuo2VJuVGR9bD54hWPfwildnCSC9m4oMG9YiCDK5gAocvuL/oTZCS
 Sp16hVZhe/fNLX+h2Qyzrx7/UlUHOKDS+r2n2PyQAN8iLnbXDTGm8Tjh5w12D3BoJnmn
 XDAxrLlgDKlSY1BGnecNaD/KaKErF3+19RVU/bRcZ4WViMDG5uhowg6VP7wSXNBBcR5A
 w7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G4BTv//+2MDg63que21d0SOH04kYLO0+v6GBYWMab9k=;
 b=wm8h8Un1yTV2X5u4W05D+YNr8wl8ZZJdKnSn+W1e5hdYdHzLhXElNZEKlIig0Sysrh
 Yh2ZAU+7bAKGYEouNH8P53OyAZ3mUZAZSvIDFDmFGaFhnW3C7mZBJFBlSPG9Zr4EXNe0
 k9aMYZd+QHsyXA21GIrPufWLDUgYi2gvJBJQ3I7mSp5dFo9VjDQtNTRFBFgw/odNqaXi
 iyJX0hqQPO9tUlHkU2ggSiCsPYW5udWHdkJ25dkls6Q0QWagzF/NBda3Q2Ly8PrFq+IR
 tvC2SDghCpz64u38fEQkjk5YzbdDV9m7wwziFH6TP6H5u7k7S7CsLS5N98skjpkyKffB
 YfIQ==
X-Gm-Message-State: AOAM531Zz/sKIG3Y93J1ID0oWl2JlNlJN0QcMCzA1kn4LiCL6GnlK++N
 PFqgEt5CAMvXwLQTYed6EYbo0uP14KU=
X-Google-Smtp-Source: ABdhPJw44Tow0AbatX/zGAE8pX5WnUDYNMbQ6+SqaKQQlklvGPlNmQeQt/l7MQKZuoIHYpXdvrFskA==
X-Received: by 2002:a17:90b:4c88:: with SMTP id
 my8mr5101646pjb.132.1637197193117; 
 Wed, 17 Nov 2021 16:59:53 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id mg17sm744731pjb.17.2021.11.17.16.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Nov 2021 16:59:52 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: rt5682s: Fix crash due to out of scope stack vars
Date: Wed, 17 Nov 2021 17:04:53 -0800
Message-Id: <20211118010453.843286-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118010453.843286-1-robdclark@gmail.com>
References: <20211118010453.843286-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rob Clark <robdclark@chromium.org>, Oder Chiou <oder_chiou@realtek.com>,
 linux-arm-msm@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 Mark Brown <broonie@kernel.org>, Derek Fang <derek.fang@realtek.com>,
 open list <linux-kernel@vger.kernel.org>
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

From: Rob Clark <robdclark@chromium.org>

Move the declaration of temporary arrays to somewhere that won't go out
of scope before the devm_clk_hw_register() call, lest we be at the whim
of the compiler for whether those stack variables get overwritten.

Fixes a crash seen with gcc version 11.2.1 20210728 (Red Hat 11.2.1-1)

Fixes: bdd229ab26be ("ASoC: rt5682s: Add driver for ALC5682I-VS codec")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 sound/soc/codecs/rt5682s.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 470957fcad6b..d49a4f68566d 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2693,6 +2693,8 @@ static int rt5682s_register_dai_clks(struct snd_soc_component *component)
 
 	for (i = 0; i < RT5682S_DAI_NUM_CLKS; ++i) {
 		struct clk_init_data init = { };
+		struct clk_parent_data parent_data;
+		const struct clk_hw *parent;
 
 		dai_clk_hw = &rt5682s->dai_clks_hw[i];
 
@@ -2700,17 +2702,17 @@ static int rt5682s_register_dai_clks(struct snd_soc_component *component)
 		case RT5682S_DAI_WCLK_IDX:
 			/* Make MCLK the parent of WCLK */
 			if (rt5682s->mclk) {
-				init.parent_data = &(struct clk_parent_data){
+				parent_data = (struct clk_parent_data){
 					.fw_name = "mclk",
 				};
+				init.parent_data = &parent_data;
 				init.num_parents = 1;
 			}
 			break;
 		case RT5682S_DAI_BCLK_IDX:
 			/* Make WCLK the parent of BCLK */
-			init.parent_hws = &(const struct clk_hw *){
-				&rt5682s->dai_clks_hw[RT5682S_DAI_WCLK_IDX]
-			};
+			parent = &rt5682s->dai_clks_hw[RT5682S_DAI_WCLK_IDX];
+			init.parent_hws = &parent;
 			init.num_parents = 1;
 			break;
 		default:
-- 
2.33.1

