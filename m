Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377CBC07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:40:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B676124C
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B676124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFEDC174A;
	Sat, 10 Jul 2021 04:39:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFEDC174A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884830;
	bh=Kj3F6WY2nm737P62wP754f/Pzo/O6ynzSq8DoMe4IJA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RGAxjRULT1WhKzQhgXmdTDhEUH9ruZds1bVwFaDNF1FJppl40C/aOYh1ApM6WPRqR
	 v99WDn6mYOi9f2t4HF30wGPyCU6pkX21WL32cY9d9wC+zD9SM8qilkNwEOdJcNYDZk
	 tDVuNC5N6LbFh74HpREMR0SSLFjW3iT5+axZIiZ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71202F804D6;
	Sat, 10 Jul 2021 04:26:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25ACEF804E0; Sat, 10 Jul 2021 04:26:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C9DAF804E0
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:26:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C9DAF804E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i3clzOtg"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23576613E6;
 Sat, 10 Jul 2021 02:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625884001;
 bh=Kj3F6WY2nm737P62wP754f/Pzo/O6ynzSq8DoMe4IJA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i3clzOtgORvhEvkoCuZfXmTYjzevqS9MUScuUMRDKIV/Bt6MqTQnuGxOiKt+1Xd5g
 fe7v8tdm2PaPLnD+c9iaZwZS8QFIUyfluFR9vl8Z+/SxOC+JK0CnBoOhhtgEUPHkOA
 /PEb382B1wndcQe7ydoI/MGC2Mf/jVqd3oConbIFeHRj1frVR65CvI4mNxSciIeORC
 B+xDtUBpWTKtDFJof3I+St30OgED/EKru4Afm7iyz5zijWO85XljjAJOHxf1y62nSq
 xrTtlm5HNpVK7gYY2ADBqY7RHhSW6aMcn0tdwhMCOfH4GBybPnUgAbS2+D/TdLFJJP
 nlIfGa4XIJNMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 76/93] ALSA: usb-audio: scarlett2: Fix data_mutex
 lock
Date: Fri,  9 Jul 2021 22:24:10 -0400
Message-Id: <20210710022428.3169839-76-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, "Geoffrey D. Bennett" <g@b4.vu>
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

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit 9b5ddea9ce5a68d7d2bedcb69901ac2a86c96c7b ]

The private->vol_updated flag was being checked outside of the
mutex_lock/unlock() of private->data_mutex leading to the volume data
being fetched twice from the device unnecessarily or old volume data
being returned.

Update scarlett2_*_ctl_get() and include the private->vol_updated flag
check inside the critical region.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://lore.kernel.org/r/20210620164643.GA9216@m.b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index e605ec5a91ba..38b3a0352b24 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1028,11 +1028,10 @@ static int scarlett2_master_volume_ctl_get(struct snd_kcontrol *kctl,
 	struct usb_mixer_interface *mixer = elem->head.mixer;
 	struct scarlett2_mixer_data *private = mixer->private_data;
 
-	if (private->vol_updated) {
-		mutex_lock(&private->data_mutex);
+	mutex_lock(&private->data_mutex);
+	if (private->vol_updated)
 		scarlett2_update_volumes(mixer);
-		mutex_unlock(&private->data_mutex);
-	}
+	mutex_unlock(&private->data_mutex);
 
 	ucontrol->value.integer.value[0] = private->master_vol;
 	return 0;
@@ -1046,11 +1045,10 @@ static int scarlett2_volume_ctl_get(struct snd_kcontrol *kctl,
 	struct scarlett2_mixer_data *private = mixer->private_data;
 	int index = elem->control;
 
-	if (private->vol_updated) {
-		mutex_lock(&private->data_mutex);
+	mutex_lock(&private->data_mutex);
+	if (private->vol_updated)
 		scarlett2_update_volumes(mixer);
-		mutex_unlock(&private->data_mutex);
-	}
+	mutex_unlock(&private->data_mutex);
 
 	ucontrol->value.integer.value[0] = private->vol[index];
 	return 0;
@@ -1314,11 +1312,10 @@ static int scarlett2_button_ctl_get(struct snd_kcontrol *kctl,
 	struct usb_mixer_interface *mixer = elem->head.mixer;
 	struct scarlett2_mixer_data *private = mixer->private_data;
 
-	if (private->vol_updated) {
-		mutex_lock(&private->data_mutex);
+	mutex_lock(&private->data_mutex);
+	if (private->vol_updated)
 		scarlett2_update_volumes(mixer);
-		mutex_unlock(&private->data_mutex);
-	}
+	mutex_unlock(&private->data_mutex);
 
 	ucontrol->value.enumerated.item[0] = private->buttons[elem->control];
 	return 0;
-- 
2.30.2

