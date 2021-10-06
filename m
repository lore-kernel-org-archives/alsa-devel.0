Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C815C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:15:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809AE610FC
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 809AE610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15CCB1697;
	Wed,  6 Oct 2021 13:14:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15CCB1697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633518913;
	bh=nP9Gz40YheGjmXGenK6aSQJa95wN7Jthsqmc5DCDn7Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C0j+lOYLcxVNZrBDmTbl1Qp1eyjsDysch5tVShwXuaAcAQOmWJIvH9J3dR3DcS0bT
	 nAz9TWoNE+xIgM6oXCWfWSQZ67MXaly+2TwrHCTHVpcRws8xlj3Fsyyn9h7AZ8rQtY
	 teXut8tBxpRrTPsiFwWhQSPmMivhazKcir+FbfAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ABE8F8020D;
	Wed,  6 Oct 2021 13:13:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 561A6F804E2; Wed,  6 Oct 2021 13:13:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECE37F8020D
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 13:13:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECE37F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dn4AQz2h"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11172610FC;
 Wed,  6 Oct 2021 11:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633518778;
 bh=nP9Gz40YheGjmXGenK6aSQJa95wN7Jthsqmc5DCDn7Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dn4AQz2hgLL13u3uefGM3BA1JoVRCvY+/ROFa+3N0o/vdlwgex2YM/3JXFw/GUwPO
 PrGbrw3lwQMrFu2BgGVAPsVQsSOL7ZLyUagoo4sChrL8+GRNIYi+iddtXf98kqpyeB
 2wHyIgiqD9iJj0XiIklOvyPtb8LB3U3S3++ZRQfGWZWvAMWaAFH7SkwMZox37SyPk1
 b+t9UWL1iDq6KexVIWjseHb1tX0pXz8uP/DM90/E9n+U4t6QqrSeib4ERhxs8lzHN0
 tFuvZMumW5/72UfrwAM8m/ESJOGK1g1EN/2NWqexPXS1wIbBm9bIlnsQwsQ96ncaKv
 0jbypelvfsZKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH MANUALSEL 5.4 4/4] ALSA: pcsp: Make hrtimer forwarding more
 robust
Date: Wed,  6 Oct 2021 07:12:50 -0400
Message-Id: <20211006111250.264294-4-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006111250.264294-1-sashal@kernel.org>
References: <20211006111250.264294-1-sashal@kernel.org>
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
index 8f0f05bbc081..23a15d892e50 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -145,7 +145,7 @@ enum hrtimer_restart pcsp_do_timer(struct hrtimer *handle)
 	if (pointer_update)
 		pcsp_pointer_update(chip);
 
-	hrtimer_forward(handle, hrtimer_get_expires(handle), ns_to_ktime(ns));
+	hrtimer_forward_now(handle, ns_to_ktime(ns));
 
 	return HRTIMER_RESTART;
 }
-- 
2.33.0

