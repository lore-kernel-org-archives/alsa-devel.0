Return-Path: <SRS0=Xywd=JL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB90C433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Apr 2021 11:00:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C8F613C7
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Apr 2021 11:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C8F613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C185516EA;
	Wed, 14 Apr 2021 12:59:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C185516EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618398011;
	bh=tdfka4VOti3P4MFpVAShoofJYNrfAOuxzRTOMvmPd5g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oSEf8Ioz5A952V+x6jLNQHCRGgeyhZ2GTuIkiQztORdXu4RtJ79Ww3+lI/Zzyl7Dp
	 6f2/EKkhY++mSZM940ssGWMDyfOwHE+or2dPK849LelbErOClpk+HbkLNFKyNXPDhy
	 I2pJtBUVdpO1IVUpuhvINo6M23KaGsNqOBFk1GF4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8FF9F800FF;
	Wed, 14 Apr 2021 12:59:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F97CF80269; Wed, 14 Apr 2021 12:59:19 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E83EF800FF
 for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2021 12:59:08 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id AFF25A003F;
 Wed, 14 Apr 2021 12:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz AFF25A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1618397947; bh=Wq1JdtzwKGFUyBE4QtDUpdTxQLXBdakZOliJaqKrNBg=;
 h=From:To:Cc:Subject:Date:From;
 b=5jz6VAVpp4lXAqdiPxN5J3rK4uiF60j2xIGchlw2sGmevQ+8IQikYu1Rf7b21AZJs
 gM9F9QB9EU8GQ8UuSiHSygmcVT/RhTq3xrgtgcAVuUkdXf3heUtaZO324MY1gT9Um1
 udQieZMN0gna6XjZu8CPx/Oim5dbYX1TISicywPU=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 14 Apr 2021 12:59:02 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ALSA: control_led - fix the stack usage (control element ops)
Date: Wed, 14 Apr 2021 12:58:58 +0200
Message-Id: <20210414105858.1937710-1-perex@perex.cz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Nathan Chancellor <nathan@kernel.org>
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

It's a bad idea to allocate big structures on the stack.
Mark the variables as static and add a note for the locking.

Fixes: 22d8de62f11b ("ALSA: control - add generic LED trigger module as the new control layer")
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/core/control_led.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 93b201063c7d..25f57c14f294 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -94,11 +94,15 @@ static struct snd_ctl_led *snd_ctl_led_get_by_access(unsigned int access)
 	return &snd_ctl_leds[group];
 }
 
+/*
+ * A note for callers:
+ *   The two static variables info and value are protected using snd_ctl_led_mutex.
+ */
 static int snd_ctl_led_get(struct snd_ctl_led_ctl *lctl)
 {
+	static struct snd_ctl_elem_info info;
+	static struct snd_ctl_elem_value value;
 	struct snd_kcontrol *kctl = lctl->kctl;
-	struct snd_ctl_elem_info info;
-	struct snd_ctl_elem_value value;
 	unsigned int i;
 	int result;
 
-- 
2.30.2
