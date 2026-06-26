Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7426C43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:56:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 448F76024E;
	Tue, 30 Jun 2026 13:56:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 448F76024E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820584;
	bh=+yp65ZMJ1cytb45g8rsqMYMiCYNglTQbBWFgdPsXs8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VHQYQmALnMi7+MvoG7Mp+cmAK+4vKgRtvJ363UD39o75QgP7/OOWD99rqAU7c6PYS
	 y5/fiTXh6++Qjx6bTI7XOUV0+T80BoY3faokTE1LnXVQh+Y/DKhvcfrtPzbevwrTJY
	 Ne2DFd13X7zLpE2pPDRYcwrrkgQuOq5xtMItvO0c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD645F806F0; Tue, 30 Jun 2026 13:54:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28380F806ED;
	Tue, 30 Jun 2026 13:54:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57CF8F8047D; Fri, 26 Jun 2026 15:48:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782481687;
	b=o+C+Qwv9PTg3YleasXyrtlvEL23oRTlq+zCBOwe7i9Af/SwGwyDvZ9lxThNFSe8Nr7Ue
	 MYGvwhnPhAgyMGbG4dSweDaTei7bE4nXLc/1K/kS0DujVCfdGv6p+TjKDXezRWrwJFWWm
	 uuvHs4PNaQXfORHQSFQN8OYKjscuyn9aaRFileXd9/HTzEOOBAvEZ/ZfCZqa+warCV7Zw
	 4Vps/duir1jM4CSC9C/fH7m/PKOJuZhGdyPCKoS3PD0Lj3thMo+66TwM61HWlh5lWF6W1
	 ogfDEsa4/Wc0+EZo7NNgkt7HpEBjEflhZp/QTL5z3s4mzlXYWgKLn0f8dWfHI3kjYUw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782481687;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+yp65ZMJ1cytb45g8rsqMYMiCYNglTQbBWFgdPsXs8w=;
	b=XOIltM8GStJl66htfdUcG4kDcpErt7QtrMaC2LjJlBMgCMf3kz6URUpuaulGQOJwM2ly
	 7UZCxp0jlMvLuPNvkcKmPEiurR+YgggVmA0JWUdKL9QgBJ+5S+JTTIlipwB2bO/hEn0lo
	 TSCfn0NG9mti0pGAhLnZAB9f2hhNZDVTwCJq2cA6rFG0OtQTm/PPT58W3M0Q31U0FkNJt
	 En98hHoUIWl7VLyM9OUzWtILAkBuz7+pBO6nM30wBdXzQPI7IZsUBvXeUUpHdDqpRB4J/
	 SYLkESXNsxzwwXrpKH7x3CqG9lIcNrrwPUEHwbke1KlKlODtO1VRNFHDmzeNmLZWNbQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=icnCVhw6;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A1890F804FF
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 15:48:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1890F804FF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=icnCVhw6
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49263703c6eso9183175e9.0
        for <alsa-devel@alsa-project.org>;
 Fri, 26 Jun 2026 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481686; x=1783086486;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M+4tAlkQOkrOABWP7WLdmPAG77uMonsQWWyHYvgdTM=;
        b=icnCVhw6jkSVSF9AIrP6l04b1MCXLxbgVT++HON4qABvBw3zxECzuV4A/X6gWSUh2S
         R7gUKeQPxE+2ZoJMlZo5N6kR8WIioBItrZoHAbGAWOA1uJ30YhsXVkNwJPPLkK0C3pTi
         CFCzVItfEXyQGDhcIKAuVb7JrAtLUbyhnNcYrrtXogADqI9RnlRNBoXN9tj2RDpPYzWk
         Zy0i3V/bnKJ/AQrgVuLUWhW8vM/Wz1mE8MpndYm8gwl5HFrvqsS7PxsebpJabunR6dzV
         PgA4eHhasreZWgak81zB1MLAqGw3lJY9Od3j/BKHwMLWwrokPuPIP8sZMVrNfHt7Aqg8
         i4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481686; x=1783086486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7M+4tAlkQOkrOABWP7WLdmPAG77uMonsQWWyHYvgdTM=;
        b=Y6qicY2DeQEWHylSH0WwvLfEkst5m14NRMAzlmlO6bGScUL8GKRX8y7w1zw3kCo5v2
         5h0735euF19RjWbJwJssJLgtMeE6B8wnTdXWO3kn3dv7BIDTRlm2OTnxIoW8FzAO/tfp
         ZP5t8aLBCuWNWL4fG8H63nGzOw6Yq1HqhkO4YIoBRJSTnq824IvILi1wfwVAYJ50F9ku
         2NTSQbmlBJFbHGDAHpJh1yuWunF/gk+Y/amwlp6PIS4TuuAmmuv+9FS8OL7cVCj6GMS/
         dnW+FsXmnt+0A1bcRXsJ7sUHPsPwyfTY/06WVtWXB4s2nxdPBwI/GHm8BwYuO/JheeJF
         GhtQ==
X-Gm-Message-State: AOJu0Yym9OHU7mss/Xu8G7L8Ew3YVs/8GgZrazlHcPqLOYgZ/hkUpR29
	WswRXkXV442p3IUiK1/Y6SopTgTxk2Xa3DdjxvBZPf3NSP5JpC+NcMjj
X-Gm-Gg: AfdE7cmotd+Z5kRvXUdxfW4KKwul5s4k7yNm5+nJk7tJ2ieP4OAZBkhfkJOthFtSRdI
	0LcKIV+J69pKpovC0SgaBlAxLiiMqxcMrUNbbJ/kXBvigYE4GfCvF6nUuAWmzb77qtu4OhIVN4n
	Eruhhpg7y7gPc1P1q9Ebe2/m1M0K7TIsQuwz0J8gklVQ0W2j4qD7z1ZpWpSU5ihRhxpkYqKl0IT
	cZ6dtVsBU08GTDQdmDkYokKU25HC5fvkCPreXTJyoeGvQIBXLJi3UIdzW0U+59hNC62Da8KLTvR
	G8E7yOx2X5JkaeJtQKFDcamiqtF0B0VedVXYfN9ZI9rBg6MSVgtM8dwHFVUpIfQKO358bkCXuNA
	gPdFUFjUZ13CX4XVtu883tzRhoxzevCNXD/naE/7DcQCfE8lqQ/QSaDcr0SQDvRXg5Il67NnZU2
	fV3KdKqKOpcDZHRFymcG+Jtxx7VklcUELFJFNqEA8RUT/Xb06Pzga5k/fDjybUwtwJ
X-Received: by 2002:a05:600c:6215:b0:490:4b89:535f with SMTP id
 5b1f17b1804b1-4926685fcc2mr94668595e9.8.1782481685852;
        Fri, 26 Jun 2026 06:48:05 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il.
 [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:05 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/6] ALSA: timer: copy queue entries to local buffer before
 copy_to_user
Date: Fri, 26 Jun 2026 16:47:07 +0300
Message-Id: <20260626134709.27883-5-nevergfx1@gmail.com>
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
Message-ID-Hash: 27JLAMXHOI342LETEZODRKWXQ3SXSW7X
X-Message-ID-Hash: 27JLAMXHOI342LETEZODRKWXQ3SXSW7X
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:54:03 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/27JLAMXHOI342LETEZODRKWXQ3SXSW7X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_timer_user_read() dequeues an entry from the timer event queue
under qlock, then drops the spinlock and calls copy_to_user() directly
from the queue slot (tread = &tu->tqueue[qhead]).

While the lock is dropped, timer interrupt callbacks
(snd_timer_user_tinterrupt) can write new entries to the queue.  If
enough events arrive to wrap qtail back to the dequeued slot, the
callback overwrites data that copy_to_user() is still reading.

This is the same class of bug fixed for the non-tread queue path in
CVE-2017-1000380, but the tread queue (tu->tqueue) and the NONE
format queue (tu->queue) were left with the same pattern.

Copy dequeued entries to local stack variables under the spinlock
before dropping it, then use the local copies for copy_to_user().

Fixes: d11662f4f798 ("ALSA: timer: Fix race between read and ioctl")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/timer.c | 19 +++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 51c6ac4df9f4..XXXXXXXXXXXX 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2390,6 +2390,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
-	struct snd_timer_tread64 *tread;
+	struct snd_timer_tread64 tread_local;
 	struct snd_timer_tread32 tread32;
+	struct snd_timer_read read_local;
 	struct snd_timer_user *tu;
 	long result = 0, unit;
 	int tread_format;
 	int qhead;
@@ -2452,23 +2454,23 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		qhead = tu->qhead++;
 		tu->qhead %= tu->queue_size;
 		tu->qused--;
+		tread_local = tu->tqueue[qhead];
+		read_local = tu->queue[qhead];
 		spin_unlock_irq(&tu->qlock);

-		tread = &tu->tqueue[qhead];
-
 		switch (tread_format) {
 		case TREAD_FORMAT_TIME64:
-			if (copy_to_user(buffer, tread,
+			if (copy_to_user(buffer, &tread_local,
 					 sizeof(struct snd_timer_tread64)))
 				err = -EFAULT;
 			break;
 		case TREAD_FORMAT_TIME32:
 			memset(&tread32, 0, sizeof(tread32));
 			tread32 = (struct snd_timer_tread32) {
-				.event = tread->event,
-				.tstamp_sec = tread->tstamp_sec,
-				.tstamp_nsec = tread->tstamp_nsec,
-				.val = tread->val,
+				.event = tread_local.event,
+				.tstamp_sec = tread_local.tstamp_sec,
+				.tstamp_nsec = tread_local.tstamp_nsec,
+				.val = tread_local.val,
 			};

 			if (copy_to_user(buffer, &tread32, sizeof(tread32)))
@@ -2470,6 +2474,6 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 			break;
 		case TREAD_FORMAT_NONE:
-			if (copy_to_user(buffer, &tu->queue[qhead],
+			if (copy_to_user(buffer, &read_local,
 					 sizeof(struct snd_timer_read)))
 				err = -EFAULT;
 			break;
--
2.43.0
