Return-Path: <SRS0=30sX=ZH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DA3C432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:04:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33BB2072D
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LplB9k4p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD6KdDrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33BB2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F1C6166A;
	Fri, 15 Nov 2019 18:04:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F1C6166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573837494;
	bh=XtELjYunLUOptI0BvHLDBC9JeRD1xUVmUH2TI/4rEOY=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LplB9k4p8RhNVpJzBUySMvmE2kPfA/05A8QCDTwuX1CDeGoET6KKhxAy08uhm26P2
	 1PuhKFZZrDSM4QjPx8QcliIEQ7E2dHpBbb/MXBpuyLfa5se/aNnS9Fd6lFOfZ2d+SH
	 ia+9iiB+Xwy8QJW7j4GxfPwzLTwcm91J8wezKbx0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C93E3F80277;
	Fri, 15 Nov 2019 17:51:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AECFDF8014E; Fri, 15 Nov 2019 17:51:26 +0100 (CET)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69098F800CC
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 17:51:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69098F800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="fD6KdDrz"
Received: by mail-qk1-x744.google.com with SMTP id q70so8598680qke.12
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYENIjArnsOjhA9ffVrRGheHs4eqvuQRpAYUpV5zbb8=;
 b=fD6KdDrzblQcsEuIyJ/dfQ3oMe1p+l3lcCZspqseJcV1T10U64kbGEr+zjd4jDEnnB
 XHU5teDDHdOPRkXRSy7t19Bgw3WGCaqRHVWOGHnkWGWHD/grgGX4E+KMwbJuD+NG0Ubr
 qIg73018r8KCxYFwlvSm7VHgGwP44WJe66FX0oVPGzKnqf5DLTPyJLzwKrPsuMzwRtDm
 MjsZYORfzlG+94r0ZmTW/bilzqC2GnqHLCNfpneRax8msJS+lLWYB65bg0NXPq8CCgCO
 SDWN4czODqimzMQFvSBIdBgjNo7BBAcGLW8xkiuzI9iDlcDJ1TC0BHdNpFUPLBGRBxQl
 k3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYENIjArnsOjhA9ffVrRGheHs4eqvuQRpAYUpV5zbb8=;
 b=QkeeXJ/ye8/xzrZSB5WSLKQfM76LUz1+NVcgMAxwvsSf95/zWjknH+zTVepJuqlAF+
 jKfweHwxoEqq2ZuwOjNv4dXEg8z/1EKnolwJvRgI0KaFWWPzwykuSe5OLdd9uSIG7YtG
 wosuJeFo0kRScRpzJZECML+Pecedcy0As0Pou2Vo+czU+mXpj8mtMZlTmeUxUv+q5xsW
 Y1xHHPj7c8Pmqqr9/NSID+HoFZSjbrVCnnBJE/Qij1mdNTAuOurUn+RTcaChfiMb40KG
 bIZ+Nk2iVjZA9BfK14joT7YHMWXqgelZEEstQdjyjQ1rlnMfVZsUSSlbEE8oDlgh2MCT
 Eg7A==
X-Gm-Message-State: APjAAAVxq0zfCxoKh9DBkkjmkj5yXGv+d1DmfkgZnnXGfxkRWTaE/g8j
 ioYJV8gJ71ftgraOMWVTs4k=
X-Google-Smtp-Source: APXvYqzwOaC1BQreazFbJdoMB/Qh1peQ2/5Nzj3Pqt2x/DwLRMCXnWexbVyA/MbOSh02tf21Oewutg==
X-Received: by 2002:a37:4752:: with SMTP id u79mr3672952qka.456.1573836666778; 
 Fri, 15 Nov 2019 08:51:06 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:51:06 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Date: Fri, 15 Nov 2019 11:50:38 -0500
Message-Id: <20191115165038.56646-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [alsa-devel] [PATCH 20/20] ALSA: hda/hdmi - enable automatic
	runtime pm for AMD HDMI codecs by default
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

So that we can power down the GPU and audio to save power.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 795cbda32cbb..8785fcc850b9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3961,6 +3961,7 @@ static int atihdmi_init(struct hda_codec *codec)
 					    ATI_VERB_SET_MULTICHANNEL_MODE,
 					    ATI_MULTICHANNEL_MODE_SINGLE);
 	}
+	codec->auto_runtime_pm = 1;
 
 	return 0;
 }
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
