Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEBAC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 20:14:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9470860EB8
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 20:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9470860EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0505A170D;
	Thu, 22 Jul 2021 22:13:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0505A170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626984859;
	bh=xUCgbbb61A1NWVEOiqpSGts1J+ptJKgWt4LKRVv9WDc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vuKlqG/07A+Rd5GwdlY+jT5q8ngPpWrFEesvZg4083ZWLprBdWiS49z3O9Fwj2nnV
	 9BngnjlpEjz8ztUiOxZO0Zqo2BqIK57Vox8rn4yHOWoH3Wqzdtza0PfJV9FTM3p+3z
	 02uEi1qJ2/K4sV6hvBzmAdAwRUF2t4orMDuHGwzM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C32C1F8049C;
	Thu, 22 Jul 2021 22:12:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44ACEF804E0; Thu, 22 Jul 2021 22:12:57 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C901F8049C
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 22:12:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C901F8049C
Received: by m.b4.vu (Postfix, from userid 1000)
 id 312EB611D167; Fri, 23 Jul 2021 05:42:48 +0930 (ACST)
Date: Fri, 23 Jul 2021 05:42:48 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: scarlett2: Correct channel mute status after mute
 button pressed
Message-ID: <aa18ddbf8d8bd7f31832ab1b6b6057c00b931202.1626959758.git.g@b4.vu>
References: <cover.1626959758.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626959758.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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

After the hardware mute button is pressed, private->vol_updated is set
so that the mute status is invalidated. As the channel mute values may
be affected by the global mute value, update scarlett2_mute_ctl_get()
to call scarlett2_update_volumes() if private->vol_updated is set.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index fa604b61066f..3457fbc8108f 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1856,9 +1856,15 @@ static int scarlett2_mute_ctl_get(struct snd_kcontrol *kctl,
 					struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct scarlett2_data *private = elem->head.mixer->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
 	int index = line_out_remap(private, elem->control);
 
+	mutex_lock(&private->data_mutex);
+	if (private->vol_updated)
+		scarlett2_update_volumes(mixer);
+	mutex_unlock(&private->data_mutex);
+
 	ucontrol->value.integer.value[0] = private->mute_switch[index];
 	return 0;
 }
-- 
2.31.1

