Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BA1C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:29:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CBD20702
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KjsvdyI9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYVZlimb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CBD20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 085E61607;
	Tue,  7 Jul 2020 12:28:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 085E61607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594117756;
	bh=bfayxl1qWMysvz40+ppRnioMOs1+lDHUkl91HxO/QrI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KjsvdyI9ryY9JtDkenqJunAp5Uyxkp+TQeTHjNwGnkRzOJBc0el14TDpNN+RKvFLZ
	 xqS7jEEGFdCj8hoFI3VDQKws7SmsqVVI0ZyNJUs7Qgtc3O5/HBkzAn4TsgtkIevMa0
	 fiKCN2ejgqGxA3epkbG/FooFf216KIGzuQSIkWtg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 165ADF80370;
	Tue,  7 Jul 2020 12:17:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6107AF80343; Tue,  7 Jul 2020 12:17:32 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B6BAF80304
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 12:17:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B6BAF80304
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="hYVZlimb"
Received: by mail-wm1-x344.google.com with SMTP id g10so1411870wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eb/RPEg+kMf5EbfmZ+xzaRqlinKf/Ie6foYLp+7RL7o=;
 b=hYVZlimbR1Y4vTKWrzDgy1aOXAjhRbuXLpjometenz6KMcYiaNc5FhS2U/BgwBCWXy
 LzGWQeSIPg9sR21qe7fjeRqIc3SEMoZrxAkopagoIob1IVlOGbwvFoVywKOqplqP8Umt
 XvO5Yn4OK6ezPzEVhTp5NEyj+HxHd9PFoQ1Fsavx+M+BoqizA5C06Jn5KeLfpr+OIWrh
 +5N+5by4tWgAD/1iQ/PsHy93hhlGY9XnJaOnJKnMMbeQ2LmKUuDnMHIW9lPfudD4XTye
 qSnp/RyyG0guNjiIyiyWHMN+FOLPl53mrX7b5uT0jtu3YXZc4Fa80g30Up4hUTbEk/B9
 MpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eb/RPEg+kMf5EbfmZ+xzaRqlinKf/Ie6foYLp+7RL7o=;
 b=IVodQtXoN9+q3njtcdp725DHe6MERfvl1bB5J36VZ1wRzVWNoz4OWtxAKy8/mfVHPb
 xvCoce5MyTlZPAycWq4pVM6KQRmVyY1ZSUqJ53Uu41930EWpus0H7R+Mz0k2UNo7L11L
 pz04OOIA38Hdun4FHJaRcP5X7r8fsz9Zu3sx+Ack2yMws7Lwys4IXSmTyAxS/c2Ko+FK
 FfbZRqAWzFTgBIlwC6CWoMJd/F25HybEYP1wvZX4L5/A4TVP6R3pZmXud9MwBHxLq18d
 wjatAC5VXRYy/Ej9J2oTgcwdHt7/W6d+upz6R5JNkRNnp6si1x9lXuixJ7y8ys1lpKQ1
 lULg==
X-Gm-Message-State: AOAM5300NbttOHOLIK/ay7jR1XXf/OPFjBil/G0SGDIcXeDyx5l7kX1D
 Dc7BX2/l4FeNyQvJ+pTsqEkXBA==
X-Google-Smtp-Source: ABdhPJwiukos6NDimwam5UH9qNhkPMjAs8ALC3WtOoAlktRpKr9H6nmMroUuFl9TDomf2uyT3u8ExA==
X-Received: by 2002:a7b:c259:: with SMTP id b25mr3421129wmj.107.1594117034103; 
 Tue, 07 Jul 2020 03:17:14 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:17:13 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH 21/28] ASoC: ti: omap-mcbsp-st: Remove set,
 but unused variable 'w'
Date: Tue,  7 Jul 2020 11:16:35 +0100
Message-Id: <20200707101642.1747944-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <samuel.ortiz@nokia.com>,
 linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
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

Looks like 'w' has remained unchecked since the driver's inception.

Fixes the following W=1 kernel build warning(s):

 sound/soc/ti/omap-mcbsp-st.c: In function ‘omap_mcbsp_st_chgain’:
 sound/soc/ti/omap-mcbsp-st.c:145:6: warning: variable ‘w’ set but not used [-Wunused-but-set-variable]

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Samuel Ortiz <samuel.ortiz@nokia.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ti/omap-mcbsp-st.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.c
index 5a32b54bbf3bb..643ef7eb68fc8 100644
--- a/sound/soc/ti/omap-mcbsp-st.c
+++ b/sound/soc/ti/omap-mcbsp-st.c
@@ -142,10 +142,9 @@ static void omap_mcbsp_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
 
 static void omap_mcbsp_st_chgain(struct omap_mcbsp *mcbsp)
 {
-	u16 w;
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 
-	w = MCBSP_ST_READ(mcbsp, SSELCR);
+	MCBSP_ST_READ(mcbsp, SSELCR);
 
 	MCBSP_ST_WRITE(mcbsp, SGAINCR, ST_CH0GAIN(st_data->ch0gain) |
 		       ST_CH1GAIN(st_data->ch1gain));
-- 
2.25.1

