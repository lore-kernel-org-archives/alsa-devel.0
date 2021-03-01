Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B24BC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 15:30:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E01464DB2
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 15:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E01464DB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FA3E16B8;
	Mon,  1 Mar 2021 16:29:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FA3E16B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614612623;
	bh=dwLwOW04yrCrWnLSViGwri/swmaChV8GHbhp0ZLVAjA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qAfr1H44GqfuD2RrTPxpfky/qFnLoQo9hCql1tLHMHdSd7QAi2h+18816CpUP1Fhc
	 1HPAO9LcILXrKFUHkFf6KcHwGogHQ9vYq4EH7Ggaguz+DIlriJl33v53uauFbFSl3q
	 wBeMvhNhogrkWMy4g5iYroLLZoWNlrY4tAb4kCeU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70095F802E0;
	Mon,  1 Mar 2021 16:28:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BE9CF80272; Mon,  1 Mar 2021 16:28:26 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2616AF8025E
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 16:28:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2616AF8025E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LlZyVzpF"
Received: by mail-wr1-x430.google.com with SMTP id j2so3735365wrx.9
 for <alsa-devel@alsa-project.org>; Mon, 01 Mar 2021 07:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6W/xTRp8He9BJ5rJ9sDchzMZU8/7AR1uLmgazPo2EWU=;
 b=LlZyVzpFWQUn2TwM76oXVGRzU9M+qtjgffKCemxdblkEbpl9jARjWrSbrtuzGJSuuB
 Ui7SJDpCxKsXY/Yy+REoqFFz+e4hMpOVsvJtyVNwF2rkpdQpn/OqQEArjlQnda1XZ4w4
 g1rnZA69xuKElojzV0DgIsGv6elc8RDEVWOO9+x/wLryeSp9vUOUowFfJbdVXoJLx5EL
 HqEuw/TnnhL9ewl31yB5rBfVz+nILENc96YR8DzmZkYv6x30BfUR0+Tx12TITyRwNcS6
 s/L10VYi/z8ql85bn6l+U8qYwcPR/7ZNYf/xf8N0sQQn5YQZ/4c9KgNVur7BxvV4NScG
 PYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6W/xTRp8He9BJ5rJ9sDchzMZU8/7AR1uLmgazPo2EWU=;
 b=hheuwwXaDZTbXQ1eUsRPaHMcyqi6RM1BKWqYA0gai5CBDdBSIHwOB62G+VJUbw412S
 KUoF5H/vz26k8B97Bf5PiP9ibwHfIJLGsqLaP8pZl5Fib1IobW+GAh10u0BNYUJXIb3S
 yvVhEhY8Uf0keqLjI1Lp3P2b8KRKiKdf0byfb26qsuzehxN3pYUCzczBdZ2TonAKcp3m
 R1rIQi6/Sw5VOEVHprJ6wtdfCU/wZnSa+U0iT3wlMnH0neYCd634MrH4BzdC8/BDm1uY
 5Kt7SrDkR7g7svccf1lCjbbY8KztW5mTiHZVrRAnA1OhfpTlFT2mN9nQrn3vCmYN9wps
 iMLg==
X-Gm-Message-State: AOAM532K1eEA2pqg13w/YFVgnzIRXglbe7ux+6rq/oxOmg1RC8AJTlZB
 3oB0NkUCjpQ3kIQgpDuEE6Y=
X-Google-Smtp-Source: ABdhPJzxPHkamR/efxc5NFfVeI53FiLL83+X+kckaSLih5fnjY7OG/LGcIuL298GVrzqLtn8fY5sHQ==
X-Received: by 2002:adf:a3c2:: with SMTP id m2mr16214241wrb.195.1614612502290; 
 Mon, 01 Mar 2021 07:28:22 -0800 (PST)
Received: from localhost.localdomain (176-171-138-112.abo.bbox.fr.
 [176.171.138.112])
 by smtp.googlemail.com with ESMTPSA id c128sm201771wme.3.2021.03.01.07.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 07:28:21 -0800 (PST)
From: Nicolas MURE <nicolas.mure2019@gmail.com>
To: tiwai@suse.de
Subject: [PATCH v2 3/4] ALSA: usb-audio: Configure Pioneer DJM-850 samplerate
Date: Mon,  1 Mar 2021 16:27:28 +0100
Message-Id: <20210301152729.18094-4-nicolas.mure2019@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301152729.18094-1-nicolas.mure2019@gmail.com>
References: <s5hv9abht6w.wl-tiwai@suse.de>
 <20210301152729.18094-1-nicolas.mure2019@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Nicolas MURE <nicolas.mure2019@gmail.com>, alsa-devel@alsa-project.org,
 livvy@base.nu
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

Send an `URB_CONTROL out` USB frame to the device to configure its
samplerate. This should be done before using the device for audio
streaming (capture or playback).

See https://github.com/nm2107/Pioneer-DJM-850-driver-reverse-engineering/blob/172fb9a61055960c88c67b7c416fe5bf3609807b/doc/windows-dvs/framerate-setting/README.md

Signed-off-by: Nicolas MURE <nicolas.mure2019@gmail.com>
---
 sound/usb/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 737b2729c0d3..d02dac5fcd40 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1503,6 +1503,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x2b73, 0x0013): /* Pioneer DJM-450 */
 		pioneer_djm_set_format_quirk(subs, 0x0082);
 		break;
+	case USB_ID(0x08e4, 0x0163): /* Pioneer DJM-850 */
+		pioneer_djm_set_format_quirk(subs, 0x0086);
+		break;
 	}
 }
 
-- 
2.29.2

