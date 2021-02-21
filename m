Return-Path: <SRS0=DIAL=HX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8097EC433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 11:21:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4105564EB3
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 11:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4105564EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5F421667;
	Sun, 21 Feb 2021 12:20:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5F421667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613906474;
	bh=GckkMDM+Uf2mY5QMX6bERuKh1ZjkbwVemNa2goa4CUY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CR8NaeT1GpM7vwxa5cbFAkgN+RzGgcnjDFPyIB7gvlqgUJDykDWMfX34oNGdDN2yf
	 jXMvAHLBDZ8TawH7VSmmEi1SIhLIXFdQBK42q7L/JWGuRNQQdh/H9zUBTkJY4/1kFF
	 slfKVG4HsYO5b6yEor8XGTL1NAc96asfs/Esjs/s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09AC1F8016A;
	Sun, 21 Feb 2021 12:20:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22EACF8016A; Sun, 21 Feb 2021 12:20:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3AB1F80082
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2021 12:20:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3AB1F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="iCGiJ1NM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613906416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i92iP2g3FelTAVWQC8EOy+yC+VzBfmrFZlUJyGyPuuU=;
 b=iCGiJ1NM3ClTEVqeE5t/+2fJRtmnsAFlxktT3f1w255t36QN5p3FbYF0zXi6SK8tc89uVb
 0Ijw6vQ4TX3LxTp/gZFukl5V0s3awZvo7pVMLjxgXkcvS9fGVQd0nyPIVfBGe6EMRQihkG
 8jKcvkd0GcN8y9kDJrQ0j6Hh3WOvoLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-h-G2GOdvOs20N_xHR8XT8Q-1; Sun, 21 Feb 2021 06:20:14 -0500
X-MC-Unique: h-G2GOdvOs20N_xHR8XT8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9171CC28A;
 Sun, 21 Feb 2021 11:20:12 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B814C6268F;
 Sun, 21 Feb 2021 11:20:06 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 0/7] HID: lenovo: Mute LED handling fixes and improvements
Date: Sun, 21 Feb 2021 12:19:58 +0100
Message-Id: <20210221112005.102116-1-hdegoede@redhat.com>
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

Hi All,

Here is v3 of my series with mute LED handling fixes and improvements
for the hid-lenovo driver.

v3 addresses the review-remarks from Marek Behún, thank you for all the
reviews Marek.

See the individual patches for detailed per patch changelogs.

Regards,

Hans


Hans de Goede (7):
  HID: lenovo: Use brightness_set_blocking callback for setting LEDs
    brightness
  HID: lenovo: Fix lenovo_led_set_tp10ubkbd() error handling
  HID: lenovo: Check hid_get_drvdata() returns non NULL in
    lenovo_event()
  HID: lenovo: Remove lenovo_led_brightness_get()
  HID: lenovo: Set LEDs max_brightness value
  HID: lenovo: Map mic-mute button to KEY_F20 instead of KEY_MICMUTE
  HID: lenovo: Set default_triggers for the mute and micmute LEDs

 drivers/hid/hid-lenovo.c | 69 ++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

-- 
2.30.1

