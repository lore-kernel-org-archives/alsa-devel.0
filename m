Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA05FFA373E
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 13:05:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A865E7691;
	Mon, 24 Oct 2022 15:04:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A865E7691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666616713;
	bh=eRSweSNYBVnFL4RXqNIHxHqL02Bf3gPIN5mHCC3vKfA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ESmiu61pZvrR3vKJAk/Z36b0D509IQ3CkOqUWc5nhscTwV87e9K4pH2BSJGhZb3Wc
	 qvkYZ2NPv6s9t+u1sQ+2b27OMI7uPt4P/JNYkAhkmpnrPf/bQthPy5uOa8+Kthzw31
	 0RHSQb18DzqadSzsXHMPQXA/GmqsCScFdt5MJ6Vw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 493C3F8052F;
	Mon, 24 Oct 2022 15:04:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4A4BF80533; Mon, 24 Oct 2022 15:04:21 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47192F80431
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 15:04:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47192F80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RD2hU3Ko"
Received: by mail-wr1-x435.google.com with SMTP id bk15so16058454wrb.13
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcT81dsOX50qiaKz4vINoGth0qfnpFewSvnJVe0v6GM=;
 b=RD2hU3KoduxI2YfWHayb28ysUwpHbeEzDpkWXSRe1hQVBB7vI5HJkjAEOIp9GG2e7S
 Wb8q5wX5u3AoTjSl5a5sbj/7i5czN8IYwPyD7tCuhNgz9d6u4YJtwfNSYMSbwf3gEEaf
 /407NCLoWXbwhgNM/ZT9cIH+9qgVRjxEGcw0sNpl6mcjbTO7mnAA3pOMxDjLLRGjymV/
 DxX+D/Qf16djnAO0Cr5LUZLE3sUzs8Y4Tq8Xm44cc3n2Ws8abt1d2qWmvUey02whjXzQ
 Ct1pgHdNW6H2JeMtgJ8VSygtxcbi+fwPiy80AP5If1uw5PDmCDn76/gs4jErczN/c86b
 BOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZcT81dsOX50qiaKz4vINoGth0qfnpFewSvnJVe0v6GM=;
 b=bPaMAN0afaFCt9jWhDQW/osR9tpFqBDvi7WR/TVeaXsCQ95xkyi5bC6ByR+A0HXI3x
 adtN1kB7a+6d1/IzhSrOcOJ7Eqyd0p5yRDnjbEYTZZgplc1Kza8N1c1zUwqS9aOqYpn6
 skrj6BHn6XqKLBnfxVVAwmcL5N3uD1ZYBZyVDzRv+NDOpXq1YtXq7iLHX00cQsaysPHv
 y5bRDP1t9VJ5BTOQLjreDSxAFRUOvVxGgtB7vMKiOvYmLECts8k2u7Ad1XK1FqAMKCzk
 Ni0vUojU9RaiFx5rUMdJSefruv4jb6YTpI8M75EbuBSR6sg2ROvzDiZoRB7tCV7PjYrQ
 jBXg==
X-Gm-Message-State: ACrzQf2LSACeoVy7B3irRyExyDsk4qkIkkQKolV2RbTkTjZRFaMxac/6
 N3P/UJmXmsHJejge2QcQCqc=
X-Google-Smtp-Source: AMsMyM5PWCQoY1oCIj0f9q6/UiAGZDAiFpyTTtXsShfeswh89X4+ely/gnqcv+fClVfORRlZZaNl6w==
X-Received: by 2002:a05:6000:1882:b0:230:9046:122 with SMTP id
 a2-20020a056000188200b0023090460122mr20371363wri.49.1666616657310; 
 Mon, 24 Oct 2022 06:04:17 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net.
 [80.193.200.194]) by smtp.gmail.com with ESMTPSA id
 f8-20020a0560001b0800b0023677fd2657sm1378422wrz.52.2022.10.24.06.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Oct 2022 06:04:16 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: rawmidi: remove variable dest_frames
Date: Mon, 24 Oct 2022 14:04:15 +0100
Message-Id: <20221024130415.2155860-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

Variable dest_frames is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/core/rawmidi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index d8edb6055072..7147fda66d93 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1050,7 +1050,6 @@ static int receive_with_tstamp_framing(struct snd_rawmidi_substream *substream,
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 	struct snd_rawmidi_framing_tstamp *dest_ptr;
 	struct snd_rawmidi_framing_tstamp frame = { .tv_sec = tstamp->tv_sec, .tv_nsec = tstamp->tv_nsec };
-	int dest_frames = 0;
 	int orig_count = src_count;
 	int frame_size = sizeof(struct snd_rawmidi_framing_tstamp);
 
@@ -1077,7 +1076,6 @@ static int receive_with_tstamp_framing(struct snd_rawmidi_substream *substream,
 		runtime->avail += frame_size;
 		runtime->hw_ptr += frame_size;
 		runtime->hw_ptr %= runtime->buffer_size;
-		dest_frames++;
 	}
 	return orig_count - src_count;
 }
-- 
2.37.3

