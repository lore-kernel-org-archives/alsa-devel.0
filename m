Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F3C48BE8
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 07:18:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22B061370
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 07:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22B061370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54598179D;
	Mon, 14 Jun 2021 09:17:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54598179D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623655107;
	bh=/g4XgqtbExvKHF9/KXXkQnyjrzmU+Cxwqq+yU0+MCFs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sl1/pOp3eRC0GsZKT3Btrz21JS4fxyigDDqTZoHNKYQk4Gpvc8BPlLlgZVP1khtxc
	 0PT35CEBozdhAEUhreG8YeGZyvfcq6bNdgd+Lw9Z0V6GL7ZuPDbLxwJz36QYXNd4hQ
	 M9kAv9MPtm1GlCwXlYvwtVl8XgOwm78HLAxsPSoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF518F8023C;
	Mon, 14 Jun 2021 09:17:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2FCCF8025A; Mon, 14 Jun 2021 09:17:35 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACC0FF80234
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 09:17:29 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B302EA003F;
 Mon, 14 Jun 2021 09:17:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B302EA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1623655043; bh=4BumbIDkvv8JEGi0l7Sa2u6YOwC6QCGV5JOZtDf8YoE=;
 h=From:To:Cc:Subject:Date:From;
 b=UpbPPbaIdvkOEfYM7juwGTx/0iOF7kBlY12YI28SvoeeW31y7Aiik8qUWktm+2Rjw
 KJjNYCaT0gqxJoQJdqp52oPzGmUV8khVjSIwTt4RssFSeR1rSsZFm+7mSyM6wQU84e
 KH3/B9McSteQeWJXwi8yUtXj6Jmv4xSNsq1l0lHk=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 14 Jun 2021 09:17:20 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] alsa: control_led - fix initialization in the mode show
 callback
Date: Mon, 14 Jun 2021 09:17:10 +0200
Message-Id: <20210614071710.1786866-1-perex@perex.cz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>
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

The str variable should be always initialized before use even if
the switch covers all cases. This is a minimalistic fix: Assign NULL,
the sprintf() may print '(null)' if something is corrupted.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/core/control_led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 861f71f2fab5..764058cc345d 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -397,7 +397,7 @@ static ssize_t mode_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct snd_ctl_led *led = container_of(dev, struct snd_ctl_led, dev);
-	const char *str;
+	const char *str = NULL;
 
 	switch (led->mode) {
 	case MODE_FOLLOW_MUTE:	str = "follow-mute"; break;
-- 
2.30.2
