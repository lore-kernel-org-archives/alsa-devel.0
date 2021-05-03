Return-Path: <SRS0=hTuJ=J6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93B8C433B4
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 20:54:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D079F61157
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 20:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D079F61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57D3E168E;
	Mon,  3 May 2021 22:53:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57D3E168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620075271;
	bh=MvY64cslqxvvQ5aECsu+fRYfvnVmyjbh1wsOH2AR6q0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c9LcUgrYc/9TjnWkHIxiPi9rRt5CgCIULqRl7zU8HIPkw31ZqgRocMS2AdDGz56cK
	 hLatLuhwRs3hgT3qCiRc19Pgmj6T748F+kU40tnJXpdbf26svvaIUOdLZLpJqqVNPc
	 MDDH6UFUC9tcpeDZuKyVs+C96gGt93A8vXimjKR0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A212F80162;
	Mon,  3 May 2021 22:52:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4274F80279; Mon,  3 May 2021 22:52:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98617F8028D
 for <alsa-devel@alsa-project.org>; Mon,  3 May 2021 22:52:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98617F8028D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="VPxwNz2D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620075162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G1J9wlfqifo9yOskr2L6kKwGnVgLunTYza73Z+xZb1o=;
 b=VPxwNz2DyrDdN/LJO6nsQ+AvW7/STj5f9cLyIRAn/EpemQOj5ICd/dG+RoJ9AvX7ug+qrl
 EyGVg2D3q08TWMWrWYSsNH02Ygcm0cXC8CfWm3F1v6L1PIxQ+U9/3kTYCp51+/B7de5vDm
 ssrtL2NmRieWb68ZXYMx2MF3VIDiHbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-3RIvdVBtOaWwQbdHjZFXXg-1; Mon, 03 May 2021 16:52:40 -0400
X-MC-Unique: 3RIvdVBtOaWwQbdHjZFXXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1683A107ACC7;
 Mon,  3 May 2021 20:52:40 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-158.ams2.redhat.com [10.36.112.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 368825C1C2;
 Mon,  3 May 2021 20:52:39 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 5/5] mixer: simple - Add exceptions for some Playback
 Switches with a " Channel Switch" suffix
Date: Mon,  3 May 2021 22:52:31 +0200
Message-Id: <20210503205231.167346-6-hdegoede@redhat.com>
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

Use the following troublesome playback-switch-control names:

"Headphone Channel Switch"
"HP Channel Switch"
"Speaker Channel Switch"

There are 2 problems with these names:

1. They are the mute controls for the matching:
"Headphone Playback Volume"
"HP Playback Volume"
"Speaker Playback Volume"
controls, to be properly paired, which is necessary for HW volume-control
support, the simple mixer code needs to recognize that the base-name for
these is e.g. "Headphone" not "Headphone Channel".

2. They are playback-switches, yet they get recognized as global-switches.

Add these to the exceptions table so that they get the proper basename
and type set.

Note we can NOT fix this by adding " Channel Switch" as a suffix to the
suffixes table, because the line-out output on these codecs has the
following controls:

"OUT Playback Switch"
"OUT Channel Switch"
"OUT Playback Volume"

Where the 2 switches describe mutes in 2 different places in the graph.

So if we were to add a " Channel Switch" suffix map to CTL_PLAYBACK_SWITCH
then we would get 2 CTL_PLAYBACK_SWITCH controls for the "OUT" mixer
element, which is not allowed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/mixer/simple_none.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index de81966f..d5025f68 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -933,6 +933,9 @@ static const struct excep {
 	{"3D Control - Depth", 18, CTL_PLAYBACK_VOLUME},
 	{"3D Control Sigmatel - Depth", 27, CTL_PLAYBACK_VOLUME},
 	{"3D Control Sigmatel - Rear Depth", 32, CTL_PLAYBACK_VOLUME},
+	{"Headphone Channel Switch", 9, CTL_PLAYBACK_SWITCH},
+	{"HP Channel Switch", 2, CTL_PLAYBACK_SWITCH},
+	{"Speaker Channel Switch", 7, CTL_PLAYBACK_SWITCH},
 	/* Capture Volume/Switch controls without a " Capture ..." suffix */
 	{"ADC Boost Gain", 14, CTL_CAPTURE_VOLUME},
 	{"IN1 Boost", 9, CTL_CAPTURE_VOLUME},
-- 
2.31.1

