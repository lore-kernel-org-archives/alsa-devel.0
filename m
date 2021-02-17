Return-Path: <SRS0=bkJA=HT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A64C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Feb 2021 14:35:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E0260C3E
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Feb 2021 14:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E0260C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B22AA15E2;
	Wed, 17 Feb 2021 15:34:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B22AA15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613572541;
	bh=bkNz4m0LfxGeeYaQgxFJa/ZwIPuaaVmDbBRW4GxXLjc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c+h5pHY1jXsmaX69SnsAJKJ06n0ICO2FVMQK0DLsVn5fruNdZem9QAD2xRl5Wlzgl
	 Vhy5JJVFfnT6uqd36D+J7Q6J2D128i1lGi/fSefTQ5UCXQNoXApTKuFFOxpAKg6Vv3
	 nHna+HZUYVo19K/8V19yCDblM8Q1r1IQ5HKVahPs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAC5BF800E9;
	Wed, 17 Feb 2021 15:34:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 681C4F80258; Wed, 17 Feb 2021 15:34:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65170F800AE
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2021 15:34:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65170F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Q/YA1DOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613572484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pn8xsOb5zlgYTotMTn8SsA+2Pg+V+xFGqpkNhg081KE=;
 b=Q/YA1DOO3EbN/qddPuP0g0WS2SbJaf9HlFW/zHV/TIKx/e1JhQ4oueS0CQTSErkbomVSx5
 suJpT0ux62wrcnTiWH4sb+GaaytsqUh1GSnWNwU9fgf++Sp3a4uajThiYzKeDsBtIODMGo
 YlJd2v/9Zs4GEAiElGjY8mL3mHxHUaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-wLUH2nXPM8K2GmBf3q8eLQ-1; Wed, 17 Feb 2021 09:34:42 -0500
X-MC-Unique: wLUH2nXPM8K2GmBf3q8eLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBED4107ACE6;
 Wed, 17 Feb 2021 14:34:39 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-224.ams2.redhat.com [10.36.115.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E4F45C1A3;
 Wed, 17 Feb 2021 14:34:37 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH alsa-ucm-conf 1/2] codecs/rt5672: Move +12dB input boost from
 'STO1 ADC Boost Gain' to 'ADC Capture Volume'
Date: Wed, 17 Feb 2021 15:34:35 +0100
Message-Id: <20210217143436.74209-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

Both the 'STO1 ADC Boost Gain' and the 'ADC Capture Volume' controls are
digital and the 'ADC Capture Volume' control goes up to +30dB.

When adding hw-volume-control support adding the +12dB boost gain on to of
the max +30dB of 'ADC Capture Volume' is a bit too much.

So move the +12dB from the 'STO1 ADC Boost Gain' control to the
'ADC Capture Volume' control.

This way we keep the same setting for userspace which does not support
hw-volume-control, while getting a better range when we start using
'ADC Capture Volume' as hw-volume-control.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 ucm2/codecs/rt5672/EnableSeq.conf | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/ucm2/codecs/rt5672/EnableSeq.conf b/ucm2/codecs/rt5672/EnableSeq.conf
index ddfb1c7..e373275 100644
--- a/ucm2/codecs/rt5672/EnableSeq.conf
+++ b/ucm2/codecs/rt5672/EnableSeq.conf
@@ -26,14 +26,13 @@ EnableSequence [
 	# cset "name='LOUT MIX OUTMIX L Switch' on"
 	# cset "name='LOUT MIX OUTMIX R Switch' on"
 
-	# 47=0dB, 0.375 dB/step
-	cset "name='ADC Capture Volume' 47"
+	# Both the DMICs and the headset mic (even with the 20dB boost below)
+	# are quite soft, set the default capture volume to +12dB
+	# 47=0dB, 0.375dB/step, 79=+12dB
+	cset "name='ADC Capture Volume' 79"
 	cset "name='ADC Capture Switch' on"
-
-	# Both the DMICs and the headset mic (even with the 20 dB boost below)
-	# are quite soft, set the ADC Boost gain (range 0-3) to 1 = 12 dB the
-	# next step is 24 dB which is a bit too much
-	cset "name='STO1 ADC Boost Gain Volume' 1"
+	# 0=0dB
+	cset "name='STO1 ADC Boost Gain Volume' 0"
 
 	# Headset mic is quite soft, boost it a bit, 1 = 20dB which is the first
 	# available boost step
-- 
2.30.1

