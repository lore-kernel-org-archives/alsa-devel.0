Return-Path: <SRS0=YAlk=H6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E61C433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Feb 2021 16:14:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBA964EB1
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Feb 2021 16:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBA964EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70E8584A;
	Sun, 28 Feb 2021 17:13:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70E8584A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614528847;
	bh=wwGcXiCR+sf909zWA6F+l9YWekOCoQ3vyWkXCnjvoNs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AKcfh3OyjQT5yzoa7bSk6sIQjwqXJPfiGoFO9Yt4SiULgMBSVCXJXQbdXD4rlwyo6
	 0Eaq7ipFf98uA9qbA324/S2gUTQz4MBL6Ks61aOgG7/F7rHxYRjsrYuz38fZDD0TYq
	 lt1tpv3WGaANEbFB66+vHKzY+66LWwsC9/djXofs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC0EBF8010A;
	Sun, 28 Feb 2021 17:13:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE6ACF80271; Sun, 28 Feb 2021 17:13:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7E7EF8010A
 for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2021 17:13:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7E7EF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="AOEC812B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614528791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ajWbcWt+G2Y7QBoHv4g0EEKtFgfnFh+pA0+cA1++zx0=;
 b=AOEC812B3zS/gmsyr+FNx/tDkAJSLbZQgwCQdlyqqdQZXxJBZGNiDSXYBPRihAbTEpiPGa
 kIsUUb5xiDeIDwGdm5FmpNsBWFGCMBZxoRfp7ZKrouDEU/o37Qa623KvEgfuiMNiTBdFNE
 wLbp/mIMUC4tt1QP228Mw3oeuSnBYe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-oRR1doWtNTyzHZVLjN7raw-1; Sun, 28 Feb 2021 11:13:07 -0500
X-MC-Unique: oRR1doWtNTyzHZVLjN7raw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 468B2C288;
 Sun, 28 Feb 2021 16:13:06 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50AC65D9CC;
 Sun, 28 Feb 2021 16:13:04 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib v2 0/3] mixer: Volume control fixes
Date: Sun, 28 Feb 2021 17:13:01 +0100
Message-Id: <20210228161304.241288-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>
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

Here is v2 of my series of alsa-lib volume-control fixes which I wrote
while working on adding hw-volume control to UCM profiles for various
x86 ASoC setups.

New in v2 is adding an extra entry to the capture_volume_names array
for the "ADC PGA Gain Volume" control used in the es8316 codec driver
in patch 3/3.

Note that patch 3/3 is not strictly necessary to make hw-volume control
work. At least the PA hw-vol-control code does not care if the controls
are wronly marked as global-volume-controls instead of
capture-volume-controls. I mostly wrote patch 3/3 because for
correctness reasons, so if it is deemed controversial we can drop it.

Regards,

Hans


Hans de Goede (3):
  mixer: Unify simple_none: base_len() exception handling
  mixer: Add exception for non " Volume" suffixed capture vol-ctls used
    in ASoC realtek codec drivers
  mixer: Add exception for some capture-vol-ctls which have a " Volume"
    suffix

 src/mixer/simple_none.c | 83 +++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 19 deletions(-)

-- 
2.30.1

