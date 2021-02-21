Return-Path: <SRS0=DIAL=HX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A1C433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 11:32:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DEB64EE0
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 11:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DEB64EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C46C167E;
	Sun, 21 Feb 2021 12:31:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C46C167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613907147;
	bh=f58vFZibWcpR9gOs38xtBt/xVvTG6JuHnuRkUehslAQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ONbiCRhU01qfZpvzTyQFPzeFMJf1bkZJmkKj0D1E7mmDH8LFxaEBF26B6PemDPRFv
	 sX0EzA/1vCk3TNA1uX7lN4bJpX2gJ0gaJhwDeJd4TuAt+15jcXSmy1SqqyOS2BC+0E
	 KaH9NCVwt5l4gOM3dOhWn1Eh3ck00VCocrbZMb5w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7F6FF80167;
	Sun, 21 Feb 2021 12:31:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37697F802DF; Sun, 21 Feb 2021 12:30:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96365F80167
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2021 12:30:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96365F80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="O0a+hCLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613907043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRvDIk6w5R7tTJTlwErthP/8a9L/ZRRF5eq/nuQxcH8=;
 b=O0a+hCLCNk6LB/xTKTYU/u80p6R1FxjpUdH3SeCzAdnTahb4F+jWqIclH1y839xbj+dymK
 DKSNNKyaRLJ/GcS7YaLkm8B2RjWhOv1ZM+/+48v+1QeRWGYh+jO1bmDBlhzc9JN4sxS4H5
 oZ/EvypLEo7qgwySDcXNQEd7yJSv5m4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-BKvnVWu4OxaWoFxFu5FipQ-1; Sun, 21 Feb 2021 06:30:41 -0500
X-MC-Unique: BKvnVWu4OxaWoFxFu5FipQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65826107ACE8;
 Sun, 21 Feb 2021 11:30:40 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E22B91001281;
 Sun, 21 Feb 2021 11:30:38 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 3/3] HID: elan: Remove elan_mute_led_get_brigtness()
Date: Sun, 21 Feb 2021 12:30:29 +0100
Message-Id: <20210221113029.103703-4-hdegoede@redhat.com>
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

The led_classdev already contains a cached value of the last set
brightness, the brightness_get callback is only meant for LED drivers
which can read back the actual / current brightness from the hardware.

Since elan_mute_led_get_brigtness() just returns the last set value
it does not add any functionality, so we can just remove it.

Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-elan.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 5173f50d474d..021049805bb7 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -410,15 +410,6 @@ static int elan_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
-static enum led_brightness elan_mute_led_get_brigtness(struct led_classdev *led_cdev)
-{
-	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hdev = to_hid_device(dev);
-	struct elan_drvdata *drvdata = hid_get_drvdata(hdev);
-
-	return drvdata->mute_led_state;
-}
-
 static int elan_mute_led_set_brigtness(struct led_classdev *led_cdev,
 				       enum led_brightness value)
 {
@@ -461,7 +452,6 @@ static int elan_init_mute_led(struct hid_device *hdev)
 
 	mute_led->name = "elan:red:mute";
 	mute_led->default_trigger = "audio-mute";
-	mute_led->brightness_get = elan_mute_led_get_brigtness;
 	mute_led->brightness_set_blocking = elan_mute_led_set_brigtness;
 	mute_led->max_brightness = LED_ON;
 	mute_led->flags = LED_HW_PLUGGABLE;
-- 
2.30.1

