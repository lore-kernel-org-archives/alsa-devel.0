Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C00C4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:56:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB614207E8
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AXX1vvCb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWVA9Dl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB614207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E6F116BE;
	Mon, 26 Oct 2020 19:55:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E6F116BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603738571;
	bh=Fsy8+3JJxfFgXzqiS+q/3GjenAAZni9gCEttZvr+ZY0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AXX1vvCbylwvpYExyebsV7lXnYwLeKrCvqlBWuxDwjypCTWcCu5rCBssmNRWtYT5f
	 RidcOPL/naeAn+5eOI9BRYPUWVog3rRMgvBLRXWFTwUUy8TIkFMh50TEzMhAg4oVV1
	 l/j3TcZfRr8WF+GNi8/zDW+/wgckoUnBPp9Y/dgg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFF27F804E5;
	Mon, 26 Oct 2020 19:53:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 149B2F804C3; Mon, 26 Oct 2020 19:52:59 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 368D8F804B3
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 19:52:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 368D8F804B3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="FWVA9Dl6"
Received: by mail-wr1-x441.google.com with SMTP id g12so13894160wrp.10
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h875RQWcCnQKEon1vZMSs7fd8QdIR1VwpoRUpUdOrgk=;
 b=FWVA9Dl6Oj8NfNYWfN2+EWXfUan70boVLG9BRrwZqRpsC0i1B8A937J5ZcF+/BXnL7
 OObwJKQ99Zd0EXLqZcBbJo+EKuBsgqFxWFiBliQPM9NMT0BFmgBJeSZfyBRWwnYMFjsL
 w1Rej3RC/ZqmlPJ5EWcwazpY3VDAytOpQ7r+qQXj/dw+zaJ9ujWus44x4fIZ9XieRwId
 XA5hdvrDFaFxVjJLEbXEIK/HkKpUIc96JQlQfUxnn4CHkvqsWUPVC5qNrnisYH06uPGy
 UrtwyC2ey3bgr063kjjxX2pDbkEUd0Wq4LfzW4Q6E4aolS0ehRjOH0GN1kRb7Vx0qTm/
 QNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h875RQWcCnQKEon1vZMSs7fd8QdIR1VwpoRUpUdOrgk=;
 b=eDH+M615a+eHLK6fuQKbr0HDgwdI6Spkvl47CUqi8Ll7nkuue04XP1y7YqQkdXwURI
 V5BE6QuG8yCtXS8xE0EoKi0W+Kkoo97x921lx/uNr/KS3ZJoR0bWn5OTaf/FReSHUdNL
 0bjX32t/PQimjNEpc6ZN5GT1dBSBAoFMmSWGKXOComt4LVqeJaXEzvoByLouD3nla1Pb
 joi6GRaRUNAuIDTLbl0+S5wNC7V3M7l9k9PdbTISBKN6BT1hykIree3CT0BOLk+nqQMn
 ForwWDJXo0RTY5RHmx/P4VWjPABOPzallbihbRS8Bqu+F7DDr/P+aK27g0W4LgPlAjgo
 tm1g==
X-Gm-Message-State: AOAM533SU9D4+Lp82FDb+IjNpO1eg7qu7jQ3hyYJE1teEpsk0fKuske/
 EzbwWvdqFKLZs1NBddtFnNA=
X-Google-Smtp-Source: ABdhPJypxi18UjO1yoMO6HQLdWad+3pWKFs2BpkRvBv/Ei72mwZ61uqV8oISGr4+IOKfHisiaPaYEQ==
X-Received: by 2002:a5d:6407:: with SMTP id z7mr20814807wru.271.1603738369911; 
 Mon, 26 Oct 2020 11:52:49 -0700 (PDT)
Received: from localhost.localdomain
 (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
 by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 11:52:49 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v8 06/14] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date: Mon, 26 Oct 2020 19:52:31 +0100
Message-Id: <20201026185239.379417-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

The FIFO TX reg is volatile and sun8i i2s register
mapping is different from sun4i.

Even if in this case it's doesn't create an issue,
Avoid setting some regs that are undefined in sun8i.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index eee1e64cd8f4..dee8688f0d37 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1161,12 +1161,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
 static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
-	if (reg == SUN8I_I2S_INT_STA_REG)
+	switch (reg) {
+	case SUN4I_I2S_FIFO_CTRL_REG:
+	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
+	case SUN4I_I2S_RX_CNT_REG:
+	case SUN4I_I2S_TX_CNT_REG:
+	case SUN8I_I2S_FIFO_TX_REG:
+	case SUN8I_I2S_INT_STA_REG:
 		return true;
-	if (reg == SUN8I_I2S_FIFO_TX_REG)
-		return false;
 
-	return sun4i_i2s_volatile_reg(dev, reg);
+	default:
+		return false;
+	}
 }
 
 static const struct reg_default sun4i_i2s_reg_defaults[] = {
-- 
2.25.1

