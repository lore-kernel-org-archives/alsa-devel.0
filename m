Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00125C63798
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 23:11:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283562240C
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 23:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C8gZW/GM";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avjXDLLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283562240C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72D6A16DA;
	Sat, 21 Nov 2020 00:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72D6A16DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605913913;
	bh=kbAL7MWra6qsYitUq3za9lXJi1OJilshLl5MxlmH1cE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C8gZW/GMhiYuioU59vPcPOkCUkP3SVz2AmtfPSd/IN5QWwc2ascyTQOcBODA0Qye2
	 t72k2N87b1kRgJEXCruDhOy9BUVGgBFPFHOp3BqARLCaN8cHASvtbXz0mLEGW0VGDV
	 +Kl1HMDK7OyyWrGhrHaZNxsuBznYheVm4UmIsqh0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0150FF800F3;
	Sat, 21 Nov 2020 00:11:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3A62F8016C; Sat, 21 Nov 2020 00:11:01 +0100 (CET)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A02BEF800F3
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2020 00:10:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A02BEF800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="avjXDLLq"
Received: by mail-lf1-x142.google.com with SMTP id r9so15750227lfn.11
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CyaDQ59Xa+QtuyHKnT1OfwqIq6Z2viIRqDw3lT6p86A=;
 b=avjXDLLq0T69cWueF0peuiKWe70cp7lI1mDGSjFGYE5O5SR1+UJV3vfgHNh63+9A+m
 rPPbBxtAUAnfO4+OozC/cnjeSh2sJHYYlxsAr21Vj/Hm2Vo4XQTEnU9Zoic/ByZIyrhi
 SaKUJI11PTFozUlWNen1X60ve37i/7siRVzyhtrNyap6byS7/x1nN544Li27Kqz2XS01
 0qMRsDQuAkGMv7P6107/YNv6jtO3yrgtQjD8qBrR3jFzOxmzy0qAGEHzNE8jbKtCFrg8
 +eZfjgKrkp/jhx0NcXvySG3j0wUG78bpsC8z042p4vMAjRzREVZyroRqm0IoAj0RMwHD
 A1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CyaDQ59Xa+QtuyHKnT1OfwqIq6Z2viIRqDw3lT6p86A=;
 b=ETNyj2Lubj1rOHKFh2LNepYhEBscRHiXnMIgYCAJW3Dh77c+yGdtYaijPNlF2B0fcM
 dAVl/p9XJXCYBjBbGKcaxDkmP0sqLnYCiLosSnil0BFtIOlRNe23n2HKc3HSHhItNUKX
 MAIZyccJx47+B87cKS9EJWe/5ITPvfjc0hP0qGO8xoVvb/tSk/o8XnbtvTCVL7qNlt8x
 cwnz26JgXqVREe6Mvd/AVqFplQ4CijkIFOwuZs2mEbo8hjzWCrrZElapETMD0O3rpB/t
 vgT366bPSsgIHU6FX6vOEosZH+V9wyqpW7lRL3rKYFynY3AyXHjLP6f54TJq6O7DwxIx
 iI1w==
X-Gm-Message-State: AOAM5338d4E93GsZAL9SO3UvRDFzYVzE9+jc8szRJkQYeoaHnYmYUanH
 XNl0kxFxNYTchCOgvyS31Fg=
X-Google-Smtp-Source: ABdhPJyFOQj6ZUsQsgE61ZNUC7d+DA/frbSsQ4l+9LnnB5R+5Q9igswbzgsPtjUNhpytFOm74Pwf4w==
X-Received: by 2002:a19:4a08:: with SMTP id x8mr9756918lfa.322.1605913851350; 
 Fri, 20 Nov 2020 15:10:51 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se.
 [158.174.22.6])
 by smtp.gmail.com with ESMTPSA id a132sm493810lfd.101.2020.11.20.15.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2020 15:10:50 -0800 (PST)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	aroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: aloop: Constify ops structs
Date: Sat, 21 Nov 2020 00:10:46 +0100
Message-Id: <20201120231046.76758-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>
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

The only usage of the ops field in the loopback_cable struct is to call
its members, the field it self is never changed. Make it a pointer to
const. This allows us to constify two static loopback_ops structs to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/drivers/aloop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index c91356326699..702f91b9c60f 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -105,7 +105,7 @@ struct loopback_cable {
 	unsigned int running;
 	unsigned int pause;
 	/* timer specific */
-	struct loopback_ops *ops;
+	const struct loopback_ops *ops;
 	/* If sound timer is used */
 	struct {
 		int stream;
@@ -1021,7 +1021,7 @@ static int loopback_jiffies_timer_open(struct loopback_pcm *dpcm)
 	return 0;
 }
 
-static struct loopback_ops loopback_jiffies_timer_ops = {
+static const struct loopback_ops loopback_jiffies_timer_ops = {
 	.open = loopback_jiffies_timer_open,
 	.start = loopback_jiffies_timer_start,
 	.stop = loopback_jiffies_timer_stop,
@@ -1172,7 +1172,7 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 /* stop_sync() is not required for sound timer because it does not need to be
  * restarted in loopback_prepare() on Xrun recovery
  */
-static struct loopback_ops loopback_snd_timer_ops = {
+static const struct loopback_ops loopback_snd_timer_ops = {
 	.open = loopback_snd_timer_open,
 	.start = loopback_snd_timer_start,
 	.stop = loopback_snd_timer_stop,
-- 
2.29.2

