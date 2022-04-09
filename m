Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA00C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 09:53:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77A3517CF;
	Tue, 12 Apr 2022 11:52:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77A3517CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649757223;
	bh=WGukVjkw7BNEIqEAQvmlQcjiwR47VtV2PCMJE5gUg/M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bo4Kti3+8W6woNrIjbHtngJfSIuyolBXYdLf0rcVBuBXAZ8NHUPpUf5tVEvgNKcmA
	 Ar1V/JyqI+UmuKWJYuMJtEWjM1beJIc14sQxjgNfYFOiXFkYcVg/vtI84Cb0kEUHm3
	 ZsVw+83pAYjfT5Fl5l1pYQgB7aYCHJYBL1HGrI/g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EFDEF80516;
	Tue, 12 Apr 2022 11:51:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6B41F8014E; Sat,  9 Apr 2022 03:27:08 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5532BF80054
 for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2022 03:27:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5532BF80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="PMKYe/MX"
Received: by mail-ej1-x62f.google.com with SMTP id n6so20339571ejc.13
 for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2022 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=V20ogy15QSuxdpuKVHUkoJksm5vVNKi7GT1C1mjhHXY=;
 b=PMKYe/MXNHQ+p5OXztmFPRWaEC1Yh/8Z7y/lFaauLXrJHr0SJsxzwqHu53EnbrQdEN
 pHP535YndBGM5B+L/tv/Sd58GLIZCxRx1a946l3Xf2hKP6MAf9g5zZ65C4pLkp2UFDGo
 J/SEV7vPj/lOggS4oKQd+Z3iTdn/jd0JyMWogLMw/LsaJ9zt3DF620uKA6C4W10cLMfA
 bpd3PH8Cv5sdALTQIRoS1GDhVZJwYzAGzbVzTzRU3yoZnMqDYvUT9bVEKrOhaTud3iKt
 Pc2WV/vxhE8E9ac2HFtuVR+FBsxuL2Xxq+Ifv9EgdhlefQLznkKQZ2A0CU1oPkJBT0WL
 Xgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=V20ogy15QSuxdpuKVHUkoJksm5vVNKi7GT1C1mjhHXY=;
 b=lB1H82s1jrv8ioAvEsGPA80u2RRzA/mBLurLw7qz4nRx/wWCncAPt54qodPS1dYevJ
 iTcshQF8noVe9UuLYtR9YktLfaIjrLCKHr6E0NJyAt8NTpti8l3Hvd56VkOG9DLSFUEo
 fbWBH1Pfdtq0v7LHfcskPB+vPqVuWxIdLEonaPXxY4+XP89e9xKEarexCLgoaYP7Whyw
 ieG23gDciIboDdC3ael60BnK9BIXXmgF+s2o6C6y8JT9QYDIfX0C8koSrOT4oaoXuLvx
 cYUGHvHcQ3IOeloV9xgXvQuv/rCcpOJUXEf4chzkoq1dtS3QjonkhHKg7N2VWwhkIiRj
 rXPA==
X-Gm-Message-State: AOAM5313fdfSxEUiks/AhZFgaXKAHhq77Xez3XuU32QM+NEgnhjVkDbw
 rFsfvBjFH+UiVhKXTXZLME4=
X-Google-Smtp-Source: ABdhPJzsD4wz47pVoeaUipKgKPbfrsRcc0CT1jwMVHwGIO0R9c+9JHElm5k88QKuJ26PxFEhx0l7Rw==
X-Received: by 2002:a17:907:6093:b0:6e0:dabf:1a9f with SMTP id
 ht19-20020a170907609300b006e0dabf1a9fmr21001267ejc.424.1649467619145; 
 Fri, 08 Apr 2022 18:26:59 -0700 (PDT)
Received: from localhost.localdomain (host-87-4-4-217.retail.telecomitalia.it.
 [87.4.4.217]) by smtp.gmail.com with ESMTPSA id
 hr38-20020a1709073fa600b006e0280f3bbdsm9265487ejc.110.2022.04.08.18.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Apr 2022 18:26:57 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcm: Test for "silence" field in struct
 "pcm_format_data"
Date: Sat,  9 Apr 2022 03:26:55 +0200
Message-Id: <20220409012655.9399-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Apr 2022 11:51:33 +0200
Cc: syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
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

Syzbot reports "KASAN: null-ptr-deref Write in
snd_pcm_format_set_silence".[1]

It is due to missing validation of the "silence" field of struct
"pcm_format_data" in "pcm_formats" array.

Add a test for valid "pat" and, if it is not so, return -EINVAL.

[1] https://lore.kernel.org/lkml/000000000000d188ef05dc2c7279@google.com/

Reported-and-tested-by: syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I wasn't able to figure out the commit for the "Fixes:" tag. If this patch
is good, can someone please help with providing this missing information?

 sound/core/pcm_misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 4866aed97aac..5588b6a1ee8b 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -433,7 +433,7 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 		return 0;
 	width = pcm_formats[(INT)format].phys; /* physical width */
 	pat = pcm_formats[(INT)format].silence;
-	if (! width)
+	if (!width || !pat)
 		return -EINVAL;
 	/* signed or 1 byte data */
 	if (pcm_formats[(INT)format].signd == 1 || width <= 8) {
-- 
2.34.1

