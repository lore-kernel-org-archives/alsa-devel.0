Return-Path: <SRS0=Bo48=LO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A34C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:51:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3246108E
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3246108E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F72516B0;
	Sun, 20 Jun 2021 18:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F72516B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624207890;
	bh=Bp599jP7nKyB9RFHLFoHyRZ+ERksFTm/oSPLwyt7LQ4=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KQpu+mfj8Xi4fA72X/fY+tC5ygguwxgEA9/w8Qmz+HF8TMZA+nQUSi1QmcUlGxwjw
	 MXztGHPzU14Xmp86zOCjGSjj/U6jVrBtfcrWqFT2HGlFO8wsmWmIw1isAy6xt/Kyha
	 AymiMSHfeckkLPK7wvNsrVY23fixfMo5QbLKaAi8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5447DF80511;
	Sun, 20 Jun 2021 18:46:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3F16F804E1; Sun, 20 Jun 2021 18:46:48 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7954F8016D
 for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2021 18:46:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7954F8016D
Received: by m.b4.vu (Postfix, from userid 1000)
 id 5030261E5F19; Mon, 21 Jun 2021 02:16:43 +0930 (ACST)
Date: Mon, 21 Jun 2021 02:16:43 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/14] ALSA: usb-audio: scarlett2: Fix data_mutex lock
Message-ID: <20210620164643.GA9216@m.b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The private->vol_updated flag was being checked outside of the
mutex_lock/unlock() of private->data_mutex leading to the volume data
being fetched twice from the device unnecessarily or old volume data
being returned.

Update scarlett2_*_ctl_get() and include the private->vol_updated flag
check inside the critical region.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index cb8483d3c58a..d6298ab1de56 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1153,11 +1153,10 @@ static int scarlett2_master_volume_ctl_get(struct snd_kcontrol *kctl,
 	struct usb_mixer_interface *mixer = elem->head.mixer;
 	struct scarlett2_data *private = mixer->private_data;
 
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
@@ -1171,11 +1170,10 @@ static int scarlett2_volume_ctl_get(struct snd_kcontrol *kctl,
 	struct scarlett2_data *private = mixer->private_data;
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
@@ -1439,11 +1437,10 @@ static int scarlett2_dim_mute_ctl_get(struct snd_kcontrol *kctl,
 	struct usb_mixer_interface *mixer = elem->head.mixer;
 	struct scarlett2_data *private = mixer->private_data;
 
-	if (private->vol_updated) {
-		mutex_lock(&private->data_mutex);
+	mutex_lock(&private->data_mutex);
+	if (private->vol_updated)
 		scarlett2_update_volumes(mixer);
-		mutex_unlock(&private->data_mutex);
-	}
+	mutex_unlock(&private->data_mutex);
 
 	ucontrol->value.enumerated.item[0] = private->dim_mute[elem->control];
 	return 0;
-- 
2.31.1

