Return-Path: <SRS0=hTuJ=J6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293CEC433ED
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 20:54:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3827061283
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 20:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3827061283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F6211694;
	Mon,  3 May 2021 22:53:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F6211694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620075266;
	bh=nImRKySFQooRHDaYWzuSd3A1Bs2fgvpSd3OaCWiVES8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K5qp3r5Ei4AABRejRfCnwMY/aTj0e4KfX1TGiXDwU3aYenCeqwkY5MdJWiCv/YOPX
	 +n/e8Kahb+FyiPnQzi4ycruNGmeFtOYRRUg0+Yln2KQqSUhW5LwE0iyHoLocvMI0w/
	 A8QwTIS5OMU/l5r/ohmwig/zP9lVNUpqoXw8RCxw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D4D5F80279;
	Mon,  3 May 2021 22:52:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D43A1F80162; Mon,  3 May 2021 22:52:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC080F80257
 for <alsa-devel@alsa-project.org>; Mon,  3 May 2021 22:52:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC080F80257
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="PlWYNMeo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620075160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7Dpb+9XXCcmVrvrfS56hBNAINZtLpujCB/6/OSM1F8=;
 b=PlWYNMeomVLDOg44Hcf53Ij45+9pcfGWePrDizIiWwAZStBrMzwI8P6MaBcLnCxuq8BQmr
 bYjs5iPKYyJYy9J6KGmIvex3LjpBqVi0RvkQE29abGyUT+73P68kCvsb+Lkqg5qYYtkVCQ
 NiI02wbwOJBhNFDnxND76kUkqFQOPOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-aDYxv0xGOC6uqnzpwZeGLA-1; Mon, 03 May 2021 16:52:38 -0400
X-MC-Unique: aDYxv0xGOC6uqnzpwZeGLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB6966972A;
 Mon,  3 May 2021 20:52:37 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-158.ams2.redhat.com [10.36.112.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EEE05C1C2;
 Mon,  3 May 2021 20:52:36 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 3/5] mixer: simple - Add exceptions for non " Volume"
 suffixed capture vol-ctls used in ASoC realtek codec drivers
Date: Mon,  3 May 2021 22:52:29 +0200
Message-Id: <20210503205231.167346-4-hdegoede@redhat.com>
In-Reply-To: <20210503205231.167346-1-hdegoede@redhat.com>
References: <20210503205231.167346-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

The following ASoC codec drivers:

sound/soc/codecs/rt5640.c
sound/soc/codecs/rt5645.c
sound/soc/codecs/rt5651.c
sound/soc/codecs/rt5677.c

Use capture-volume-control names like: "IN1 Boost", note the missing
" Volume" suffix. This causes the mixer code to not identify these as
volume-controls, which causes some of the dB related sm_elem_ops to
return -EINVAL.

This in turn causes alsamixer to not show dB info and causes UCM profile
HW volume control support in pulseaudio to not work properly due to the
lacking dB scale info.

This cannot be fixed on the kernel side because the non " Volume" suffixed
names are used in UCM profiles currently shipping in alsa-ucm-conf.

Add these to the exceptions table, so that these correctly get identified
as CTL_CAPTURE_VOLUME controls.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/mixer/simple_none.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index b29554cb..8f964959 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -926,6 +926,11 @@ static const struct excep {
 	{"3D Control - Depth", 18, CTL_PLAYBACK_VOLUME},
 	{"3D Control Sigmatel - Depth", 27, CTL_PLAYBACK_VOLUME},
 	{"3D Control Sigmatel - Rear Depth", 32, CTL_PLAYBACK_VOLUME},
+	/* Capture Volume/Switch controls without a " Capture ..." suffix */
+	{"ADC Boost Gain", 14, CTL_CAPTURE_VOLUME},
+	{"IN1 Boost", 9, CTL_CAPTURE_VOLUME},
+	{"IN2 Boost", 9, CTL_CAPTURE_VOLUME},
+	{"IN3 Boost", 9, CTL_CAPTURE_VOLUME},
 	{NULL,}
 };
 #endif
-- 
2.31.1

