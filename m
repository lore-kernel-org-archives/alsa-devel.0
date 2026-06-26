Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC4AC43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:55:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA441601B3;
	Tue, 30 Jun 2026 13:55:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA441601B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820542;
	bh=9ApYCd9eoUR67lFP2ZptzcWwdF+b8C4vftRHSpyKXlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FicHSZCuqwOgTb5qPbS5e9C1NHcwwvvPT+FbrW4FfVCiAoWgzgetDxp9JFwdTBAdo
	 xQmCrI+c8s0qiIN/51v6vrPRPtt6utL34wg30atvT7pTH6HExz/OT8m6e+Gf0u5IoG
	 6J5+5MCPNTX7F7M7+mG0BWxSs5pdii635gVe94Bc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C20F7F806C1; Tue, 30 Jun 2026 13:54:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 266C2F806AE;
	Tue, 30 Jun 2026 13:54:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F0D5F80527; Fri, 26 Jun 2026 15:48:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782481685;
	b=FEQrhdBC8v8ET7LpjCy3k2qi5nwO8JJdeb/2t8FVJv5+LrfVqIs25OZ628+nMugQOAUa
	 jzUqaD6aaOsdn6SlOZrreqWSdPtxreH1GEfyW8K+Yo7lZSztKiFGYGWmbjE9AnCEaQ2Nm
	 N9EmVtyC0LN2xwDk4grepL89HVp24nIqnrtndXUOaqLNS7oP1wS8mT/hou7LJNoVWu1Ug
	 oPFBNHuwcHp6nvKGfs8B1nvMMNrhQAYs42UE7PxHA4ajkIRM+H18ZFOPE6aErAAhNpsyn
	 N8k9uFeogJO1ARJ+NH68TQOhDzqWmvgwKFde4R8vIIULEh7uXl0n4HAgPyiqCSjzOLg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782481685;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9ApYCd9eoUR67lFP2ZptzcWwdF+b8C4vftRHSpyKXlI=;
	b=mq7tdKn+0hCMnpILAAVE7gEjzGCM8vf2PQKPzHLFTbHHZpvmMSA2jczm2Vdf34qV5HLk
	 P2JkYdYuCDU23SHy1MqX9dY6AEu7q0RT9A0c+vujkeox3ItlC4IPgL8sQ74eyUsxmp5M0
	 dKNUCQEv+LRzZqgM3Xt3JKNA7qdCs5+S0m/n1WBv4LlrnQEWsmsxW9d+0PIxR1YCzjjkW
	 p7osEZs1MI/80Pu2ZAmQf39Qo3PlZIwE+0Es5g+MoB56O8iiatGovJWxnBoPPpOLuA18I
	 musSNmB2/yJI2yA1XX2qb5ZC1cdbTrOta76qkOeNtJ5bc+VTswHNBnWEvDXLDJc8Mqw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TgoI1ddS;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CFEC4F800D0
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 15:48:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFEC4F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TgoI1ddS
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49258ac7294so6756245e9.0
        for <alsa-devel@alsa-project.org>;
 Fri, 26 Jun 2026 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481684; x=1783086484;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+2YgZ2mqjyDlATLW5oPiZaPLYlj8ywXc3kq+B4OAO0=;
        b=TgoI1ddSCz0rixI48rSmKFgD1RX4Jtfdz5QkylpcuurDahRrJ+mdt/S0aAxrfC9rUD
         zhDDa4mG5V0jHT9wbPDf4U0dcSaiQ4Mkpf0ljk2KyqxNjjSnwd8UmKP1gvspSlVhBumF
         K7HHSp5LW/RGEXDqzDjxe3ZPLkVK4g0BuGjUcNLaicTk2yFsbxzUjsmQbYPT8t5owbpO
         7kVrV2tF0aq9VTSvr5UFX8WUm7ZSnTmRqoILCbD42R8ZF20OMo0VwCqyGf3PRBmkd3s5
         j9cuhNZBjLDdq/OZuQoTRlUQGtYcy9tRBL/xj9Qx1ufzL/S7y8BnvoOGJcI9LP8EBJ/w
         15fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481684; x=1783086484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+2YgZ2mqjyDlATLW5oPiZaPLYlj8ywXc3kq+B4OAO0=;
        b=hkuWP8h0FHvqtLNJflRYQ/7WF0T92DE5zCCh0urEQZOnzDrpCAXlHzlAPfVklTSUnk
         nsOgQ+ZmdCuKTVm+UEIRFhB35hjhxG+YghAX6KtaZ3ouMPauKv9CG42q/PV17B/vRpiF
         k9lMXQc8blb6tFQ94dLazLyEcCHPXvxAXn2xppppSMoarxY3PVHH/FkIkYR7ELAx0c14
         Qbg56tDOTFiHOSf0CQtbkTR5d/YjzybV9hxeQmJ6L1ClRD5JSmCd5tI+6tTQH4z5T8xF
         kXq4LL+SuJq8/pH77QawRzSGULECoTJKpI+d1rFxRtydxhL2OYzoq+ILI9E46DjH5aft
         9CTg==
X-Gm-Message-State: AOJu0Ywoje2QVnhzHBoANusHbuBGNRIoWyUnCbmk3y7B2+tKM5dDlYX+
	6hwWEagemaWfl2S1j4+W6fPtm54ZjLFtbW+GQzByQMSzZP2LTWFQ/85O
X-Gm-Gg: AfdE7ck8WhVc/YMKyftsKIi59duDjSwIbSF7RcCsK4fWm7gKWqz32CiNENDwfKNVLBl
	gXaG34gpWQdvyrEYPFxPngaIPfXdfLX6I7jGmz20XZIVBy358mVsXLHdQQnF/3DeeTgeBgykfhl
	NAjP1YUYLllBIJtyVAxv3lBZ/zv/jg1NrbRVBzTOV88JMxMl3JUjSBFn3ngePhjClrU8lU75GGh
	RnEMQAGuqIVk0v27RH2rm6APzMzfW7j2Ywy+m0usqSOYU/w2PA36s5zezbQIK9E9gRSlqyjiCKb
	jnxwiLzYjxi43wlrCeVvYYAJbuaxXeKRXiLrMHZAKx8M3wZ1JquOl7M9LW67DDA6yrznHRXfhV1
	bL50Y0um46k2uzxubpozo5KQyrB+0x+4eMI+J0g+VEQoA0P8v/zJGk7ydvYiw7WWoRq80p6z7qq
	jjMn1UeA02oLh5yZZ9wUeqo55Vl4gqbze8AFHirpGaXEdcGUb3w/Avgw==
X-Received: by 2002:a05:600c:6094:b0:490:da12:f1fa with SMTP id
 5b1f17b1804b1-4926689343bmr104030985e9.31.1782481684099;
        Fri, 26 Jun 2026 06:48:04 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il.
 [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:03 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/6] ALSA: timer: fix lockless tu->tread read in
 snd_timer_user_read()
Date: Fri, 26 Jun 2026 16:47:06 +0300
Message-Id: <20260626134709.27883-4-nevergfx1@gmail.com>
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
Message-ID-Hash: 7MP2DMCI2JYVQYC4HDTKF6OHSGQYNT77
X-Message-ID-Hash: 7MP2DMCI2JYVQYC4HDTKF6OHSGQYNT77
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:54:02 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7MP2DMCI2JYVQYC4HDTKF6OHSGQYNT77/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_timer_user_read() reads tu->tread without holding ioctl_lock to
determine the entry size (unit), then reads it again under ioctl_lock
to select the copy format.  A concurrent SNDRV_TIMER_IOCTL_TREAD64
can change tu->tread between the two reads, causing a mismatch between
the entry size used for the read loop and the format used for the
actual copy.

Move the initial tu->tread read inside the ioctl_lock and cache the
value in a local variable for consistent use throughout the function.

Fixes: d11662f4f798 ("ALSA: timer: Fix race between read and ioctl")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 51c6ac4df9f4..XXXXXXXXXXXX 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2390,12 +2390,15 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 	struct snd_timer_tread32 tread32;
 	struct snd_timer_user *tu;
 	long result = 0, unit;
+	int tread_format;
 	int qhead;
 	int err = 0;

 	tu = file->private_data;
-	switch (tu->tread) {
-	case TREAD_FORMAT_TIME64:
+	mutex_lock(&tu->ioctl_lock);
+	tread_format = tu->tread;
+	switch (tread_format) {
+	case TREAD_FORMAT_TIME64:
 		unit = sizeof(struct snd_timer_tread64);
 		break;
 	case TREAD_FORMAT_TIME32:
@@ -2407,8 +2410,8 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 	default:
 		WARN_ONCE(1, "Corrupt snd_timer_user\n");
+		mutex_unlock(&tu->ioctl_lock);
 		return -ENOTSUPP;
 	}

-	mutex_lock(&tu->ioctl_lock);
 	spin_lock_irq(&tu->qlock);
 	while ((long)count - result >= unit) {
@@ -2453,7 +2456,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,

 		tread = &tu->tqueue[qhead];

-		switch (tu->tread) {
+		switch (tread_format) {
 		case TREAD_FORMAT_TIME64:
 			if (copy_to_user(buffer, tread,
 					 sizeof(struct snd_timer_tread64)))
--
2.43.0
