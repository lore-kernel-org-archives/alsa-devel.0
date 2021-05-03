Return-Path: <SRS0=hTuJ=J6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02726C433ED
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 20:55:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F312761364
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 20:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F312761364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EF0816A9;
	Mon,  3 May 2021 22:55:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EF0816A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620075354;
	bh=SkO2kUkdspS8LMHlb1JIs8Aoi+JHNMn3ZTo9jObCTS0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=beu+n5OJfAN1fDK5LWhS4tkRIQbdiVUA29sRFDpBCffM+mWXFPleXIeDpPOAHOxpA
	 ey4NT6k2pURyCiWt0vahf67icRtMZRo1lLdNUyFAm1Se0i7wGRJXQcvHrnL8DG85bU
	 iAqxq6/bx3Z9WxNnSWbAA6cvi8RJZm/spEZtm5G0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 013D7F8025F;
	Mon,  3 May 2021 22:54:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6096EF8042F; Mon,  3 May 2021 22:54:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F579F8025F
 for <alsa-devel@alsa-project.org>; Mon,  3 May 2021 22:52:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F579F8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="B+uefpHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620075161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0f3mmuBzUelgfzaRUh59gtvVHzuroudMEaeaBKG0JMw=;
 b=B+uefpHu9ScpSSeALcwLbYz6mjKwJlTT9WVMW0sOkbBcyPS+gLyasIr9NxHyuj5vMr3Sp0
 9P3g3465AdaH+qZ2gzKfuS/c264P8B2160LTgG2Z9hAHxJGJ8vU6drMPszSLlJLa88fG0c
 6j4+EzJwDZblwObqR8wVEDsHaaSFJSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-T12GfFWlMgugG0ArO4V9ig-1; Mon, 03 May 2021 16:52:40 -0400
X-MC-Unique: T12GfFWlMgugG0ArO4V9ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5765801106;
 Mon,  3 May 2021 20:52:38 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-158.ams2.redhat.com [10.36.112.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C6125C1C2;
 Mon,  3 May 2021 20:52:38 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 4/5] mixer: simple - Add exceptions for some
 capture-vol-ctls which have a " Volume" suffix
Date: Mon,  3 May 2021 22:52:30 +0200
Message-Id: <20210503205231.167346-5-hdegoede@redhat.com>
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

sound/soc/codecs/rt5659.c
sound/soc/codecs/rt5660.c
sound/soc/codecs/rt5665.c
sound/soc/codecs/rt5668.c
sound/soc/codecs/rt5670.c
sound/soc/codecs/rt5682.c

Use the following troublesome capture-volume-control names:
"IN1 Boost Volume"
"IN2 Boost Volume"
"IN3 Boost Volume"
"STO1 ADC Boost Gain Volume"
"STO2 ADC Boost Gain Volume"
"Mono ADC Boost Gain Volume"

And sound/soc/codecs/es8316.c uses "ADC PGA Gain Volume".

Note how these are suffixed with just " Volume" instead of
"Capture Volume". Add these to the exceptions table,
so that the type correctly gets set to CTL_CAPTURE_VOLUME instead
of CTL_GLOBAL_VOLUME.

This correctly makes snd_mixer_selem_has_capture_volume() return true for
these (and makes snd_mixer_selem_has_common_volume() return false).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/mixer/simple_none.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 8f964959..de81966f 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -920,8 +920,15 @@ static const struct excep {
 	 */
 	{"Input Source", 12, CTL_CAPTURE_ROUTE},
 	/* Avoid these Capture Volume/Switch controls getting seen as GLOBAL VOL/SW */
+	{"ADC PGA Gain Volume", 12, CTL_CAPTURE_VOLUME},
 	{"Capture Volume", 7, CTL_CAPTURE_VOLUME},
 	{"Capture Switch", 7, CTL_CAPTURE_SWITCH},
+	{"IN1 Boost Volume", 9, CTL_CAPTURE_VOLUME},
+	{"IN2 Boost Volume", 9, CTL_CAPTURE_VOLUME},
+	{"IN3 Boost Volume", 9, CTL_CAPTURE_VOLUME},
+	{"Mono ADC Boost Gain Volume", 19, CTL_CAPTURE_VOLUME},
+	{"STO1 ADC Boost Gain Volume", 19, CTL_CAPTURE_VOLUME},
+	{"STO2 ADC Boost Gain Volume", 19, CTL_CAPTURE_VOLUME},
 	/* Playback Volume/Switch controls without a " Playback ..." suffix */
 	{"3D Control - Depth", 18, CTL_PLAYBACK_VOLUME},
 	{"3D Control Sigmatel - Depth", 27, CTL_PLAYBACK_VOLUME},
-- 
2.31.1

