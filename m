Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D69C54E4B
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 06:18:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA7D20736
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 06:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LO+clxh3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="GiFn5PvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA7D20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6E5A1607;
	Tue, 12 May 2020 08:17:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6E5A1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589264307;
	bh=XLeLx/dphbHqFok52C1f5ryP979Bxk/u5KQcRscz5VM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LO+clxh3UdZxdtRO4aju1XBQCH6mfRAXMoJhy0wy/sl+/r3G+yKZ0slEWPDmsCryI
	 8q5KiCHSJ2wYfpR0y7hWRXnL4BZB2eBEroK92wBoWrd73rczWvPbQucCxTF0Fz+bj/
	 QkBFVP7j4Sk0fPuEQ94tiiDTrnFHsiJAJZHho/+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D9A0F8015A;
	Tue, 12 May 2020 08:17:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2C2DF801DB; Tue, 12 May 2020 08:17:08 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30161F800E3
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 08:17:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30161F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com
 header.i=@endlessm-com.20150623.gappssmtp.com header.b="GiFn5PvR"
Received: by mail-pj1-x1043.google.com with SMTP id l73so132542pjb.1
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qAP5dzqVjJ1/UNcW8HWgPzFOYDWg70LyvfFQzRXxTzQ=;
 b=GiFn5PvRBAiNNSCjp3LSNNPQLCb2Lrne6Y8zq48dgtp4CcMRhQi+O+K2Dwztn34F7R
 7Vkukl7I0TfGaEdCPWB4DF1jmBihUlw4HH0+7CkUQMgvhUYPOrXoIyMLtR3SuQYc1gQj
 7Z+LIz8qDkGoMqCnW2t+PqSKZWm0lBJ8E9MZ3EhdbGQGgL3GmbpyH6K22bEvTLj9+eKr
 uGZ56MOYu7dHCmcxLPueWE8F7wd7krI6pr7Vmr6fB6RZq1j1pUi3k4ScwGbnWb1gWqPu
 5yWjw3ebMnKYPfmJRatOH/zfp5q2xiXRjb7IUTWxFTRKkXYKhTvc103RJQfdqEofoShb
 ofXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qAP5dzqVjJ1/UNcW8HWgPzFOYDWg70LyvfFQzRXxTzQ=;
 b=lYmLmJ+infeMieMK0/NjmKFRNtG4ViH0StaCFk8Uy46nW7AhKdxPeNi/XXz3wJSxFF
 JI7+/Jc8q5Ji//fxpsPgemcWA7tNNo+msk8eKw3RwoUDXgO5WgQt8bAdFrLVqSAk6Ksy
 MiSY+EoLD9IOYadlrdY8khZVsZU8YPMGH1Mh2TsGRi+q7qihI1B9YDEUrk88ojgx1X8m
 yd6m8Xy/jrJkovqiFszGHlDM8Bl9e5CcsYj0KuGtS6Yf4PqyGYee7+Ywd9QAwfVDEi5j
 fgCkycflamu1sdpJqe0TQm8FLpcnoC9B2I3rSvJxh4i6YKLKhTNrNgYZ48uN1++0c87N
 Nb3Q==
X-Gm-Message-State: AGi0PuYR3/n66H8xGGITdI8OLYgeCaDeXdTjhQ1A5KRP51uImJaiMfit
 +iwV4+XGRo9xCZg23Fau8bjLvQ==
X-Google-Smtp-Source: APiQypJbf1szRLV+fkXX/8u/vx+eHe31O5PTgScOEapJLc6RobEu0dNQebD5n2VIxPWzClVYUjNR/w==
X-Received: by 2002:a17:90a:30e7:: with SMTP id
 h94mr28196449pjb.225.1589264219649; 
 Mon, 11 May 2020 23:16:59 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.googlemail.com with ESMTPSA id m14sm9660554pgk.56.2020.05.11.23.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 23:16:59 -0700 (PDT)
From: Jian-Hong Pan <jian-hong@endlessm.com>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/3] ALSA: hda/realtek - Enable headset mic of ASUS UX550GE
 with ALC295
Date: Tue, 12 May 2020 14:15:26 +0800
Message-Id: <20200512061525.133985-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512061525.133985-1-jian-hong@endlessm.com>
References: <20200512061525.133985-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, alsa-devel@alsa-project.org,
 linux@endlessm.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>
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

The ASUS laptop UX550GE with ALC295 can't detect the headset microphone
until ALC295_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6c996df16201..dcb97b39be6e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8003,6 +8003,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1043, "ASUS", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x12, 0x90a60120},
+		{0x17, 0x90170110},
+		{0x21, 0x04211030}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1043, "ASUS", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
-- 
2.26.2

