Return-Path: <SRS0=XrcS=NS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71D1C432BE
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Aug 2021 15:38:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1878D60FDA
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Aug 2021 15:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1878D60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A852C170C;
	Fri, 27 Aug 2021 17:38:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A852C170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630078735;
	bh=WUqfD2pC6BWf112dl5CNJKTfdSh2hWR/AjSeTkNFVzw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c+8uB/smUCMyt4hggEpEf02mdxF+k0pX6u9UZibw4U0UeNCfsBlbx1OwWXWWUcAEz
	 7JAGGeaKJadFUOj4bfLGUGXCOMC7KmI93udhHrNCXoFhqfdAwYO+szvAOksiqoHhf0
	 5u+IpiJFbEKsl7RibRuHt9xAR8M1CLJYo43sD9s0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D27CF80107;
	Fri, 27 Aug 2021 17:38:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EE02F80129; Fri, 27 Aug 2021 17:38:03 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC05AF80054
 for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2021 17:37:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC05AF80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="GjTnPpvK"
Received: by mail-pg1-x535.google.com with SMTP id e7so6290281pgk.2
 for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2021 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5fGpvFFSR6Z2EYtwBS3YhrtThiDvO4JMN2bAX/nLtf8=;
 b=GjTnPpvKfExL0s9AksCZOm8pMb4kSmBZ9mH6ETTF8jNgP/Lle/6S4y1PDFxKgx7G39
 bqx7wU0vDC1ic4bPsOJlWUpfc2IU2spHNl1HFc+XSVhimaU8mVrrTpPvGFd1ueZc69M3
 sV9Peykj+t4iFVDqIr2rmjFgGwC+srymNI3xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5fGpvFFSR6Z2EYtwBS3YhrtThiDvO4JMN2bAX/nLtf8=;
 b=nTxi4Y7aI3aqQEdyYGDRrHd1eDXfQ+4b+CzPi+YHE9/XwlBj7T7JyNTgoxMUjvEWGE
 r66DleC4EKbaUmGgm7KpJYvHsIz59AEhiC2Uc9LpRyJw6HzWD6xS8GlnusMJAFgEJXJG
 /Snlk8LZ9aQtSiteKawYtNB+JHavaehaDNeXXJcyojUSsnpcGwnDAS6A0vt8ZNNw2SGR
 P2CrJILvsJnhF+TV6i1ibZGbp/QqPnUdax7V3boKZnF2uYv+izX4zd1POcCwAbGHS4Sd
 76D5jJ3x0qmyKaEed4kIr0hE4pE8ZHQRBChtm1qUALW0ByAzUWTLRd2stX6Q4qJS3+WT
 fDPw==
X-Gm-Message-State: AOAM530QQV7u2XMRtiydDQWtE0ZD9n4lW6tyTgExjj3s+Q+cwQFUHM25
 CNLGOCraDUOMIMhW3S++8JF6ps/K0U0MUQ==
X-Google-Smtp-Source: ABdhPJxMmXVJPN9uHneFkD4brsiADZYIke5VCr4D+/Nm0219HJQrONu/1yu1Lbt+Gm6erBlgJ4Rkrw==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr8387515pgj.407.1630078669693; 
 Fri, 27 Aug 2021 08:37:49 -0700 (PDT)
Received: from zsm-linux.mtv.corp.google.com
 ([2620:15c:202:201:48c6:7176:3bae:a573])
 by smtp.googlemail.com with ESMTPSA id y21sm6580263pfm.52.2021.08.27.08.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Aug 2021 08:37:49 -0700 (PDT)
From: Zubin Mithra <zsm@chromium.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ALSA: pcm: fix divide error in snd_pcm_lib_ioctl
Date: Fri, 27 Aug 2021 08:37:35 -0700
Message-Id: <20210827153735.789452-1-zsm@chromium.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: groeck@chromium.org, tiwai@suse.com, Zubin Mithra <zsm@chromium.org>
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

Syzkaller reported a divide error in snd_pcm_lib_ioctl. fifo_size
is of type snd_pcm_uframes_t(unsigned long). If frame_size
is 0x100000000, the error occurs.

Fixes: a9960e6a293e ("ALSA: pcm: fix fifo_size frame calculation")
Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 sound/core/pcm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 7d5883432085..a144a3f68e9e 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1746,7 +1746,7 @@ static int snd_pcm_lib_ioctl_fifo_size(struct snd_pcm_substream *substream,
 		channels = params_channels(params);
 		frame_size = snd_pcm_format_size(format, channels);
 		if (frame_size > 0)
-			params->fifo_size /= (unsigned)frame_size;
+			params->fifo_size /= frame_size;
 	}
 	return 0;
 }
-- 
2.33.0.259.gc128427fd7-goog

