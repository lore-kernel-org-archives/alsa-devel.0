Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C500DC4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:14:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFF96115B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFF96115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5633169F;
	Mon, 21 Jun 2021 20:13:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5633169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299268;
	bh=dtlEOrUJ5KamiNiNipdNZPL9MSKWgBExAntofgEvg10=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L2yfPaU4/tCicGhN1Iitj7S7lfiCLAT23gQZD6JmqU+pq7VaOxJckKY/nz0odwF4l
	 74XuHZM5xasgqwniBtu/OmFIOfzOrk+jKWC7YcelyqOzAQiV9YF8JLpuAOTtpghEwy
	 qDRWGsc6jLzN6UrJ1avbi/Qvpu7c58ZWRS3TXKMI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8B0FF80529;
	Mon, 21 Jun 2021 20:09:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E26EF80520; Mon, 21 Jun 2021 20:09:43 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38F02F80517
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:09:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38F02F80517
Received: by m.b4.vu (Postfix, from userid 1000)
 id BCC0A61E5F02; Tue, 22 Jun 2021 03:39:37 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:39:37 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/31] ALSA: usb-audio: scarlett2: Add
 scarlett2_vol_ctl_write() helper
Message-ID: <00dd57e1abb3fa379fb51d4ac8537dbddc09f0ea.1624294591.git.g@b4.vu>
References: <cover.1624294591.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624294591.git.g@b4.vu>
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

Add helper function for setting the read/write status of a volume
control. This will simplify the upcoming mute control support.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index ded99baa92de..e156119a21e8 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1344,6 +1344,24 @@ static int scarlett2_sw_hw_enum_ctl_get(struct snd_kcontrol *kctl,
 	return 0;
 }
 
+static void scarlett2_vol_ctl_set_writable(struct usb_mixer_interface *mixer,
+					   int index, int value)
+{
+	struct scarlett2_data *private = mixer->private_data;
+
+	/* Set/Clear write bit */
+	if (value)
+		private->vol_ctls[index]->vd[0].access |=
+			SNDRV_CTL_ELEM_ACCESS_WRITE;
+	else
+		private->vol_ctls[index]->vd[0].access &=
+			~SNDRV_CTL_ELEM_ACCESS_WRITE;
+
+	/* Notify of write bit change */
+	snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_INFO,
+		       &private->vol_ctls[index]->id);
+}
+
 static int scarlett2_sw_hw_enum_ctl_put(struct snd_kcontrol *kctl,
 					struct snd_ctl_elem_value *ucontrol)
 {
@@ -1367,12 +1385,7 @@ static int scarlett2_sw_hw_enum_ctl_put(struct snd_kcontrol *kctl,
 	/* Change access mode to RO (hardware controlled volume)
 	 * or RW (software controlled volume)
 	 */
-	if (val)
-		private->vol_ctls[index]->vd[0].access &=
-			~SNDRV_CTL_ELEM_ACCESS_WRITE;
-	else
-		private->vol_ctls[index]->vd[0].access |=
-			SNDRV_CTL_ELEM_ACCESS_WRITE;
+	scarlett2_vol_ctl_set_writable(mixer, index, !val);
 
 	/* Reset volume to master volume */
 	private->vol[index] = private->master_vol;
@@ -1384,10 +1397,6 @@ static int scarlett2_sw_hw_enum_ctl_put(struct snd_kcontrol *kctl,
 	if (err < 0)
 		goto unlock;
 
-	/* Notify of RO/RW change */
-	snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_INFO,
-		       &private->vol_ctls[index]->id);
-
 	/* Send SW/HW switch change to the device */
 	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_SW_HW_SWITCH,
 				       index, val);
@@ -1620,8 +1629,7 @@ static int scarlett2_add_line_out_ctls(struct usb_mixer_interface *mixer)
 
 		/* Make the fader read-only if the SW/HW switch is set to HW */
 		if (private->vol_sw_hw_switch[i])
-			private->vol_ctls[i]->vd[0].access &=
-				~SNDRV_CTL_ELEM_ACCESS_WRITE;
+			scarlett2_vol_ctl_set_writable(mixer, i, 0);
 
 		/* SW/HW Switch */
 		if (info->line_out_hw_vol) {
-- 
2.31.1

