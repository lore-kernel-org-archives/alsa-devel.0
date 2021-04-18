Return-Path: <SRS0=kjsd=JP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276EBC433B4
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 13:49:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B60161057
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 13:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B60161057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAC3D16A0;
	Sun, 18 Apr 2021 15:48:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAC3D16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618753783;
	bh=1CjRm5ecSlygOf9UWKFV6kZydosGPNtVOybVRYxAbao=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mjeeh7a0nt8oKfSRvcXjjTsXpk8K0TkG1LztpiavjrYAflV9/w9P6xVL02cLa1gI9
	 40nzeVGnDgGZapopH8UgyIvlnedG4lea3aUDmYUb8TVdMkz6OZJXFMsupKUViSoTrO
	 x3zHe+K/zckBfKOtXnnDvl7YO00axvst2huQaiZ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BD7AF80431;
	Sun, 18 Apr 2021 15:47:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E79CF80253; Sun, 18 Apr 2021 15:47:57 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E21FF80253
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 15:47:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E21FF80253
Received: by mail-qk1-f173.google.com with SMTP id u20so1298930qku.10
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 06:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W6Zca4GVJY1fggJs5iafYXFuVE85I8IMOERxrI28jD8=;
 b=G1lJSpWLyenT27qti8nnrYq2MtXLTTz2+C4t4icy4Q/EojfcChvZ5QiLLeXAFHBmvG
 JhuvY0kOCMynGmLD/3FFJTw9ZHwcNOfOKxTLb5N3rRFczx6GYZ8KEFBuMZt/HFWcZmHq
 nZQpucpEV/i4k/+TuymxVro2HxVxz1k1xM46cSTENXJ/L9nXFq4ChgxrgjocMMD1HcuM
 uEXFilW/oO1xztqkUudlbvu343KnEp/VYGWvLSViuyxPTv7pXdraUG9LFzATHMsbiG8t
 SqKbJSVyBtfIJe6ebAL8sXvcKsETe2opK1dcf2XliM3cpvCv/WRYzVZaQuIzu/oFcLR/
 PmKw==
X-Gm-Message-State: AOAM532gFkVu4h2/7gPMTC+WUpgxLes/SDPqKXG2V0S4gp1Ko+6vmZNV
 yTE1j3s1f8G9sinj6ePplXY=
X-Google-Smtp-Source: ABdhPJz/cCWYxz+Q7XrC4BWia1woqDR4nMpolxZi0gZGfeldAQFyGM+X6tEWTuUgN1KZRv97N8G3QQ==
X-Received: by 2002:a37:8a01:: with SMTP id m1mr8036277qkd.85.1618753623229;
 Sun, 18 Apr 2021 06:47:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:5b5f::f3be:e978])
 by smtp.gmail.com with ESMTPSA id p23sm3927937qtl.8.2021.04.18.06.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Apr 2021 06:47:03 -0700 (PDT)
From: David Ward <david.ward@gatech.edu>
To: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/5] ASoC: rt286: Make RT286_SET_GPIO_* readable and writable
Date: Sun, 18 Apr 2021 09:46:57 -0400
Message-Id: <20210418134658.4333-5-david.ward@gatech.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418134658.4333-1-david.ward@gatech.edu>
References: <20210418134658.4333-1-david.ward@gatech.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Shuming Fan <shumingf@realtek.com>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mario Limonciello <mario_limonciello@dell.com>
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

The GPIO configuration cannot be applied if the registers are inaccessible.
This prevented the headset mic from working on the Dell XPS 13 9343.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=114171
Signed-off-by: David Ward <david.ward@gatech.edu>
---
 sound/soc/codecs/rt286.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 67a5affdb705..45e4a48ef5bf 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -171,6 +171,9 @@ static bool rt286_readable_register(struct device *dev, unsigned int reg)
 	case RT286_PROC_COEF:
 	case RT286_SET_AMP_GAIN_ADC_IN1:
 	case RT286_SET_AMP_GAIN_ADC_IN2:
+	case RT286_SET_GPIO_MASK:
+	case RT286_SET_GPIO_DIRECTION:
+	case RT286_SET_GPIO_DATA:
 	case RT286_SET_POWER(RT286_DAC_OUT1):
 	case RT286_SET_POWER(RT286_DAC_OUT2):
 	case RT286_SET_POWER(RT286_ADC_IN1):
-- 
2.31.1

