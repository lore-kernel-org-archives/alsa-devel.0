Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A80C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 04:35:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEE564EE4
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 04:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEE564EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 421161AA9;
	Thu,  4 Mar 2021 05:34:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 421161AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614832545;
	bh=d8FInV8S3MOtwXgzRC27IsIJdPDgtOMmNcjSuU/dTEU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kmS+RQBmgITDfaiMNOU+4wy/uEP+MkluCo2GAaAFv8CENgGF9U0BgubyYxfgWFn9J
	 rNttwZpgYjXkat47kSae15f6sJZB6McD0+xyMhS2FuLre09IGf+5ItmFwKfZiyCN5L
	 1atyvZhfcN+Pn/bvZXF1Am4ce4WtPCGNG9qsBpjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CBDBF8025B;
	Thu,  4 Mar 2021 05:34:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6182F80269; Thu,  4 Mar 2021 05:34:52 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D3B9F8007E
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 05:34:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D3B9F8007E
Received: from 36-229-232-16.dynamic-ip.hinet.net ([36.229.232.16]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1lHfgz-0007xv-3k; Thu, 04 Mar 2021 04:34:30 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: usb-audio: Disable USB autosuspend properly in
 setup_disable_autosuspend()
Date: Thu,  4 Mar 2021 12:34:16 +0800
Message-Id: <20210304043419.287191-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Olivia Mackintosh <livvy@base.nu>, Dylan Robinson <dylan_robinson@motu.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chris Wulff <crwulff@gmail.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Joakim Tjernlund <joakim.tjernlund@infinera.com>,
 Alexander Tsoy <alexander@tsoy.me>, Mark Brown <broonie@kernel.org>,
 Joe Perches <joe@perches.com>, Dmitry Panchenko <dmitry@d-systems.ee>,
 open list <linux-kernel@vger.kernel.org>
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

Rear audio on Lenovo ThinkStation P620 stops working after commit
1965c4364bdd ("ALSA: usb-audio: Disable autosuspend for Lenovo
ThinkStation P620"):
[    6.013526] usbcore: registered new interface driver snd-usb-audio
[    6.023064] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.023083] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.023090] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.023098] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.023103] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.023110] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.045846] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.045866] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.045877] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.045886] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.045894] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.045908] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4

I overlooked the issue because when I was working on the said commit,
only the front audio is tested. Apology for that.

Changing supports_autosuspend in driver is too late for disabling
autosuspend, because it was already used by USB probe routine, so it can
break the balance on the following code that depends on
supports_autosuspend.

Fix it by using usb_disable_autosuspend() helper, and balance the
suspend count in disconnect callback.

Fixes: 1965c4364bdd ("ALSA: usb-audio: Disable autosuspend for Lenovo ThinkStation P620")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/card.c     | 5 +++++
 sound/usb/quirks.c   | 2 +-
 sound/usb/usbaudio.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 85ed8507e41a..08c794883299 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -830,6 +830,8 @@ static int usb_audio_probe(struct usb_interface *intf,
 		snd_media_device_create(chip, intf);
 	}
 
+	chip->quirk_type = quirk->type;
+
 	usb_chip[chip->index] = chip;
 	chip->intf[chip->num_interfaces] = intf;
 	chip->num_interfaces++;
@@ -912,6 +914,9 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 	} else {
 		mutex_unlock(&register_mutex);
 	}
+
+	if (chip->quirk_type & QUIRK_SETUP_DISABLE_AUTOSUSPEND)
+		usb_enable_autosuspend(interface_to_usbdev(intf));
 }
 
 /* lock the shutdown (disconnect) task and autoresume */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9ba4682ebc48..ef5ee899db26 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -547,7 +547,7 @@ static int setup_disable_autosuspend(struct snd_usb_audio *chip,
 				       struct usb_driver *driver,
 				       const struct snd_usb_audio_quirk *quirk)
 {
-	driver->supports_autosuspend = 0;
+	usb_disable_autosuspend(interface_to_usbdev(iface));
 	return 1;	/* Continue with creating streams and mixer */
 }
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 215c1771dd57..60b9dd7df6bb 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -27,6 +27,7 @@ struct snd_usb_audio {
 	struct snd_card *card;
 	struct usb_interface *intf[MAX_CARD_INTERFACES];
 	u32 usb_id;
+	uint16_t quirk_type;
 	struct mutex mutex;
 	unsigned int system_suspend;
 	atomic_t active;
-- 
2.30.0

