Return-Path: <SRS0=hTuJ=J6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E9C43460
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 20:56:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF2A61283
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 20:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF2A61283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3B1416BA;
	Mon,  3 May 2021 22:55:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3B1416BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620075370;
	bh=EKl7AwZyJPSf2QbpJLTqeUbNflHPB6jkuqALetRnOEM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ew8oBhilwrzWOgz59yd4cz686oAmF+nTOVUlIq68XPqo4TqqwSZpGHqkoTzFYh20I
	 OwenrzjMKSg7GoE9ICEQrVcmtMGNtDJ4dHeRHTuCBX4y0+WMB0uVmXmVh08zMoCUoo
	 qVrgj7PjGwVEy1AwQkcPceZ6cOROpS5OXXTPUTrY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B901BF804B2;
	Mon,  3 May 2021 22:54:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74675F80114; Mon,  3 May 2021 22:54:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B90DF80114
 for <alsa-devel@alsa-project.org>; Mon,  3 May 2021 22:52:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B90DF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="dLCCHoUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620075159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+huvqnxgF1KlARPMQj5K/U3By1xTBi1G7sO3q6623O8=;
 b=dLCCHoUvK3Jd6qm6BSL7CTDQ61K+PVjlFycM/RkoTwmtnqo+Y7Ve7HHKJ09YzplcbWqROq
 AJpj6qH0bBbbukq+Xodm66qE90MSBYCr1gn26JeoXz4rkjXQJ1s1c+2MD2KKbOmjrLOCie
 uqFFcD5hJn1CkWgdqQD073P3CQYqVOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-xgTusvynNJqE48R6zRTZ6w-1; Mon, 03 May 2021 16:52:37 -0400
X-MC-Unique: xgTusvynNJqE48R6zRTZ6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDCFA805EE3;
 Mon,  3 May 2021 20:52:36 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-158.ams2.redhat.com [10.36.112.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1242C5C1C2;
 Mon,  3 May 2021 20:52:35 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 2/5] mixer: simple - Move handling of 3D Control -
 Depth controls to the exceptions list
Date: Mon,  3 May 2021 22:52:28 +0200
Message-Id: <20210503205231.167346-3-hdegoede@redhat.com>
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

Remove the custom handling of 3D Control - Depth control-names, replacing
this with adding the 3 full names which are used for such controls to the
exceptions list:

"3D Control - Depth"
"3D Control Sigmatel - Depth"
"3D Control Sigmatel - Rear Depth"

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/mixer/simple_none.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 30d5aa8b..b29554cb 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -922,6 +922,10 @@ static const struct excep {
 	/* Avoid these Capture Volume/Switch controls getting seen as GLOBAL VOL/SW */
 	{"Capture Volume", 7, CTL_CAPTURE_VOLUME},
 	{"Capture Switch", 7, CTL_CAPTURE_SWITCH},
+	/* Playback Volume/Switch controls without a " Playback ..." suffix */
+	{"3D Control - Depth", 18, CTL_PLAYBACK_VOLUME},
+	{"3D Control Sigmatel - Depth", 27, CTL_PLAYBACK_VOLUME},
+	{"3D Control Sigmatel - Rear Depth", 32, CTL_PLAYBACK_VOLUME},
 	{NULL,}
 };
 #endif
@@ -953,13 +957,6 @@ static int base_len(const char *name, selem_ctl_type_t *type)
 		}
 	}
 
-	if (strstr(name, "3D Control")) {
-		if (strstr(name, "Depth")) {
-			*type = CTL_PLAYBACK_VOLUME;
-			return strlen(name);
-		}
-	}
-
 	*type = CTL_SINGLE;
 	return strlen(name);
 }
-- 
2.31.1

