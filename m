Return-Path: <SRS0=SdgV=HW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88A1C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Feb 2021 16:34:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0575164ED7
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Feb 2021 16:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0575164ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C5181671;
	Sat, 20 Feb 2021 17:33:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C5181671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613838850;
	bh=NUnoDA2ls7PwWFaepPwTH6PBzwVuIgcpyRz5f9q7Hpk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xgh/chyixikkJvchRLk0X118/KUGVTEczN17ubG7UFZhVW1DY6HcFHRMcUHzsnDKf
	 /plFx9bbm0UwRvE7kReo5Kej9s1IMhcGCsNFYA3Atao8xXUn0LP4XUFazvGZ6rgIJK
	 x2oSiy229AyZBndShUlNL2tqIoJox78nQRb+gbP8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B56E5F801DB;
	Sat, 20 Feb 2021 17:32:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8216F80260; Sat, 20 Feb 2021 17:32:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1508DF8016E
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 17:32:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1508DF8016E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="UtwaFKt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613838746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhMG8x2Y9+zAbxFa8WeeiJJ9q6pmNxG6wm/onpeMyVQ=;
 b=UtwaFKt++GdFTQwQU2+HsgeIXu4Ci8TSBOSkPkEMvgFCsKYwfaISF4Z+mB0Zd8aGk+jBuM
 VtEvfXlptNsS1cBqUrx0I3VACiTkNbdEtMCy3J3Dc5mxS5T6RuTjFvTkwip174B8SmX3ly
 CULuIevYsfsw4PqDVzuBd3EUT16/SlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-CRAw_weDMyGhi0NyZIEkHg-1; Sat, 20 Feb 2021 11:32:22 -0500
X-MC-Unique: CRAw_weDMyGhi0NyZIEkHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A01C518449FA;
 Sat, 20 Feb 2021 16:32:21 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-29.ams2.redhat.com [10.36.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C0076064B;
 Sat, 20 Feb 2021 16:32:17 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/3] HID: elan: Set default_trigger-s for the mute LED
Date: Sat, 20 Feb 2021 17:32:10 +0100
Message-Id: <20210220163211.323178-2-hdegoede@redhat.com>
In-Reply-To: <20210220163211.323178-1-hdegoede@redhat.com>
References: <20210220163211.323178-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
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

The mute LED should be automatically turned on/off based
on the audio-cards mixer settings.

Add the standardized default-trigger name for this, so that the alsa
code can turn the LED on/off as appropriate (on supported audio cards).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-elan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 71740988a3f6..6958649ece22 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -460,6 +460,7 @@ static int elan_init_mute_led(struct hid_device *hdev)
 	struct led_classdev *mute_led = &drvdata->mute_led;
 
 	mute_led->name = "elan:red:mute";
+	mute_led->default_trigger = "audio-mute";
 	mute_led->brightness_get = elan_mute_led_get_brigtness;
 	mute_led->brightness_set_blocking = elan_mute_led_set_brigtness;
 	mute_led->max_brightness = LED_ON;
-- 
2.30.1

