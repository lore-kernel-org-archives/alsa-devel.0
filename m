Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0345C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:43:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59759206D8
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cNnmsS2K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAJg/Vsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59759206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFEE582A;
	Wed, 18 Dec 2019 04:43:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFEE582A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576640637;
	bh=k4pkpjWomB59Hqay2x2X7IhrqyyhCvjcZmYG8zJjKZ0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cNnmsS2KA0zJTjZGjw3xsuVSbZlfvD+a0lU9cR2aHsyja+CU/lwF8S6ObTFsPLXnQ
	 WExtzWXf3eWUdoUVn9RfQVCFjkCQJ0SrjPTPcerAYvv6C4sTpkmZFv97p77K7HzFL2
	 KkUQbtn0LxOZe52ABJZllZVE4/Lz95dJhVkkcpl4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17635F8015A;
	Wed, 18 Dec 2019 04:43:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C846F8022C; Wed, 18 Dec 2019 04:43:05 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFB8BF80059
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 04:43:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFB8BF80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZAJg/Vsf"
Received: by mail-ot1-x344.google.com with SMTP id k14so628687otn.4
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 19:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DTLHJB/iUcLDfSNgBM/rRd3/H05ShntwvWDkcVOuP88=;
 b=ZAJg/VsfqHfAuA79L5vD2Ey6OpHmmoZSS1dDrf4XEoZWod53aC9rF4y45Noqua0A50
 LtZYqDB1iJt43WO4BjCyodOhPdraBw3odtu8MA7i/A9qpySPvR3hHf5uOvjBRLlHGYIV
 FQ4Jt6o80x4l2JzqJRF/DluvbyOVLjOqSMwTbhtmEnCEeMRMrr6YoPZerrCrISuzJiBS
 dcBhss7gTBIZyUz5WFFN3XvcSf/LhG9NKm9SQDFM/mLlGld5HAVcTpZZU9ZF241lawy0
 MNoTo6uE1F26dNLh7GEKt+gPQOdXQPY459Im7iTHCyXLhlo/V+zSN7Fhl1o60v/n1Jm+
 swrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DTLHJB/iUcLDfSNgBM/rRd3/H05ShntwvWDkcVOuP88=;
 b=JY1pbVEqdpYEpWFdoN17Q2VPfPp99qZBZTkzo+UCMpZDncBLVl8+IcnPP9G7dCk4iJ
 y1CJKQSgrI0ZxwfL2Xdm013B4oivxkVdGVNbqJEszuTBAi/gm7Z/ocPoJnzOFU+06UIz
 r24O9OcNrsuCw5TGuX/OkfU1UogCXgY7H58RXunFnLLlLJ4hayFKfcemHPtGhpPZyofx
 V2rt3ot6s45NDMxGR0a3EHH1h9c8adXS34yJUOuBGthkpFnkZboLrzzE5o0CUswfU5LH
 7mi73khN+16MRrEYzvUVrNYcmLPBYIN3MWa5ucb6mJrwa50L+VWoFFk+TLzcc93MZ96H
 b7RQ==
X-Gm-Message-State: APjAAAVz6WXmIZ1Eo6XCFweodroU2bCZZLTfyQ8OQpNkb4Nu7TV7WFNg
 CKPqIBNwJFwBdMTrDhqAd9w=
X-Google-Smtp-Source: APXvYqyWkKYiPX0Oalp+GwJKtbJm7N+/LKAcXm06U7mnzZIJAM/DsOUTb+h0bjkHM9vDH2c+qw6uiA==
X-Received: by 2002:a9d:2264:: with SMTP id o91mr236481ota.328.1576640580929; 
 Tue, 17 Dec 2019 19:43:00 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id q1sm358262otr.40.2019.12.17.19.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 19:43:00 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Date: Tue, 17 Dec 2019 20:42:57 -0700
Message-Id: <20191218034257.54535-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Cc: Nathan Chancellor <natechancellor@gmail.com>,
 clang-built-linux@googlegroups.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ALSA: usx2y: Adjust indentation in
	snd_usX2Y_hwdep_dsp_status
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

Clang warns:

../sound/usb/usx2y/usX2Yhwdep.c:122:3: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
        info->version = USX2Y_DRIVER_VERSION;
        ^
../sound/usb/usx2y/usX2Yhwdep.c:120:2: note: previous statement is here
        if (us428->chip_status & USX2Y_STAT_CHIP_INIT)
        ^
1 warning generated.

This warning occurs because there is a space before the tab on this
line. Remove it so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

This was introduced before the beginning of git history so no fixes tag.

Link: https://github.com/ClangBuiltLinux/linux/issues/831
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/usb/usx2y/usX2Yhwdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index d1caa8ed9e68..9985fc139487 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -119,7 +119,7 @@ static int snd_usX2Y_hwdep_dsp_status(struct snd_hwdep *hw,
 	info->num_dsps = 2;		// 0: Prepad Data, 1: FPGA Code
 	if (us428->chip_status & USX2Y_STAT_CHIP_INIT)
 		info->chip_ready = 1;
- 	info->version = USX2Y_DRIVER_VERSION; 
+	info->version = USX2Y_DRIVER_VERSION;
 	return 0;
 }
 
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
