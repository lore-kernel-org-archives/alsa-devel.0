Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C5C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 12:15:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1799A61A10
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 12:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1799A61A10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9877016A8;
	Thu, 25 Mar 2021 13:14:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9877016A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616674514;
	bh=bbPp1Xn0qWa2tYMRfwefhSjFM2zlh2gp9OG0giHqfpQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e+7fBLL8HKKPcuiUr9q6mSpD7pJ8/IkL3auCC+qZtgFO0KFEupN19r6la84R70jJk
	 +V5ULCTvXE2WhtlLFaIh2cp/eWodbl9IJuuj6LJoVTUjp3fcZrVpscMm6ZC6jLW8Bz
	 F3h+81nIUZUtAdujxTzekeMA0p2PjSLPlbEHAO/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EFC5F8025F;
	Thu, 25 Mar 2021 13:13:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0ED1F80279; Thu, 25 Mar 2021 13:13:33 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7102AF80257
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 13:13:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7102AF80257
Received: from 1-171-92-165.dynamic-ip.hinet.net ([1.171.92.165]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1lPOrG-00017f-6f; Thu, 25 Mar 2021 12:13:02 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH v2 2/2] ALSA: usb-audio: Check connector value on resume
Date: Thu, 25 Mar 2021 20:12:48 +0800
Message-Id: <20210325121250.133009-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325121250.133009-1-kai.heng.feng@canonical.com>
References: <20210325121250.133009-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Pavel Skripkin <paskripkin@gmail.com>,
 Chris Chiu <chiu@endlessm.com>, open list <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>,
 Tom Yan <tom.ty89@gmail.com>
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

Rear Mic on Lenovo P620 cannot record after S3, despite that there's no
error and the other two functions of the USB audio, Line In and Line
Out, work just fine.

The mic starts to work again after running userspace app like "alsactl
store". Following the lead, the evidence shows that as soon as connector
status is queried, the mic can work again.

So also check connector value on resume to "wake up" the USB audio to
make it functional.

This can be device specific, however I think this generic approach may
benefit more than one device.

While at it, also remove reset-resume path to consolidate mixer resume
path.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Remove reset-resume.
 - Fold the connector checking to the mixer resume callback.

 sound/usb/card.c  | 16 +++-------------
 sound/usb/mixer.c | 27 +++++++++++++++------------
 sound/usb/mixer.h |  2 +-
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 0826a437f8fc..552a57c00799 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1014,7 +1014,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
-static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
+static int usb_audio_resume(struct usb_interface *intf)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
 	struct snd_usb_stream *as;
@@ -1040,7 +1040,7 @@ static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 	 * we just notify and restart the mixers
 	 */
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
-		err = snd_usb_mixer_resume(mixer, reset_resume);
+		err = snd_usb_mixer_resume(mixer);
 		if (err < 0)
 			goto err_out;
 	}
@@ -1060,16 +1060,6 @@ static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 	atomic_dec(&chip->active); /* allow autopm after this point */
 	return err;
 }
-
-static int usb_audio_resume(struct usb_interface *intf)
-{
-	return __usb_audio_resume(intf, false);
-}
-
-static int usb_audio_reset_resume(struct usb_interface *intf)
-{
-	return __usb_audio_resume(intf, true);
-}
 #else
 #define usb_audio_suspend	NULL
 #define usb_audio_resume	NULL
@@ -1095,7 +1085,7 @@ static struct usb_driver usb_audio_driver = {
 	.disconnect =	usb_audio_disconnect,
 	.suspend =	usb_audio_suspend,
 	.resume =	usb_audio_resume,
-	.reset_resume =	usb_audio_reset_resume,
+	.reset_resume =	usb_audio_resume,
 	.id_table =	usb_audio_ids,
 	.supports_autosuspend = 1,
 };
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5a2d9a768f70..7468c8d2b158 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3601,11 +3601,16 @@ int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
-static int restore_mixer_value(struct usb_mixer_elem_list *list)
+static int resume_mixer(struct usb_mixer_elem_list *list)
 {
 	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
 	int c, err, idx;
 
+	/* get connector value to "wake up" the USB audio */
+	if (cval->val_type == USB_MIXER_BOOLEAN && cval->channels == 1)
+		get_connector_value(cval, NULL, NULL);
+
+	/* restore other mixer value */
 	if (cval->cmask) {
 		idx = 0;
 		for (c = 0; c < MAX_CHANNELS; c++) {
@@ -3631,20 +3636,18 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
 	return 0;
 }
 
-int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
+int snd_usb_mixer_resume(struct usb_mixer_interface *mixer)
 {
 	struct usb_mixer_elem_list *list;
 	int id, err;
 
-	if (reset_resume) {
-		/* restore cached mixer values */
-		for (id = 0; id < MAX_ID_ELEMS; id++) {
-			for_each_mixer_elem(list, mixer, id) {
-				if (list->resume) {
-					err = list->resume(list);
-					if (err < 0)
-						return err;
-				}
+	/* restore cached mixer values */
+	for (id = 0; id < MAX_ID_ELEMS; id++) {
+		for_each_mixer_elem(list, mixer, id) {
+			if (list->resume) {
+				err = list->resume(list);
+				if (err < 0)
+					return err;
 			}
 		}
 	}
@@ -3663,6 +3666,6 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
 	list->id = unitid;
 	list->dump = snd_usb_mixer_dump_cval;
 #ifdef CONFIG_PM
-	list->resume = restore_mixer_value;
+	list->resume = resume_mixer;
 #endif
 }
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index c29e27ac43a7..7584c4762823 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -120,7 +120,7 @@ int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 
 #ifdef CONFIG_PM
 int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer);
-int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume);
+int snd_usb_mixer_resume(struct usb_mixer_interface *mixer);
 #endif
 
 int snd_usb_set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
-- 
2.30.2

