Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC71BC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:14:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4408B2078D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OD4H/oMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4408B2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEE7A175D;
	Thu, 18 Jun 2020 13:13:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEE7A175D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592478855;
	bh=ePhLyiOtvflOThTOH1WMHTbla0ME9U5MdxrTbjakOs0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OD4H/oMjBmcNFU9dG7vKfsNuGyJXfIoRA8A2YbjGJ7rK+LkC6Mb+jAs9RWxEBWx3w
	 BvNDC8aDBOeePbzz8tp6bT4qsLQSfjnWLZEZ4CtvNQ8AC23p9V0O9cVp+dRH6ELtv8
	 a3aSUxVMZpjdQmzm94x+ZDxL0zvmxK07TdzU5p+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A28B9F802E9;
	Thu, 18 Jun 2020 13:09:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61B14F802D2; Thu, 18 Jun 2020 13:09:13 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92FEDF8022B
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 13:08:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92FEDF8022B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BA826AF3E;
 Thu, 18 Jun 2020 11:08:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/13] ALSA: hda: generic: Add vmaster mute LED helper
Date: Thu, 18 Jun 2020 13:08:37 +0200
Message-Id: <20200618110842.27238-9-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200618110842.27238-1-tiwai@suse.de>
References: <20200618110842.27238-1-tiwai@suse.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
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

Like mic-mute LED handling, add a new helper to deal with the master
mute LED with LED classdev.  Unlike the mic-mute case, the playback
master mute is hooked on vmaster, and we suppose no nested hooks
allowed there.

The classdev creation code is factored out to a common function that
is called from both mute and mic-mute LED helpers.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 71 +++++++++++++++++++++++++++++++++++++--------
 sound/pci/hda/hda_generic.h |  3 ++
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index c97a1404af6b..c74519d7096b 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3888,6 +3888,64 @@ static int parse_mic_boost(struct hda_codec *codec)
 }
 
 #ifdef CONFIG_SND_HDA_GENERIC_LEDS
+/*
+ * vmaster mute LED hook helpers
+ */
+
+static int create_mute_led_cdev(struct hda_codec *codec,
+				int (*callback)(struct led_classdev *,
+						enum led_brightness),
+				bool micmute)
+{
+	struct led_classdev *cdev;
+
+	cdev = devm_kzalloc(&codec->core.dev, sizeof(*cdev), GFP_KERNEL);
+	if (!cdev)
+		return -ENOMEM;
+
+	cdev->name = micmute ? "hda::micmute" : "hda::mute";
+	cdev->max_brightness = 1;
+	cdev->default_trigger = micmute ? "audio-micmute" : "audio-mute";
+	cdev->brightness_set_blocking = callback;
+	cdev->brightness = ledtrig_audio_get(micmute ? LED_AUDIO_MICMUTE : LED_AUDIO_MUTE);
+
+	return devm_led_classdev_register(&codec->core.dev, cdev);
+}
+
+static void vmaster_update_mute_led(void *private_data, int enabled)
+{
+	ledtrig_audio_set(LED_AUDIO_MUTE, enabled ? LED_OFF : LED_ON);
+}
+
+/**
+ * snd_dha_gen_add_mute_led_cdev - Create a LED classdev and enable as vmaster mute LED
+ * @codec: the HDA codec
+ * @callback: the callback for LED classdev brightness_set_blocking
+ */
+int snd_hda_gen_add_mute_led_cdev(struct hda_codec *codec,
+				  int (*callback)(struct led_classdev *,
+						  enum led_brightness))
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int err;
+
+	if (callback) {
+		err = create_mute_led_cdev(codec, callback, false);
+		if (err) {
+			codec_warn(codec, "failed to create a mute LED cdev\n");
+			return err;
+		}
+	}
+
+	if (spec->vmaster_mute.hook)
+		codec_err(codec, "vmaster hook already present before cdev!\n");
+
+	spec->vmaster_mute.hook = vmaster_update_mute_led;
+	spec->vmaster_mute_enum = 1;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hda_gen_add_mute_led_cdev);
+
 /*
  * mic mute LED hook helpers
  */
@@ -4029,20 +4087,9 @@ int snd_hda_gen_add_micmute_led_cdev(struct hda_codec *codec,
 						     enum led_brightness))
 {
 	int err;
-	struct led_classdev *cdev;
 
 	if (callback) {
-		cdev = devm_kzalloc(&codec->core.dev, sizeof(*cdev), GFP_KERNEL);
-		if (!cdev)
-			return -ENOMEM;
-
-		cdev->name = "hda::micmute";
-		cdev->max_brightness = 1;
-		cdev->default_trigger = "audio-micmute";
-		cdev->brightness_set_blocking = callback;
-		cdev->brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
-
-		err = devm_led_classdev_register(&codec->core.dev, cdev);
+		err = create_mute_led_cdev(codec, callback, true);
 		if (err) {
 			codec_warn(codec, "failed to create a mic-mute LED cdev\n");
 			return err;
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index a59e66f9ff33..bbd6d2b741f2 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -354,6 +354,9 @@ unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on);
 int snd_hda_gen_fix_pin_power(struct hda_codec *codec, hda_nid_t pin);
 
+int snd_hda_gen_add_mute_led_cdev(struct hda_codec *codec,
+				  int (*callback)(struct led_classdev *,
+						  enum led_brightness));
 int snd_hda_gen_add_micmute_led_cdev(struct hda_codec *codec,
 				     int (*callback)(struct led_classdev *,
 						     enum led_brightness));
-- 
2.16.4

