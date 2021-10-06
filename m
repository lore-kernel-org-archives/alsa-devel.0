Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E16C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:16:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37F2610E5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E37F2610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BDAC169C;
	Wed,  6 Oct 2021 13:15:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BDAC169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633518969;
	bh=14utBTnVu/9mbipzCGXIpaBWLjpPIZQ3PDlawEedbKE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vR2Qcdabfr6FV6qb5ANmKfq9q/qi4ouTV69cWJ33ZZGPkBdD2GypuhoDt8zvrYe23
	 CQK7Z/CYnRAinouzPfXz4k5C/n6tcuav2heV3kOngXY+SBYEWD9CLy/CFw/2eJ5ts9
	 yEvD+xhbdpFizuz6/poGTrgb6kJJZPt/gGLa62jk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E81DFF804FD;
	Wed,  6 Oct 2021 13:13:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E71C5F804FA; Wed,  6 Oct 2021 13:13:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F4AEF804EB
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 13:13:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F4AEF804EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SKktJo6/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4ABD611B0;
 Wed,  6 Oct 2021 11:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633518791;
 bh=14utBTnVu/9mbipzCGXIpaBWLjpPIZQ3PDlawEedbKE=;
 h=From:To:Cc:Subject:Date:From;
 b=SKktJo6/H7SIgQevFoDdBLbcxWecVdu0yUXfPqwSNJ7w9Lx28KloE0rw+gB7SKC4L
 fcTiuYLIzNYnSUdoKl5tvE8WOOig+rcWn67ZrR7Hu5nipeUTVK6Cbu/VZ7uMDsE95m
 oRWkgN1w1571tWJuXln5d26Kgc5aWYPZfI1SvmCtlBXMpWJBhp7gI2GvVKGlsG1iHf
 yKO3FzlR4qQ8bWoud1tvKWkz793F/N9kl4a94f9edtClBlLRvDAZ9OQl8XaincSg43
 0NeK+zzxKGBIbkeIuDwrL4L24aML4wJ7qQZ5/W1e20NF8N0sxxulCjCT5+u4UAbX+3
 iFhCf8jpjADYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH MANUALSEL 4.9] ALSA: pcsp: Make hrtimer forwarding more robust
Date: Wed,  6 Oct 2021 07:13:08 -0400
Message-Id: <20211006111309.264510-1-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit f2ff7147c6834f244b8ce636b12e71a3bd044629 ]

The hrtimer callback pcsp_do_timer() prepares rearming of the timer with
hrtimer_forward(). hrtimer_forward() is intended to provide a mechanism to
forward the expiry time of the hrtimer by a multiple of the period argument
so that the expiry time greater than the time provided in the 'now'
argument.

pcsp_do_timer() invokes hrtimer_forward() with the current timer expiry
time as 'now' argument. That's providing a periodic timer expiry, but is
not really robust when the timer callback is delayed so that the resulting
new expiry time is already in the past which causes the callback to be
invoked immediately again. If the timer is delayed then the back to back
invocation is not really making it better than skipping the missed
periods. Sound is distorted in any case.

Use hrtimer_forward_now() which ensures that the next expiry is in the
future. This prevents hogging the CPU in the timer expiry code and allows
later on to remove hrtimer_forward() from the public interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20210923153339.623208460@linutronix.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/pcsp/pcsp_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index 3689f5f6be64..3766624c018f 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -144,7 +144,7 @@ enum hrtimer_restart pcsp_do_timer(struct hrtimer *handle)
 	if (pointer_update)
 		pcsp_pointer_update(chip);
 
-	hrtimer_forward(handle, hrtimer_get_expires(handle), ns_to_ktime(ns));
+	hrtimer_forward_now(handle, ns_to_ktime(ns));
 
 	return HRTIMER_RESTART;
 }
-- 
2.33.0

