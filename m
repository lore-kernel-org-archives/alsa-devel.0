Return-Path: <SRS0=dMuI=H3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B24C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:29:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EFE64F0A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EFE64F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47AE21699;
	Thu, 25 Feb 2021 12:28:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47AE21699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614252535;
	bh=CbPCkBbsrfweHo/cKgu1hsry/vTVKeiZDRUf80rjjes=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cKYTcYUlZFpBU8E88FiSGhj+jwaQg1baAEErz+4mGHnOWUmSTx7V1pZn2xKnCzoRT
	 fCIR5EldUpkprkkErKDC7L/d5xrzLPbNraCX6MLwn3nbeg7aFqgeXYuwowU9wX1YqM
	 fOXx8DsBSGWhe9c7Vc0wMwGWe/2s2twvOrEMizTU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C29CF8042F;
	Thu, 25 Feb 2021 12:25:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B73C2F8025E; Mon, 22 Feb 2021 16:13:04 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C69CF80082
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 16:13:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C69CF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CcgFY/Ti"
Received: by mail-wr1-x435.google.com with SMTP id u14so19477343wri.3
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WYznJRJi7sEltEuFcbESAgA/1ekiiKcyEWk34Vl4+aw=;
 b=CcgFY/TizwV98v0EjQpqqprS4kVWLxLIO+yAEtYX9MJDmQjMwKOK0zhLFhUAmTTUvo
 UYCCmjDnP3NHnqKIuslmK1ckzcpTkXYuvs0ZfCVMNzBvYmY5JxTzUGmctvKraW5OW/3m
 d3UAE7bzLdvPxuy+csHIHgHU41Y17L8S4vqx0F0JnvKxr1BGWcR0gdJnGyVtMHkBv2OD
 G+ZRlYUbp7mUHzS2OGp06688Aziy6jCbmBcL2ghihroHV2JxcYem1sy18GTKwUfACGzy
 RNfbhejFrJtQ2h2UcWWTlvOP9zx7vP2kTgELNmMdR7OqC90iRXVahtQQtVVU1CPFV8sf
 TYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WYznJRJi7sEltEuFcbESAgA/1ekiiKcyEWk34Vl4+aw=;
 b=Z1W2YZQcoUZuEAVsKze6DIUR3X/TMTgmXOgIoxD+yFcHcjnsg+tvQzjqO3f+Nx1BRo
 Ya6SeOzpcbDWQ06o89WNwc82FvV8uigTTpk07DisiklMHFdvSmJxHjg6h9hMbbCtYIdI
 4TjCN1dFTfHWN613XmMWOK+1JYhbTzidC5MzrI/bQK+fmh7yfRbdbw7PnRsqRWFShy+s
 9Zl6s1Yv5gmIkd4yx3pzIRavUpgHpuH0fUFElobE7GI7HgYXJSoBwu0ftZwSSAq2c92O
 xyJsFSlce/7+nkP2cL8oxDwDZUBYsyenOT1NmmSQNCP3oE6uzNpp0LmAvqTXlnNu5/RI
 xntA==
X-Gm-Message-State: AOAM532ipoa57RbI9WhSuHRCiDU6djjSnRU1uvplH0bmr88T7axjjJ7L
 9aFNku8V5qsYYTb+nTnNMSk=
X-Google-Smtp-Source: ABdhPJzjuRXaYt/SRvU62YQ+PqGinj8lFxjNzE0l2PB160Gii4xzWBJxkVSIXDJqoVo/mJEet+g7wQ==
X-Received: by 2002:a5d:54cb:: with SMTP id x11mr2479881wrv.165.1614006780305; 
 Mon, 22 Feb 2021 07:13:00 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
 by smtp.gmail.com with ESMTPSA id q20sm25316500wmc.14.2021.02.22.07.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 07:12:59 -0800 (PST)
From: Romain Perier <romain.perier@gmail.com>
To: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 15/20] ALSA: usb-audio: Manual replacement of the deprecated
 strlcpy() with return values
Date: Mon, 22 Feb 2021 16:12:26 +0100
Message-Id: <20210222151231.22572-16-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Feb 2021 12:25:31 +0100
Cc: alsa-devel@alsa-project.org, Romain Perier <romain.perier@gmail.com>,
 linux-kernel@vger.kernel.org
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

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 sound/usb/card.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 85ed8507e41a..acb1ea3e16a3 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -496,7 +496,7 @@ static void usb_audio_make_longname(struct usb_device *dev,
 	struct snd_card *card = chip->card;
 	const struct usb_audio_device_name *preset;
 	const char *s = NULL;
-	int len;
+	ssize_t len;
 
 	preset = lookup_device_name(chip->usb_id);
 
-- 
2.20.1


