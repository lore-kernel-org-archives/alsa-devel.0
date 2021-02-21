Return-Path: <SRS0=DIAL=HX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F6DC433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 11:33:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7938064EEF
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 11:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7938064EEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A789168C;
	Sun, 21 Feb 2021 12:32:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A789168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613907198;
	bh=8am2Wfeu7o2jRNSplTVndKL/SWb6HzsQxkgeIT6EEkg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V9gUvyeb6+1W/mbYFEUKS1jZCB+z1tROrG2XcPvMUovUBA2qROVQGdyMfiOrPlm6k
	 EJipftU96nyjf/vXWphu8qKIQiYlcyUTNkeiHfgmMwl4MzMIRq1TYG7q8yQASgupw2
	 gKg5NCJgZzT0lagAczAwBycGvRtSlQpQ0uNSGNKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F439F80425;
	Sun, 21 Feb 2021 12:31:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71703F8016A; Sun, 21 Feb 2021 12:30:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65139F80082
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2021 12:30:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65139F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="UORxlXsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613907042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGhoaiUahRGEqg6YAu1OLbTZWon7ll7ymdptKdOKNCc=;
 b=UORxlXsyNvK2ZTaxpFuDLtVhygrzBxcUJn1uvWKTB2ZgGl8U2iylEDeBA+lXXFleVDSghR
 eHhiDHLMs2o11fxu/ft4TX2TQ+oK3hKlW9PupWGCOSMQIVsmqGqnL3+0W0+a2e5ZkT8p3w
 txMJ0c+/7TEdajybKcYy4lPb/1oju4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-IpQAVNBeNgqFWX0TVZqZIw-1; Sun, 21 Feb 2021 06:30:38 -0500
X-MC-Unique: IpQAVNBeNgqFWX0TVZqZIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0721C291;
 Sun, 21 Feb 2021 11:30:36 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 743751002391;
 Sun, 21 Feb 2021 11:30:35 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 1/3] HID: elan: Silence mute LED errors being logged when
 the device is unplugged
Date: Sun, 21 Feb 2021 12:30:27 +0100
Message-Id: <20210221113029.103703-2-hdegoede@redhat.com>
In-Reply-To: <20210221113029.103703-1-hdegoede@redhat.com>
References: <20210221113029.103703-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 linux-leds@vger.kernel.org, linux-input@vger.kernel.org
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

Being integrated into an USB keyboard-dock the mute LED can go away
at any time, leading to the following errors:

[  918.667671] elan 0003:04F3:0755.0002: Failed to set mute led brightness: -19
[  918.667737] leds elan:red:mute: Setting an LED's brightness failed (-19)

Fix this by making the following changes:

1. Don't log an error from elan_mute_led_set_brigtness() when
   ret == -ENODEV
2. Set the LED_HW_PLUGGABLE flag on the mute LED led_classdev

While at it also make sure that elan_mute_led_set_brigtness() returns
an error (-EIO) when ret != 3 but it is not an error (>= 0).

Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Return -EIO when ret != 3 and >= 0
---
 drivers/hid/hid-elan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index dae193749d44..473d8528319d 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -445,8 +445,9 @@ static int elan_mute_led_set_brigtness(struct led_classdev *led_cdev,
 	kfree(dmabuf);
 
 	if (ret != ELAN_LED_REPORT_SIZE) {
-		hid_err(hdev, "Failed to set mute led brightness: %d\n", ret);
-		return ret;
+		if (ret != -ENODEV)
+			hid_err(hdev, "Failed to set mute led brightness: %d\n", ret);
+		return ret < 0 ? ret : -EIO;
 	}
 
 	drvdata->mute_led_state = led_state;
@@ -462,6 +463,7 @@ static int elan_init_mute_led(struct hid_device *hdev)
 	mute_led->brightness_get = elan_mute_led_get_brigtness;
 	mute_led->brightness_set_blocking = elan_mute_led_set_brigtness;
 	mute_led->max_brightness = LED_ON;
+	mute_led->flags = LED_HW_PLUGGABLE;
 	mute_led->dev = &hdev->dev;
 
 	return devm_led_classdev_register(&hdev->dev, mute_led);
-- 
2.30.1

