Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B97C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:22:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E70F20760
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Wrr0tWBc";
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1Eb4h9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E70F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3B9315E5;
	Mon,  8 Jun 2020 22:22:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3B9315E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591647772;
	bh=q3WAxFXYkLFQwiYhY+Y0zJEJbIJj5BWJWRTBLZyv1xE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wrr0tWBcbBWdttoLUFNskQKKap83CFQHDYsilvPt55c1x7vJyH0yghZYssDtgzm2g
	 XCoZsttQC6DwBTQdfDqKguaq+/RfTYzu5MiVmuz8MlxrFeYfOqFKyRZCTbiJ5IDxaD
	 U2P47fnrxDSEGTsyh+iuMsdxibyKo+W5fA8VLoUY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E64C6F801F7;
	Mon,  8 Jun 2020 22:22:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A223F8021E; Mon,  8 Jun 2020 22:22:00 +0200 (CEST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43742F80124
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 22:21:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43742F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="C1Eb4h9Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591647713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxQFYhQlenCf2Gvq4gPwtQYTqKj9U0Rn8vNZE8pcjHs=;
 b=C1Eb4h9ZXoaZt2YShMpXNHw3tIv4IUdfMnwROaENiAPJg0ryECOaCGJeut5fZZd1PvO3Ym
 qo0qwHyih1OANRwGxRujy9BDdneSWifqgkjLgn+ImpZbwxS26qdOt5qKHkiu5tCUg7kWHl
 bQbtXWuunrMjAfSxF5Hzef8IzG7vSkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-bwtsGpopOui5H03F0gU6Mw-1; Mon, 08 Jun 2020 16:21:51 -0400
X-MC-Unique: bwtsGpopOui5H03F0gU6Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B950119057BA;
 Mon,  8 Jun 2020 20:21:47 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-122.ams2.redhat.com
 [10.36.114.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 963796116D;
 Mon,  8 Jun 2020 20:21:46 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 2/3] bytcr-rt5651: Fix high noise level + soft input on DMIC
Date: Mon,  8 Jun 2020 22:21:41 +0200
Message-Id: <20200608202142.92894-2-hdegoede@redhat.com>
In-Reply-To: <20200608202142.92894-1-hdegoede@redhat.com>
References: <20200608202142.92894-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
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

The DMIC needs to have the DMIC ASRC enabled, otherwise capturing audio
from it results in mostly capturing noise + the actual recorded voice
very soft in the background of the noise.

This has been tested on a Point of View P1006W v1.0 tablet, which is the
only RT5651 X86 device using a DMIC that I am aware of.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5651/DigitalMic.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ucm2/codecs/rt5651/DigitalMic.conf b/ucm2/codecs/rt5651/DigitalMic.conf
index aa40c1c..d21b21d 100644
--- a/ucm2/codecs/rt5651/DigitalMic.conf
+++ b/ucm2/codecs/rt5651/DigitalMic.conf
@@ -4,12 +4,14 @@ SectionDevice."Mic" {
 	EnableSequence [
 		cset "name='Stereo1 ADC MIXL ADC2 Switch' on"
 		cset "name='Stereo1 ADC MIXR ADC2 Switch' on"
+		cset "name='DMIC ASRC Switch' on"
 		cset "name='Internal Mic Switch' on"
 	]
 
 	DisableSequence [
 		cset "name='Stereo1 ADC MIXL ADC2 Switch' off"
 		cset "name='Stereo1 ADC MIXR ADC2 Switch' off"
+		cset "name='DMIC ASRC Switch' off"
 		cset "name='Internal Mic Switch' off"
 	]
 
-- 
2.26.2

