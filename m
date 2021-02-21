Return-Path: <SRS0=DIAL=HX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB74C433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 11:24:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA0164ED7
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 11:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA0164ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B37CC1698;
	Sun, 21 Feb 2021 12:23:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B37CC1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613906667;
	bh=QL1sxbSIu0CbMqtc4ZYRud2Tx43SGTwnUaM327cebBg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jiLwj9S6E8zzvq/+TeBBvMJQ2ym96WRFB29w3gh4a/Rbt0RtSeM0MmkZqWwzDJbzJ
	 3vwIKTJlC8bBAsLONJPhSt6NEgY4pYz6/VhIR4jlh+0vyrcbRnAeD9ay3kezoAye0T
	 2YIOxJcEm+mkmreDuLsfCvKFub46EjF3TgUTA0cQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5A3EF804D1;
	Sun, 21 Feb 2021 12:20:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E740AF80424; Sun, 21 Feb 2021 12:20:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60A0AF802E7
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2021 12:20:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60A0AF802E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="J6Dl4GT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613906435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrHSilLpHTGkQD/lwIjOp8nYxJSDcdy1iNLafz2rtxw=;
 b=J6Dl4GT6dHFq4hh2WxkgTtrEpRRmpneYwBJ7/V/iB1XSf8EqNbHDB4zQnQrBQPlwtOvW0y
 xEgizfG8E9k6SXRGdFw8Jm1v2HbHyhQvAv0qWecd8UC68xCRA9zowfFQslvOOT257CE9vc
 QQEkgx78WRwWtkRHs6pRaWJ3xa31UEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-J_Vw7hP6O1-Ys7kVYjEEDw-1; Sun, 21 Feb 2021 06:20:33 -0500
X-MC-Unique: J_Vw7hP6O1-Ys7kVYjEEDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3A251009615;
 Sun, 21 Feb 2021 11:20:31 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82EA262A24;
 Sun, 21 Feb 2021 11:20:26 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 7/7] HID: lenovo: Set default_triggers for the mute and
 micmute LEDs
Date: Sun, 21 Feb 2021 12:20:05 +0100
Message-Id: <20210221112005.102116-8-hdegoede@redhat.com>
In-Reply-To: <20210221112005.102116-1-hdegoede@redhat.com>
References: <20210221112005.102116-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

The mute and mic-mute LEDs should be automatically turned on/off based
on the audio-card's mixer settings.

Add the standardized default-trigger names for this, so that the alsa
code can turn the LEDs on/off as appropriate (on supported audio cards).

This brings the mute/mic-mute LED support inline with the thinkpad_acpi
support for the same LEDs in keyboards directly connected to the
laptop's embedded-controller.

Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-lenovo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 2cf89b880ac5..2287142116b9 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -824,6 +824,7 @@ static int lenovo_register_leds(struct hid_device *hdev)
 	snprintf(name_micm, name_sz, "%s:amber:micmute", dev_name(&hdev->dev));
 
 	data->led_mute.name = name_mute;
+	data->led_mute.default_trigger = "audio-mute";
 	data->led_mute.brightness_set_blocking = lenovo_led_brightness_set;
 	data->led_mute.max_brightness = 1;
 	data->led_mute.flags = LED_HW_PLUGGABLE;
@@ -833,6 +834,7 @@ static int lenovo_register_leds(struct hid_device *hdev)
 		return ret;
 
 	data->led_micmute.name = name_micm;
+	data->led_micmute.default_trigger = "audio-micmute";
 	data->led_micmute.brightness_set_blocking = lenovo_led_brightness_set;
 	data->led_micmute.max_brightness = 1;
 	data->led_micmute.flags = LED_HW_PLUGGABLE;
-- 
2.30.1

