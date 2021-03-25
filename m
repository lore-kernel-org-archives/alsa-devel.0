Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7DC433C1
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 17:01:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17B361A2A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 17:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17B361A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 033AD166D;
	Thu, 25 Mar 2021 18:00:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 033AD166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616691696;
	bh=rO3aeqOYVLNTmEGKg/BdQ/Du+f+UuCHzw1ap571zeTE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E0DjNj3QjZLUBb2/rANoEM1TerLiFrQGo9S7afhKBImWCdEl1kruREIP9Psw3bKqm
	 VWzshSIaAV4Ak/hcyI3PdZJA/5LgEY+1ZMdbJ0or99sd4U5pZzTC2RuhD86bg//mC4
	 P9AA0ayC/5gHQJEna3dDZytjKxDYIUozydIYtp0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64BDFF8026D;
	Thu, 25 Mar 2021 18:00:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50C0EF8026F; Thu, 25 Mar 2021 18:00:19 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35171F80103
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 18:00:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35171F80103
Received: from 1-171-92-165.dynamic-ip.hinet.net ([1.171.92.165]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1lPTKZ-0003Ut-Ua; Thu, 25 Mar 2021 16:59:36 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH v3 2/2] ALSA: usb-audio: Check connector value on resume
Date: Fri, 26 Mar 2021 00:59:13 +0800
Message-Id: <20210325165918.22593-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325165918.22593-1-kai.heng.feng@canonical.com>
References: <20210325165918.22593-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
 Takashi Iwai <tiwai@suse.de>, Thomas Ebeling <penguins@bollie.de>,
 Chris Chiu <chiu@endlessm.com>, open list <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 =?UTF-8?q?Franti=C5=A1ek=20Ku=C4=8Dera?= <franta-linux@frantovo.cz>,
 Joe Perches <joe@perches.com>, Olivia Mackintosh <livvy@base.nu>,
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

Now the resume callback checks connector, and a new callback,
reset_resume, to also restore switches and volumes.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - New callback to handle resume and reset-resume separately.

v2:
 - Remove reset-resume.
 - Fold the connector checking to the mixer resume callback.

 sound/usb/mixer.c        | 44 +++++++++++++++++++++++++++++++---------
 sound/usb/mixer.h        |  1 +
 sound/usb/mixer_quirks.c |  2 +-
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5a2d9a768f70..2faf5767c7f8 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3631,20 +3631,43 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
 	return 0;
 }
 
+static int default_mixer_resume(struct usb_mixer_elem_list *list)
+{
+	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
+
+	/* get connector value to "wake up" the USB audio */
+	if (cval->val_type == USB_MIXER_BOOLEAN && cval->channels == 1)
+		get_connector_value(cval, NULL, NULL);
+
+	return 0;
+}
+
+static int default_mixer_reset_resume(struct usb_mixer_elem_list *list)
+{
+	int err = default_mixer_resume(list);
+
+	if (err < 0)
+		return err;
+	return restore_mixer_value(list);
+}
+
 int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
 {
 	struct usb_mixer_elem_list *list;
+	usb_mixer_elem_resume_func_t f;
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
+			if (reset_resume)
+				f = list->reset_resume;
+			else
+				f = list->resume;
+			if (f) {
+				err = f(list);
+				if (err < 0)
+					return err;
 			}
 		}
 	}
@@ -3663,6 +3686,7 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
 	list->id = unitid;
 	list->dump = snd_usb_mixer_dump_cval;
 #ifdef CONFIG_PM
-	list->resume = restore_mixer_value;
+	list->resume = default_mixer_resume;
+	list->reset_resume = default_mixer_reset_resume;
 #endif
 }
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index c29e27ac43a7..e5a01f17bf3c 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -69,6 +69,7 @@ struct usb_mixer_elem_list {
 	bool is_std_info;
 	usb_mixer_elem_dump_func_t dump;
 	usb_mixer_elem_resume_func_t resume;
+	usb_mixer_elem_resume_func_t reset_resume;
 };
 
 /* iterate over mixer element list of the given unit id */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ffd922327ae4..b7f9c2fded05 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -151,7 +151,7 @@ static int add_single_ctl_with_resume(struct usb_mixer_interface *mixer,
 		*listp = list;
 	list->mixer = mixer;
 	list->id = id;
-	list->resume = resume;
+	list->reset_resume = resume;
 	kctl = snd_ctl_new1(knew, list);
 	if (!kctl) {
 		kfree(list);
-- 
2.30.2

