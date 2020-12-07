Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1861C4361B
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 08:48:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBD1229C4
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 08:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBD1229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1425175C;
	Mon,  7 Dec 2020 09:47:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1425175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607330892;
	bh=nxuF/vClMqpEsXksCJQ75demgDBY6BSCQd8ifS5AVnE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KOzvv9jEesYoAbch6XQgbH18VVYyYHO1z3QaUDRC9BH83OCSmuyWEJNWohk/Wc0cg
	 hhCP54LIqks6lupl4hEqhzQmCdiPf31X7cKO6gVcx5DkTe+SOaJBskzhveVvXlaMVy
	 jatdHwEuJTMhQVCj142maeXgWY9VCHMBgjkKiqIc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40C2DF80217;
	Mon,  7 Dec 2020 09:46:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0386F80264; Mon,  7 Dec 2020 09:46:31 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01C9FF8015B
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2020 09:46:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01C9FF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="TCw4ggub"
Received: by mail-qk1-x743.google.com with SMTP id 19so4275676qkm.8
 for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2020 00:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XTZhOtD/mfgDmjZI7TlxngV+W/PI5tFf+zUtfTsDwaM=;
 b=TCw4ggubn4E4b34Ozz6AnkYFmgCYW/YdHwm3dkrajSvDu9iF3IwTehK+PVHS/LpGuX
 Uld2WgLFfOLxiQPlmD01/GSOOAUSCggiYyFNwHzRm35H/VlVtskfrhTl6rH2fZvRbLBs
 q2WRkTieE2XegDMdyaF+lMA7jW6X21mJ0XjFRQnK8HLjdarmhnbUekzM9DsTkgiiNLVb
 L/ipv+krnBy95KsKZalE6N0TAKgKL1ZIn3wF7FZ+TTnA+H2MeGLjel1+bdqoeYucdkg6
 tBNdF5MhPiBHj8vIXnaKu29HC7MyGWDP/Yf5WKhFLB6XI+IwTPEXx1OLVvSsHgEv1ftw
 w/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XTZhOtD/mfgDmjZI7TlxngV+W/PI5tFf+zUtfTsDwaM=;
 b=LfLu8l4ATLsaTG8FuJaTUN50f7hzV+iAjgAKikD3HN4YeIR2vtFn/e82JOxvWH4WxW
 dssT9rlM5Y+lx+CUHd1Cs5x/3q6GKqdL6ew5aKBRA6tjd9W8xHODEqbn2IRBtINXonOl
 XVFBWY8DH02QySnKTxVA2R7Ua8DM1TRJlq2o6r0V6lOmyeqiPhZoq7yW38E239e+buj4
 aAEcEtQ6Vq3Bo+08/cxY7I4/bmGKMU6mWSTKbqcimydJfHzTPKxj/xf5R1LLsnnCQyuk
 qWbXI+qo0oTmsQG9FboZzZdi7Q4ewAi493aRP4ULNnNYNRgxyefUNOp5NQGjsvNm8t02
 Ig4w==
X-Gm-Message-State: AOAM533DCWzo0oNrwadAhUoLGn6vOcJ+STxoqmAGnsTCAq/IYcmrHfgf
 dEBgpwpnrCIvjE+sNa52D5g=
X-Google-Smtp-Source: ABdhPJx7aT2XclbJxVMOWrrjzYdD/nc59udTfgiLAzURpOBFj9255P82D7H3hG/Rdwhc2x3wm8J3gQ==
X-Received: by 2002:a37:6403:: with SMTP id y3mr23201617qkb.204.1607330785078; 
 Mon, 07 Dec 2020 00:46:25 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id a9sm3424681qkk.39.2020.12.07.00.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 00:46:24 -0800 (PST)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH 2/3] ALSA: hda/ca0132 - Change Input Source enum strings.
Date: Mon,  7 Dec 2020 03:46:14 -0500
Message-Id: <20201207084616.411531-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207084616.411531-1-conmanx360@gmail.com>
References: <20201207084616.411531-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, conmanx360@gmail.com,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
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

Change the Input Source enumerated control's strings to make it play
nice with pulseaudio.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index e96db73c32f5..793dc5d501a5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -95,7 +95,7 @@ enum {
 };
 
 /* Strings for Input Source Enum Control */
-static const char *const in_src_str[3] = {"Rear Mic", "Line", "Front Mic" };
+static const char *const in_src_str[3] = { "Microphone", "Line In", "Front Microphone" };
 #define IN_SRC_NUM_OF_INPUTS 3
 enum {
 	REAR_MIC,
-- 
2.25.1

