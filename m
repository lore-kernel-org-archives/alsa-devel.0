Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C8BC43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:56:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03C7B60250;
	Tue, 30 Jun 2026 13:56:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03C7B60250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820601;
	bh=n5Rtehg5Wikz/OKCAwRELwtd1STgfqx29gu7EcctqdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QHA+61f5EPPKZrbLY1tTgDhAZ9OvB4WhGzq+uOrW+wo9SjqhyRs5fCiyJe6Bt824r
	 IHlRuLlCpYwXS3WPRZC8MTAliuIJ4bXNd2CHUhm23EKwyCRR8g2+jRuo5594E/g7mV
	 WAf+f1lL8ACUY0zGOCcamx5Gyz9VWy7Km0AiOlEE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA8BDF80722; Tue, 30 Jun 2026 13:54:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 425DBF8071C;
	Tue, 30 Jun 2026 13:54:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBE49F80549; Fri, 26 Jun 2026 15:48:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782481689;
	b=G4VW+1N9kCl8JAtNrWXWJorJwilq1iHstNSGb+QP6xZg6hVTd7FKuGZfJPYYF97CdA/+
	 454X9c3efsjyD9Z+KWW018A+X2S6hipUiycJRiJyePwH6I7xYsdzxlQOoEUQk3Veo1q0c
	 nNlLKdyO7MQsOFs6/idD0GzYnqN0oWA30JMDOEfmZ92b+3nykH9Q+5pY+19OitAtc4xFZ
	 sp/Wecx6Mv+9HHo/IyjBqTLf3joEYnvkf/GuSPXi//bRCdhx3aXwcetmvXsqsGaQt0O6E
	 zJZM/Vy2yr9qqf5DlELAmDxAgqFQXygWX4z8sZIT+URvh/16Mb+mYOn4HZglU12Ya6Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782481689;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version;
	bh=n5Rtehg5Wikz/OKCAwRELwtd1STgfqx29gu7EcctqdE=;
	b=nsxRgiLTUxfZdHFxCUWOXygzkq3oiDSwjkr/DH1oBjwTuQElUDbH80fn9uK+SPHdMq8c
	 wvMXLYXBN5lW1rB+VxAIGqeExV+4qzcGcQpZixVYA8seZSG9UY293zTHwTq9PpQIsbvh6
	 4KPDFQeDGB0cfyaOvJM0NtIcxUl1YwJkc5oSdKfP4185L9c8yAtJBLhdr5M9TGCF5c8ro
	 RBOcCkGEc/odemzjr14iA6tS0G7zL0NqdgllybZGciRc22lnzMtJq79GtipUUtjMfot20
	 paaBPEzrmOQKsVT+T0PUhustun27L1MHwaAIz43pcEzx+z4L9mp1MW3nYINf1pogPpw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NHamePNw;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2C965F800D0
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 15:48:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C965F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NHamePNw
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-46f3ca3c598so792822f8f.3
        for <alsa-devel@alsa-project.org>;
 Fri, 26 Jun 2026 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481687; x=1783086487;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYwJhG59Ofi/WzjVAi9x0eXfAYxxgdst32Q14etLU8k=;
        b=NHamePNwjJjgNItfI9MFvElCOXKuIHZ1yA0F3bnJF6VPZEnhwp0sIDDhUiXI15WbQ7
         Z8b06rr+K0KCUOao4EngWIsj63QWYzuHJk8zuJd1rY1MAMhVC1buWNUL4Vc2YEw/dNAr
         hf8yFR4azF7J4dsnpDVeodC64rS0nYLEH33fYdi41ZgU4XYDZh4fAC2hoHlJZNGUcJHJ
         cbDLH4HMSMPRP6TlQnsNx7PLOpn+A9yiXpnJ11mUDaM0m3Pp32QjUMB0CIcbC+fHytNi
         mgEwvkKve7g4vtrDRkUMuntEgIjmsOSUoIyTKXCh3TNlDZfgSmmGT6JqS7UgleGeQUiU
         e/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481687; x=1783086487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mYwJhG59Ofi/WzjVAi9x0eXfAYxxgdst32Q14etLU8k=;
        b=jsAVV+xysEKb1XNUju2It8YdRtwfgOR9poaGJDfpM4ziGQ19Jqik8J56xBArLe/G3l
         LHVCq7tQgzXcqnWhFWpNOJbxFpI/8vKIyrFGXqwcywlevDHmLBPSxiNTzDDcmw6fR6nu
         EdP2hUIkJAGRBBeqRQC/0Nez+3CDaP1hyLHPSkTkACCzLebzOLOAlaFr3R+IpZvmroJ6
         9XUlhzIjlgGY15Y/XsrDokReSq1Dz+APFDuZ5xzVLh0eQ6xecuv7ViuOFmCGMCriCqx+
         I5CPNpxvr5m8zhjgM9UR9wEpi5x0c3BQFgsqqXnUfiHqxkkZuBljGJCKLqBDzC1Esb4t
         xVeA==
X-Gm-Message-State: AOJu0YyrevcgeR2U9CDIwhobWFAVJ7XNJNcpVYXm+mKkz+aYdQ3KeAD6
	DOnZelUS/agJr8gDmyycrjaVMQsN+SJn4/XMLuFzgPcBG83RRrOjJerv
X-Gm-Gg: AfdE7cl2LGJCefVFws7/dZiSjW1z7Tg5XZ/GVMKHSmgsNoX4ASiIji+lBqeNYtlUy0s
	XhOACws4SLPZkQ3MbprqcOwXVICXCEUHb6dvy6bOPe4BWTkmLwCK6Df0lQkr3snOFB5Z6+WxpwR
	edV53FyZ0+zadjUnJ0CgKFtH072ZRpwMKWFd3Sxdsds8i7LXaraMoQ3sbWV76tjtImp6JTT+8wd
	MII75idzZCwRmDh8J5dZnPgJ9JR1nlhpc7OezIhbyfmgW1lkPAo0nXbhfTqlQPwOzbWETeBQ0DW
	p1t2rrLznIqfWNqYgKsgg3mY53n1ybHV628iOie5w8g98S+fpGeuw2fcIVI3y58azd2Zwxtdpsn
	D0crj0uD+Xm3slIwYP9QpcDgo4FVmocGWHgcH8YzcEnrmwPDNP2W4cw1bM/XkkTMyf9v8n6KOjz
	56HwJpUKkrdS4kMAVbTA+JiOyQmgUorS8AA/345mjLa2gTguwKHaiPog==
X-Received: by 2002:a05:6000:5c9:b0:46f:dda9:35b9 with SMTP id
 ffacd0b85a97d-46fdda93626mr445196f8f.34.1782481687248;
        Fri, 26 Jun 2026 06:48:07 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il.
 [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:06 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/6] ALSA: pcm: use locked state read in snd_pcm_drop()
Date: Fri, 26 Jun 2026 16:47:08 +0300
Message-Id: <20260626134709.27883-6-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: nevergfx1@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: C33KQGAY5JUHZHVLIUGR3MAWF7AXCN55
X-Message-ID-Hash: C33KQGAY5JUHZHVLIUGR3MAWF7AXCN55
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:54:03 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C33KQGAY5JUHZHVLIUGR3MAWF7AXCN55/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_pcm_drop() reads runtime->state without the stream lock at lines
2274-2275 to check for OPEN and DISCONNECTED states.  The stream lock
is acquired shortly after at line 2278.

Commit 7bc02ab446d3 ("ALSA: pcm: Fix unlocked state reads in
read/write file ops") fixed this exact pattern in the read and write
paths but missed snd_pcm_drop().

Use snd_pcm_get_state() which acquires the stream lock for the read.

Fixes: f0061c18c169 ("ALSA: pcm: Avoid reference to status->state")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/pcm_native.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index XXXXXXXXXXXX..XXXXXXXXXXXX 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2265,13 +2265,14 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream)
 static int snd_pcm_drop(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
+	snd_pcm_state_t state;
 	int result = 0;

 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;

-	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
-	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
+	state = snd_pcm_get_state(substream);
+	if (state == SNDRV_PCM_STATE_OPEN ||
+	    state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;

 	guard(pcm_stream_lock_irq)(substream);
--
2.43.0
