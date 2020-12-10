Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A7C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:37:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE90923DE3
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE90923DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9ADA51663;
	Thu, 10 Dec 2020 18:36:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9ADA51663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607621829;
	bh=yd1l4pCxXlm3KfaIT8ykcnPwptQ1+SYBw95OZnmI6IY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UiX16k53CJ0JXvMyFZ9iTmpdsKS9bEu4abSY6RBdeGNPX9W2y68kqq/0UYF3UsBKV
	 9WlYtI3rxk304pUnnSlADbZujYwwyKD1i4P9YjnKC8GmIDRcEiWTf6goDf9Px2k+oK
	 6LcQX++bo9+EhGHrMdacTXQk/49KofQNA+/hYvsE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 048AFF80164;
	Thu, 10 Dec 2020 18:36:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA4C7F8019D; Thu, 10 Dec 2020 18:36:17 +0100 (CET)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A02EEF800E1
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 18:36:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A02EEF800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="JwNxEvwY"
Received: by mail-qt1-x844.google.com with SMTP id z20so4271336qtq.3
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 09:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E1hwgGPc5XzvWzLpZ/u2ztIUVy06ybOCmMW5LrKZ6/4=;
 b=JwNxEvwYgTpW4/CVoIAfLYCXJKGxAMzE9Kw8FvCi9uPMfMtiE3XSKQ1X9auxbIHhaj
 NFl+L2CDKyeEm4X8g/Fv8yLP6vhDIKh0hy1ghLTDfrWJEMVb39dwRXFRj2oW9CVfBmUt
 VBtvo3jAfKCQocAbdCaMofE9fkudhq2Zuaa6VyYdLCe9IAJaF5ybltMMFTvycfkM5KZV
 mW7BCYHBSBsyay5cR/a1LLX0s6hvMB9qPepOuqilh1E/IDN0sliZJ75HmjwGmjbH2Zj1
 v0Tl34OGD2HbajA9T0xjT+di/IhjspLN/H3ThHfyflxS9HRBcD/RYlbKU/xFnB6f7j4S
 2brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E1hwgGPc5XzvWzLpZ/u2ztIUVy06ybOCmMW5LrKZ6/4=;
 b=V7+9D6dWbnOKEhGPM16SfI1HWOmKqGATbbQoF/ykfZRV6vfBF1o5vXV5+duLM986cC
 +NRzRITPJM1myRWT4/9cYgK967tF12x9oI6aGdt5uogxVSuZYxXM3HKxKzPskeB7yeHV
 OsNAzG6Xkwd9D3IPDpElbyx+iGF6U8xKvHAcGiQhAdpFzhKnIRwtmgYDRRrkKFcHAmCY
 IL37O2AHK2g1tqigZ9cgKZNZDnmUF1YdjSUawN91ZPPY3Zh7TIV+g0LhUnIORp7k+9Yp
 ieBLmrlHiKXWhFUiWriC4PSvC7/nfHtVvt9NgGnLkm8EzMgDb86tLz0mITp+VC73nXSK
 glag==
X-Gm-Message-State: AOAM533unYgfl5chww+7hXmzuE9T0iGYNICXSqOnIXU+eApWbPCMXO+o
 94kPqGpWkBuVePBMA4lseLA=
X-Google-Smtp-Source: ABdhPJzesXmTEhgHW0KZeIMclsMQ/HLw4HTjUu1GUabI9bCijhC9qiqhsg2Sy37yA6AfgphG8NyvOg==
X-Received: by 2002:ac8:5802:: with SMTP id g2mr10176977qtg.383.1607621765004; 
 Thu, 10 Dec 2020 09:36:05 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id y22sm3886786qkj.129.2020.12.10.09.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 09:36:04 -0800 (PST)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH v3 1/2] ALSA: hda/ca0132 - Fix AE-5 rear headphone pincfg.
Date: Thu, 10 Dec 2020 12:35:48 -0500
Message-Id: <20201210173550.2968-1-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 conmanx360@gmail.com, stable@kernel.org
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

The Windows driver sets the pincfg for the AE-5's rear-headphone to
report as a microphone. This causes issues with Pulseaudio mistakenly
believing there is no headphone plugged in. In Linux, we should instead
set it to be a headphone.

Fixes: a6b0961b39896 ("ALSA: hda/ca0132 - fix AE-5 pincfg")
Cc: <stable@kernel.org>
Signed-off-by: Connor McAdams <conmanx360@gmail.com>
Link: https://lore.kernel.org/r/20201208195223.424753-1-conmanx360@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4fbec4258f58..e96db73c32f5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1223,7 +1223,7 @@ static const struct hda_pintbl ae5_pincfgs[] = {
 	{ 0x0e, 0x01c510f0 }, /* SPDIF In */
 	{ 0x0f, 0x01017114 }, /* Port A -- Rear L/R. */
 	{ 0x10, 0x01017012 }, /* Port D -- Center/LFE or FP Hp */
-	{ 0x11, 0x01a170ff }, /* Port B -- LineMicIn2 / Rear Headphone */
+	{ 0x11, 0x012170ff }, /* Port B -- LineMicIn2 / Rear Headphone */
 	{ 0x12, 0x01a170f0 }, /* Port C -- LineIn1 */
 	{ 0x13, 0x908700f0 }, /* What U Hear In*/
 	{ 0x18, 0x50d000f0 }, /* N/A */
-- 
2.25.1

